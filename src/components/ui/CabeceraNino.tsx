"use client";

import type { ReactNode } from "react";
import { ChevronLeft } from "lucide-react";
import { BotonIcono } from "@/components/ui/BotonIcono";
import { cn } from "@/lib/cn";

type Props = {
  titulo: string;
  /** Destino del botón volver. Por defecto /mundo. Ignorado si hay onVolver. */
  hrefVolver?: string;
  /** Volver por callback (p. ej. hub del álbum). */
  onVolver?: () => void;
  trailing?: ReactNode;
  className?: string;
  labelVolver?: string;
};

/**
 * Cabecera infantil unificada: volver grande + título centrado + slot derecho.
 */
export function CabeceraNino({
  titulo,
  hrefVolver = "/mundo",
  onVolver,
  trailing,
  className,
  labelVolver = "Volver",
}: Props) {
  return (
    <header
      className={cn(
        "relative flex min-h-11 items-center justify-center",
        className,
      )}
    >
      <div className="absolute left-0 top-1/2 -translate-y-1/2">
        {onVolver ? (
          <BotonIcono type="button" onClick={onVolver} aria-label={labelVolver}>
            <ChevronLeft className="h-6 w-6 stroke-[1.75]" aria-hidden />
          </BotonIcono>
        ) : (
          <BotonIcono href={hrefVolver} aria-label={labelVolver}>
            <ChevronLeft className="h-6 w-6 stroke-[1.75]" aria-hidden />
          </BotonIcono>
        )}
      </div>

      <h1 className="max-w-[70%] truncate px-12 text-center font-titulo text-2xl font-semibold text-primary">
        {titulo}
      </h1>

      {trailing ? (
        <div className="absolute right-0 top-1/2 -translate-y-1/2">
          {trailing}
        </div>
      ) : null}
    </header>
  );
}
