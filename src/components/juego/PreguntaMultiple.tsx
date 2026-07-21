"use client";

import { motion } from "framer-motion";
import { cn } from "@/lib/cn";

type Props = {
  opciones: string[];
  onElegir: (valor: string) => void;
  disabled?: boolean;
  /** Respuesta elegida por el niño (texto de la opción). */
  elegida?: string | null;
  /** Respuesta correcta (texto). */
  correcta?: string | null;
  /** Si true, pinta acierto/fallo. */
  revelada?: boolean;
};

/**
 * 4 opciones grandes. Diseño preparado para ampliar a imagen+texto
 * (cada opción podría ser { texto, imagenUrl } en el futuro).
 */
export function PreguntaMultiple({
  opciones,
  onElegir,
  disabled,
  elegida = null,
  correcta = null,
  revelada = false,
}: Props) {
  const visibles = opciones.slice(0, 4);

  return (
    <div className="flex flex-col gap-3">
      {visibles.map((opcion, index) => {
        const letra = String.fromCharCode(65 + index);
        const esElegida = elegida != null && opcion === elegida;
        const esCorrecta = correcta != null && opcion === correcta;

        let estado: "idle" | "acierto" | "fallo" | "correcta" = "idle";
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
            whileTap={disabled || revelada ? undefined : { scale: 0.97 }}
            transition={{ type: "spring", stiffness: 420, damping: 28 }}
            className={cn(
              "flex min-h-[4.25rem] w-full items-center gap-3 rounded-[18px] border-2 bg-white px-3.5 py-3 text-left shadow-[0_4px_0_0_rgba(216,90,48,0.1)] transition-colors",
              estado === "idle" && "border-[#E8D9C8]",
              estado === "acierto" &&
                "border-mar bg-mar-claro/25 shadow-[0_4px_0_0_rgba(29,158,117,0.25)]",
              estado === "fallo" &&
                "border-sol-claro bg-fallo/20 shadow-[0_4px_0_0_rgba(240,153,123,0.3)]",
              (disabled || revelada) && "cursor-default",
            )}
          >
            <span
              className={cn(
                "flex h-11 w-11 shrink-0 items-center justify-center rounded-[12px] font-titulo text-lg font-semibold text-white",
                estado === "acierto"
                  ? "bg-mar"
                  : estado === "fallo"
                    ? "bg-sol-claro"
                    : "bg-sol",
              )}
              aria-hidden
            >
              {letra}
            </span>
            <span className="font-titulo text-xl font-semibold leading-snug text-sol sm:text-2xl">
              {opcion}
            </span>
          </motion.button>
        );
      })}
    </div>
  );
}
