"use client";

import { Gem } from "lucide-react";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { Boton } from "@/components/ui";
import { Confeti } from "@/components/juego/Confeti";
import { InsigniaMedalla } from "@/components/medallas/InsigniaMedalla";
import type { MedallaDesbloqueada } from "@/lib/juego/medallas";
import type { MedallaId } from "@/lib/juego/medallas-catalogo";

type Props = {
  medallas: MedallaDesbloqueada[];
  indice: number;
  onContinuar: () => void;
};

/**
 * Fanfarria a pantalla completa. Si hay varias, el padre avanza el índice
 * (secuencia una a una) al pulsar «¡Genial!».
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
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-[#FFF8ED]/92 backdrop-blur-[2px]">
      <Confeti cantidad={48} />

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
            <p className="font-titulo text-2xl font-semibold text-sol sm:text-3xl">
              ¡Nueva medalla!
            </p>

            <motion.div
              className="mt-8"
              initial={
                reducir
                  ? false
                  : { opacity: 0, scale: 0.35, y: 48 }
              }
              animate={{ opacity: 1, scale: 1, y: 0 }}
              transition={{
                type: "spring",
                stiffness: 380,
                damping: 14,
                mass: 0.9,
                delay: reducir ? 0 : 0.08,
              }}
            >
              <InsigniaMedalla
                id={id}
                conseguida
                size="lg"
                conHalo
              />
            </motion.div>

            <motion.h2
              className="mt-6 font-titulo text-3xl font-semibold text-sol"
              initial={reducir ? false : { opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: reducir ? 0 : 0.35 }}
            >
              {medalla.nombre}
            </motion.h2>

            <motion.p
              className="mt-3 inline-flex items-center gap-2 font-titulo text-xl font-semibold text-mar"
              initial={reducir ? false : { opacity: 0, scale: 0.9 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ delay: reducir ? 0 : 0.45 }}
            >
              <Gem className="h-6 w-6 stroke-[1.75]" aria-hidden />+
              {medalla.diamantes}{" "}
              {medalla.diamantes === 1 ? "diamante" : "diamantes"}
            </motion.p>

            {medallas.length > 1 ? (
              <p className="mt-2 font-cuerpo text-sm text-black/40">
                {indice + 1} de {medallas.length}
              </p>
            ) : null}
          </motion.div>
        </AnimatePresence>

        <motion.div
          className="mt-10 w-full"
          initial={reducir ? false : { opacity: 0, y: 12 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: reducir ? 0 : 0.55 }}
        >
          <Boton type="button" variant="primario" onClick={onContinuar}>
            ¡Genial!
          </Boton>
        </motion.div>
      </div>
    </div>
  );
}
