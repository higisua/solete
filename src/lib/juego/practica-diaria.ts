import { createClient } from "@/lib/supabase/server";
import {
  fechaEnZonaISO,
  hoyMadridISO,
  sumarDiasCiviles,
  ZONA_SOLETE,
} from "@/lib/fecha-madrid";
import {
  DIAMANTES_PRACTICA_DIARIA,
  DIAMANTES_PRACTICA_EXTREMA_LOTE,
  PRACTICA_EXTREMA_ACIERTOS_POR_LOTE,
  PRACTICA_PREGUNTAS_PARA_DIAMANTE,
  type NivelPractica,
} from "@/lib/juego/economia";

/** Diamantes de práctica extrema por sesión (sin tope diario). */
export function diamantesPracticaExtrema(aciertos: number): number {
  if (aciertos <= 0) return 0;
  const lotes = Math.floor(aciertos / PRACTICA_EXTREMA_ACIERTOS_POR_LOTE);
  return lotes * DIAMANTES_PRACTICA_EXTREMA_LOTE;
}

/**
 * Otorga diamantes de práctica extrema según aciertos de la sesión.
 */
export async function otorgarDiamantesPracticaExtrema(
  ninoId: string,
  aciertos: number,
  diamantesActuales: number,
): Promise<{ diamanteGanado: number; diamantesTotales: number }> {
  const ganado = diamantesPracticaExtrema(aciertos);
  if (ganado <= 0) {
    return { diamanteGanado: 0, diamantesTotales: diamantesActuales };
  }

  const supabase = await createClient();
  const { data: ninoAct } = await supabase
    .from("ninos")
    .select("diamantes")
    .eq("id", ninoId)
    .maybeSingle();
  const base = ninoAct?.diamantes ?? diamantesActuales;
  const nuevo = base + ganado;
  const { error: diamErr } = await supabase
    .from("ninos")
    .update({ diamantes: nuevo })
    .eq("id", ninoId);

  if (diamErr) {
    console.warn("[practica] diamantes extrema:", diamErr.message);
    return { diamanteGanado: 0, diamantesTotales: diamantesActuales };
  }

  return { diamanteGanado: ganado, diamantesTotales: nuevo };
}

export type { NivelPractica };
export type PracticaDiariaRow = {
  id: string;
  nino_id: string;
  fecha: string;
  preguntas: number;
  diamante_otorgado: boolean;
};

function filaPractica(raw: unknown): PracticaDiariaRow | null {
  if (!raw) return null;
  const row = (Array.isArray(raw) ? raw[0] : raw) as PracticaDiariaRow;
  if (!row || typeof row !== "object") return null;
  return row;
}

/** Suma preguntas de práctica libre del día Madrid desde `sesiones`. */
async function preguntasHoyDesdeSesiones(ninoId: string): Promise<number> {
  const supabase = await createClient();
  const hoy = hoyMadridISO();
  // Ventana UTC amplia (±14h) que cubre el día civil Madrid; filtro fino en JS.
  const desde = `${sumarDiasCiviles(hoy, -1)}T10:00:00.000Z`;
  const hasta = `${sumarDiasCiviles(hoy, 1)}T14:00:00.000Z`;

  const { data, error } = await supabase
    .from("sesiones")
    .select("total, fecha")
    .eq("nino_id", ninoId)
    .eq("modo", "libre")
    .gte("fecha", desde)
    .lte("fecha", hasta);

  if (error || !data) {
    console.warn("[practica] sesiones hoy:", error?.message);
    return 0;
  }

  return data.reduce((s, r) => {
    const fecha = r.fecha
      ? fechaEnZonaISO(ZONA_SOLETE, new Date(String(r.fecha)))
      : "";
    if (fecha !== hoy) return s;
    return s + (r.total ?? 0);
  }, 0);
}

async function leerFilaPracticaHoy(
  ninoId: string,
): Promise<PracticaDiariaRow | null> {
  const supabase = await createClient();
  const hoy = hoyMadridISO();
  const { data } = await supabase
    .from("practica_diaria")
    .select("*")
    .eq("nino_id", ninoId)
    .eq("fecha", hoy)
    .maybeSingle();
  return (data as PracticaDiariaRow | null) ?? null;
}

/** Upsert directo (fallback si el RPC falla). */
async function sumarPracticaDirecto(
  ninoId: string,
  preguntasSesion: number,
): Promise<PracticaDiariaRow | null> {
  const supabase = await createClient();
  const hoy = hoyMadridISO();
  const actual = await leerFilaPracticaHoy(ninoId);

  if (actual) {
    const nuevo = (actual.preguntas ?? 0) + preguntasSesion;
    const { data, error } = await supabase
      .from("practica_diaria")
      .update({
        preguntas: nuevo,
        actualizado_en: new Date().toISOString(),
      })
      .eq("id", actual.id)
      .select("*")
      .maybeSingle();
    if (error) {
      console.warn("[practica] update directo:", error.message);
      return null;
    }
    return (data as PracticaDiariaRow) ?? { ...actual, preguntas: nuevo };
  }

  const { data, error } = await supabase
    .from("practica_diaria")
    .insert({
      nino_id: ninoId,
      fecha: hoy,
      preguntas: preguntasSesion,
      diamante_otorgado: false,
    })
    .select("*")
    .maybeSingle();

  if (error) {
    console.warn("[practica] insert directo:", error.message);
    return null;
  }
  return data as PracticaDiariaRow;
}

/**
 * Si el día ya alcanzó el umbral y aún no cobró, otorga diamantes.
 * Idempotente vía flag diamante_otorgado / RPC marcar.
 */
