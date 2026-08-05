/**
 * Configuración central de Legendarios Solete.
 * Añadir un legendario = añadir una entrada aquí (y su PNG en /public/assets/cromos).
 *
 * No salen en tienda ni sobres. Ownership en cromos_nino (sin migración SQL).
 */

import type { TematicaId } from "@/lib/juego/cromos-catalogo";

/** Tipos de desbloqueo soportados (exactos de Fase 4). */
export const LEGENDARY_UNLOCK_TYPES = [
  "missions_completed",
  "stars_earned",
  "category_completed",
  "practice_sessions",
  "questions_answered",
  "perfect_missions",
  "language_questions",
  "math_questions",
  "all_medals",
  "correct_streak",
  "cards_collected",
  "all_normal_albums_completed",
  "all_previous_legendaries",
] as const;

export type LegendaryUnlockType = (typeof LEGENDARY_UNLOCK_TYPES)[number];

export type LegendaryDef = {
  id: string;
  category: TematicaId;
  title: string;
  /** Emoji visual opcional (álbum / celebración). */
  emoji: string;
  rarity: "legendary";
  /** Nombre de archivo exacto bajo /public/assets/cromos/ */
  asset: string;
  description: string;
  unlockType: LegendaryUnlockType;
  /** Meta numérica cuando aplica. */
  target?: number;
  /** Para category_completed: temática de cromos normales. */
  categoryTarget?: TematicaId;
  /** Nombre oculto hasta desbloquear. */
  hidden: boolean;
  /** Orden dentro de la sección Legendarios / por categoría. */
  orden: number;
};

const img = (archivo: string) => `/assets/cromos/${archivo}`;

/**
 * Nombres de archivo ASCII (sin tildes) bajo /public/assets/cromos/.
 */
const ASSET_EQUITACION = "deportes_legendaria_equitacion.png";
const ASSET_CAMION = "transporte_legendaria_camion.png";

/**
 * Catálogo de los 15 legendarios.
 * Orden global: Marrakech al final (all_previous_legendaries).
 */
