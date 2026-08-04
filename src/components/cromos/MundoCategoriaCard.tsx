"use client";

import { Check } from "lucide-react";
import { BarraProgreso } from "@/components/ui";
import {
  etiquetaEstadoMundo,
  MUNDO_COLORES,
  type MundoVista,
} from "@/components/cromos/mapa-coleccion";
import { cn } from "@/lib/cn";

type Props = {
  mundo: MundoVista;
  onAbrir: (temaId: MundoVista["tema"]["id"]) => void;
  destacado?: boolean;
};

/**
 * Isla / mundo del hub del álbum.
 */
export function MundoCategoriaCard({
  mundo,
  onAbrir,
  destacado = false,
}: Props) {
  const colores = MUNDO_COLORES[mundo.tema.id];
  const estado = etiquetaEstadoMundo(mundo);

  return (
    <button
      type="button"
      onClick={() => onAbrir(mundo.tema.id)}
      className={cn(
        "relative flex w-full flex-col overflow-hidden rounded-card p-4 text-left shadow-card transition active:scale-[0.98] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus",
        destacado && "ring-2 ring-sol/40 shadow-elevated",
      )}
      style={{
        background: `linear-gradient(155deg, #FFFBF5 0%, ${colores.soft} 55%, #FFF8ED 100%)`,
      }}
      aria-label={`Abrir ${mundo.tema.nombre}. ${mundo.tema.conseguidos} de ${mundo.tema.total} cromos. ${mundo.legConseguidos} de ${mundo.legTotal} legendarios.`}
    >
      <div className="flex items-start justify-between gap-2">
        <div className="min-w-0">
          <span className="text-3xl" aria-hidden>
            {mundo.emoji}
          </span>
          <h2 className="mt-1 font-titulo text-xl font-semibold text-primary">
            {mundo.tema.nombre}
          </h2>
        </div>
        <span
          className={cn(
            "shrink-0 rounded-full px-2.5 py-1 font-titulo text-[11px] font-semibold",
            mundo.mundoCompleto
              ? "bg-mar/15 text-mar"
              : destacado
                ? "bg-sol/20 text-primary"
                : "bg-surface/80 text-readable",
          )}
        >
          {mundo.mundoCompleto ? (
            <span className="inline-flex items-center gap-0.5">
              <Check className="h-3 w-3 stroke-[2.5]" aria-hidden />
              {estado}
            </span>
          ) : (
            estado
          )}
        </span>
      </div>

      <div className="mt-3">
        <div className="mb-1 flex items-center justify-between gap-2">
          <span className="font-titulo text-xs font-semibold text-readable">
            Cromos
          </span>
          <span
            className="font-titulo text-sm font-semibold tabular-nums"
            style={{ color: colores.accent }}
          >
            {mundo.tema.conseguidos}/{mundo.tema.total}
          </span>
        </div>
        <BarraProgreso
          valor={mundo.tema.conseguidos}
          max={Math.max(mundo.tema.total, 1)}
          size="sm"
          tono={mundo.normalesCompletos ? "mar" : "sol"}
          aria-label={`${mundo.tema.conseguidos} de ${mundo.tema.total}`}
        />
      </div>

      {mundo.legTotal > 0 ? (
        <div className="mt-2.5 flex items-center justify-between gap-2">
          <span className="font-titulo text-xs font-semibold text-[#7A4FE0]">
            Legendarios
          </span>
          <span className="font-titulo text-sm font-semibold tabular-nums text-[#7A4FE0]">
            👑 {mundo.legConseguidos}/{mundo.legTotal}
          </span>
        </div>
      ) : null}
    </button>
  );
}