async function intentarCobrarDiamanteDia(
  ninoId: string,
  preguntasHoy: number,
  diamantesActuales: number,
  yaOtorgado: boolean,
): Promise<{ diamanteGanado: number; diamantesTotales: number }> {
  if (preguntasHoy < PRACTICA_PREGUNTAS_PARA_DIAMANTE || yaOtorgado) {
    return { diamanteGanado: 0, diamantesTotales: diamantesActuales };
  }

  const supabase = await createClient();
  const hoy = hoyMadridISO();

  const { data: marcado, error: markErr } = await supabase.rpc(
    "marcar_diamante_practica_diaria",
    { p_nino_id: ninoId, p_fecha: hoy },
  );

  let cobrado = marcado === true;
  if (markErr || !cobrado) {
    if (markErr) {
      console.warn("[practica] marcar_diamante RPC:", markErr.message);
    }
    // Fallback: marcar en tabla si el RPC no puede
    const fila = await leerFilaPracticaHoy(ninoId);
    if (
      fila &&
      !fila.diamante_otorgado &&
      (fila.preguntas ?? 0) >= PRACTICA_PREGUNTAS_PARA_DIAMANTE
    ) {
      const { data: upd, error: updErr } = await supabase
        .from("practica_diaria")
        .update({ diamante_otorgado: true })
        .eq("id", fila.id)
        .eq("diamante_otorgado", false)
        .select("id")
        .maybeSingle();
      cobrado = Boolean(upd) && !updErr;
    }
  }

  if (!cobrado) {
    return { diamanteGanado: 0, diamantesTotales: diamantesActuales };
  }

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
    return { diamanteGanado: 0, diamantesTotales: diamantesActuales };
  }

  return {
    diamanteGanado: DIAMANTES_PRACTICA_DIARIA,
    diamantesTotales: nuevo,
  };
}

/**
 * Suma preguntas de práctica al día Madrid (todas las asignaturas cuentan juntas).
 * Al llegar a PRACTICA_PREGUNTAS_PARA_DIAMANTE por primera vez ese día → diamantes.
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

  let row: PracticaDiariaRow | null = null;
  const { data: fila, error } = await supabase.rpc("sumar_practica_diaria", {
    p_nino_id: ninoId,
    p_fecha: hoy,
    p_preguntas: preguntasSesion,
  });

  if (error || !fila) {
    console.warn(
      "[practica] sumar_practica_diaria (fallback directo):",
      error?.message,
    );
    row = await sumarPracticaDirecto(ninoId, preguntasSesion);
  } else {
    row = filaPractica(fila);
  }

  if (!row) {
    return {
      preguntasHoy: 0,
      diamanteGanado: 0,
      diamantesTotales: diamantesActuales,
    };
  }

  const cobro = await intentarCobrarDiamanteDia(
    ninoId,
    row.preguntas ?? 0,
    diamantesActuales,
    Boolean(row.diamante_otorgado),
  );

  return {
    preguntasHoy: row.preguntas ?? 0,
    diamanteGanado: cobro.diamanteGanado,
    diamantesTotales: cobro.diamantesTotales,
  };
}

/**
 * Repara el premio diario si ya hubo ≥ umbral de preguntas hoy
 * (p.ej. sumando varias asignaturas) y no se cobró.
 * Alinea practica_diaria con la suma de sesiones libres del día.
 * Barato si practica_diaria ya está al día.
 */
export async function reconciliarPremioPracticaHoy(
  ninoId: string,
  diamantesActuales: number,
): Promise<{
  preguntasHoy: number;
  diamanteGanado: number;
  diamantesTotales: number;
}> {
  const supabase = await createClient();
  const hoy = hoyMadridISO();
  let fila = await leerFilaPracticaHoy(ninoId);
  let preguntasHoy = fila?.preguntas ?? 0;

  // Solo escanea sesiones si no hay fila o el contador parece incompleto
  const necesitaScan =
    !fila ||
    (!fila.diamante_otorgado &&
      preguntasHoy < PRACTICA_PREGUNTAS_PARA_DIAMANTE);

  if (necesitaScan) {
    const desdeSesiones = await preguntasHoyDesdeSesiones(ninoId);
    if (desdeSesiones > preguntasHoy) {
      if (fila) {
        const { data } = await supabase
          .from("practica_diaria")
          .update({
            preguntas: desdeSesiones,
            actualizado_en: new Date().toISOString(),
          })
          .eq("id", fila.id)
          .select("id, nino_id, fecha, preguntas, diamante_otorgado")
          .maybeSingle();
        fila = (data as PracticaDiariaRow) ?? {
          ...fila,
          preguntas: desdeSesiones,
        };
      } else {
        const { data } = await supabase
          .from("practica_diaria")
          .insert({
            nino_id: ninoId,
            fecha: hoy,
            preguntas: desdeSesiones,
            diamante_otorgado: false,
          })
          .select("id, nino_id, fecha, preguntas, diamante_otorgado")
          .maybeSingle();
        fila = data as PracticaDiariaRow | null;
      }
      preguntasHoy = fila?.preguntas ?? desdeSesiones;
    }
  }

  const cobro = await intentarCobrarDiamanteDia(
    ninoId,
    preguntasHoy,
    diamantesActuales,
    Boolean(fila?.diamante_otorgado),
  );

  return {
    preguntasHoy,
    diamanteGanado: cobro.diamanteGanado,
    diamantesTotales: cobro.diamantesTotales,
  };
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
  const fila = await leerFilaPracticaHoy(ninoId);
  const desdeTabla = fila?.preguntas ?? 0;
  if (desdeTabla > 0) return desdeTabla;
  return preguntasHoyDesdeSesiones(ninoId);
}
