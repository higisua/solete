import {
  BookOpen,
  CalendarDays,
  CheckCircle2,
  Crosshair,
  Crown,
  Dumbbell,
  Flame,
  LayoutGrid,
  Sparkles,
  Star,
  Sun,
  Target,
  Trophy,
  Zap,
  type LucideIcon,
} from "lucide-react";
import type { MedallaId } from "@/lib/juego/medallas-catalogo";
import type { TematicaId } from "@/lib/juego/cromos-catalogo";

/** Icono de línea por medalla (misma identidad en rejilla y fanfarria). */
export const ICONOS_MEDALLA: Record<MedallaId, LucideIcon> = {
  primer_dia: Sun,
  tres_dias: Flame,
  semana: CalendarDays,
  quince_dias: Flame,
  mes_completo: Crown,
  primer_perfecto: Crosshair,
  estrella_fija: Star,
  diez_perfectos: Trophy,
  sin_fallar: CheckCircle2,
  aprendiz: BookOpen,
  aciertos_250: Target,
  sabelotodo: Trophy,
  misiones_10: CalendarDays,
  misiones_25: Crown,
  bienvenida: Sparkles,
  practica_10: Zap,
  practica_dia_25: Zap,
  practica_50: Dumbbell,
  practica_100: Dumbbell,
  primer_cromo: LayoutGrid,
  coleccion_10: LayoutGrid,
  album_animales: LayoutGrid,
  album_ciudades: LayoutGrid,
  album_comidas: LayoutGrid,
  album_deportes: LayoutGrid,
  album_transportes: LayoutGrid,
};

/** Medallas con barra de progreso (hitos acumulativos). */
export const MEDALLAS_CON_PROGRESO: ReadonlySet<MedallaId> = new Set([
  "tres_dias",
  "semana",
  "quince_dias",
  "estrella_fija",
  "diez_perfectos",
  "aprendiz",
  "aciertos_250",
  "sabelotodo",
  "misiones_10",
  "misiones_25",
  "mes_completo",
  "practica_10",
  "practica_dia_25",
  "practica_50",
  "practica_100",
  "primer_cromo",
  "coleccion_10",
  "album_animales",
  "album_ciudades",
  "album_comidas",
  "album_deportes",
  "album_transportes",
]);

/** MedallaId ↔ temática de cromos (bonus +3💎 al completar categoría). */
export const MEDALLA_POR_TEMATICA: Record<TematicaId, MedallaId> = {
  animales: "album_animales",
  ciudades: "album_ciudades",
  comidas: "album_comidas",
  deportes: "album_deportes",
  transportes: "album_transportes",
};
