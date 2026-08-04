"use server";

import { redirect } from "next/navigation";
import { requireZonaPadres } from "@/app/actions/zona-padres";
import { createClient } from "@/lib/supabase/server";
import type { ActionResult, TipoPregunta } from "@/types/database";

function texto(formData: FormData, key: string): string {
  return String(formData.get(key) ?? "").trim();
}

/** Verifica PIN de zona padres + rol superadmin en servidor. */
export async function requireSuperadmin() {
  const familia = await requireZonaPadres();
  if (familia.rol !== "superadmin") {
    redirect("/zona-padres/hijos");
  }
  return familia;
}

async function assertSuperadmin(): Promise<ActionResult | { ok: true }> {
  const { getFamiliaActual } = await import("@/lib/familia");
  const { tieneAccesoZonaPadres } = await import("@/lib/zona-padres");
  const f = await getFamiliaActual();
  if (!f) return { ok: false, error: "No autenticado." };
  if (!(await tieneAccesoZonaPadres(f.id))) {
    return { ok: false, error: "Debes desbloquear la zona padres." };
  }
  if (f.rol !== "superadmin") {
    return { ok: false, error: "No tienes permisos de administración." };
  }
  return { ok: true };
}

// —— Asignaturas ——

export async function crearAsignatura(formData: FormData): Promise<ActionResult> {
  const gate = await assertSuperadmin();
  if (!gate.ok) return gate;

  const nombre = texto(formData, "nombre");
  const icono = texto(formData, "icono") || "📚";
  const curso = texto(formData, "curso");
  if (!nombre || (curso !== "1" && curso !== "2" && curso !== "3")) {
    return { ok: false, error: "Nombre y curso (1, 2 o 3) son obligatorios." };
  }

  const supabase = await createClient();
  const { error } = await supabase.from("asignaturas").insert({ nombre, icono, curso });
  if (error) return { ok: false, error: error.message };
  redirect("/zona-padres/contenido");
}

export async function actualizarAsignatura(formData: FormData): Promise<ActionResult> {
  const gate = await assertSuperadmin();
  if (!gate.ok) return gate;

  const id = texto(formData, "id");
  const nombre = texto(formData, "nombre");
  const icono = texto(formData, "icono") || "📚";
  const curso = texto(formData, "curso");
  if (!id || !nombre || (curso !== "1" && curso !== "2" && curso !== "3")) {
    return { ok: false, error: "Datos incompletos." };
  }

  const supabase = await createClient();
  const { error } = await supabase
    .from("asignaturas")
    .update({ nombre, icono, curso })
    .eq("id", id);
  if (error) return { ok: false, error: error.message };
  redirect(`/zona-padres/contenido/${id}`);
}

export async function borrarAsignatura(id: string, _formData?: FormData): Promise<void> {
  const gate = await assertSuperadmin();
  if (!gate.ok) redirect("/zona-padres/hijos");

  const supabase = await createClient();
  await supabase.from("asignaturas").delete().eq("id", id);
  redirect("/zona-padres/contenido");
}

// —— Temas ——

export async function crearTema(formData: FormData): Promise<ActionResult> {
  const gate = await assertSuperadmin();
  if (!gate.ok) return gate;

  const asignaturaId = texto(formData, "asignatura_id");
  const nombre = texto(formData, "nombre");
  const orden = Number(texto(formData, "orden") || "0");
  if (!asignaturaId || !nombre) {
    return { ok: false, error: "Nombre obligatorio." };
  }

  const supabase = await createClient();
  const { data, error } = await supabase
    .from("temas")
    .insert({ asignatura_id: asignaturaId, nombre, orden: Number.isFinite(orden) ? orden : 0 })
    .select("id")
    .single();
  if (error) return { ok: false, error: error.message };
  redirect(`/zona-padres/contenido/${asignaturaId}/temas/${data.id}`);
}

export async function actualizarTema(formData: FormData): Promise<ActionResult> {
  const gate = await assertSuperadmin();
  if (!gate.ok) return gate;

  const id = texto(formData, "id");
  const asignaturaId = texto(formData, "asignatura_id");
  const nombre = texto(formData, "nombre");
  const orden = Number(texto(formData, "orden") || "0");
  if (!id || !nombre) return { ok: false, error: "Datos incompletos." };

  const supabase = await createClient();
  const { error } = await supabase
    .from("temas")
    .update({ nombre, orden: Number.isFinite(orden) ? orden : 0 })
    .eq("id", id);
  if (error) return { ok: false, error: error.message };
  redirect(`/zona-padres/contenido/${asignaturaId}/temas/${id}`);
}

