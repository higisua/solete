"use client";

import { motion } from "framer-motion";
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
  function clases(valor: boolean) {
    const esElegida = elegida === valor;
    const esCorrecta = correcta === valor;

    if (revelada) {
      if (esCorrecta) {
        return "border-mar bg-mar text-white shadow-[0_4px_0_0_rgba(18,110,80,0.35)]";
      }
      if (esElegida) {
        return "border-sol-claro bg-fallo/35 text-sol shadow-[0_4px_0_0_rgba(240,153,123,0.35)]";
      }
      return "border-[#E8D9C8] bg-white/70 text-black/35";
    }

    return valor
      ? "border-mar/30 bg-white text-mar shadow-[0_4px_0_0_rgba(29,158,117,0.2)]"
      : "border-sol/25 bg-white text-sol shadow-[0_4px_0_0_rgba(216,90,48,0.15)]";
  }

  return (
    <div className="grid grid-cols-2 gap-3">
      {[
        { valor: true, label: "Verdadero" },
        { valor: false, label: "Falso" },
      ].map((op) => (
        <motion.button
          key={String(op.valor)}
          type="button"
          disabled={disabled || revelada}
          onClick={() => onElegir(op.valor)}
          whileTap={disabled || revelada ? undefined : { scale: 0.97 }}
          transition={{ type: "spring", stiffness: 420, damping: 28 }}
          className={cn(
            "flex min-h-[5.5rem] items-center justify-center rounded-[18px] border-2 px-3 font-titulo text-xl font-semibold leading-tight sm:text-2xl",
            clases(op.valor),
          )}
        >
          {op.label}
        </motion.button>
      ))}
    </div>
  );
}
