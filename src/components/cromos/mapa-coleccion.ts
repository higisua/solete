import type { TematicaId } from "@/lib/juego/cromos-catalogo";
import type { TematicaAlbum } from "@/lib/juego/cromos";
import type { LegendarioProgresoItem } from "@/lib/juego/legendarios-eval";
import { TEMATICA_EMOJI } from "@/components/cromos/coleccion-mensajes";

/** Acento visual por mundo (hub). */
export const MUNDO_COLORES: Record<
  TematicaId,
  { soft: string; accent: string }
> = {
  animales: { soft: "rgba(79, 176, 141, 0.18)", accent: "#4FB08D" },
  ciudades: { soft: "rgba(61, 122, 181, 0.18)", accent: "#3D7AB5" },
  comidas: { soft: "rgba(232, 168, 74, 0.2)", accent: "#E8A84A" },
  deportes: { soft: "rgba(216, 90, 48, 0.16)", accent: "#D85A30" },
  transportes: { soft: "rgba(126, 169, 198, 0.22)", accent: "#5B8FAF" },
};

export type MundoVista = {
  tema: TematicaAlbum;
  emoji: string;
  legendarios: LegendarioProgresoItem[];
  legConseguidos: number;
  legTotal: number;
  normalesCompletos: boolean;
  mundoCompleto: boolean;
  faltanNormales: number;
  /** 0–1 progreso normales. */
  ratioNormales: number;
};

export function mundosDesdeColeccion(
  tematicas: TematicaAlbum[],
  legendariosPorCat: Array<{
    category: TematicaId;
    items: LegendarioProgresoItem[];
  }>,
): MundoVista[] {
  return tematicas.map((tema) => {
    const legs =
      legendariosPorCat.find((g) => g.category === tema.id)?.items ?? [];
    const legConseguidos = legs.filter((l) => l.loTiene).length;
    const legTotal = legs.length;
    const normalesCompletos = tema.total > 0 && tema.conseguidos >= tema.total;
    const mundoCompleto =
      normalesCompletos && (legTotal === 0 || legConseguidos >= legTotal);
    const faltanNormales = Math.max(0, tema.total - tema.conseguidos);

    return {
      tema,
      emoji: TEMATICA_EMOJI[tema.id] ?? "📦",
      legendarios: legs,
      legConseguidos,
      legTotal,
      normalesCompletos,
      mundoCompleto,
      faltanNormales,
      ratioNormales: tema.total > 0 ? tema.conseguidos / tema.total : 0,
    };
  });
}

/** Mundo más cercano a completar (prioridad: faltan menos normales; luego legendarios). */
export function siguienteObjetivoMundo(
  mundos: MundoVista[],
): MundoVista | null {
  const pendientes = mundos.filter((m) => !m.mundoCompleto);
  if (pendientes.length === 0) return null;

  return [...pendientes].sort((a, b) => {
    if (a.faltanNormales !== b.faltanNormales) {
      return a.faltanNormales - b.faltanNormales;
    }
    const aLeg = a.legTotal - a.legConseguidos;
    const bLeg = b.legTotal - b.legConseguidos;
    return aLeg - bLeg;
  })[0]!;
}

export function etiquetaEstadoMundo(m: MundoVista): string {
  if (m.mundoCompleto) return "¡Completo!";
  if (m.normalesCompletos) return "Legendarios";
  if (m.faltanNormales <= 2 && m.faltanNormales > 0) return "¡Casi!";
  if (m.tema.conseguidos === 0) return "Por empezar";
  return "En curso";
}
