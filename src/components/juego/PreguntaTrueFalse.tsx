"use client";

import { Check } from "lucide-react";
import { motion, useReducedMotion } from "framer-motion";
import { cn } from "@/lib/cn";

type Props = {
  onElegir: (valor: boolean) => void;
  disabled?: boolean;
  elegida?: boolean | null;
  correcta?: boolean | null;
  revelada?: boolean;
};

export function PreguntaTrueFalse({
  onElegir,
  disabled,
  elegida = null,
  correcta = null,
  revelada = false,
}: Props) {
  const reducir = useReducedMotion();

  function clases(valor: boolean) {
    const esElegida = elegida === valor;
    const esCorrecta = correcta === valor;

    if (revelada) {
      if (esCorrecta) {
        return "border-mar bg-mar text-text-inverse shadow-[0_5px_0_0_rgba(18,110,80,0.35)]";
      }
      if (esElegida) {
        return "border-sol-claro/60 bg-[#FFF5EE] text-primary shadow-[0_5px_0_0_rgba(216,90,48,0.12)]";
      }
      return "border-border bg-surface/65 text-readable opacity-70";
    }

    return valor
      ? "border-mar/35 bg-surface text-mar shadow-[0_5px_0_0_rgba(29,158,117,0.22)]"
      : "border-sol/30 bg-surface text-primary shadow-[0_5px_0_0_rgba(216,90,48,0.16)]";
  }

  return (
    <div className="grid grid-cols-2 gap-3.5">
      {[
        { valor: true, label: "Verdadero" },
        { valor: false, label: "Falso" },
      ].map((op) => {
        const esCorrecta = revelada && correcta === op.valor;
        const esFallo =
          revelada && elegida === op.valor && correcta !== op.valor;

        return (
          <motion.button
            key={String(op.valor)}
            type="button"
            disabled={disabled || revelada}
            onClick={() => onElegir(op.valor)}
            whileTap={
              disabled || revelada || reducir
                ? undefined
                : { scale: 0.96, y: 2 }
            }
            animate={
              esFallo && !reducir
                ? { x: [0, -5, 5, -3, 3, 0] }
                : esCorrecta && !reducir
                  ? { scale: [1, 1.05, 1] }
                  : { scale: 1, x: 0 }
            }
            transition={{ duration: esFallo ? 0.32 : 0.35 }}
            className={cn(
              "relative flex min-h-[6.5rem] items-center justify-center overflow-hidden rounded-[1.35rem] border-[2.5px] px-3 font-titulo text-2xl font-semibold leading-tight focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus sm:min-h-[7rem] sm:text-[1.65rem]",
              clases(op.valor),
            )}
          >
            {esCorrecta && !reducir ? (
              <motion.span
                aria-hidden
                className="pointer-events-none absolute inset-0 bg-gradient-to-r from-transparent via-white/35 to-transparent"
                initial={{ x: "-100%" }}
                animate={{ x: "120%" }}
                transition={{ duration: 0.5, ease: "easeOut" }}
              />
            ) : null}
            {esCorrecta ? (
              <span className="absolute right-2.5 top-2.5 flex h-8 w-8 items-center justify-center rounded-full bg-white/25">
                <Check className="h-5 w-5 stroke-[3]" aria-hidden />
              </span>
            ) : null}
            <span className="relative">{op.label}</span>
          </motion.button>
        );
      })}
    </div>
  );
}
