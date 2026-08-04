/**
 * Progreso y desbloqueo de Legendarios a partir de datos existentes.
 * Sin tablas nuevas: ownership en cromos_nino (via 'compra', 0 diamantes).
 */

import { createClient } from "@/lib/supabase/server";
import {
  CATALOGO_CROMOS,
  TEMATICAS_CROMOS,
  type TematicaId,
} from "@/lib/juego/cromos-catalogo";
import { CATALOGO_MEDALLAS } from "@/lib/juego/medallas-catalogo";
import {
  CATALOGO_LEGENDARIOS,
  META_RACHA_CORRECTAS_ID,
  esIdLegendario,
  idsLegendariosPreviosAMarrakech,
  imagenLegendario,
  legendarioPorId,
  type LegendaryDef,
  type LegendaryUnlockType,
} from "@/lib/juego/legendaries";

export type LegendarioDesbloqueado = {
  id: string;
  title: string;
  emoji: string;
  description: string;
  imagenSrc: string;
};

export type LegendarioProgresoItem = {
  def: LegendaryDef;
  imagenSrc: string;
  loTiene: boolean;
  actual: number;
  meta: number;
  completado: boolean;
  /** Texto de progreso legible (p.ej. "3 / 5"). */
  progresoTexto: string;
};

export type LegendariosVista = {
  items: LegendarioProgresoItem[];
  conseguidos: number;
  total: number;
  /** Por categoría, mismos items filtrados. */
  porCategoria: Array<{
    category: TematicaId;
    nombre: string;
    items: LegendarioProgresoItem[];
  }>;
};

type StatsLegendarios = {
  missionsCompleted: number;
  starsEarned: number;
  perfectMissions: number;
  practiceSessions: number;
  questionsAnswered: number;
  languageCorrect: number;
  mathCorrect: number;
  medalsOwned: number;
  medalsTotal: number;
  cardsCollected: number;
  maxCorrectStreak: number;
  normalsOwnedByTheme: Record<TematicaId, { owned: number; total: number }>;
  ownedLegendaryIds: Set<string>;
};

function cromosNormalesDeTematica(tematicaId: TematicaId) {
  return CATALOGO_CROMOS.filter((c) => c.tematicaId === tematicaId);
}

async function idsPoseidosCromos(ninoId: string): Promise<Set<string>> {
  const supabase = await createClient();
  const { data, error } = await supabase
    .from("cromos_nino")
    .select("cromo_id")
    .eq("nino_id", ninoId);

  if (error) {
    console.warn("[legendarios] cromos_nino:", error.message);
    return new Set();
  }
  return new Set((data ?? []).map((r) => String(r.cromo_id)));
}

async function leerMejorRachaMeta(ninoId: string): Promise<number> {
  const supabase = await createClient();
  const { data } = await supabase
    .from("cromos_nino")
    .select("diamantes_gastados")
    .eq("nino_id", ninoId)
    .eq("cromo_id", META_RACHA_CORRECTAS_ID)
    .maybeSingle();

  return Math.max(0, Number(data?.diamantes_gastados ?? 0));
}

/**
 * Persiste la mejor racha de aciertos consecutivos (sin migración SQL).
 * Reutiliza cromos_nino: diamantes_gastados = valor de racha.
 */
export async function actualizarMejorRachaCorrectas(
  ninoId: string,
  rachaSesion: number,
): Promise<number> {
  if (rachaSesion <= 0) return leerMejorRachaMeta(ninoId);

  const actual = await leerMejorRachaMeta(ninoId);
  if (rachaSesion <= actual) return actual;

  const supabase = await createClient();
  if (actual === 0) {
    const { error } = await supabase.from("cromos_nino").insert({
      nino_id: ninoId,
      cromo_id: META_RACHA_CORRECTAS_ID,
      via: "compra",
      diamantes_gastados: rachaSesion,
    });
    if (error && error.code !== "23505") {
      console.warn("[legendarios] meta racha insert:", error.message);
      return actual;
    }
    if (error?.code === "23505") {
      await supabase
        .from("cromos_nino")
        .update({ diamantes_gastados: rachaSesion })
        .eq("nino_id", ninoId)
        .eq("cromo_id", META_RACHA_CORRECTAS_ID);
    }
  } else {
    const { error } = await supabase
      .from("cromos_nino")
      .update({ diamantes_gastados: rachaSesion })
      .eq("nino_id", ninoId)
      .eq("cromo_id", META_RACHA_CORRECTAS_ID);
    if (error) {
      console.warn("[legendarios] meta racha update:", error.message);
      return actual;
    }
  }
  return rachaSesion;
}

