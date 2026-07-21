import { createClient } from "@/lib/supabase/server";
import { hoyMadridISO } from "@/lib/fecha-madrid";
import { MISION_OBJETIVO } from "@/lib/juego/reglas";
import {
  getPreguntasParaMisionDiaria,
  getPreguntasPorIds,
} from "@/lib/juego/preguntas";
import type { MisionDiaria, Pregunta } from "@/types/database";

export type EstadoMisionDiaria =
  | {
      estado: "completada";
      mision: MisionDiaria;
    }
  | {
      estado: "lista";
      mision: MisionDiaria;
      preguntas: Pregunta[];
      misionCorta: boolean;
    }
  | {
      estado: "sin_preguntas";
    };

function mapMision(row: Record<string, unknown>): MisionDiaria {
  return {
    id: String(row.id),
    nino_id: String(row.nino_id),
    fecha: String(row.fecha).slice(0, 10),
    completada: Boolean(row.completada),
    aciertos: Number(row.aciertos ?? 0),
    total: Number(row.total ?? 0),
    estrellas: Number(row.estrellas ?? 0),
    diamante_otorgado: Boolean(row.diamante_otorgado),
    pregunta_ids: Array.isArray(row.pregunta_ids)
      ? (row.pregunta_ids as string[])
      : [],
    creada_en: String(row.creada_en ?? ""),
    completada_en: row.completada_en ? String(row.completada_en) : null,
  };
}

/**
 * Obtiene o crea la misión de hoy (Europe/Madrid).
 * Si ya está completada, no regenera preguntas.
 */
export async function obtenerMisionDiariaDeHoy(
  ninoId: string,
  curso: "1" | "2",
): Promise<EstadoMisionDiaria> {
  const supabase = await createClient();
  const fecha = hoyMadridISO();

  const { data: existente, error } = await supabase
    .from("misiones_diarias")
    .select("*")
    .eq("nino_id", ninoId)
    .eq("fecha", fecha)
    .maybeSingle();

  if (error) {
    console.error("[obtenerMisionDiariaDeHoy]", error);
    // Tabla aún no creada: degrada a generar preguntas sin persistir fila
    const gen = await getPreguntasParaMisionDiaria(ninoId, curso);
    if (gen.preguntas.length === 0) return { estado: "sin_preguntas" };
    return {
      estado: "lista",
      mision: {
        id: "",
        nino_id: ninoId,
        fecha,
        completada: false,
        aciertos: 0,
        total: 0,
        estrellas: 0,
        diamante_otorgado: false,
        pregunta_ids: gen.preguntas.map((p) => p.id),
        creada_en: "",
        completada_en: null,
      },
      preguntas: gen.preguntas,
      misionCorta: gen.misionCorta,
    };
  }

  if (existente?.completada) {
    return { estado: "completada", mision: mapMision(existente) };
  }

  if (existente?.pregunta_ids?.length) {
    const preguntas = await getPreguntasPorIds(existente.pregunta_ids as string[]);
    if (preguntas.length > 0) {
      return {
        estado: "lista",
        mision: mapMision(existente),
        preguntas,
        misionCorta: preguntas.length < MISION_OBJETIVO,
      };
    }
  }

  const gen = await getPreguntasParaMisionDiaria(ninoId, curso);
  if (gen.preguntas.length === 0) {
    return { estado: "sin_preguntas" };
  }

  const ids = gen.preguntas.map((p) => p.id);

  if (existente) {
    const { data: actualizada, error: upErr } = await supabase
      .from("misiones_diarias")
      .update({ pregunta_ids: ids })
      .eq("id", existente.id)
      .select("*")
      .single();

    if (upErr || !actualizada) {
      console.error("[obtenerMisionDiariaDeHoy] update", upErr);
      return {
        estado: "lista",
        mision: mapMision(existente),
        preguntas: gen.preguntas,
        misionCorta: gen.misionCorta,
      };
    }

    return {
      estado: "lista",
      mision: mapMision(actualizada),
      preguntas: gen.preguntas,
      misionCorta: gen.misionCorta,
    };
  }

  const { data: creada, error: insErr } = await supabase
    .from("misiones_diarias")
    .insert({
      nino_id: ninoId,
      fecha,
      pregunta_ids: ids,
      completada: false,
    })
    .select("*")
    .single();

  if (insErr || !creada) {
    console.error("[obtenerMisionDiariaDeHoy] insert", insErr);
    return {
      estado: "lista",
      mision: {
        id: "",
        nino_id: ninoId,
        fecha,
        completada: false,
        aciertos: 0,
        total: 0,
        estrellas: 0,
        diamante_otorgado: false,
        pregunta_ids: ids,
        creada_en: "",
        completada_en: null,
      },
      preguntas: gen.preguntas,
      misionCorta: gen.misionCorta,
    };
  }

  return {
    estado: "lista",
    mision: mapMision(creada),
    preguntas: gen.preguntas,
    misionCorta: gen.misionCorta,
  };
}
