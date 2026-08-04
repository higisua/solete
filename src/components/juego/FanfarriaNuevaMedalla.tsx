"use client";

import { Gem } from "lucide-react";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { Boton } from "@/components/ui";
import { InsigniaMedalla } from "@/components/medallas/InsigniaMedalla";
import { Solete } from "@/components/solete";
import type { MedallaDesbloqueada } from "@/lib/juego/medallas";
import type { MedallaId } from "@/lib/juego/medallas-catalogo";

type Props = {
  medallas: MedallaDesbloqueada[];
  indice: number;
  onContinuar: () => void;
};

/**
 * Celebración elegante al desbloquear medalla (sin confeti ni partículas).
 */
export function FanfarriaNuevaMedalla({
  medallas,
  indice,
  onContinuar,
}: Props) {
  const medalla = medallas[indice];
  const reducir = useReducedMotion();
  if (!medalla) return null;

  const id = medalla.id as MedallaId;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-[#FFF8ED]/94 backdrop-blur-[3px]">
      <div className="relative z-20 flex w-full max-w-sm flex-col items-center px-6 text-center">
        <AnimatePresence mode="wait">
          <motion.div
            key={medalla.id}
            className="flex w-full flex-col items-center"
            initial={reducir ? false : { opacity: 0, y: 24 }}
            animate={{ opacity: 1, y: 0 }}
            exit={reducir ? undefined : { opacity: 0, y: -16 }}
            transition={{ duration: 0.28 }}
          >
            <Solete mood="cheer" size="lg" priority alt="" />

            <p className="mt-3 font-titulo text-2xl font-semibold text-sol sm:text-3xl">
              ¡Nueva medalla!
            </p>

            <motion.div
              className="mt-6"
              initial={
                reducir ? false : { opacity: 0, scale: 0.35, y: 40 }
              }
              animate={{ opacity: 1, scale: 1, y: 0 }}
              transition={{
                type: "spring",
                stiffness: 340,
                damping: 15,
                mass: 0.9,
                delay: reducir ? 0 : 0.08,
              }}
            >
              <InsigniaMedalla id={id} estado="earned" size="lg" conHalo />
            </motion.div>

            <motion.h2
              className="mt-6 font-titulo text-3xl font-semibold text-primary"
              initial={reducir ? false : { opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: reducir ? 0 : 0.32 }}
            >
              {medalla.nombre}
            </motion.h2>

            <motion.p
              className="mt-3 inline-flex items-center gap-2 font-titulo text-xl font-semibold text-mar"
              initial={reducir ? false : { opacity: 0, scale: 0.9 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ delay: reducir ? 0 : 0.42 }}
            >
              <Gem className="h-6 w-6 stroke-[1.75]" aria-hidden />+
              {medalla.diamantes}{" "}
              {medalla.diamantes === 1 ? "diamante" : "diamantes"}
            </motion.p>

            {medallas.length > 1 ? (
              <p className="mt-2 font-cuerpo text-sm text-readable">
                {indice + 1} de {medallas.length}
              </p>
            ) : null}
          </motion.div>
        </AnimatePresence>

        <motion.div
          className="mt-10 w-full"
          initial={reducir ? false : { opacity: 0, y: 12 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: reducir ? 0 : 0.5 }}
        >
          <Boton type="button" variant="primario" onClick={onContinuar}>
            ¡Genial!
          </Boton>
        </motion.div>
      </div>
    </div>
  );
}
