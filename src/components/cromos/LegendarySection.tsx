"use client";

import { BarraProgreso } from "@/components/ui";
import { CromoCara, EtiquetaRareza } from "@/components/cromos/CromoCara";
import type { LegendarioProgresoItem } from "@/lib/juego/legendarios-eval";
import { cn } from "@/lib/cn";

type Props = {
  items: LegendarioProgresoItem[];
  onVer: (item: LegendarioProgresoItem) => void;
  className?: string;
};

/**
 * Legendarios de un mundo (siempre visibles en el detalle).
 */
export function LegendarySection({ items, onVer, className }: Props) {
  if (items.length === 0) return null;

  return (
    <div className={cn("mt-4 border-t border-black/6 pt-3", className)}>
      <div className="mb-2.5 flex items-center justify-between gap-2">
        <p className="font-titulo text-sm font-semibold text-[#7A4FE0]">
          Legendarios
        </p>
        <EtiquetaRareza rareza="legendary" />
      </div>

      <ul className="flex flex-col gap-2.5">
        {items.map((item) => (
          <li key={item.def.id}>
            <button
              type="button"
              onClick={() => onVer(item)}
              className="flex w-full items-center gap-2.5 rounded-xl bg-[#9B6DFF]/6 px-2 py-2 text-left transition active:scale-[0.99] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus"
              aria-label={
                item.loTiene
                  ? `Ver ${item.def.title}`
                  : `Progreso: ${item.def.description}`
              }
            >
              <div className="w-14 shrink-0 sm:w-16">
                {item.loTiene ? (
                  <CromoCara
                    loTiene
                    nombre={item.def.title}
                    imagenSrc={item.imagenSrc}
                    rareza="legendary"
                    size="sm"
                  />
                ) : (
                  <CromoCara
                    loTiene={false}
                    imagenBloqueada={item.imagenSrc}
                    rarezaBloqueada="legendary"
                    size="sm"
                  />
                )}
              </div>
              <div className="min-w-0 flex-1">
                <p className="truncate font-titulo text-sm font-semibold text-primary">
                  {item.def.emoji}{" "}
                  {item.loTiene || !item.def.hidden ? item.def.title : "???"}
                </p>
                <p className="mt-0.5 line-clamp-2 font-cuerpo text-xs text-readable">
                  {item.def.description}
                </p>
                <p className="mt-1 font-titulo text-xs font-semibold text-[#7A4FE0]">
                  {item.progresoTexto}
                </p>
                {!item.loTiene && item.meta > 0 ? (
                  <div className="mt-1">
                    <BarraProgreso
                      valor={item.actual}
                      max={item.meta}
                      size="sm"
                      tono="sol"
                      aria-label={`Progreso ${item.actual} de ${item.meta}`}
                    />
                  </div>
                ) : null}
              </div>
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
}
