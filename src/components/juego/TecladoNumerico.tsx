"use client";

import { Delete } from "lucide-react";
import { motion, useReducedMotion } from "framer-motion";
import { cn } from "@/lib/cn";

type Props = {
  valor: string;
  onChange: (valor: string) => void;
  onConfirmar: () => void;
  disabled?: boolean;
  revelada?: boolean;
  acerto?: boolean | null;
};

const TECLAS = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "borrar", "0", "ok"] as const;

/**
 * Teclado numérico estilo app moderna: teclas grandes y feedback inmediato.
 */
export function TecladoNumerico({
  valor,
  onChange,
  onConfirmar,
  disabled,
  revelada = false,
  acerto = null,
}: Props) {
  const reducir = useReducedMotion();

  function pulsar(tecla: (typeof TECLAS)[number]) {
    if (disabled || revelada) return;
    if (tecla === "borrar") {
      onChange(valor.slice(0, -1));
      return;
    }
    if (tecla === "ok") {
      onConfirmar();
      return;
    }
    if (valor.length >= 6) return;
    onChange(valor + tecla);
  }

  return (
    <div className="w-full">
      <motion.div
        className={cn(
          "mb-4 flex min-h-[4.25rem] items-center justify-center rounded-[1.35rem] border-[2.5px] px-4 py-3 text-center font-titulo text-4xl font-semibold transition-colors sm:min-h-[4.5rem] sm:text-5xl",
          revelada && acerto === true && "border-mar bg-mar-claro/30 text-mar",
          revelada &&
            acerto === false &&
            "border-sol-claro/60 bg-[#FFF5EE] text-primary",
          !revelada && "border-border bg-surface text-primary",
        )}
        aria-live="polite"
        animate={
          revelada && !reducir
            ? acerto
              ? { scale: [1, 1.045, 1] }
              : { x: [0, -5, 5, -3, 3, 0] }
            : { scale: 1, x: 0 }
        }
        transition={{ duration: 0.32 }}
      >
        {valor || "—"}
      </motion.div>
      <div className="grid grid-cols-3 gap-2.5 sm:gap-3">
        {TECLAS.map((tecla) => {
          const esOk = tecla === "ok";
          const esBorrar = tecla === "borrar";
          return (
            <motion.button
              key={tecla}
              type="button"
              disabled={disabled || revelada}
              onClick={() => pulsar(tecla)}
              whileTap={
                disabled || revelada || reducir
                  ? undefined
                  : { scale: 0.92, y: 2 }
              }
              transition={{ duration: 0.08 }}
              aria-label={esBorrar ? "Borrar" : esOk ? "Confirmar" : tecla}
              className={cn(
                "flex min-h-[3.65rem] items-center justify-center rounded-[1.15rem] font-titulo text-[1.65rem] font-semibold focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus sm:min-h-16 sm:text-3xl",
                esOk &&
                  "bg-secondary text-text-inverse shadow-[0_4px_0_0_rgba(18,110,80,0.35)]",
                esBorrar &&
                  "bg-[#FFE8DC] text-primary shadow-[0_4px_0_0_rgba(216,90,48,0.14)]",
                !esOk &&
                  !esBorrar &&
                  "border-[2.5px] border-border bg-surface text-primary shadow-[0_4px_0_0_rgba(216,90,48,0.1)]",
              )}
            >
              {esBorrar ? (
                <Delete className="h-7 w-7 stroke-[1.75]" aria-hidden />
              ) : esOk ? (
                "OK"
              ) : (
                tecla
              )}
            </motion.button>
          );
        })}
      </div>
    </div>
  );
}
