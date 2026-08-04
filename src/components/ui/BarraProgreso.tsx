"use client";

import { motion, useReducedMotion } from "framer-motion";
import { cn } from "@/lib/cn";

type Props = {
  valor: number;
  max?: number;
  className?: string;
  size?: "sm" | "md" | "lg";
  tono?: "mar" | "sol";
  "aria-label"?: string;
  /** Barra viva con scaleX (GPU). Por defecto true. */
  viva?: boolean;
};

/**
 * Barra de progreso de misión. Avanza con spring; nunca de golpe.
 */
export function BarraProgreso({
  valor,
  max = 100,
  className,
  size = "md",
  tono = "mar",
  viva = true,
  "aria-label": ariaLabel,
}: Props) {
  const reducir = useReducedMotion();
  const pct = max > 0 ? Math.min(1, Math.max(0, valor / max)) : 0;

  const alturas = {
    sm: "h-2.5",
    md: "h-4",
    lg: "h-5",
  } as const;

  return (
    <div
      className={cn(
        "relative w-full overflow-hidden rounded-full bg-black/[0.07] shadow-inner",
        alturas[size],
        className,
      )}
      role="progressbar"
      aria-valuenow={Math.round(valor)}
      aria-valuemin={0}
      aria-valuemax={Math.round(max)}
      aria-label={ariaLabel}
    >
      {viva ? (
        <motion.div
          className={cn(
            "relative h-full w-full origin-left overflow-hidden rounded-full will-change-transform",
            tono === "mar"
              ? "bg-gradient-to-r from-mar to-mar-claro"
              : "bg-gradient-to-r from-sol to-sol-claro",
          )}
          initial={false}
          animate={{ scaleX: pct }}
          transition={
            reducir
              ? { duration: 0 }
              : {
                  type: "spring",
                  stiffness: 130,
                  damping: 22,
                  mass: 0.65,
                }
          }
        >
          {!reducir && valor > 0 ? (
            <motion.span
              key={valor}
              aria-hidden
              className="pointer-events-none absolute inset-y-0 w-1/3 bg-gradient-to-r from-transparent via-white/45 to-transparent"
              initial={{ x: "-130%" }}
              animate={{ x: "230%" }}
              transition={{ duration: 0.5, ease: "easeOut" }}
            />
          ) : null}
        </motion.div>
      ) : (
        <motion.div
          className={cn(
            "h-full rounded-full",
            tono === "mar" ? "bg-mar" : "bg-sol",
          )}
          initial={false}
          animate={{ width: `${pct * 100}%` }}
          transition={
            reducir
              ? { duration: 0 }
              : { type: "spring", stiffness: 160, damping: 24 }
          }
        />
      )}
    </div>
  );
}
