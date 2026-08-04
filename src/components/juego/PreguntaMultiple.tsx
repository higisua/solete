"use client";

import { Check } from "lucide-react";
import { motion, useReducedMotion } from "framer-motion";
import { cn } from "@/lib/cn";

type Props = {
  opciones: string[];
  onElegir: (valor: string) => void;
  disabled?: boolean;
  elegida?: string | null;
  correcta?: string | null;
  revelada?: boolean;
};

/**
 * Opciones grandes, infantiles y táctiles. Feedback inmediato al pulsar.
 */
export function PreguntaMultiple({
  opciones,
  onElegir,
  disabled,
  elegida = null,
  correcta = null,
  revelada = false,
}: Props) {
  const reducir = useReducedMotion();
  const visibles = opciones.slice(0, 4);

  return (
    <div className="flex flex-col gap-3.5">
      {visibles.map((opcion, index) => {
        const letra = String.fromCharCode(65 + index);
        const esElegida = elegida != null && opcion === elegida;
        const esCorrecta = correcta != null && opcion === correcta;

        let estado: "idle" | "acierto" | "fallo" = "idle";
        if (revelada) {
          if (esCorrecta) estado = "acierto";
          else if (esElegida) estado = "fallo";
        }

        return (
          <motion.button
            key={`${index}-${opcion}`}
            type="button"
            disabled={disabled || revelada}
            onClick={() => onElegir(opcion)}
            whileTap={
              disabled || revelada || reducir
                ? undefined
                : { scale: 0.97, y: 2 }
            }
            animate={
              revelada && estado === "acierto" && !reducir
                ? { scale: [1, 1.035, 1] }
                : revelada && estado === "fallo" && !reducir
                  ? { x: [0, -5, 5, -3, 3, 0] }
                  : { scale: 1, x: 0 }
            }
            transition={
              estado === "fallo"
                ? { duration: 0.32 }
                : estado === "acierto"
                  ? { duration: 0.4, ease: [0.22, 1, 0.36, 1] }
                  : { duration: 0.1 }
            }
            className={cn(
              "relative flex min-h-[4.85rem] w-full items-center gap-3.5 overflow-hidden rounded-[1.35rem] border-[2.5px] bg-surface px-4 py-3.5 text-left shadow-[0_5px_0_0_rgba(216,90,48,0.12)] transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus sm:min-h-[5.25rem]",
              estado === "idle" && "border-border",
              estado === "acierto" &&
                "border-mar bg-mar-claro/35 shadow-[0_5px_0_0_rgba(29,158,117,0.3)]",
              estado === "fallo" &&
                "border-sol-claro/60 bg-[#FFF5EE] shadow-[0_5px_0_0_rgba(216,90,48,0.1)]",
              (disabled || revelada) && "cursor-default",
            )}
          >
            {estado === "acierto" && !reducir ? (
              <motion.span
                aria-hidden
                className="pointer-events-none absolute inset-0 bg-gradient-to-r from-transparent via-white/45 to-transparent"
                initial={{ x: "-100%" }}
                animate={{ x: "120%" }}
                transition={{ duration: 0.55, ease: "easeOut" }}
              />
            ) : null}

            <span
              className={cn(
                "relative flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl font-titulo text-xl font-semibold text-text-inverse sm:h-[3.25rem] sm:w-[3.25rem]",
                estado === "acierto"
                  ? "bg-mar"
                  : estado === "fallo"
                    ? "bg-sol-claro"
                    : "bg-primary",
              )}
              aria-hidden
            >
              {estado === "acierto" ? (
                <Check className="h-6 w-6 stroke-[3]" />
              ) : (
                letra
              )}
            </span>
            <span className="relative font-titulo text-[1.35rem] font-semibold leading-snug text-primary sm:text-2xl">
              {opcion}
            </span>
          </motion.button>
        );
      })}
    </div>
  );
}
