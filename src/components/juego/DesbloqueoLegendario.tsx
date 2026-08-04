"use client";

import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { Boton } from "@/components/ui";
import { CromoCara, EtiquetaRareza } from "@/components/cromos/CromoCara";
import { Solete } from "@/components/solete";
import type { LegendarioDesbloqueado } from "@/lib/juego/legendarios-eval";

type Props = {
  legendarios: LegendarioDesbloqueado[];
  indice: number;
  onContinuar: () => void;
};

/**
 * Celebración premium al desbloquear un Legendario.
 * Sin confeti ni partículas: Solete cheer + carta grande + borde legendario.
 */
export function DesbloqueoLegendario({
  legendarios,
  indice,
  onContinuar,
}: Props) {
  const item = legendarios[indice];
  const reducir = useReducedMotion();
  if (!item) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-[#FFF8ED]/94 backdrop-blur-[3px]">
      <div className="relative z-20 flex w-full max-w-sm flex-col items-center px-6 text-center">
        <AnimatePresence mode="wait">
          <motion.div
            key={item.id}
            className="flex w-full flex-col items-center"
            initial={reducir ? false : { opacity: 0, y: 28 }}
            animate={{ opacity: 1, y: 0 }}
            exit={reducir ? undefined : { opacity: 0, y: -18 }}
            transition={{ duration: 0.32, ease: [0.22, 1, 0.36, 1] }}
          >
            <Solete mood="cheer" size="lg" priority alt="" />

            <p className="mt-3 font-titulo text-2xl font-semibold text-[#7A4FE0] sm:text-3xl">
              ¡Legendario!
            </p>

            <motion.div
              className="mt-6 w-full max-w-[15rem]"
              initial={
                reducir ? false : { opacity: 0, scale: 0.72, y: 36 }
              }
              animate={{ opacity: 1, scale: 1, y: 0 }}
              transition={{
                type: "spring",
                stiffness: 260,
                damping: 16,
                mass: 0.95,
                delay: reducir ? 0 : 0.1,
              }}
            >
              <CromoCara
                loTiene
                nombre={item.title}
                imagenSrc={item.imagenSrc}
                rareza="legendary"
                size="lg"
              />
            </motion.div>

            <motion.div
              className="mt-5 flex flex-col items-center gap-1.5"
              initial={reducir ? false : { opacity: 0, y: 12 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: reducir ? 0 : 0.28, duration: 0.3 }}
            >
              <EtiquetaRareza rareza="legendary" />
              <h2 className="font-titulo text-3xl font-semibold text-primary">
                {item.emoji} {item.title}
              </h2>
              <p className="mt-1 max-w-[18rem] font-cuerpo text-base text-readable">
                {item.description}
              </p>
            </motion.div>

            <motion.div
              className="mt-8 w-full"
              initial={reducir ? false : { opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: reducir ? 0 : 0.4 }}
            >
              <Boton type="button" variant="primario" size="lg" onClick={onContinuar}>
                ¡Genial!
              </Boton>
            </motion.div>
          </motion.div>
        </AnimatePresence>
      </div>
    </div>
  );
}
