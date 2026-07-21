import { createClient } from "@/lib/supabase/server";
import type { Pregunta, Tema } from "@/types/database";
import { MISION_OBJETIVO, repartirCupos } from "@/lib/juego/reglas";
import { getAsignaturasPorCurso } from "@/lib/juego/nino";

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

function mapPreguntas(data: unknown[] | null): Pregunta[] {
  return (data ?? []).map((p) => {
    const row = p as Pregunta & { opciones: unknown };
    return {
      ...row,
      opciones: parseOpciones(row.opciones),
    };
  });
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
    if (!mapa.has(tema.id)) return true;
    return mapa.get(tema.id) === true;
  });
}

async function getPreguntasDeTemas(temaIds: string[]): Promise<Pregunta[]> {
  if (temaIds.length === 0) return [];
  const supabase = await createClient();
  const { data } = await supabase.from("preguntas").select("*").in("tema_id", temaIds);
  return mapPreguntas(data);
}

export async function getPreguntasPorIds(ids: string[]): Promise<Pregunta[]> {
  if (ids.length === 0) return [];
  const supabase = await createClient();
  const { data } = await supabase.from("preguntas").select("*").in("id", ids);
  const mapa = new Map(mapPreguntas(data).map((p) => [p.id, p]));
  // Conserva el orden de ids
  return ids.map((id) => mapa.get(id)).filter((p): p is Pregunta => Boolean(p));
}

/**
 * Práctica (antes «libre»): pool infinito de una asignatura,
 * opcionalmente filtrado a un tema concreto (debe estar activo).
 */
export async function getPreguntasParaPractica(
  ninoId: string,
  asignaturaId: string,
  temaId?: string | null,
): Promise<Pregunta[]> {
  const temas = await getTemasActivosDeAsignatura(ninoId, asignaturaId);
  const filtrados = temaId ? temas.filter((t) => t.id === temaId) : temas;
  if (filtrados.length === 0) return [];

  const pool = await getPreguntasDeTemas(filtrados.map((t) => t.id));
  return shuffle(pool);
}

/**
 * Misión diaria: hasta MISION_OBJETIVO preguntas repartidas equitativamente
 * entre las asignaturas del curso, solo temas activos del niño.
 */
export async function getPreguntasParaMisionDiaria(
  ninoId: string,
  curso: "1" | "2",
): Promise<{ preguntas: Pregunta[]; misionCorta: boolean }> {
  const asignaturas = await getAsignaturasPorCurso(curso);
  if (asignaturas.length === 0) {
    return { preguntas: [], misionCorta: false };
  }

  const pools: Pregunta[][] = [];
  for (const asig of asignaturas) {
    const temas = await getTemasActivosDeAsignatura(ninoId, asig.id);
    const pool = shuffle(await getPreguntasDeTemas(temas.map((t) => t.id)));
    pools.push(pool);
  }

  const conPreguntas = pools
    .map((pool, index) => ({ pool, index }))
    .filter((p) => p.pool.length > 0);

  if (conPreguntas.length === 0) {
    return { preguntas: [], misionCorta: false };
  }

  const objetivo = MISION_OBJETIVO;
  const cupos = repartirCupos(objetivo, conPreguntas.length);
  const tomadas: Pregunta[][] = conPreguntas.map(() => []);
  const restantes = conPreguntas.map((c) => [...c.pool]);

  // Primera pasada: cupo equitativo
  for (let i = 0; i < conPreguntas.length; i += 1) {
    const n = Math.min(cupos[i], restantes[i].length);
    tomadas[i] = restantes[i].splice(0, n);
  }

  let faltan =
    objetivo - tomadas.reduce((s, arr) => s + arr.length, 0);

  // Segunda pasada: rellenar huecos con lo que quede en otras asignaturas
  while (faltan > 0) {
    let progreso = false;
    for (let i = 0; i < restantes.length && faltan > 0; i += 1) {
      if (restantes[i].length === 0) continue;
      tomadas[i].push(restantes[i].shift()!);
      faltan -= 1;
      progreso = true;
    }
    if (!progreso) break;
  }

  const seleccion = shuffle(tomadas.flat());
  return {
    preguntas: seleccion,
    misionCorta: seleccion.length < objetivo,
  };
}

/** @deprecated Usar getPreguntasParaMisionDiaria / getPreguntasParaPractica */
export async function getPreguntasParaPartida(
  ninoId: string,
  asignaturaId: string,
  modo: "mision" | "libre",
  temaId?: string | null,
): Promise<{ preguntas: Pregunta[]; misionCorta: boolean }> {
  if (modo === "libre") {
    const preguntas = await getPreguntasParaPractica(ninoId, asignaturaId, temaId);
    return { preguntas, misionCorta: false };
  }
  // Compat: misión por asignatura ya no es el modelo; redirige a pool de esa asignatura
  const temas = await getTemasActivosDeAsignatura(ninoId, asignaturaId);
  const pool = shuffle(await getPreguntasDeTemas(temas.map((t) => t.id)));
  const seleccion = pool.slice(0, MISION_OBJETIVO);
  return {
    preguntas: seleccion,
    misionCorta: seleccion.length < MISION_OBJETIVO,
  };
}