async function cargarStats(ninoId: string): Promise<StatsLegendarios> {
  const supabase = await createClient();
  const poseidos = await idsPoseidosCromos(ninoId);
  const ownedLegendaryIds = new Set(
    [...poseidos].filter((id) => esIdLegendario(id)),
  );

  const [
    { data: misiones },
    { data: sesionesLibre },
    { data: progresoRows },
    { data: medallas },
    { data: asignaturas },
  ] = await Promise.all([
    supabase
      .from("misiones_diarias")
      .select("estrellas, completada")
      .eq("nino_id", ninoId)
      .eq("completada", true),
    supabase
      .from("sesiones")
      .select("id, total")
      .eq("nino_id", ninoId)
      .eq("modo", "libre"),
    supabase
      .from("progreso")
      .select("tema_id, aciertos, intentos")
      .eq("nino_id", ninoId),
    supabase.from("medallas_nino").select("medalla_id").eq("nino_id", ninoId),
    supabase.from("asignaturas").select("id, nombre"),
  ]);

  const missionsCompleted = (misiones ?? []).length;
  const starsEarned = (misiones ?? []).reduce(
    (s, m) => s + Number(m.estrellas ?? 0),
    0,
  );
  const perfectMissions = (misiones ?? []).filter(
    (m) => Number(m.estrellas ?? 0) >= 3,
  ).length;

  const practiceSessions = (sesionesLibre ?? []).length;
  const questionsFromPractice = (sesionesLibre ?? []).reduce(
    (s, r) => s + Number(r.total ?? 0),
    0,
  );
  const questionsFromProgreso = (progresoRows ?? []).reduce(
    (s, r) => s + Number(r.intentos ?? 0),
    0,
  );
  // Preferimos el mayor (cubre misión+práctica vía progreso; práctica también en sesiones).
  const questionsAnswered = Math.max(
    questionsFromProgreso,
    questionsFromPractice,
  );

  const temaIds = [...new Set((progresoRows ?? []).map((p) => String(p.tema_id)))];
  let languageCorrect = 0;
  let mathCorrect = 0;

  if (temaIds.length > 0) {
    const { data: temas } = await supabase
      .from("temas")
      .select("id, asignatura_id")
      .in("id", temaIds);

    const asigById = new Map(
      (asignaturas ?? []).map((a) => [String(a.id), String(a.nombre ?? "")]),
    );
    const temaAsig = new Map(
      (temas ?? []).map((t) => [String(t.id), String(t.asignatura_id)]),
    );

    for (const row of progresoRows ?? []) {
      const asigId = temaAsig.get(String(row.tema_id));
      const nombre = asigId ? (asigById.get(asigId) ?? "") : "";
      const aciertos = Number(row.aciertos ?? 0);
      if (/lengua/i.test(nombre)) languageCorrect += aciertos;
      if (/matem/i.test(nombre)) mathCorrect += aciertos;
    }
  }

  const normalsOwnedByTheme = {} as StatsLegendarios["normalsOwnedByTheme"];
  for (const tema of TEMATICAS_CROMOS) {
    const normals = cromosNormalesDeTematica(tema.id);
    const owned = normals.filter((c) => poseidos.has(c.id)).length;
    normalsOwnedByTheme[tema.id] = { owned, total: normals.length };
  }

  const cardsCollected = [...poseidos].filter((id) => {
    if (id === META_RACHA_CORRECTAS_ID) return false;
    return esIdLegendario(id) || CATALOGO_CROMOS.some((c) => c.id === id);
  }).length;

  const maxCorrectStreak = await leerMejorRachaMeta(ninoId);

  return {
    missionsCompleted,
    starsEarned,
    perfectMissions,
    practiceSessions,
    questionsAnswered,
    languageCorrect,
    mathCorrect,
    medalsOwned: (medallas ?? []).length,
    medalsTotal: CATALOGO_MEDALLAS.length,
    cardsCollected,
    maxCorrectStreak,
    normalsOwnedByTheme,
    ownedLegendaryIds,
  };
}

