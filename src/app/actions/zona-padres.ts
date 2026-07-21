"use server";

import bcrypt from "bcryptjs";
import { redirect } from "next/navigation";
import { AVATARES } from "@/lib/avatares";
import { getFamiliaActual, getNinosDeMiFamilia } from "@/lib/familia";
import { createClient } from "@/lib/supabase/server";
import {
  clearAccesoZonaPadres,
  setAccesoZonaPadres,
  tieneAccesoZonaPadres,
} from "@/lib/zona-padres";
import type { ActionResult } from "@/types/database";

const BCRYPT_ROUNDS = 12;

function texto(formData: FormData, key: string): string {
  return String(formData.get(key) ?? "").trim();
}

export async function requireZonaPadres() {
  const familia = await getFamiliaActual();
  if (!familia) {
    redirect("/login");
  }
  const ok = await tieneAccesoZonaPadres(familia.id);
  if (!ok) {
    redirect("/zona-padres");
  }
  return familia;
}

export async function verificarPinZonaPadres(formData: FormData): Promise<ActionResult> {
  const pin = texto(formData, "pin");
  if (!/^\d{4}$/.test(pin)) {
    return { ok: false, error: "El PIN debe tener 4 dígitos." };
  }

  const familia = await getFamiliaActual();
  if (!familia) {
    return { ok: false, error: "Debes iniciar sesión." };
  }
  if (!familia.pin_hash) {
    return {
      ok: false,
      error: "Esta familia no tiene PIN. Completa el alta o contacta soporte.",
    };
  }

  const valido = await bcrypt.compare(pin, familia.pin_hash);
  if (!valido) {
    return { ok: false, error: "PIN incorrecto. Inténtalo de nuevo." };
  }

  await setAccesoZonaPadres(familia.id);
  redirect("/zona-padres/hijos");
}

export async function salirZonaPadres(): Promise<void> {
  await clearAccesoZonaPadres();
  redirect("/mundo");
}

export async function cambiarPin(formData: FormData): Promise<ActionResult> {
  await requireZonaPadres();
  const actual = texto(formData, "pin_actual");
  const nuevo = texto(formData, "pin_nuevo");
  const nuevo2 = texto(formData, "pin_nuevo2");

  if (!/^\d{4}$/.test(actual) || !/^\d{4}$/.test(nuevo)) {
    return { ok: false, error: "Los PIN deben tener 4 dígitos." };
  }
  if (nuevo !== nuevo2) {
    return { ok: false, error: "El PIN nuevo no coincide." };
  }

  const familia = await getFamiliaActual();
  if (!familia?.pin_hash) {
    return { ok: false, error: "No encontramos tu familia." };
  }

  const valido = await bcrypt.compare(actual, familia.pin_hash);
  if (!valido) {
    return { ok: false, error: "El PIN actual no es correcto." };
  }

  const pin_hash = await bcrypt.hash(nuevo, BCRYPT_ROUNDS);
  const supabase = await createClient();
  const { error } = await supabase
    .from("familias")
    .update({ pin_hash })
    .eq("id", familia.id);

  if (error) {
    return { ok: false, error: "No se pudo cambiar el PIN." };
  }

  return { ok: true };
}

export async function actualizarNombreFamilia(formData: FormData): Promise<ActionResult> {
  await requireZonaPadres();
  const nombre = texto(formData, "nombre");
  if (!nombre) {
    return { ok: false, error: "Escribe un nombre." };
  }

  const familia = await getFamiliaActual();
  if (!familia) {
    return { ok: false, error: "No encontramos tu familia." };
  }

  const supabase = await createClient();
  const { error } = await supabase
    .from("familias")
    .update({ nombre })
    .eq("id", familia.id);

  if (error) {
    return { ok: false, error: "No se pudo guardar el nombre." };
  }

  return { ok: true };
}

