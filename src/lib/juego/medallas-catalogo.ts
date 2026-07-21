/**
 * Catálogo fijo de medallas Solete.
 * Las condiciones se evalúan en código; aquí solo metadatos del premio.
 */

export type MedallaId =
  | "primer_dia"
  | "tres_dias"
  | "semana"
  | "mes_completo"
  | "primer_perfecto"
  | "estrella_fija"
  | "sin_fallar"
  | "aprendiz"
  | "sabelotodo"
  | "bienvenida"
  | "practica_10"
  | "practica_100";

export type MedallaDef = {
  id: MedallaId;
  nombre: string;
  diamantes: number;
  /** Texto corto para UI futura. */
  descripcion: string;
};

export const CATALOGO_MEDALLAS: readonly MedallaDef[] = [
  {
    id: "primer_dia",
    nombre: "Primer día",
    diamantes: 2,
    descripcion: "Completar la primera misión",
  },
  {
    id: "tres_dias",
    nombre: "Tres días seguidos",
    diamantes: 3,
    descripcion: "3 días consecutivos con misión completada",
  },
  {
    id: "semana",
    nombre: "Una semana seguida",
    diamantes: 5,
    descripcion: "7 días consecutivos con misión completada",
  },
  {
    id: "mes_completo",
    nombre: "Todo el mes",
    diamantes: 15,
    descripcion: "Un mes natural completo sin faltar ningún día",
  },
  {
    id: "primer_perfecto",
    nombre: "¡Perfecto!",
    diamantes: 3,
    descripcion: "Sacar 3 estrellas en una misión por primera vez",
  },
  {
    id: "estrella_fija",
    nombre: "Estrella fija",
    diamantes: 8,
    descripcion: "Conseguir 3 estrellas en 5 misiones",
  },
  {
    id: "sin_fallar",
    nombre: "Sin fallar",
    diamantes: 5,
    descripcion: "Completar una misión con el 100% de aciertos",
  },
  {
    id: "aprendiz",
    nombre: "Aprendiz",
    diamantes: 3,
    descripcion: "Acertar 100 preguntas en total",
  },
  {
    id: "sabelotodo",
    nombre: "Sabelotodo",
    diamantes: 10,
    descripcion: "Acertar 500 preguntas en total",
  },
  {
    id: "bienvenida",
    nombre: "Bienvenido a Solete",
    diamantes: 1,
    descripcion: "Crear el perfil",
  },
  {
    id: "practica_10",
    nombre: "Con ganas",
    diamantes: 2,
    descripcion: "Practicar 10 preguntas en un día",
  },
  {
    id: "practica_100",
    nombre: "Incansable",
    diamantes: 5,
    descripcion: "Acumular 100 preguntas de práctica",
  },
] as const;

export function medallaPorId(id: MedallaId): MedallaDef {
  const m = CATALOGO_MEDALLAS.find((c) => c.id === id);
  if (!m) throw new Error(`Medalla desconocida: ${id}`);
  return m;
}
