"use client";

import { ChevronDown, ChevronUp } from "lucide-react";
import { cn } from "@/lib/cn";

type Props = {
  faltan: number;
  abierto: boolean;
  onToggle: () => void;
  className?: string;
};

/**
 * Entrada secundaria a la compra individual (no compite con los sobres).
 */
export function CompraIndividualGate({
  faltan,
  abierto,
  onToggle,
  className,
}: Props) {
  if (faltan <= 0) {
    return (
      <p
        className={cn(
          "text-center font-cuerpo text-sm text-readable",
          className,
        )}
      >
        ¡Ya tienes todos los cromos de la tienda!
      </p>
    );
  }

  return (
    <div className={cn("w-full", className)}>
      <div className="mx-auto h-px max-w-[12rem] bg-black/8" aria-hidden />
      <button
        type="button"
        onClick={onToggle}
        aria-expanded={abierto}
        className="mt-5 flex w-full flex-col items-center gap-1 rounded-2xl px-3 py-3 text-center transition active:scale-[0.99] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus"
      >
        <p className="font-titulo text-base font-semibold text-primary">
          ¿Te falta un cromo?
        </p>
        <p className="inline-flex items-center gap-1 font-cuerpo text-sm text-mar">
          Comprar individualmente
          {abierto ? (
            <ChevronUp className="h-4 w-4 stroke-[2]" aria-hidden />
          ) : (
            <ChevronDown className="h-4 w-4 stroke-[2]" aria-hidden />
          )}
        </p>
        {!abierto ? (
          <p className="font-cuerpo text-xs text-readable/80">
            {faltan === 1
              ? "1 cromo por completar"
              : `${faltan} cromos por completar`}
          </p>
        ) : null}
      </button>
    </div>
  );
}
