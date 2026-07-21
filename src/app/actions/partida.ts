"use server";

import { createClient } from "@/lib/supabase/server";
import { ayerMadridISO, hoyMadridISO } from "@/lib/fecha-madrid";
import { getNinoDeMiFamilia } from "@/lib/juego";
import { calcularEstrellas, puntosPorAciertos } from "@/lib/juego/reglas";
import type { ActionResult, ModoJuego } from "@/types/database";

export type DetalleTemaPartida = {
  temaId: string;
  aciertos: number;
  intentos: number;
};

export type ResultadoGuardado = {
  /** En misión: diamantes ganados en esta partida (0 o 1). En práctica: 0. */
  puntos: number;
  diamantesGanados: number;
  diamantesTotales: number | null;
  estrellas: number;
  aciertos: number;
  total: number;
  rachaDias: number | null;
  rachaSumoHoy: boolean;
  misionCorta: boolean;
};

type PayloadFinalizar = {
  ninoId: string;
  modo: ModoJuego;
  temaPredominanteId: string;
  aciertos: number;
  total: number;
  misionCorta: boolean;
  porTema: DetalleTemaPartida[];
  /** Id de misiones_diarias si aplica (misión). */
  misionDiariaId?: string | null;
};

/**
 * Guarda el resultado de una partida.
 *
 * Misión diaria:
 * - Sesión + progreso (aciertos/intentos; puntos internos de tema; sin estrellas en progreso).
 * - Estrellas + diamante (+1 máx/día) en misiones_diarias / ninos.diamantes.
 * - Racha con día Europe/Madrid.
 *
 * Práctica (modo libre):
 * - Sesión + progreso aciertos/intentos (sin puntos, estrellas, diamantes ni racha).
 */
