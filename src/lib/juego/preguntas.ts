import { createClient } from "@/lib/supabase/server";
import type { Asignatura, CursoContenido, Pregunta, Tema } from "@/types/database";
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

/** Normaliza nombre de asignatura/tema para emparejar entre cursos. */
function claveNombre(nombre: string): string {
  return nombre
    .normalize("NFD")
    .replace(/\p{M}/gu, "")
    .trim()
    .toLowerCase();
}

/**
 * Curso del contenido usado en práctica extrema:
 * 1º → preguntas de 2º · 2º → preguntas de 3º.
 */
export function cursoContenidoExtremo(
  cursoNino: "1" | "2",
): Exclude<CursoContenido, "1"> {
  return cursoNino === "1" ? "2" : "3";
}

function mapPreguntas(data: unknown[] | null): Pregunta[] {
  return (data ?? []).map((p) => {
    const row = p as Pregunta & { opciones: unknown };
    let opciones = parseOpciones(row.opciones);
    // Baraja opciones de multiple choice (la respuesta sigue siendo el texto).
    if (
      row.tipo === "multiple_choice" &&
      opciones &&
      opciones.length >= 2
    ) {
      opciones = shuffle(opciones);
    }
    return {
      ...row,
      opciones,
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
 * Pool de práctica extrema: contenido del curso siguiente
 * (misma asignatura por nombre; tema opcional emparejado por nombre).
 * No usa temas_activos del curso origen (son IDs distintos).
 * Sin match o sin preguntas → [].
 */
async function getPoolPracticaExtrema(
  cursoNino: "1" | "2",
  asignaturaId: string,
  temaId?: string | null,
): Promise<Pregunta[]> {
  const supabase = await createClient();
  const cursoDestino = cursoContenidoExtremo(cursoNino);

  const { data: asigOrigen } = await supabase
    .from("asignaturas")
    .select("id, nombre")
    .eq("id", asignaturaId)
    .maybeSingle();

  if (!asigOrigen) return [];

  const destinos = await getAsignaturasPorCurso(cursoDestino);
  const asigDestino = destinos.find(
    (a) => claveNombre(a.nombre) === claveNombre(String(asigOrigen.nombre)),
  );
  if (!asigDestino) return [];

  const { data: temasDest } = await supabase
    .from("temas")
    .select("*")
    .eq("asignatura_id", asigDestino.id)
    .order("orden", { ascending: true });

  if (!temasDest?.length) return [];

  let temasUsar = temasDest as Tema[];

  if (temaId) {
    // temaId puede ser del curso origen (UI antigua) o del destino (UI extrema).
    const { data: temaRef } = await supabase
      .from("temas")
      .select("id, nombre, asignatura_id")
      .eq("id", temaId)
      .maybeSingle();

    if (temaRef?.asignatura_id === asigDestino.id) {
      temasUsar = temasUsar.filter((t) => t.id === temaId);
    } else if (temaRef?.nombre) {
      const clave = claveNombre(String(temaRef.nombre));
      const emparejados = temasUsar.filter(
        (t) => claveNombre(t.nombre) === clave,
      );
      if (emparejados.length > 0) temasUsar = emparejados;
      else return []; // tema pedido sin equivalente en el curso siguiente
    } else {
      return [];
    }
  }

  return getPreguntasDeTemas(temasUsar.map((t) => t.id));
}

/** Asignatura destino del curso siguiente con el mismo nombre, si existe. */
export async function getAsignaturaContenidoExtremo(
  cursoNino: "1" | "2",
  asignaturaId: string,
): Promise<Asignatura | null> {
  const supabase = await createClient();
  const { data: asigOrigen } = await supabase
    .from("asignaturas")
    .select("nombre")
    .eq("id", asignaturaId)
    .maybeSingle();
  if (!asigOrigen) return null;

  const destinos = await getAsignaturasPorCurso(
    cursoContenidoExtremo(cursoNino),
  );
  return (
    destinos.find(
      (a) => claveNombre(a.nombre) === claveNombre(String(asigOrigen.nombre)),
    ) ?? null
  );
}

/** Temas del curso siguiente para una asignatura (práctica extrema). */
export async function getTemasContenidoExtremo(
  cursoNino: "1" | "2",
  asignaturaId: string,
): Promise<Tema[]> {
  const dest = await getAsignaturaContenidoExtremo(cursoNino, asignaturaId);
  if (!dest) return [];
  const supabase = await createClient();
  const { data } = await supabase
    .from("temas")
    .select("*")
    .eq("asignatura_id", dest.id)
    .order("orden", { ascending: true });
  return (data as Tema[]) ?? [];
}

/**
 * Lista rápida para el menú de práctica extrema:
 * asignaturas del niño con equivalente en el curso siguiente y ≥1 pregunta.
 * Evita cargar pools completos.
 */
export async function listarAsignaturasParaPracticaExtrema(
  cursoNino: "1" | "2",
  asignaturasOrigen: Asignatura[],
): Promise<Array<Asignatura & { temas: Tema[] }>> {
  if (asignaturasOrigen.length === 0) return [];

  const destinos = await getAsignaturasPorCurso(
    cursoContenidoExtremo(cursoNino),
  );
  const destPorNombre = new Map(
    destinos.map((a) => [claveNombre(a.nombre), a]),
  );

  const pares = asignaturasOrigen
    .map((origen) => {
      const dest = destPorNombre.get(claveNombre(origen.nombre));
      return dest ? { origen, dest } : null;
    })
    .filter((p): p is { origen: Asignatura; dest: Asignatura } => p != null);

  if (pares.length === 0) return [];

  const destIds = pares.map((p) => p.dest.id);
  const supabase = await createClient();
  const { data: temas } = await supabase
    .from("temas")
    .select("id, asignatura_id, nombre, orden, creado_en")
    .in("asignatura_id", destIds)
    .order("orden", { ascending: true });

  const temasLista = (temas as Tema[]) ?? [];
  if (temasLista.length === 0) return [];

  const temaIds = temasLista.map((t) => t.id);
  const { data: conPreg } = await supabase
    .from("preguntas")
    .select("tema_id")
    .in("tema_id", temaIds);

  const temasConPreguntas = new Set(
    (conPreg ?? []).map((p) => String(p.tema_id)),
  );

  const temasPorDest = new Map<string, Tema[]>();
  for (const t of temasLista) {
    const list = temasPorDest.get(t.asignatura_id) ?? [];
    list.push(t);
    temasPorDest.set(t.asignatura_id, list);
  }

  const out: Array<Asignatura & { temas: Tema[] }> = [];
  for (const { origen, dest } of pares) {
    const ts = temasPorDest.get(dest.id) ?? [];
    if (!ts.some((t) => temasConPreguntas.has(t.id))) continue;
    out.push({ ...origen, temas: ts });
  }
  return out;
}

/**
 * Práctica: pool de una asignatura (opcionalmente un tema).
 * Extremo: SOLO preguntas del curso siguiente (1→2, 2→3).
 * Sin contenido superior → [] (sin fallback al mismo curso).
 */
export async function getPreguntasParaPractica(
  ninoId: string,
  asignaturaId: string,
  temaId?: string | null,
  nivel: "normal" | "extremo" = "normal",
): Promise<Pregunta[]> {
  if (nivel !== "extremo") {
    const temas = await getTemasActivosDeAsignatura(ninoId, asignaturaId);
    const filtrados = temaId ? temas.filter((t) => t.id === temaId) : temas;
    if (filtrados.length === 0) return [];
    const pool = await getPreguntasDeTemas(filtrados.map((t) => t.id));
    return shuffle(pool);
  }

  const supabase = await createClient();
  const { data: nino } = await supabase
    .from("ninos")
    .select("curso")
    .eq("id", ninoId)
    .maybeSingle();

  const cursoNino =
    nino?.curso === "1" || nino?.curso === "2" ? nino.curso : null;
  if (!cursoNino) return [];

  const poolSuperior = await getPoolPracticaExtrema(
    cursoNino,
    asignaturaId,
    temaId,
  );
  return shuffle(poolSuperior);
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