export async function crearNinoZonaPadres(formData: FormData): Promise<ActionResult> {
  await requireZonaPadres();
  const nombre = texto(formData, "nombre");
  const curso = texto(formData, "curso");
  const avatar = texto(formData, "avatar");

  if (!nombre) return { ok: false, error: "Escribe el nombre." };
  if (curso !== "1" && curso !== "2") {
    return { ok: false, error: "Elige el curso." };
  }
  if (!AVATARES.some((a) => a.id === avatar)) {
    return { ok: false, error: "Elige un avatar." };
  }

  const familia = await getFamiliaActual();
  if (!familia) return { ok: false, error: "Sin familia." };

  const supabase = await createClient();
  const { data: creado, error } = await supabase
    .from("ninos")
    .insert({
      familia_id: familia.id,
      nombre,
      curso,
      avatar,
    })
    .select("id")
    .single();

  if (error || !creado) {
    return { ok: false, error: "No se pudo crear el perfil." };
  }

  try {
    const { otorgarMedallaBienvenida } = await import("@/lib/juego/medallas");
    await otorgarMedallaBienvenida(creado.id);
  } catch (err) {
    console.warn("[crearNinoZonaPadres] medalla bienvenida:", err);
  }

  redirect("/zona-padres/hijos");
}

export async function actualizarNinoZonaPadres(formData: FormData): Promise<ActionResult> {
  await requireZonaPadres();
  const ninoId = texto(formData, "nino_id");
  const nombre = texto(formData, "nombre");
  const curso = texto(formData, "curso");
  const avatar = texto(formData, "avatar");

  if (!ninoId || !nombre) return { ok: false, error: "Datos incompletos." };
  if (curso !== "1" && curso !== "2") {
    return { ok: false, error: "Elige el curso." };
  }
  if (!AVATARES.some((a) => a.id === avatar)) {
    return { ok: false, error: "Elige un avatar." };
  }

  const ninos = await getNinosDeMiFamilia();
  if (!ninos.some((n) => n.id === ninoId)) {
    return { ok: false, error: "Ese niño no es de tu familia." };
  }

  const supabase = await createClient();
  const { error } = await supabase
    .from("ninos")
    .update({ nombre, curso, avatar })
    .eq("id", ninoId);

  if (error) {
    return { ok: false, error: "No se pudo guardar." };
  }

  redirect("/zona-padres/hijos");
}

export async function borrarNinoZonaPadres(ninoId: string, _formData?: FormData): Promise<void> {
  await requireZonaPadres();
  const ninos = await getNinosDeMiFamilia();
  if (!ninos.some((n) => n.id === ninoId)) {
    redirect("/zona-padres/hijos");
  }

  const supabase = await createClient();
  await supabase.from("ninos").delete().eq("id", ninoId);
  redirect("/zona-padres/hijos");
}

export async function setTemaActivoParaNino(formData: FormData): Promise<ActionResult> {
  await requireZonaPadres();
  const ninoId = texto(formData, "nino_id");
  const temaId = texto(formData, "tema_id");
  const activo = texto(formData, "activo") === "true";

  const ninos = await getNinosDeMiFamilia();
  if (!ninos.some((n) => n.id === ninoId)) {
    return { ok: false, error: "Niño no válido." };
  }

  const supabase = await createClient();

  const { data: existente } = await supabase
    .from("temas_activos")
    .select("id")
    .eq("nino_id", ninoId)
    .eq("tema_id", temaId)
    .maybeSingle();

  if (existente) {
    const { error } = await supabase
      .from("temas_activos")
      .update({ activo })
      .eq("id", existente.id);
    if (error) return { ok: false, error: "No se pudo actualizar el tema." };
  } else {
    // Sin fila = activo. Solo creamos fila si se desactiva, o si se activa explícitamente.
    const { error } = await supabase.from("temas_activos").insert({
      nino_id: ninoId,
      tema_id: temaId,
      activo,
    });
    if (error) return { ok: false, error: "No se pudo guardar el tema." };
  }

  return { ok: true };
}
