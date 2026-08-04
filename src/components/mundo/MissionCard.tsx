"use client";

import Link from "next/link";
import { Check, Star } from "lucide-react";
import { motion, useReducedMotion } from "framer-motion";
import { Boton } from "@/components/ui";
import { cn } from "@/lib/cn";
import { MISSION_STAGES } from "@/lib/juego/mission-stages";
import { MISION_OBJETIVO } from "@/lib/juego/reglas";

type Props = {
  completada: boolean;
  estrellasHoy: number;
  className?: string;
};

/**
 * Acción principal del Mundo: la misión / aventura del día.
 * Ocupa el foco visual; único CTA primario.
 */
export function MissionCard({
  completada,
  estrellasHoy,
  className,
}: Props) {
  const reducir = useReducedMotion();
  const retos = MISSION_STAGES.stages.length;

  return (
    <section
      className={cn(
        "relative flex min-h-0 flex-1 flex-col items-center justify-center text-center",
        className,
      )}
      aria-label={completada ? "Misión de hoy completada" : "Misión del día"}
    >
      <div
        aria-hidden
        className="pointer-events-none absolute inset-x-8 top-1/2 h-40 -translate-y-1/2 rounded-full bg-[#FFF3DC]/80 blur-3xl sm:h-48"
      />

      <div className="relative z-10 flex w-full max-w-sm flex-col items-center">
        {completada ? (
          <>
            <span className="inline-flex items-center gap-1.5 font-titulo text-sm font-semibold text-mar">
              <Check className="h-4 w-4 stroke-[2.5]" aria-hidden />
              Aventura de hoy hecha
            </span>

            <div
              className="mt-4 flex items-center justify-center gap-2.5 sm:gap-3"
              aria-label={`${estrellasHoy} estrellas hoy`}
            >
              {[1, 2, 3].map((n) => {
                const ganada = n <= estrellasHoy;
                return (
                  <motion.span
                    key={n}
                    initial={
                      reducir ? false : { opacity: 0, scale: 0.35, y: 14 }
                    }
                    animate={{
                      opacity: ganada ? 1 : 0.28,
                      scale: ganada ? 1 : 0.85,
                      y: 0,
                    }}
                    transition={{
                      delay: reducir ? 0 : 0.12 + (n - 1) * 0.14,
                      type: "spring",
                      stiffness: 380,
                      damping: 14,
                    }}
                  >
                    <Star
                      className={
                        ganada
                          ? "h-12 w-12 fill-[#FAC775] stroke-[#E8A84A] drop-shadow-[0_4px_8px_rgba(232,168,74,0.4)] sm:h-14 sm:w-14"
                          : "h-12 w-12 fill-[#D4CBBE] stroke-[#B8AFA3] sm:h-14 sm:w-14"
                      }
                      strokeWidth={1.5}
                      aria-hidden
                    />
                  </motion.span>
                );
              })}
            </div>

            <p className="mt-4 max-w-[16rem] font-titulo text-xl font-semibold leading-snug text-primary sm:text-2xl">
              ¡Hasta mañana!
            </p>

            <Link
              href="/practica"
              className="mt-5 font-titulo text-base font-semibold text-mar underline-offset-4 transition hover:underline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus"
            >
              Seguir practicando
            </Link>
          </>
        ) : (
          <>
            <p className="font-titulo text-sm font-semibold uppercase tracking-wide text-sol">
              Aventura de hoy
            </p>
            <h2 className="mt-1.5 font-titulo text-[1.75rem] font-semibold leading-tight text-primary sm:text-3xl">
              ¡Tu misión te espera!
            </h2>
            <p className="mt-2 font-cuerpo text-base text-readable">
              {retos} retos · {MISION_OBJETIVO} preguntas
            </p>

            <motion.div
              className="mt-6 w-full"
              animate={
                reducir
                  ? undefined
                  : {
                      scale: [1, 1.03, 1],
                    }
              }
              transition={
                reducir
                  ? undefined
                  : {
                      duration: 2.4,
                      repeat: Infinity,
                      repeatDelay: 2.8,
                      ease: "easeInOut",
                    }
              }
            >
              <Boton href="/jugar/mision" variant="primario" size="lg">
                ¡Jugar!
              </Boton>
            </motion.div>
          </>
        )}
      </div>
    </section>
  );
}