export const CATALOGO_LEGENDARIOS: readonly LegendaryDef[] = [
  // —— Animales
  {
    id: "legendario_animales_mariquita",
    category: "animales",
    title: "Mariquita",
    emoji: "🐞",
    rarity: "legendary",
    asset: "animales_legendaria_mariquita.png",
    description: "Completa 5 misiones.",
    unlockType: "missions_completed",
    target: 5,
    hidden: true,
    orden: 1,
  },
  {
    id: "legendario_animales_conejito",
    category: "animales",
    title: "Conejito",
    emoji: "🐰",
    rarity: "legendary",
    asset: "animales_legendaria_conejito.png",
    description: "Consigue 10 estrellas.",
    unlockType: "stars_earned",
    target: 10,
    hidden: true,
    orden: 2,
  },
  {
    id: "legendario_animales_pinguino",
    category: "animales",
    title: "Pingüino",
    emoji: "🐧",
    rarity: "legendary",
    asset: "animales_legendaria_pinguino.png",
    description: "Completa todos los cromos normales de Animales.",
    unlockType: "category_completed",
    categoryTarget: "animales",
    hidden: true,
    orden: 3,
  },

  // —— Transportes
  {
    id: "legendario_transportes_bicicleta",
    category: "transportes",
    title: "Bicicleta",
    emoji: "🚲",
    rarity: "legendary",
    asset: "transporte_legendaria_bicicleta.png",
    description: "Completa 10 sesiones de práctica.",
    unlockType: "practice_sessions",
    target: 10,
    hidden: true,
    orden: 4,
  },
  {
    id: "legendario_transportes_camion",
    category: "transportes",
    title: "Camión",
    emoji: "🚚",
    rarity: "legendary",
    asset: ASSET_CAMION,
    description: "Responde 200 preguntas.",
    unlockType: "questions_answered",
    target: 200,
    hidden: true,
    orden: 5,
  },
  {
    id: "legendario_transportes_submarino",
    category: "transportes",
    title: "Submarino",
    emoji: "🚢",
    rarity: "legendary",
    asset: "transportes_legendaria_submarino.png",
    description: "Consigue 5 misiones perfectas.",
    unlockType: "perfect_missions",
    target: 5,
    hidden: true,
    orden: 6,
  },

  // —— Comidas
  {
    id: "legendario_comidas_espaguetti",
    category: "comidas",
    title: "Espaguetti",
    emoji: "🍝",
    rarity: "legendary",
    asset: "comidas_legendaria_spaguetti.png",
    description: "Responde correctamente 75 preguntas de Lengua.",
    unlockType: "language_questions",
    target: 75,
    hidden: true,
    orden: 7,
  },
  {
    id: "legendario_comidas_gofre",
    category: "comidas",
    title: "Gofre",
    emoji: "🧇",
    rarity: "legendary",
    asset: "comidas_legendaria_gofre.png",
    description: "Consigue 20 estrellas.",
    unlockType: "stars_earned",
    target: 20,
    hidden: true,
    orden: 8,
  },
  {
    id: "legendario_comidas_huevos",
    category: "comidas",
    title: "Huevos con patatas",
    emoji: "🍳",
    rarity: "legendary",
    asset: "comidas_legendaria_huevos-con-patatas.png",
    description: "Consigue todas las medallas.",
    unlockType: "all_medals",
    hidden: true,
    orden: 9,
  },

  // —— Deportes
  {
    id: "legendario_deportes_rugby",
    category: "deportes",
    title: "Rugby",
    emoji: "🏉",
    rarity: "legendary",
    asset: "deportes_legendaria_rugby.png",
    description: "Responde correctamente 100 preguntas de Matemáticas.",
    unlockType: "math_questions",
    target: 100,
    hidden: true,
    orden: 10,
  },
  {
    id: "legendario_deportes_patinaje",
    category: "deportes",
    title: "Patinaje sobre hielo",
    emoji: "⛸",
    rarity: "legendary",
    asset: "deportes_legendaria_patinaje-sobre-hielo.png",
    description: "Consigue una racha de 15 respuestas correctas.",
    unlockType: "correct_streak",
    target: 15,
    hidden: true,
    orden: 11,
  },
  {
    id: "legendario_deportes_equitacion",
    category: "deportes",
    title: "Equitación",
    emoji: "🐴",
    rarity: "legendary",
    asset: ASSET_EQUITACION,
    description: "Completa 20 misiones.",
    unlockType: "missions_completed",
    target: 20,
    hidden: true,
    orden: 12,
  },

  // —— Ciudades
  {
    id: "legendario_ciudades_nueva_york",
    category: "ciudades",
    title: "Nueva York",
    emoji: "🗽",
    rarity: "legendary",
    asset: "ciudades_legendaria_nueva-york.png",
    description: "Consigue 30 cromos distintos.",
    unlockType: "cards_collected",
    target: 30,
    hidden: true,
    orden: 13,
  },
  {
    id: "legendario_ciudades_tokio",
    category: "ciudades",
    title: "Tokio",
    emoji: "🗼",
    rarity: "legendary",
    asset: "ciudades_legendaria_tokio.png",
    description: "Completa todos los álbumes normales.",
    unlockType: "all_normal_albums_completed",
    hidden: true,
    orden: 14,
  },
  {
    id: "legendario_ciudades_marrakech",
    category: "ciudades",
    title: "Marrakech",
    emoji: "🕌",
    rarity: "legendary",
    asset: "ciudades_legendaria_marrakech.png",
    description: "Consigue los otros 14 legendarios.",
    unlockType: "all_previous_legendaries",
    hidden: true,
    orden: 15,
  },
] as const;

export type LegendaryId = (typeof CATALOGO_LEGENDARIOS)[number]["id"];

/** Fila meta en cromos_nino: diamantes_gastados = mejor racha de aciertos. */
export const META_RACHA_CORRECTAS_ID = "__meta_racha_correctas" as const;

export function legendarioPorId(id: string): LegendaryDef | undefined {
  return CATALOGO_LEGENDARIOS.find((l) => l.id === id);
}

export function esIdLegendario(id: string): boolean {
  return CATALOGO_LEGENDARIOS.some((l) => l.id === id);
}

export function imagenLegendario(def: LegendaryDef): string {
  return img(def.asset);
}

export function legendariosDeCategoria(category: TematicaId): LegendaryDef[] {
  return CATALOGO_LEGENDARIOS.filter((l) => l.category === category).sort(
    (a, b) => a.orden - b.orden,
  );
}

/** IDs de los 14 anteriores a Marrakech. */
export function idsLegendariosPreviosAMarrakech(): string[] {
  return CATALOGO_LEGENDARIOS.filter(
    (l) => l.unlockType !== "all_previous_legendaries",
  ).map((l) => l.id);
}
