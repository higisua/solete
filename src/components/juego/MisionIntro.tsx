"use client";

import { motion, useReducedMotion } from "framer-motion";
import { Boton, Pantalla } from "@/components/ui";
import { Solete, type SoleteMood } from "@/components/solete";

type Props = {
  title: string;
  body: string;
  cta: string;
  mood: SoleteMood;
  onEmpezar: () => void;
};

/**
 * Pantalla breve al inicio de la misión diaria.
 */
export function MisionIntro({ title, body, cta, mood, onEmpezar }: Props) {
  const reducir = useReducedMotion();

  return (
    <Pantalla centrar className="fondo-halo-sol" sinAtmosfera>
      <motion.div
        className="flex w-full max-w-sm flex-col items-center text-center"
        initial={reducir ? false : { opacity: 0, y: 16 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: reducir ? 0 : 0.28, ease: [0.22, 1, 0.36, 1] }}
      >
        <Solete mood={mood} size="hero" priority alt="" />
        <h1 className="mt-4 font-titulo text-3xl font-semibold leading-tight text-primary sm:text-4xl">
          {title}
        </h1>
        <p className="mt-3 font-cuerpo text-lg text-readable">{body}</p>
        <div className="mt-8 w-full">
          <Boton type="button" variant="primario" size="lg" onClick={onEmpezar}>
            {cta}
          </Boton>
        </div>
      </motion.div>
    </Pantalla>
  );
}
