"use client";

import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { cn } from "@/lib/cn";
import type { EtapaPlan } from "@/lib/juego/mission-stages";

type Props = {
  plan: EtapaPlan[];
  etapaIndex: number;
  preguntaEnEtapa: number;
  preguntasEnEtapa: number;
  className?: string;
};

/**
 * Progreso dual: etapas (segmentos) + pregunta dentro del reto (n / 5).
 */
export function ProgresoMisionEtapas({
  plan,
  etapaIndex,
  preguntaEnEtapa,
  preguntasEnEtapa,
  className,
}: Props) {
  const reducir = useReducedMotion();
  const etapa = plan[etapaIndex] ?? plan[0];
  if (!etapa) return null;

  return (
    <div className={cn("w-full", className)}>
      <div className="flex items-center justify-between gap-2">
        <p className="min-w-0 truncate font-titulo text-base font-semibold text-primary sm:text-lg">
          <span aria-hidden>{etapa.def.emoji} </span>
          {etapa.def.title}
        </p>
        <p
          className="shrink-0 font-titulo text-sm font-semibold tabular-nums text-readable"
          aria-label={`Etapa ${etapaIndex + 1} de ${plan.length}`}
        >
          {etapaIndex + 1}/{plan.length}
        </p>
      </div>

      <div
        className="mt-2.5 flex gap-1.5"
        role="img"
        aria-label={`${etapaIndex} de ${plan.length} retos completados`}
      >
        {plan.map((e, i) => {
          const hecha = i < etapaIndex;
          const actual = i === etapaIndex;
          return (
            <motion.div
              key={e.def.id + String(i)}
              className="h-2.5 flex-1 rounded-full"
              style={{
                backgroundColor: hecha || actual ? e.def.color : e.def.colorSoft,
                opacity: hecha || actual ? 1 : 0.85,
                boxShadow: actual
                  ? `0 0 0 2px ${e.def.colorSoft}`
                  : undefined,
              }}
              initial={false}
              animate={
                actual && !reducir
                  ? { scaleY: [1, 1.15, 1] }
                  : { scaleY: 1 }
              }
              transition={{ duration: 0.35 }}
            />
          );
        })}
      </div>

      <div className="mt-3 flex items-baseline justify-between gap-2">
        <span className="font-cuerpo text-sm text-readable">Pregunta</span>
        <p
          className="inline-flex items-baseline gap-1 font-titulo text-base font-semibold text-primary"
          aria-label={`Pregunta ${preguntaEnEtapa} de ${preguntasEnEtapa}`}
        >
          <span className="relative inline-grid min-w-[1.4ch] place-items-center">
            <span className="invisible tabular-nums" aria-hidden>
              {preguntaEnEtapa}
            </span>
            <AnimatePresence mode="popLayout" initial={false}>
              <motion.span
                key={preguntaEnEtapa}
                className="absolute tabular-nums"
                initial={reducir ? false : { y: 10, opacity: 0 }}
                animate={{ y: 0, opacity: 1 }}
                exit={reducir ? undefined : { y: -10, opacity: 0 }}
                transition={{ duration: reducir ? 0 : 0.18 }}
              >
                {preguntaEnEtapa}
              </motion.span>
            </AnimatePresence>
          </span>
          <span className="text-readable/70" aria-hidden>
            /
          </span>
          <span className="tabular-nums text-readable">{preguntasEnEtapa}</span>
        </p>
      </div>

      <div
        className="mt-1.5 h-2 overflow-hidden rounded-full bg-black/[0.06]"
        role="progressbar"
        aria-valuenow={preguntaEnEtapa}
        aria-valuemin={0}
        aria-valuemax={preguntasEnEtapa}
      >
        <motion.div
          className="h-full w-full origin-left rounded-full"
          style={{ backgroundColor: etapa.def.color }}
          initial={false}
          animate={{
            scaleX: preguntasEnEtapa > 0 ? preguntaEnEtapa / preguntasEnEtapa : 0,
          }}
          transition={
            reducir
              ? { duration: 0 }
              : { type: "spring", stiffness: 280, damping: 24 }
          }
        />
      </div>
    </div>
  );
}
