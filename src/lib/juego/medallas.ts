import { createClient } from "@/lib/supabase/server";
import { hoyMadridISO } from "@/lib/fecha-madrid";
import { finMesISO, inicioMesISO } from "@/lib/juego/calendario";
import {
  CATALOGO_MEDALLAS,
  medallaPorId,
  type MedallaId,
} from "@/lib/juego/medallas-catalogo";
import { PRACTICA_PREGUNTAS_PARA_DIAMANTE } from "@/lib/juego/economia";

export type MedallaDesbloqueada = {
  id: MedallaId;
  nombre: string;
  diamantes: number;
};

type ContextoMision = {
  ninoId: string;
  /** Aciertos / total / estrellas de la misión que acaba de guardarse. */
  aciertos: number;
  total: number;
  estrellas: number;
  /** Racha ya actualizada (Europe/Madrid). */
  rachaDias: number;
};

type ContextoPractica = {
  ninoId: string;
  /** Preguntas de práctica acumuladas hoy (Madrid), tras esta sesión. */
  preguntasHoy: number;
  /** Total histórico de preguntas en sesiones libres. */
  preguntasTotales: number;
};

const MEDALLAS_SOLO_PRACTICA: ReadonlySet<MedallaId> = new Set([
  "practica_10",
  "practica_100",
]);

/**
 * Inserta la medalla si no existe y suma diamantes.
 * UNIQUE (nino_id, medalla_id) evita duplicados aunque haya carreras.
 */
async function intentarOtorgar(
  ninoId: string,
  medallaId: MedallaId,
): Promise<MedallaDesbloqueada | null> {
  const def = medallaPorId(medallaId);
  const supabase = await createClient();

  const { error: insErr } = await supabase.from("medallas_nino").insert({
    nino_id: ninoId,
    medalla_id: medallaId,
    diamantes_otorgados: def.diamantes,
  });

  if (insErr) {
    // 23505 = unique_violation → ya la tenía
    if (insErr.code === "23505") return null;
    console.warn(`[medallas] insert ${medallaId}:`, insErr.message);
    return null;
  }

  const { data: nino } = await supabase
    .from("ninos")
    .select("diamantes")
    .eq("id", ninoId)
    .maybeSingle();

  const actual = nino?.diamantes ?? 0;
  const { error: diamErr } = await supabase
    .from("ninos")
    .update({ diamantes: actual + def.diamantes })
    .eq("id", ninoId);

  if (diamErr) {
    console.warn(`[medallas] diamantes ${medallaId}:`, diamErr.message);
    // La medalla quedó marcada; no reintentamos diamantes aquí.
  }

  return { id: def.id, nombre: def.nombre, diamantes: def.diamantes };
}

async function idsYaConseguidas(ninoId: string): Promise<Set<string>> {
  const supabase = await createClient();
  const { data, error } = await supabase
    .from("medallas_nino")
    .select("medalla_id")
    .eq("nino_id", ninoId);

  if (error) {
    console.warn("[medallas] lectura:", error.message);
    return new Set();
  }
  return new Set((data ?? []).map((r) => String(r.medalla_id)));
}

async function statsMisiones(ninoId: string): Promise<{
  totalCompletadas: number;
  conTresEstrellas: number;
  mesCompleto: boolean;
}> {
  const supabase = await createClient();
  const { data, error } = await supabase
    .from("misiones_diarias")
    .select("fecha, estrellas, completada")
    .eq("nino_id", ninoId)
    .eq("completada", true);

  if (error || !data) {
    return { totalCompletadas: 0, conTresEstrellas: 0, mesCompleto: false };
  }

  const totalCompletadas = data.length;
  const conTresEstrellas = data.filter((m) => (m.estrellas ?? 0) >= 3).length;

  // ¿El mes civil de hoy (Madrid) tiene misión todos los días?
  const hoy = hoyMadridISO();
  const [y, m] = hoy.split("-").map(Number);
  const mes = { year: y, month: m };
  const desde = inicioMesISO(mes);
  const hasta = finMesISO(mes);
  const ultimoDia = Number(hasta.slice(8, 10));
  const diasMes = new Set(
    data
      .map((r) => String(r.fecha).slice(0, 10))
      .filter((f) => f >= desde && f <= hasta)
      .map((f) => f.slice(8, 10)),
  );
  const mesCompleto = diasMes.size >= ultimoDia;

  return { totalCompletadas, conTresEstrellas, mesCompleto };
}

