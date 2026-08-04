"use client";

import Image from "next/image";
import {
  motion,
  useReducedMotion,
  type Transition,
  type TargetAndTransition,
} from "framer-motion";
import { cn } from "@/lib/cn";
import {
  rutaAssetSolete,
  SOLETE_SIZES,
  type SoleteMood,
  type SoleteSize,
} from "@/components/solete/moods";

export type SoleteProps = {
  mood: SoleteMood;
  size?: SoleteSize;
  /** Si false, solo muestra el PNG estático. Por defecto true. */
  animate?: boolean;
  className?: string;
  /** Alt descriptivo; vacío = decorativo. */
  alt?: string;
  priority?: boolean;
};

type AnimDef = {
  animate: TargetAndTransition;
  transition: Transition;
};

/**
 * Animaciones muy sutiles: personaje vivo, no cartoon exagerado.
 * Todas se anulan con prefers-reduced-motion.
 */
function animacionDeMood(mood: SoleteMood): AnimDef | null {
  switch (mood) {
    case "happy":
      return {
        animate: { y: [0, -3, 0], scale: [1, 1.015, 1] },
        transition: {
          duration: 3.2,
          repeat: Infinity,
          ease: "easeInOut",
        },
      };
    case "thinking":
      return {
        animate: { rotate: [-2.5, 2.5, -2.5] },
        transition: {
          duration: 3.6,
          repeat: Infinity,
          ease: "easeInOut",
        },
      };
    case "wave":
      return {
        animate: { rotate: [0, -4, 3, -2, 0] },
        transition: {
          duration: 2.4,
          repeat: Infinity,
          ease: "easeInOut",
          repeatDelay: 1.2,
        },
      };
    case "gift":
      return {
        animate: { y: [0, -5, 0] },
        transition: {
          duration: 1.1,
          repeat: Infinity,
          ease: "easeInOut",
          repeatDelay: 0.6,
        },
      };
    case "cheer":
      return {
        animate: { y: [0, -8, 0], scale: [1, 1.04, 1] },
        transition: {
          duration: 0.7,
          repeat: Infinity,
          ease: "easeOut",
          repeatDelay: 1.4,
        },
      };
    case "love":
      return {
        animate: { scale: [1, 1.035, 1] },
        transition: {
          duration: 1.35,
          repeat: Infinity,
          ease: "easeInOut",
        },
      };
    case "sleep":
      return {
        animate: { y: [0, -2, 0], scale: [1, 1.01, 1] },
        transition: {
          duration: 4.2,
          repeat: Infinity,
          ease: "easeInOut",
        },
      };
    case "nervous":
      return {
        animate: { x: [0, -2, 2, -1.5, 1.5, 0] },
        transition: {
          duration: 0.55,
          repeat: Infinity,
          ease: "easeInOut",
          repeatDelay: 0.9,
        },
      };
    case "cry":
      return null;
    default:
      return null;
  }
}

/**
 * Único punto de entrada para la mascota Solete.
 * No usar Image con /assets/mascot/… directamente.
 */
export function Solete({
  mood,
  size = "md",
  animate = true,
  className,
  alt = "",
  priority = false,
}: SoleteProps) {
  const reducir = useReducedMotion();
  const px = SOLETE_SIZES[size];
  const anim = animate && !reducir ? animacionDeMood(mood) : null;
  const decorativo = alt === "";

  return (
    <motion.div
      className={cn("relative inline-flex shrink-0 select-none", className)}
      style={{ width: px, height: px }}
      animate={anim?.animate}
      transition={anim?.transition}
      aria-hidden={decorativo || undefined}
    >
      <Image
        src={rutaAssetSolete(mood)}
        alt={alt}
        width={px * 2}
        height={px * 2}
        unoptimized
        priority={priority}
        draggable={false}
        className="h-full w-full object-contain drop-shadow-sm"
      />
    </motion.div>
  );
}

export type { SoleteMood, SoleteSize };
export { SOLETE_MOODS, SOLETE_SIZES, esSoleteMood, rutaAssetSolete } from "./moods";