export async function borrarTema(
  id: string,
  asignaturaId: string,
  _formData?: FormData,
): Promise<void> {
  const gate = await assertSuperadmin();
  if (!gate.ok) redirect("/zona-padres/hijos");

  const supabase = await createClient();
  await supabase.from("temas").delete().eq("id", id);
  redirect(`/zona-padres/contenido/${asignaturaId}`);
}

// —— Preguntas ——

function parseRespuesta(tipo: TipoPregunta, formData: FormData): unknown {
  if (tipo === "true_false") {
    return texto(formData, "respuesta") === "true";
  }
  if (tipo === "numeric") {
    const n = Number(texto(formData, "respuesta"));
    return Number.isFinite(n) ? n : texto(formData, "respuesta");
  }
  // multiple_choice: texto de la opción correcta
  return texto(formData, "respuesta");
}

function parseOpciones(tipo: TipoPregunta, formData: FormData): string[] | null {
  if (tipo !== "multiple_choice") return null;
  const ops = [1, 2, 3, 4]
    .map((i) => texto(formData, `opcion_${i}`))
    .filter(Boolean);
  return ops.length ? ops : null;
}

export async function crearPregunta(formData: FormData): Promise<ActionResult> {
  const gate = await assertSuperadmin();
  if (!gate.ok) return gate;

  const temaId = texto(formData, "tema_id");
  const asignaturaId = texto(formData, "asignatura_id");
  const tipo = texto(formData, "tipo") as TipoPregunta;
  const enunciado = texto(formData, "enunciado");
  const dificultad = Number(texto(formData, "dificultad") || "1");

  if (!temaId || !enunciado) return { ok: false, error: "Faltan datos." };
  if (!["numeric", "true_false", "multiple_choice"].includes(tipo)) {
    return { ok: false, error: "Tipo no válido." };
  }
  if (![1, 2, 3].includes(dificultad)) {
    return { ok: false, error: "Dificultad 1–3." };
  }

  const opciones = parseOpciones(tipo, formData);
  if (tipo === "multiple_choice" && (!opciones || opciones.length < 2)) {
    return { ok: false, error: "Añade al menos 2 opciones." };
  }

  const respuesta = parseRespuesta(tipo, formData);
  const supabase = await createClient();
  const { error } = await supabase.from("preguntas").insert({
    tema_id: temaId,
    tipo,
    enunciado,
    opciones,
    respuesta,
    dificultad,
  });
  if (error) return { ok: false, error: error.message };
  redirect(`/zona-padres/contenido/${asignaturaId}/temas/${temaId}`);
}

export async function actualizarPregunta(formData: FormData): Promise<ActionResult> {
  const gate = await assertSuperadmin();
  if (!gate.ok) return gate;

  const id = texto(formData, "id");
  const temaId = texto(formData, "tema_id");
  const asignaturaId = texto(formData, "asignatura_id");
  const tipo = texto(formData, "tipo") as TipoPregunta;
  const enunciado = texto(formData, "enunciado");
  const dificultad = Number(texto(formData, "dificultad") || "1");

  if (!id || !temaId || !enunciado) return { ok: false, error: "Faltan datos." };
  if (!["numeric", "true_false", "multiple_choice"].includes(tipo)) {
    return { ok: false, error: "Tipo no válido." };
  }

  const opciones = parseOpciones(tipo, formData);
  const respuesta = parseRespuesta(tipo, formData);

  const supabase = await createClient();
  const { error } = await supabase
    .from("preguntas")
    .update({ tipo, enunciado, opciones, respuesta, dificultad })
    .eq("id", id);
  if (error) return { ok: false, error: error.message };
  redirect(`/zona-padres/contenido/${asignaturaId}/temas/${temaId}`);
}

export async function borrarPregunta(
  id: string,
  asignaturaId: string,
  temaId: string,
  _formData?: FormData,
): Promise<void> {
  const gate = await assertSuperadmin();
  if (!gate.ok) redirect("/zona-padres/hijos");

  const supabase = await createClient();
  await supabase.from("preguntas").delete().eq("id", id);
  redirect(`/zona-padres/contenido/${asignaturaId}/temas/${temaId}`);
}