async function totalAciertosProgreso(ninoId: string): Promise<number> {
  const supabase = await createClient();
  const { data, error } = await supabase
    .from("progreso")
    .select("aciertos")
    .eq("nino_id", ninoId);

  if (error || !data) return 0;
  return data.reduce((s, r) => s + (r.aciertos ?? 0), 0);
}

async function otorgarCandidatas(
  ninoId: string,
  candidatas: MedallaId[],
  ya: Set<string>,
  omitir: ReadonlySet<MedallaId> = new Set(),
): Promise<{ medallas: MedallaDesbloqueada[]; diamantesExtra: number }> {
  const medallas: MedallaDesbloqueada[] = [];
  let diamantesExtra = 0;

  for (const def of CATALOGO_MEDALLAS) {
    if (omitir.has(def.id)) continue;
    if (def.id === "bienvenida") continue;
    if (!candidatas.includes(def.id)) continue;
    if (ya.has(def.id)) continue;

    const otorgada = await intentarOtorgar(ninoId, def.id);
    if (otorgada) {
      medallas.push(otorgada);
      diamantesExtra += otorgada.diamantes;
      ya.add(def.id);
    }
  }

  return { medallas, diamantesExtra };
}

/**
 * Evalúa medallas tras una misión diaria recién guardada y otorga las nuevas.
 * No incluye «bienvenida» ni medallas solo de práctica.
 */
export async function evaluarMedallasTrasMision(
  ctx: ContextoMision,
): Promise<{ medallas: MedallaDesbloqueada[]; diamantesExtra: number }> {
  const ya = await idsYaConseguidas(ctx.ninoId);
  const stats = await statsMisiones(ctx.ninoId);
  const aciertosTotales = await totalAciertosProgreso(ctx.ninoId);

  const candidatas: MedallaId[] = [];

  if (stats.totalCompletadas >= 1) candidatas.push("primer_dia");
  if (ctx.rachaDias >= 3) candidatas.push("tres_dias");
  if (ctx.rachaDias >= 7) candidatas.push("semana");
  if (stats.mesCompleto) candidatas.push("mes_completo");
  if (ctx.estrellas >= 3 && stats.conTresEstrellas >= 1) {
    candidatas.push("primer_perfecto");
  }
  if (stats.conTresEstrellas >= 5) candidatas.push("estrella_fija");
  if (ctx.total > 0 && ctx.aciertos === ctx.total) candidatas.push("sin_fallar");
  if (aciertosTotales >= 100) candidatas.push("aprendiz");
  if (aciertosTotales >= 500) candidatas.push("sabelotodo");

  return otorgarCandidatas(ctx.ninoId, candidatas, ya, MEDALLAS_SOLO_PRACTICA);
}

/**
 * Medallas de práctica tras guardar una sesión libre.
 */
export async function evaluarMedallasTrasPractica(
  ctx: ContextoPractica,
): Promise<{ medallas: MedallaDesbloqueada[]; diamantesExtra: number }> {
  const ya = await idsYaConseguidas(ctx.ninoId);
  const candidatas: MedallaId[] = [];

  if (ctx.preguntasHoy >= PRACTICA_PREGUNTAS_PARA_DIAMANTE) {
    candidatas.push("practica_10");
  }
  if (ctx.preguntasTotales >= 100) {
    candidatas.push("practica_100");
  }

  const medallas: MedallaDesbloqueada[] = [];
  let diamantesExtra = 0;

  for (const id of candidatas) {
    if (ya.has(id)) continue;
    const otorgada = await intentarOtorgar(ctx.ninoId, id);
    if (otorgada) {
      medallas.push(otorgada);
      diamantesExtra += otorgada.diamantes;
      ya.add(id);
    }
  }

  return { medallas, diamantesExtra };
}

/** Medalla de bienvenida al crear el perfil del niño. */
export async function otorgarMedallaBienvenida(
  ninoId: string,
): Promise<MedallaDesbloqueada | null> {
  return intentarOtorgar(ninoId, "bienvenida");
}
