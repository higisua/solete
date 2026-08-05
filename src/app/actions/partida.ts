"use server";

import { createClient } from "@/lib/supabase/server";
import { ayerMadridISO, hoyMadridISO } from "@/lib/fecha-madrid";
import { getNinoDeMiFamilia } from "@/lib/juego";
import { DIAMANTES_MISION_DIARIA, type NivelPractica } from "@/lib/juego/economia";
import {
  otorgarDiamantesPracticaExtrema,
  registrarPracticaDelDia,
  totalPreguntasPractica,
} from "@/lib/juego/practica-diaria";
import {
  evaluarMedallasTrasMision,
  evaluarMedallasTrasPractica,
  type MedallaDesbloqueada,
} from "@/lib/juego/medallas";
import type { LegendarioDesbloqueado } from "@/lib/juego/legendarios-eval";
import { programarCatchupPremios } from "@/lib/juego/catchup-premios";
import { calcularEstrellas, puntosPorAciertos } from "@/lib/juego/reglas";
import type { ActionResult, ModoJuego } from "@/types/database";

export type DetalleTemaPartida = {
  temaId: string;
  aciertos: number;
  intentos: number;
};

export type ResultadoGuardado = {
  /** Diamantes ganados en esta partida (misión/práctica + medallas). */
  puntos: number;
  diamantesGanados: number;
  diamantesTotales: number | null;
  estrellas: number;
  aciertos: number;
  total: number;
  rachaDias: number | null;
  rachaSumoHoy: boolean;
  misionCorta: boolean;
  /** Medallas desbloqueadas en esta partida (fanfarria en resultados). */
  medallasNuevas: MedallaDesbloqueada[];
  /** Legendarios desbloqueados en esta partida (celebración premium). */
  legendariosNuevos: LegendarioDesbloqueado[];
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
  /** Solo práctica: normal (tope diario) u extremo (lotes de aciertos). */
  nivelPractica?: NivelPractica;
  /** Mejor racha de aciertos consecutivos de esta sesión. */
  rachaCorrectasSesion?: number;
};

/**
 * Guarda el resultado de una partida.
 *
 * Misión diaria:
 * - Sesión + progreso; estrellas; +4💎 máx/día Madrid; racha; medallas de misión.
 *
 * Práctica normal:
 * - +2💎 al llegar a 10 preguntas/día (máx. 1/día); medallas de práctica.
 *
 * Práctica extrema:
 * - +3💎 cada 10 aciertos de la sesión (sin tope diario).
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
  let medallasNuevas: MedallaDesbloqueada[] = [];
  let legendariosNuevos: LegendarioDesbloqueado[] = [];

  // 3) Misión diaria: cerrar fila + diamantes + racha (Europe/Madrid)
  if (esMision && payload.total > 0) {
    const hoy = hoyMadridISO();
    const ayer = ayerMadridISO();

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
    let misionPersistida = false;

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
        diamantesGanados = DIAMANTES_MISION_DIARIA;
        misionPersistida = true;
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
        diamantesGanados = DIAMANTES_MISION_DIARIA;
        misionPersistida = true;
      }
    }

    if (diamantesGanados === DIAMANTES_MISION_DIARIA) {
      const nuevoTotal = (nino.diamantes ?? 0) + DIAMANTES_MISION_DIARIA;
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

    let nuevaRacha = nino.racha_dias ?? 0;
    if (misionPersistida) {
      const ultima = nino.ultima_mision_fecha
        ? String(nino.ultima_mision_fecha).slice(0, 10)
        : null;

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

      try {
        const evalMedallas = await evaluarMedallasTrasMision({
          ninoId: payload.ninoId,
          aciertos: payload.aciertos,
          total: payload.total,
          estrellas,
          rachaDias: rachaDias ?? nuevaRacha,
        });
        medallasNuevas = evalMedallas.medallas;
        if (evalMedallas.diamantesExtra > 0) {
          diamantesGanados += evalMedallas.diamantesExtra;
          const { data: ninoAct } = await supabase
            .from("ninos")
            .select("diamantes")
            .eq("id", payload.ninoId)
            .maybeSingle();
          diamantesTotales = ninoAct?.diamantes ?? diamantesTotales;
        }
      } catch (err) {
        console.warn("[finalizarPartida] medallas:", err);
      }
    }
  }

  // 4) Práctica: normal (tope diario acumulado entre asignaturas) o extrema
  if (esPractica && payload.total > 0) {
    const nivel: NivelPractica =
      payload.nivelPractica === "extremo" ? "extremo" : "normal";

    if (nivel === "extremo") {
      const reg = await otorgarDiamantesPracticaExtrema(
        payload.ninoId,
        payload.aciertos,
        nino.diamantes ?? 0,
      );
      diamantesGanados = reg.diamanteGanado;
      diamantesTotales = reg.diamantesTotales;
    } else {
      const reg = await registrarPracticaDelDia(
        payload.ninoId,
        payload.total,
        nino.diamantes ?? 0,
      );
      diamantesGanados = reg.diamanteGanado;
      diamantesTotales = reg.diamantesTotales;

      try {
        const preguntasTotales = await totalPreguntasPractica(payload.ninoId);
        const evalMedallas = await evaluarMedallasTrasPractica({
          ninoId: payload.ninoId,
          preguntasHoy: reg.preguntasHoy,
          preguntasTotales,
        });
        medallasNuevas = evalMedallas.medallas;
        if (evalMedallas.diamantesExtra > 0) {
          diamantesGanados += evalMedallas.diamantesExtra;
          const { data: ninoAct } = await supabase
            .from("ninos")
            .select("diamantes")
            .eq("id", payload.ninoId)
            .maybeSingle();
          diamantesTotales = ninoAct?.diamantes ?? diamantesTotales;
        }
      } catch (err) {
        console.warn("[finalizarPartida] medallas práctica:", err);
      }
    }
  }

  // Catch-up de medallas/premios fuera del hang de resultados
  programarCatchupPremios(
    payload.ninoId,
    diamantesTotales ?? nino.diamantes ?? 0,
  );

  // 5) Legendarios: evaluación automática (no altera economía)
  try {
    const { evaluarLegendarios } = await import("@/lib/juego/legendarios-eval");
    legendariosNuevos = await evaluarLegendarios(payload.ninoId, {
      rachaCorrectasSesion: payload.rachaCorrectasSesion ?? 0,
    });
  } catch (err) {
    console.warn("[finalizarPartida] legendarios:", err);
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
      medallasNuevas,
      legendariosNuevos,
    },
  };
}
