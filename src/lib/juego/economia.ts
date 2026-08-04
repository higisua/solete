/** Recompensas de diamantes (misión / práctica). Parametrizable. */
export const DIAMANTES_MISION_DIARIA = 4;
export const DIAMANTES_PRACTICA_DIARIA = 2;
/** Preguntas de práctica normal en el día Madrid para ganar el diamante topado. */
export const PRACTICA_PREGUNTAS_PARA_DIAMANTE = 10;

/** Bonus al completar todos los cromos de una temática. */
export const DIAMANTES_CATEGORIA_COMPLETA = 3;

/** Práctica extrema: diamantes por cada lote de aciertos (sin tope diario). */
export const DIAMANTES_PRACTICA_EXTREMA_LOTE = 3;
export const PRACTICA_EXTREMA_ACIERTOS_POR_LOTE = 10;

export type NivelPractica = "normal" | "extremo";

export function esNivelPractica(v: unknown): v is NivelPractica {
  return v === "normal" || v === "extremo";
}