export async function finalizarPartida(
  payload: PayloadFinalizar,
): Promise<ActionResult & { resultado?: ResultadoGuardado }> {
  const nino = await getNinoDeMiFamilia(payload.ninoId);
  if (!nino) {
    return { ok: false, error: "No puedes guardar esta partida." };
  }

  if (payload.total < 0 || payload.aciertos < 0 || payload.aciertos > payload.total) {
    return { ok: false, error: "Datos de partida no válidos." };
  }

  const supabase = await createClient();
  const esMision = payload.modo === "mision";
  const esPractica = payload.modo === "libre";

  const estrellas = esMision
    ? calcularEstrellas(payload.aciertos, payload.total)
    : 0;

  // 1) Sesión (una fila; tema = predominante)
  if (payload.temaPredominanteId) {
    const { error: sesionError } = await supabase.from("sesiones").insert({
      nino_id: payload.ninoId,
      tema_id: payload.temaPredominanteId,
      modo: payload.modo,
      aciertos: payload.aciertos,
      total: payload.total,
      fecha: new Date().toISOString(),
    });

    if (sesionError) {
      console.error("[finalizarPartida] sesiones", sesionError);
      return { ok: false, error: "No se pudo guardar la sesión." };
    }
  }

  // 2) Progreso por tema
  for (const bloque of payload.porTema) {
    if (bloque.intentos <= 0) continue;

    const { data: actual } = await supabase
      .from("progreso")
      .select("*")
      .eq("nino_id", payload.ninoId)
      .eq("tema_id", bloque.temaId)
      .maybeSingle();

    // Práctica: solo aciertos/intentos. Misión: también puntos de tema (analítica).
    const puntosTema = esMision ? puntosPorAciertos(bloque.aciertos) : 0;
    const estrellasTema = actual?.estrellas ?? 0; // estrellas viven en misiones_diarias

    if (actual) {
      const { error } = await supabase
        .from("progreso")
        .update({
          puntos: (actual.puntos ?? 0) + puntosTema,
          aciertos: (actual.aciertos ?? 0) + bloque.aciertos,
          intentos: (actual.intentos ?? 0) + bloque.intentos,
          estrellas: estrellasTema,
        })
        .eq("id", actual.id);

      if (error) {
        console.error("[finalizarPartida] progreso update", error);
        return { ok: false, error: "No se pudo actualizar el progreso." };
      }
    } else {
      const { error } = await supabase.from("progreso").insert({
        nino_id: payload.ninoId,
        tema_id: bloque.temaId,
        puntos: puntosTema,
        aciertos: bloque.aciertos,
        intentos: bloque.intentos,
        estrellas: 0,
      });

      if (error) {
        console.error("[finalizarPartida] progreso insert", error);
        return { ok: false, error: "No se pudo crear el progreso." };
      }
    }
  }

  let diamantesGanados = 0;
  let diamantesTotales: number | null = nino.diamantes ?? 0;
  let rachaDias: number | null = nino.racha_dias ?? null;
  let rachaSumoHoy = false;

  // 3) Misión diaria: cerrar fila + diamante + racha (Europe/Madrid)
  if (esMision && payload.total > 0) {
    const hoy = hoyMadridISO();
    const ayer = ayerMadridISO();

    // Evitar completar dos veces el mismo día
    const { data: misionHoy } = await supabase
      .from("misiones_diarias")
      .select("*")
      .eq("nino_id", payload.ninoId)
      .eq("fecha", hoy)
      .maybeSingle();

    if (misionHoy?.completada) {
      return {
        ok: false,
        error: "Ya completaste la misión de hoy. ¡Vuelve mañana!",
      };
    }

    const misionId = payload.misionDiariaId || misionHoy?.id;
    if (misionId) {
      const { error: misErr } = await supabase
        .from("misiones_diarias")
        .update({
          completada: true,
          aciertos: payload.aciertos,
          total: payload.total,
          estrellas,
          diamante_otorgado: true,
          completada_en: new Date().toISOString(),
        })
        .eq("id", misionId)
        .eq("completada", false);

      if (misErr) {
        console.warn(
          "[finalizarPartida] misiones_diarias (¿ejecutaste fase6_mision_diaria.sql?):",
          misErr.message,
        );
      } else {
        diamantesGanados = 1;
      }
    } else {
      const { error: insMis } = await supabase.from("misiones_diarias").insert({
        nino_id: payload.ninoId,
        fecha: hoy,
        completada: true,
        aciertos: payload.aciertos,
        total: payload.total,
        estrellas,
        diamante_otorgado: true,
        completada_en: new Date().toISOString(),
      });
      if (insMis) {
        console.warn("[finalizarPartida] insert mision", insMis.message);
      } else {
        diamantesGanados = 1;
      }
    }

    if (diamantesGanados === 1) {
      const nuevoTotal = (nino.diamantes ?? 0) + 1;
      const { error: diamErr } = await supabase
        .from("ninos")
        .update({ diamantes: nuevoTotal })
        .eq("id", payload.ninoId);

      if (diamErr) {
        console.warn(
          "[finalizarPartida] diamantes (¿fase6_mision_diaria.sql?):",
          diamErr.message,
        );
        diamantesGanados = 0;
        diamantesTotales = nino.diamantes ?? null;
      } else {
        diamantesTotales = nuevoTotal;
      }
    }

    // Racha
    const ultima = nino.ultima_mision_fecha
      ? String(nino.ultima_mision_fecha).slice(0, 10)
      : null;

    let nuevaRacha = nino.racha_dias ?? 0;

    if (ultima === hoy) {
      rachaSumoHoy = false;
    } else if (ultima === ayer) {
      nuevaRacha = (nino.racha_dias ?? 0) + 1;
      rachaSumoHoy = true;
    } else {
      nuevaRacha = 1;
      rachaSumoHoy = true;
    }

    if (rachaSumoHoy || ultima !== hoy) {
      const { error: rachaError } = await supabase
        .from("ninos")
        .update({
          racha_dias: ultima === hoy ? (nino.racha_dias ?? 0) : nuevaRacha,
          ultima_mision_fecha: hoy,
        })
        .eq("id", payload.ninoId);

      if (rachaError) {
        console.warn("[finalizarPartida] racha:", rachaError.message);
        rachaDias = null;
      } else {
        rachaDias = ultima === hoy ? (nino.racha_dias ?? 0) : nuevaRacha;
      }
    } else {
      rachaDias = nino.racha_dias ?? 0;
    }
  }

  if (esPractica) {
    diamantesGanados = 0;
    diamantesTotales = nino.diamantes ?? null;
  }

  return {
    ok: true,
    resultado: {
      puntos: diamantesGanados,
      diamantesGanados,
      diamantesTotales,
      estrellas,
      aciertos: payload.aciertos,
      total: payload.total,
      rachaDias,
      rachaSumoHoy,
      misionCorta: payload.misionCorta,
    },
  };
}
