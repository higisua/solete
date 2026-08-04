"use client";

import { Gem } from "lucide-react";
import { InsigniaMedalla } from "@/components/medallas/InsigniaMedalla";
import { MedalProgress } from "@/components/medallas/MedalProgress";
import type { MedallaVistaItem } from "@/lib/juego/medallas-vista";
import { cn } from "@/lib/cn";

export type MedalCardVariant = "featured" | "earned" | "locked";

type Props = {
  item: MedallaVistaItem;
  variant: MedalCardVariant;
  className?: string;
};

/**
 * Tarjeta de medalla — tres estados visuales claros.
 */
export function MedalCard({ item, variant, className }: Props) {
  if (variant === "featured") {
    return (
      <article
        className={cn(
          "flex gap-3 rounded-card bg-surface px-3.5 py-3.5 shadow-elevated ring-2 ring-sol/20",
          className,
        )}
      >
        <InsigniaMedalla id={item.id} estado="almost" size="md" />
        <div className="min-w-0 flex-1">
          <h3 className="font-titulo text-base font-semibold leading-snug text-primary sm:text-lg">
            {item.nombre}
          </h3>
          <p className="mt-0.5 line-clamp-2 font-cuerpo text-xs text-readable sm:text-sm">
            {item.descripcion}
          </p>
          <p className="mt-1.5 inline-flex items-center gap-1 font-titulo text-sm font-semibold text-mar">
            <Gem className="h-3.5 w-3.5 stroke-[2]" aria-hidden />+
            {item.diamantes}
          </p>
          {item.progreso ? (
            <div className="mt-2">
              <MedalProgress
                actual={item.progreso.actual}
                meta={item.progreso.meta}
                destacada
              />
            </div>
          ) : null}
        </div>
      </article>
    );
  }

  if (variant === "earned") {
    return (
      <article
        className={cn(
          "flex flex-col items-center rounded-card bg-[linear-gradient(165deg,#FFFBF0_0%,#FFF3DC_55%,#FFE9A8_100%)] px-2.5 py-3 text-center shadow-card ring-2 ring-[#E8B84A]/45",
          className,
        )}
      >
        <InsigniaMedalla id={item.id} estado="earned" size="sm" conHalo />
        <h3 className="mt-2 line-clamp-2 font-titulo text-sm font-semibold leading-snug text-primary">
          {item.nombre}
        </h3>
        <p className="mt-1.5 inline-flex items-center gap-0.5 font-titulo text-xs font-semibold text-[#9A6B12]">
          <Gem className="h-3 w-3 stroke-[2]" aria-hidden />+{item.diamantes}
        </p>
        <span className="mt-1.5 rounded-full bg-[#E8B84A]/25 px-2 py-0.5 font-titulo text-[10px] font-semibold uppercase tracking-wide text-[#8A5A10]">
          ¡Tuya!
        </span>
      </article>
    );
  }

  // locked
  return (
    <article
      className={cn(
        "flex items-center gap-2.5 rounded-2xl bg-surface/75 px-2.5 py-2 shadow-card",
        className,
      )}
    >
      <InsigniaMedalla id={item.id} estado="locked" size="sm" />
      <div className="min-w-0 flex-1">
        <h3 className="truncate font-titulo text-sm font-semibold text-primary">
          {item.nombre}
        </h3>
        <p className="mt-0.5 line-clamp-1 font-cuerpo text-[11px] text-readable">
          {item.descripcion}
        </p>
        <div className="mt-1 flex items-center justify-between gap-2">
          <span className="inline-flex items-center gap-0.5 font-titulo text-xs font-semibold text-readable">
            <Gem className="h-3 w-3 stroke-[2]" aria-hidden />+{item.diamantes}
          </span>
          {item.progreso ? (
            <span className="font-titulo text-[11px] font-semibold tabular-nums text-readable">
              {item.progreso.actual}/{item.progreso.meta}
            </span>
          ) : (
            <span className="font-cuerpo text-[11px] text-readable/80">
              Por descubrir
            </span>
          )}
        </div>
        {item.progreso ? (
          <div className="mt-1.5">
            <MedalProgress
              actual={item.progreso.actual}
              meta={item.progreso.meta}
            />
          </div>
        ) : null}
      </div>
    </article>
  );
}
