"use client";

import { Gem } from "lucide-react";
import { Boton } from "@/components/ui";
import { CromoCara, EtiquetaRareza } from "@/components/cromos/CromoCara";
import { precioPorRareza } from "@/lib/juego/cromos-catalogo";
import type { CromoAlbumItem } from "@/lib/juego/cromos";
import { cn } from "@/lib/cn";

type Props = {
  cromo: CromoAlbumItem;
  diamantes: number;
  pending: boolean;
  comprandoId: string | null;
  onComprar: (cromo: CromoAlbumItem) => void;
};

/**
 * Cromo en venta: compacto (imagen, rareza, nombre, precio).
 */
export function CardItem({
  cromo,
  diamantes,
  pending,
  comprandoId,
  onComprar,
}: Props) {
  const precio = precioPorRareza(cromo.rareza);
  const puede = diamantes >= precio;
  const cargando = comprandoId === cromo.id;

  return (
    <article
      className={cn(
        "flex flex-col rounded-2xl bg-surface p-2.5 shadow-card transition active:scale-[0.98] sm:p-3",
      )}
    >
      <CromoCara
        loTiene
        nombre={cromo.nombre}
        imagenSrc={cromo.imagenSrc}
        rareza={cromo.rareza}
        size="sm"
      />
      <div className="mt-1.5 flex flex-col items-center gap-0.5 text-center">
        <EtiquetaRareza rareza={cromo.rareza} className="scale-90" />
        <h3 className="line-clamp-1 font-titulo text-sm font-semibold leading-tight text-primary">
          {cromo.nombre}
        </h3>
      </div>
      <div className="mt-2">
        <Boton
          type="button"
          variant="secundario"
          size="sm"
          disabled={!puede || pending || Boolean(comprandoId)}
          isLoading={cargando}
          onClick={() => onComprar(cromo)}
          className={cn("text-sm", !puede && "opacity-45")}
        >
          {cargando ? (
            "…"
          ) : (
            <>
              {precio} <Gem className="h-3.5 w-3.5 stroke-[2]" aria-hidden />
            </>
          )}
        </Boton>
      </div>
    </article>
  );
}
