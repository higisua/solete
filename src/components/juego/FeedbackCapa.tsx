"use client";

import { Check } from "lucide-react";
import { motion, useReducedMotion } from "framer-motion";
import { Solete } from "@/components/solete";

type Props = {
  acierto: boolean;
  textoCorrecto?: string;
};

/**
 * Capa de feedback ligera (no pantalla muerta).
 * Solete celebra o acompaña; sin cruces agresivas.
 */
export function FeedbackCapa({ acierto, textoCorrecto }: Props) {
  const reducir = useReducedMotion();

  return (
    <motion.div
      className="pointer-events-none absolute inset-x-0 bottom-0 z-20 flex flex-col items-center px-4 pb-2 pt-8"
      initial={reducir ? false : { opacity: 0, y: 12 }}
      animate={{ opacity: 1, y: 0 }}
      exit={reducir ? undefined : { opacity: 0, y: 8 }}
      transition={{ duration: reducir ? 0 : 0.2 }}
      role="status"
      aria-live="polite"
    >
      <div
        className={`flex w-full max-w-sm flex-col items-center rounded-card px-5 py-4 text-center shadow-elevated ${
          acierto
            ? "bg-[#E8F7F0]/97 ring-2 ring-mar/25"
            : "bg-[#FFF8F0]/97 ring-2 ring-sol-claro/35"
        }`}
      >
        <Solete
          mood={acierto ? "cheer" : "nervous"}
          size="lg"
          priority
          alt=""
        />

        {acierto ? (
          <motion.div
            className="mt-2 flex h-10 w-10 items-center justify-center rounded-full bg-mar text-white shadow-[0_3px_0_0_rgba(18,110,80,0.28)]"
            initial={reducir ? false : { scale: 0.5, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={
              reducir
                ? { duration: 0 }
                : { type: "spring", stiffness: 420, damping: 14 }
            }
            aria-hidden
          >
            <Check className="h-5 w-5 stroke-[3]" />
          </motion.div>
        ) : null}

        <motion.p
          className="mt-2 font-titulo text-3xl font-semibold text-primary"
          initial={reducir ? false : { opacity: 0, y: 6 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: reducir ? 0 : 0.06, duration: 0.2 }}
        >
          {acierto ? "¡Muy bien!" : "¡Casi!"}
        </motion.p>

        {!acierto && textoCorrecto ? (
          <motion.p
            className="mt-1.5 max-w-xs font-cuerpo text-base leading-snug text-readable"
            initial={reducir ? false : { opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: reducir ? 0 : 0.1 }}
          >
            Era:{" "}
            <span className="font-semibold text-primary">{textoCorrecto}</span>
          </motion.p>
        ) : null}
      </div>
    </motion.div>
  );
}
