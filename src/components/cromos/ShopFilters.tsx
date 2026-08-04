"use client";

import type { ReactNode } from "react";
import { cn } from "@/lib/cn";
import { TEMATICA_EMOJI } from "@/components/cromos/coleccion-mensajes";
import { TEMATICAS_CROMOS, type TematicaId } from "@/lib/juego/cromos-catalogo";

export type ShopFiltro = "todas" | TematicaId;

type Props = {
  filtro: ShopFiltro;
  onChange: (filtro: ShopFiltro) => void;
  className?: string;
};

/**
 * Chips de categoría en wrap (sin scroll horizontal).
 */
export function ShopFilters({ filtro, onChange, className }: Props) {
  return (
    <div
      className={cn("flex flex-wrap justify-center gap-2", className)}
      role="tablist"
      aria-label="Categorías"
    >
      <FiltroChip activo={filtro === "todas"} onClick={() => onChange("todas")}>
        Todas
      </FiltroChip>
      {TEMATICAS_CROMOS.map((t) => (
        <FiltroChip
          key={t.id}
          activo={filtro === t.id}
          onClick={() => onChange(t.id)}
        >
          <span aria-hidden>{TEMATICA_EMOJI[t.id]} </span>
          {t.nombre}
        </FiltroChip>
      ))}
    </div>
  );
}

function FiltroChip({
  children,
  activo,
  onClick,
}: {
  children: ReactNode;
  activo: boolean;
  onClick: () => void;
}) {
  return (
    <button
      type="button"
      role="tab"
      aria-selected={activo}
      onClick={onClick}
      className={cn(
        "min-h-11 rounded-full px-3.5 py-2 font-titulo text-sm font-semibold transition focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus",
        activo
          ? "bg-primary text-text-inverse shadow-[0_3px_0_0_rgba(184,64,28,0.3)]"
          : "bg-surface text-primary shadow-card active:scale-[0.97]",
      )}
    >
      {children}
    </button>
  );
}
