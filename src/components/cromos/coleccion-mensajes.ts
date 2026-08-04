import type { TematicaId } from "@/lib/juego/cromos-catalogo";
import type { SoleteMood } from "@/components/solete/moods";

export const TEMATICA_EMOJI: Record<TematicaId, string> = {
  animales: "🐾",
  ciudades: "🌆",
  comidas: "🍽️",
  deportes: "⚽",
  transportes: "🚗",
};

export type TipColeccion = {
  text: string;
  mood: SoleteMood;
};

/**
 * Tip de Solete para la colección (solo si aporta valor).
 */
export function tipColeccion(opts: {
  normalesConseguidos: number;
  normalesTotal: number;
  legendariosConseguidos: number;
  categoriasCompletas: number;
  categoriasTotal: number;
  faltanEnMejorCategoria: number | null;
}): TipColeccion | null {
  const {
    normalesConseguidos,
    normalesTotal,
    legendariosConseguidos,
    categoriasCompletas,
    categoriasTotal,
    faltanEnMejorCategoria,
  } = opts;

  if (
    normalesConseguidos >= normalesTotal &&
    normalesTotal > 0 &&
    legendariosConseguidos > 0
  ) {
    return {
      text: "¡Colección casi mágica! Sigue con los legendarios.",
      mood: "gift",
    };
  }

  if (categoriasCompletas >= categoriasTotal && categoriasTotal > 0) {
    return {
      text: "¡Todas las categorías completas!",
      mood: "cheer",
    };
  }

  if (categoriasCompletas > 0) {
    return {
      text: `¡Genial! Ya completaste ${categoriasCompletas} ${categoriasCompletas === 1 ? "categoría" : "categorías"}.`,
      mood: "cheer",
    };
  }

  if (faltanEnMejorCategoria === 1) {
    return { text: "¡Solo te queda uno!", mood: "happy" };
  }
  if (faltanEnMejorCategoria === 2) {
    return { text: "¡Solo te quedan dos!", mood: "happy" };
  }

  if (legendariosConseguidos > 0) {
    return {
      text: "¡Ya tienes legendarios! Entra en un mundo para verlos.",
      mood: "gift",
    };
  }

  return null;
}

export function tipCategoria(opts: {
  normalesConseguidos: number;
  normalesTotal: number;
  legendariosConseguidos: number;
  legendariosTotal: number;
}): TipColeccion | null {
  const {
    normalesConseguidos,
    normalesTotal,
    legendariosConseguidos,
    legendariosTotal,
  } = opts;

  if (
    normalesConseguidos >= normalesTotal &&
    normalesTotal > 0 &&
    legendariosConseguidos >= legendariosTotal &&
    legendariosTotal > 0
  ) {
    return { text: "¡Categoría completa!", mood: "cheer" };
  }

  if (normalesConseguidos >= normalesTotal && normalesTotal > 0) {
    return {
      text: "¡Álbum listo! Ahora los legendarios.",
      mood: "cheer",
    };
  }

  const faltan = normalesTotal - normalesConseguidos;
  if (faltan === 1) return { text: "¡Solo te queda uno!", mood: "happy" };
  if (faltan === 2) return { text: "¡Solo te quedan dos!", mood: "happy" };

  if (legendariosConseguidos > 0) {
    return { text: "¡Legendario conseguido!", mood: "gift" };
  }

  return null;
}
