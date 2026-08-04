"use client";

import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { cn } from "@/lib/cn";

type Props = {
  actual: number;
  total: number;
  className?: string;
};

/**
 * Contador de misión (1 / 20) con cambio de número animado.
 */
export function ContadorMision({ actual, total, className }: Props) {
  const reducir = useReducedMotion();

  return (
    <p
      className={cn(
        "inline-flex items-baseline gap-1.5 font-titulo text-base font-semibold text-primary sm:text-lg",
        className,
      )}
      aria-label={`Pregunta ${actual} de ${total}`}
    >
      <span className="relative inline-grid min-w-[1.6ch] place-items-center">
        <span className="invisible tabular-nums" aria-hidden>
          {actual}
        </span>
        <AnimatePresence mode="popLayout" initial={false}>
          <motion.span
            key={actual}
            className="absolute tabular-nums"
            initial={reducir ? false : { y: 12, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            exit={reducir ? undefined : { y: -12, opacity: 0 }}
            transition={{
              duration: reducir ? 0 : 0.2,
              ease: [0.22, 1, 0.36, 1],
            }}
          >
            {actual}
          </motion.span>
        </AnimatePresence>
      </span>
      <span className="text-readable/70" aria-hidden>
        /
      </span>
      <span className="tabular-nums text-readable">{total}</span>
    </p>
  );
}
