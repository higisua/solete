/**
 * Agrupación visual de medallas (solo UI).
 * No cambia desbloqueos ni recompensas.
 */

import type { MedallaId } from "@/lib/juego/medallas-catalogo";

export type MedallaGrupoId =
  | "constancia"
  | "misiones"
  | "aprendizaje"
  | "coleccion"
  | "especiales";

export type MedallaGrupoDef = {
  id: MedallaGrupoId;
  emoji: string;
  titulo: string;
  medallaIds: readonly MedallaId[];
};

export const GRUPOS_MEDALLAS: readonly MedallaGrupoDef[] = [
  {
    id: "constancia",
    emoji: "☀️",
    titulo: "Constancia",
    medallaIds: [
      "primer_dia",
      "tres_dias",
      "semana",
      "quince_dias",
      "mes_completo",
    ],
  },
  {
    id: "misiones",
    emoji: "🏆",
    titulo: "Misiones",
    medallaIds: [
      "primer_perfecto",
      "estrella_fija",
      "diez_perfectos",
      "sin_fallar",
      "misiones_10",
      "misiones_25",
    ],
  },
  {
    id: "aprendizaje",
    emoji: "📚",
    titulo: "Aprendizaje",
    medallaIds: [
      "aprendiz",
      "aciertos_250",
      "sabelotodo",
      "practica_10",
      "practica_dia_25",
      "practica_50",
      "practica_100",
    ],
  },
  {
    id: "coleccion",
    emoji: "💎",
    titulo: "Colección",
    medallaIds: [
      "primer_cromo",
      "coleccion_10",
      "album_animales",
      "album_ciudades",
      "album_comidas",
      "album_deportes",
      "album_transportes",
    ],
  },
  {
    id: "especiales",
    emoji: "⭐",
    titulo: "Especiales",
    medallaIds: ["bienvenida"],
  },
] as const;

const GRUPO_POR_MEDALLA = new Map<MedallaId, MedallaGrupoId>();
for (const g of GRUPOS_MEDALLAS) {
  for (const id of g.medallaIds) GRUPO_POR_MEDALLA.set(id, g.id);
}

export function grupoDeMedalla(id: MedallaId): MedallaGrupoId {
  return GRUPO_POR_MEDALLA.get(id) ?? "especiales";
}
