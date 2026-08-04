/**
 * Catálogo fijo de medallas Solete.
 * Las condiciones se evalúan en código; aquí solo metadatos del premio.
 */

export type MedallaId =
  | "primer_dia"
  | "tres_dias"
  | "semana"
  | "quince_dias"
  | "mes_completo"
  | "primer_perfecto"
  | "estrella_fija"
  | "diez_perfectos"
  | "sin_fallar"
  | "aprendiz"
  | "aciertos_250"
  | "sabelotodo"
  | "misiones_10"
  | "misiones_25"
  | "bienvenida"
  | "practica_10"
  | "practica_50"
  | "practica_100"
  | "practica_dia_25"
  | "primer_cromo"
  | "coleccion_10"
  | "album_animales"
  | "album_ciudades"
  | "album_comidas"
  | "album_deportes"
  | "album_transportes";

export type MedallaDef = {
  id: MedallaId;
  nombre: string;
  diamantes: number;
  /** Texto corto para UI. */
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
    id: "quince_dias",
    nombre: "Quince días",
    diamantes: 8,
    descripcion: "15 días consecutivos con misión completada",
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
    id: "diez_perfectos",
    nombre: "Diez perfectos",
    diamantes: 10,
    descripcion: "Conseguir 3 estrellas en 10 misiones",
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
    id: "aciertos_250",
    nombre: "Mente ágil",
    diamantes: 5,
    descripcion: "Acertar 250 preguntas en total",
  },
  {
    id: "sabelotodo",
    nombre: "Sabelotodo",
    diamantes: 10,
    descripcion: "Acertar 500 preguntas en total",
  },
  {
    id: "misiones_10",
    nombre: "Diez misiones",
    diamantes: 4,
    descripcion: "Completar 10 misiones diarias",
  },
  {
    id: "misiones_25",
    nombre: "Veinticinco misiones",
    diamantes: 7,
    descripcion: "Completar 25 misiones diarias",
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
    id: "practica_dia_25",
    nombre: "Día intenso",
    diamantes: 4,
    descripcion: "Practicar 25 preguntas en un mismo día",
  },
  {
    id: "practica_50",
    nombre: "En marcha",
    diamantes: 3,
    descripcion: "Acumular 50 preguntas de práctica",
  },
  {
    id: "practica_100",
    nombre: "Incansable",
    diamantes: 5,
    descripcion: "Acumular 100 preguntas de práctica",
  },
  {
    id: "primer_cromo",
    nombre: "Primer cromo",
    diamantes: 2,
    descripcion: "Conseguir tu primer cromo",
  },
  {
    id: "coleccion_10",
    nombre: "Coleccionista",
    diamantes: 5,
    descripcion: "Tener 10 cromos distintos",
  },
  {
    id: "album_animales",
    nombre: "Álbum: Animales",
    diamantes: 3,
    descripcion: "Completar la categoría Animales",
  },
  {
    id: "album_ciudades",
    nombre: "Álbum: Ciudades",
    diamantes: 3,
    descripcion: "Completar la categoría Ciudades",
  },
  {
    id: "album_comidas",
    nombre: "Álbum: Comidas",
    diamantes: 3,
    descripcion: "Completar la categoría Comidas",
  },
  {
    id: "album_deportes",
    nombre: "Álbum: Deportes",
    diamantes: 3,
    descripcion: "Completar la categoría Deportes",
  },
  {
    id: "album_transportes",
    nombre: "Álbum: Transportes",
    diamantes: 3,
    descripcion: "Completar la categoría Transportes",
  },
] as const;

export function medallaPorId(id: MedallaId): MedallaDef {
  const m = CATALOGO_MEDALLAS.find((c) => c.id === id);
  if (!m) throw new Error(`Medalla desconocida: ${id}`);
  return m;
}
