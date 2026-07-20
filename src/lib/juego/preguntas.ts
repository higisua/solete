import { createClient } from "@/lib/supabase/server";
import type { Pregunta, Tema } from "@/types/database";
import { MISION_OBJETIVO } from "@/lib/juego/reglas";

function shuffle<T>(items: T[]): T[] {
  const arr = [...items];
  for (let i = arr.length - 1; i > 0; i -= 1) {
    const j = Math.floor(Math.random() * (i + 1));
    [arr[i], arr[j]] = [arr[j], arr[i]];
  }
  return arr;
}

function parseOpciones(raw: unknown): string[] | null {
  if (raw == null) return null;
  if (Array.isArray(raw)) return raw.map((o) => String(o));
  return null;
}

/**
 * Temas de la asignatura activos para el niño.
 * Sin fila en temas_activos → activo por defecto.
 * Fila con activo=false → desactivado.
 */
export async function getTemasActivosDeAsignatura(
  ninoId: string,
  asignaturaId: string,
): Promise<Tema[]> {
  const supabase = await createClient();

  const { data: temas } = await supabase
    .from("temas")
    .select("*")
    .eq("asignatura_id", asignaturaId)
    .order("orden", { ascending: true });

  if (!temas?.length) return [];

  const temaIds = temas.map((t) => t.id);
  const { data: activos } = await supabase
    .from("temas_activos")
    .select("tema_id, activo")
    .eq("nino_id", ninoId)
    .in("tema_id", temaIds);

  const mapa = new Map((activos ?? []).map((a) => [a.tema_id, a.activo]));

  return (temas as Tema[]).filter((tema) => {
    if (!mapa.has(tema.id)) return true; // por defecto activo
    return mapa.get(tema.id) === true;
  });
}

export async function getPreguntasParaPartida(
  ninoId: string,
  asignaturaId: string,
  modo: "mision" | "libre",
): Promise<{ preguntas: Pregunta[]; misionCorta: boolean }> {
  const temas = await getTemasActivosDeAsignatura(ninoId, asignaturaId);
  if (temas.length === 0) {
    return { preguntas: [], misionCorta: false };
  }

  const supabase = await createClient();
  const { data } = await supabase
    .from("preguntas")
    .select("*")
    .in(
      "tema_id",
      temas.map((t) => t.id),
    );

  const pool: Pregunta[] = (data ?? []).map((p) => ({
    ...(p as Pregunta),
    opciones: parseOpciones(p.opciones),
  }));

  if (pool.length === 0) {
    return { preguntas: [], misionCorta: false };
  }

  const mezcladas = shuffle(pool);

  if (modo === "libre") {
    // En libre enviamos todo el pool barajado; el cliente puede rebarajar al agotarlo.
    return { preguntas: mezcladas, misionCorta: false };
  }

  // Misión: hasta 10 sin repetir
  const seleccion = mezcladas.slice(0, MISION_OBJETIVO);
  return {
    preguntas: seleccion,
    misionCorta: seleccion.length < MISION_OBJETIVO,
  };
}
