import {
  BookOpen,
  CalendarDays,
  CheckCircle2,
  Crosshair,
  Crown,
  Dumbbell,
  Flame,
  Sparkles,
  Star,
  Sun,
  Trophy,
  Zap,
  type LucideIcon,
} from "lucide-react";
import type { MedallaId } from "@/lib/juego/medallas-catalogo";

/** Icono de línea por medalla (misma identidad en rejilla y fanfarria). */
export const ICONOS_MEDALLA: Record<MedallaId, LucideIcon> = {
  primer_dia: Sun,
  tres_dias: Flame,
  semana: CalendarDays,
  mes_completo: Crown,
  primer_perfecto: Crosshair,
  estrella_fija: Star,
  sin_fallar: CheckCircle2,
  aprendiz: BookOpen,
  sabelotodo: Trophy,
  bienvenida: Sparkles,
  practica_10: Zap,
  practica_100: Dumbbell,
};

/** Medallas con barra de progreso (hitos acumulativos). */
export const MEDALLAS_CON_PROGRESO: ReadonlySet<MedallaId> = new Set([
  "tres_dias",
  "semana",
  "estrella_fija",
  "aprendiz",
  "sabelotodo",
  "mes_completo",
  "practica_10",
  "practica_100",
]);