function progresoDe(
  def: LegendaryDef,
  stats: StatsLegendarios,
): { actual: number; meta: number } {
  switch (def.unlockType as LegendaryUnlockType) {
    case "missions_completed":
      return { actual: stats.missionsCompleted, meta: def.target ?? 0 };
    case "stars_earned":
      return { actual: stats.starsEarned, meta: def.target ?? 0 };
    case "perfect_missions":
      return { actual: stats.perfectMissions, meta: def.target ?? 0 };
    case "practice_sessions":
      return { actual: stats.practiceSessions, meta: def.target ?? 0 };
    case "questions_answered":
      return { actual: stats.questionsAnswered, meta: def.target ?? 0 };
    case "language_questions":
      return { actual: stats.languageCorrect, meta: def.target ?? 0 };
    case "math_questions":
      return { actual: stats.mathCorrect, meta: def.target ?? 0 };
    case "correct_streak":
      return { actual: stats.maxCorrectStreak, meta: def.target ?? 0 };
    case "cards_collected":
      return { actual: stats.cardsCollected, meta: def.target ?? 0 };
    case "all_medals":
      return { actual: stats.medalsOwned, meta: stats.medalsTotal };
    case "category_completed": {
      const cat = def.categoryTarget ?? def.category;
      const t = stats.normalsOwnedByTheme[cat];
      return { actual: t?.owned ?? 0, meta: t?.total ?? 0 };
    }
    case "all_normal_albums_completed": {
      const themes = TEMATICAS_CROMOS;
      const done = themes.filter((t) => {
        const x = stats.normalsOwnedByTheme[t.id];
        return x && x.total > 0 && x.owned >= x.total;
      }).length;
      return { actual: done, meta: themes.length };
    }
    case "all_previous_legendaries": {
      const prev = idsLegendariosPreviosAMarrakech();
      const got = prev.filter((id) => stats.ownedLegendaryIds.has(id)).length;
      return { actual: got, meta: prev.length };
    }
    default:
      return { actual: 0, meta: 1 };
  }
}

function cumple(def: LegendaryDef, stats: StatsLegendarios): boolean {
  const { actual, meta } = progresoDe(def, stats);
  if (meta <= 0) return false;
  return actual >= meta;
}

async function otorgarLegendario(
  ninoId: string,
  def: LegendaryDef,
): Promise<LegendarioDesbloqueado | null> {
  const supabase = await createClient();
  const { error } = await supabase.from("cromos_nino").insert({
    nino_id: ninoId,
    cromo_id: def.id,
    via: "compra",
    diamantes_gastados: 0,
  });

  if (error) {
    if (error.code === "23505") return null;
    console.warn(`[legendarios] insert ${def.id}:`, error.message);
    return null;
  }

  return {
    id: def.id,
    title: def.title,
    emoji: def.emoji,
    description: def.description,
    imagenSrc: imagenLegendario(def),
  };
}

/**
 * Evalúa y otorga legendarios pendientes. Idempotente.
 */
export async function evaluarLegendarios(
  ninoId: string,
  opts?: { rachaCorrectasSesion?: number },
): Promise<LegendarioDesbloqueado[]> {
  if (opts?.rachaCorrectasSesion != null) {
    await actualizarMejorRachaCorrectas(ninoId, opts.rachaCorrectasSesion);
  }

  const stats = await cargarStats(ninoId);
  const nuevos: LegendarioDesbloqueado[] = [];

  // Marrakech al final: primero el resto, luego all_previous.
  const ordenados = [...CATALOGO_LEGENDARIOS].sort((a, b) => {
    const am = a.unlockType === "all_previous_legendaries" ? 1 : 0;
    const bm = b.unlockType === "all_previous_legendaries" ? 1 : 0;
    if (am !== bm) return am - bm;
    return a.orden - b.orden;
  });

  for (const def of ordenados) {
    if (stats.ownedLegendaryIds.has(def.id)) continue;
    if (!cumple(def, stats)) continue;
    const otorgado = await otorgarLegendario(ninoId, def);
    if (otorgado) {
      nuevos.push(otorgado);
      stats.ownedLegendaryIds.add(def.id);
      // cards_collected sube al otorgar
      stats.cardsCollected += 1;
    }
  }

  return nuevos;
}

export async function getLegendariosVista(
  ninoId: string,
): Promise<LegendariosVista> {
  const stats = await cargarStats(ninoId);

  const items: LegendarioProgresoItem[] = CATALOGO_LEGENDARIOS.map((def) => {
    const loTiene = stats.ownedLegendaryIds.has(def.id);
    const { actual, meta } = progresoDe(def, stats);
    const capped = Math.min(actual, meta);
    return {
      def,
      imagenSrc: imagenLegendario(def),
      loTiene,
      actual: capped,
      meta,
      completado: loTiene || (meta > 0 && actual >= meta),
      progresoTexto: loTiene ? "¡Conseguido!" : `${capped} / ${meta}`,
    };
  });

  const porCategoria = TEMATICAS_CROMOS.map((t) => ({
    category: t.id,
    nombre: t.nombre,
    items: items.filter((i) => i.def.category === t.id),
  })).filter((g) => g.items.length > 0);

  return {
    items,
    conseguidos: items.filter((i) => i.loTiene).length,
    total: items.length,
    porCategoria,
  };
}

export function legendarioDesdeId(
  id: string,
): LegendarioDesbloqueado | null {
  const def = legendarioPorId(id);
  if (!def) return null;
  return {
    id: def.id,
    title: def.title,
    emoji: def.emoji,
    description: def.description,
    imagenSrc: imagenLegendario(def),
  };
}
