"use client";

import { CromoCara } from "@/components/cromos/CromoCara";
import type { CromoAlbumItem } from "@/lib/juego/cromos";
import { cn } from "@/lib/cn";

type Props = {
  cromos: CromoAlbumItem[];
  onVerCromo: (cromo: CromoAlbumItem) => void;
  className?: string;
  /** Columnas del grid. */
  cols?: "album" | "shop";
};

/**
 * Grid reutilizable de cromos (álbum o tienda).
 */
export function CardGrid({
  cromos,
  onVerCromo,
  className,
  cols = "album",
}: Props) {
  return (
    <div
      className={cn(
        cols === "album"
          ? "grid grid-cols-4 gap-1.5 sm:gap-2 md:grid-cols-5"
          : "grid grid-cols-2 gap-2.5 sm:grid-cols-3",
        className,
      )}
    >
      {cromos.map((c) =>
        c.loTiene ? (
          <button
            key={c.id}
            type="button"
            onClick={() => onVerCromo(c)}
            className="min-h-11 rounded-xl text-left transition active:scale-[0.96] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus"
            aria-label={`Ver ${c.nombre}`}
          >
            <CromoCara
              loTiene
              nombre={c.nombre}
              imagenSrc={c.imagenSrc}
              rareza={c.rareza}
              size="sm"
            />
          </button>
        ) : (
          <div key={c.id} className="min-h-11">
            <CromoCara loTiene={false} size="sm" />
          </div>
        ),
      )}
    </div>
  );
}
