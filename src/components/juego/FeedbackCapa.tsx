"use client";

import Image from "next/image";
import { motion, useReducedMotion } from "framer-motion";
import { publicAssetClient } from "@/lib/public-asset-client";

type Props = {
  acierto: boolean;
  textoCorrecto?: string;
};

/**
 * Capa de feedback a pantalla casi completa.
 * Misma mascota PNG: salto alegre en acierto, ladeo suave en fallo.
 */
export function FeedbackCapa({ acierto, textoCorrecto }: Props) {
  const reducir = useReducedMotion();

  return (
    <motion.div
      className={`absolute inset-0 z-20 flex flex-col items-center justify-center px-6 text-center ${
        acierto ? "bg-[#E8F7F0]/95" : "bg-[#FDEBDF]/95"
      }`}
      initial={reducir ? false : { opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={reducir ? undefined : { opacity: 0 }}
      transition={{ duration: 0.2 }}
      role="status"
      aria-live="polite"
    >
      <motion.div
        initial={reducir ? false : { scale: 0.5, y: 20, opacity: 0 }}
        animate={
          acierto
            ? { scale: 1, y: [0, -14, 0], opacity: 1, rotate: 0 }
            : { scale: 1, y: 0, opacity: 1, rotate: -6 }
        }
        transition={
          acierto
            ? {
                scale: { type: "spring", stiffness: 380, damping: 14 },
                y: {
                  delay: 0.15,
                  duration: 0.55,
                  times: [0, 0.45, 1],
                  ease: "easeOut",
                },
                opacity: { duration: 0.2 },
              }
            : {
                type: "spring",
                stiffness: 260,
                damping: 18,
              }
        }
      >
        <Image
          src={publicAssetClient("assets/logos/solete_solo_logo.png")}
          alt=""
          width={160}
          height={160}
          unoptimized
          priority
          className="h-32 w-32 object-contain drop-shadow-md sm:h-36 sm:w-36"
          aria-hidden
        />
      </motion.div>

      <motion.p
        className="mt-5 font-titulo text-4xl font-semibold text-sol sm:text-5xl"
        initial={reducir ? false : { opacity: 0, y: 10 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.12, duration: 0.25 }}
      >
        {acierto ? "¡Muy bien!" : "¡Casi!"}
      </motion.p>

      {!acierto && textoCorrecto ? (
        <motion.p
          className="mt-3 max-w-xs font-cuerpo text-base leading-snug text-black/55 sm:text-lg"
          initial={reducir ? false : { opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.2 }}
        >
          La respuesta era:{" "}
          <span className="font-semibold text-sol">{textoCorrecto}</span>
        </motion.p>
      ) : null}
    </motion.div>
  );
}
