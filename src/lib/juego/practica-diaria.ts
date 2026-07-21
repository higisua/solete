import { createClient } from "@/lib/supabase/server";
import { hoyMadridISO } from "@/lib/fecha-madrid";
import {
  DIAMANTES_PRACTICA_DIARIA,
  PRACTICA_PREGUNTAS_PARA_DIAMANTE,
} from "@/lib/juego/economia";

export type PracticaDiariaRow = {
  id: string;
  nino_id: string;
  fecha: string;
  preguntas: number;
  diamante_otorgado: boolean;
};

/**
 * Suma preguntas de práctica al día Madrid y, si llega a 10 por primera vez
 * ese día, otorga 1💎 (flag atómico en BD).
 */
export async function registrarPracticaDelDia(
  ninoId: string,
  preguntasSesion: number,
  diamantesActuales: number,
): Promise<{
  preguntasHoy: number;
  diamanteGanado: number;
  diamantesTotales: number;
}> {
  if (preguntasSesion <= 0) {
    return {
      preguntasHoy: 0,
      diamanteGanado: 0,
      diamantesTotales: diamantesActuales,
    };
  }

  const supabase = await createClient();
  const hoy = hoyMadridISO();

  const { data: fila, error } = await supabase.rpc("sumar_practica_diaria", {
    p_nino_id: ninoId,
    p_fecha: hoy,
    p_preguntas: preguntasSesion,
  });

  if (error || !fila) {
    console.warn(
      "[practica] sumar_practica_diaria (¿fase6_practica_diaria.sql?):",
      error?.message,
    );
    return {
      preguntasHoy: 0,
      diamanteGanado: 0,
      diamantesTotales: diamantesActuales,
    };
  }

  const row = fila as PracticaDiariaRow;
  const preguntasHoy = row.preguntas ?? 0;
  let diamantesTotales = diamantesActuales;
  let diamanteGanado = 0;

  if (
    preguntasHoy >= PRACTICA_PREGUNTAS_PARA_DIAMANTE &&
    !row.diamante_otorgado
  ) {
    const { data: marcado, error: markErr } = await supabase.rpc(
      "marcar_diamante_practica_diaria",
      { p_nino_id: ninoId, p_fecha: hoy },
    );

    if (markErr) {
      console.warn("[practica] marcar_diamante:", markErr.message);
    } else if (marcado === true) {
      const { data: ninoAct } = await supabase
        .from("ninos")
        .select("diamantes")
        .eq("id", ninoId)
        .maybeSingle();
      const base = ninoAct?.diamantes ?? diamantesActuales;
      const nuevo = base + DIAMANTES_PRACTICA_DIARIA;
      const { error: diamErr } = await supabase
        .from("ninos")
        .update({ diamantes: nuevo })
        .eq("id", ninoId);

      if (diamErr) {
        console.warn("[practica] diamantes:", diamErr.message);
      } else {
        diamanteGanado = DIAMANTES_PRACTICA_DIARIA;
        diamantesTotales = nuevo;
      }
    }
  }

  return { preguntasHoy, diamanteGanado, diamantesTotales };
}

/** Total de preguntas de práctica (todas las sesiones libres). */
export async function totalPreguntasPractica(ninoId: string): Promise<number> {
  const supabase = await createClient();
  const { data, error } = await supabase
    .from("sesiones")
    .select("total")
    .eq("nino_id", ninoId)
    .eq("modo", "libre");

  if (error || !data) {
    console.warn("[practica] total sesiones:", error?.message);
    return 0;
  }
  return data.reduce((s, r) => s + (r.total ?? 0), 0);
}

/** Preguntas de práctica del día Madrid (0 si no hay fila). */
export async function preguntasPracticaHoy(ninoId: string): Promise<number> {
  const supabase = await createClient();
  const hoy = hoyMadridISO();
  const { data } = await supabase
    .from("practica_diaria")
    .select("preguntas")
    .eq("nino_id", ninoId)
    .eq("fecha", hoy)
    .maybeSingle();
  return data?.preguntas ?? 0;
}
