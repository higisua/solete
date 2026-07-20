"use server";

import { createClient } from "@/lib/supabase/server";
import { getNinoDeMiFamilia } from "@/lib/juego";
import { calcularEstrellas, puntosPorAciertos } from "@/lib/juego/reglas";
import type { ActionResult, ModoJuego } from "@/types/database";

export type DetalleTemaPartida = {
  temaId: string;
  aciertos: number;
  intentos: number;
};

export type ResultadoGuardado = {
  puntos: number;
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
};

function hoyISOFecha(): string {
  // Día calendario en zona local del servidor; para app familiar ES suele bastar.
  const d = new Date();
  const y = d.getFullYear();
  const m = String(d.getMonth() + 1).padStart(2, "0");
  const day = String(d.getDate()).padStart(2, "0");
  return `${y}-${m}-${day}`;
}

function ayerISOFecha(): string {
  const d = new Date();
  d.setDate(d.getDate() - 1);
  const y = d.getFullYear();
  const m = String(d.getMonth() + 1).padStart(2, "0");
  const day = String(d.getDate()).padStart(2, "0");
  return `${y}-${m}-${day}`;
}

/**
 * Criterio de estrellas en progreso:
 * - Solo misión otorga estrellas.
 * - Se guardan en el tema predominante de la sesión como MÁXIMO histórico
 *   (GREATEST): si ya tenías 3 y sacas 1, se mantienen 3.
 * - El resto de temas de la sesión solo suman puntos/aciertos/intentos.
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
  const puntos = puntosPorAciertos(payload.aciertos);
  const estrellas =
    payload.modo === "mision"
      ? calcularEstrellas(payload.aciertos, payload.total)
      : 0;

  // 1) Sesión (una fila; tema = predominante)
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

  // 2) Progreso por cada tema tocado
  for (const bloque of payload.porTema) {
    if (bloque.intentos <= 0) continue;

    const puntosTema = puntosPorAciertos(bloque.aciertos);
    const esPredominante = bloque.temaId === payload.temaPredominanteId;

    const { data: actual } = await supabase
      .from("progreso")
      .select("*")
      .eq("nino_id", payload.ninoId)
      .eq("tema_id", bloque.temaId)
      .maybeSingle();

    const estrellasTema =
      payload.modo === "mision" && esPredominante
        ? Math.max(actual?.estrellas ?? 0, estrellas)
        : (actual?.estrellas ?? 0);

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
        estrellas: estrellasTema,
      });

      if (error) {
        console.error("[finalizarPartida] progreso insert", error);
        return { ok: false, error: "No se pudo crear el progreso." };
      }
    }
  }

  // 3) Racha diaria (solo misión; requiere columnas de fase4b_racha.sql)
  let rachaDias: number | null = nino.racha_dias ?? null;
  let rachaSumoHoy = false;

  if (payload.modo === "mision" && payload.total > 0) {
    const hoy = hoyISOFecha();
    const ayer = ayerISOFecha();
    const ultima = nino.ultima_mision_fecha
      ? String(nino.ultima_mision_fecha).slice(0, 10)
      : null;

    let nuevaRacha = nino.racha_dias ?? 0;

    if (ultima === hoy) {
      // Ya contó hoy: no cambia
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
        // Columnas aún no creadas: no bloqueamos el guardado de la partida
        console.warn(
          "[finalizarPartida] racha no actualizada (¿ejecutaste fase4b_racha.sql?):",
          rachaError.message,
        );
        rachaDias = null;
      } else {
        rachaDias = ultima === hoy ? (nino.racha_dias ?? 0) : nuevaRacha;
      }
    } else {
      rachaDias = nino.racha_dias ?? 0;
    }
  }

  return {
    ok: true,
    resultado: {
      puntos,
      estrellas,
      aciertos: payload.aciertos,
      total: payload.total,
      rachaDias,
      rachaSumoHoy,
      misionCorta: payload.misionCorta,
    },
  };
}
