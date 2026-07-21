import type { RarezaCromo } from "@/lib/juego/cromos-catalogo";

export const COLORES_RAREZA: Record<
  RarezaCromo,
  { hex: string; label: string; confeti: string[] }
> = {
  comun: {
    hex: "#7EA9C6",
    label: "Común",
    confeti: ["#7EA9C6", "#A8C8DC", "#5B8FAF", "#D6E6F0"],
  },
  raro: {
    hex: "#4FB08D",
    label: "Raro",
    confeti: ["#4FB08D", "#7BC9AB", "#2F8F6E", "#C5EBD9"],
  },
  especial: {
    hex: "#E09A2E",
    label: "Especial",
    confeti: ["#E09A2E", "#F0C05A", "#C87A12", "#FFE6B0", "#FFF3DC"],
  },
};
