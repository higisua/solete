/**
 * Helpers de ordenación / mensajes para la UI de medallas.
 * No otorgan ni cambian progreso.
 */

import type { MedallaVistaItem } from "@/lib/juego/medallas-vista";
import type { SoleteMood } from "@/components/solete/moods";

/** Cuánto falta para completar (Infinity si no hay barra). */
export function restanteProgreso(item: MedallaVistaItem): number {
  if (item.conseguida || !item.progreso || item.progreso.meta <= 0) {
    return Number.POSITIVE_INFINITY;
  }
  return Math.max(0, item.progreso.meta - item.progreso.actual);
}

export function ratioProgreso(item: MedallaVistaItem): number {
  if (!item.progreso || item.progreso.meta <= 0) return -1;
  return item.progreso.actual / item.progreso.meta;
}

/**
 * Las N medallas pendientes más cercanas (con progreso iniciable).
 */
export function medallasCercanas(
  items: MedallaVistaItem[],
  limite = 4,
): MedallaVistaItem[] {
  const conBarra = items.filter(
    (m) => !m.conseguida && m.progreso && m.progreso.meta > 0,
  );

  const ordenadas = [...conBarra].sort((a, b) => {
    const ra = restanteProgreso(a);
    const rb = restanteProgreso(b);
    if (ra !== rb) return ra - rb;
    return ratioProgreso(b) - ratioProgreso(a);
  });

  // Prioriza las que ya tienen algo de progreso; completa con las demás.
  const conAvance = ordenadas.filter((m) => m.progreso!.actual > 0);
  const sinAvance = ordenadas.filter((m) => m.progreso!.actual <= 0);
  return [...conAvance, ...sinAvance].slice(0, limite);
}

export function mensajeProxima(item: MedallaVistaItem | null): string {
  if (!item?.progreso) {
    return "¡Sigue jugando para conseguir más medallas!";
  }
  const left = restanteProgreso(item);
  if (left <= 0) return `¡Ya casi tienes «${item.nombre}»!`;
  if (left === 1) {
    return `Solo te falta un poco para «${item.nombre}».`;
  }
  return `Te faltan ${left} para «${item.nombre}».`;
}

export function moodMedallas(opts: {
  conseguidas: number;
  total: number;
  cercanas: number;
}): SoleteMood {
  if (opts.total > 0 && opts.conseguidas >= opts.total) return "love";
  if (opts.cercanas > 0) return "happy";
  if (opts.conseguidas > 0) return "cheer";
  return "wave";
}
