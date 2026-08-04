/**
 * Moods oficiales de la mascota Solete.
 * Único origen de verdad: no repetir strings sueltos en pantallas.
 */
export const SOLETE_MOODS = [
  "wave",
  "happy",
  "thinking",
  "nervous",
  "cry",
  "gift",
  "cheer",
  "love",
  "sleep",
] as const;

export type SoleteMood = (typeof SOLETE_MOODS)[number];

export function esSoleteMood(valor: string): valor is SoleteMood {
  return (SOLETE_MOODS as readonly string[]).includes(valor);
}

/** Ruta pública del PNG de un mood (assets existentes, sin modificar). */
export function rutaAssetSolete(mood: SoleteMood): string {
  return `/assets/mascot/${mood}.png`;
}

/**
 * Tamaños estándar del personaje (px CSS del lado corto).
 * No usar tamaños arbitrarios fuera de esta escala.
 */
export const SOLETE_SIZES = {
  xs: 40,
  sm: 56,
  md: 80,
  lg: 112,
  xl: 144,
  hero: 192,
} as const;

export type SoleteSize = keyof typeof SOLETE_SIZES;
