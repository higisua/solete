"use client";

import { Delete } from "lucide-react";
import { motion } from "framer-motion";
import { cn } from "@/lib/cn";

type Props = {
  valor: string;
  onChange: (valor: string) => void;
  onConfirmar: () => void;
  disabled?: boolean;
  /** Tras responder: pinta el display según acierto. */
  revelada?: boolean;
  acerto?: boolean | null;
};

const TECLAS = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "borrar", "0", "ok"] as const;

export function TecladoNumerico({
  valor,
  onChange,
  onConfirmar,
  disabled,
  revelada = false,
  acerto = null,
}: Props) {
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
      <div
        className={cn(
          "mb-4 flex min-h-16 items-center justify-center rounded-[18px] border-2 px-4 py-3 text-center font-titulo text-4xl font-semibold transition-colors",
          revelada && acerto === true && "border-mar bg-mar-claro/25 text-mar",
          revelada && acerto === false && "border-sol-claro bg-fallo/25 text-sol",
          !revelada && "border-[#E8D9C8] bg-[#FFFCFA] text-sol",
        )}
        aria-live="polite"
      >
        {valor || "—"}
      </div>
      <div className="grid grid-cols-3 gap-2.5">
        {TECLAS.map((tecla) => {
          const esOk = tecla === "ok";
          const esBorrar = tecla === "borrar";
          return (
            <motion.button
              key={tecla}
              type="button"
              disabled={disabled || revelada}
              onClick={() => pulsar(tecla)}
              whileTap={disabled || revelada ? undefined : { scale: 0.94 }}
              transition={{ type: "spring", stiffness: 420, damping: 28 }}
              className={cn(
                "flex min-h-14 items-center justify-center rounded-[16px] font-titulo text-2xl font-semibold",
                esOk && "bg-mar text-white shadow-[0_4px_0_0_rgba(18,110,80,0.35)]",
                esBorrar &&
                  "bg-sol-claro/35 text-sol shadow-[0_3px_0_0_rgba(216,90,48,0.15)]",
                !esOk &&
                  !esBorrar &&
                  "border-2 border-[#E8D9C8] bg-white text-sol shadow-[0_3px_0_0_rgba(216,90,48,0.1)]",
              )}
            >
              {esBorrar ? (
                <Delete className="h-6 w-6 stroke-[1.75]" aria-label="Borrar" />
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
