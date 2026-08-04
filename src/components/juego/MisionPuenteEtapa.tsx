"use client";

import { motion, useReducedMotion } from "framer-motion";
import { Pantalla } from "@/components/ui";
import { Solete, type SoleteMood } from "@/components/solete";

type Props = {
  emoji: string;
  title: string;
  body: string;
  mood: SoleteMood;
  accentColor: string;
};

/**
 * Puente elegante entre etapas (sin confeti ni partículas).
 */
export function MisionPuenteEtapa({
  emoji,
  title,
  body,
  mood,
  accentColor,
}: Props) {
  const reducir = useReducedMotion();

  return (
    <Pantalla centrar className="fondo-halo-sol" sinAtmosfera>
      <motion.div
        className="flex w-full max-w-sm flex-col items-center text-center"
        initial={reducir ? false : { opacity: 0, scale: 0.92, y: 12 }}
        animate={{ opacity: 1, scale: 1, y: 0 }}
        exit={reducir ? undefined : { opacity: 0, y: -10 }}
        transition={{
          type: "spring",
          stiffness: 320,
          damping: 22,
          mass: 0.85,
        }}
      >
        <Solete mood={mood} size="xl" priority alt="" />
        <p
          className="mt-4 font-titulo text-4xl"
          aria-hidden
          style={{ filter: "saturate(1.05)" }}
        >
          {emoji}
        </p>
        <h1
          className="mt-2 font-titulo text-3xl font-semibold leading-tight sm:text-4xl"
          style={{ color: accentColor }}
        >
          {title}
        </h1>
        <p className="mt-3 font-cuerpo text-lg text-readable">{body}</p>
        <motion.div
          className="mt-8 h-1 w-16 rounded-full"
          style={{ backgroundColor: accentColor }}
          initial={reducir ? false : { scaleX: 0.4, opacity: 0.5 }}
          animate={{ scaleX: 1, opacity: 1 }}
          transition={{ duration: reducir ? 0 : 0.55 }}
        />
      </motion.div>
    </Pantalla>
  );
}
