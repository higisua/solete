"use client";

import { AparecerItem, ListaAparecer } from "@/components/ui";
import { MedalCard } from "@/components/medallas/MedalCard";
import type { MedallaVistaItem } from "@/lib/juego/medallas-vista";
import { cn } from "@/lib/cn";

type Props = {
  emoji: string;
  titulo: string;
  items: MedallaVistaItem[];
  /** earned | locked */
  mode: "earned" | "locked";
  className?: string;
  defaultCollapsed?: boolean;
};

/**
 * Grupo temático de medallas (conseguidas o bloqueadas).
 */
export function MedalGroup({
  emoji,
  titulo,
  items,
  mode,
  className,
}: Props) {
  if (items.length === 0) return null;

  return (
    <section className={cn("w-full", className)}>
      <div className="mb-2.5 flex items-center justify-between gap-2">
        <h3 className="font-titulo text-base font-semibold text-primary">
          <span aria-hidden>{emoji} </span>
          {titulo}
        </h3>
        <span className="font-titulo text-xs font-semibold text-readable">
          {items.length}
        </span>
      </div>

      {mode === "earned" ? (
        <ListaAparecer
          className="grid grid-cols-3 gap-2 sm:grid-cols-4"
          as="ul"
        >
          {items.map((item) => (
            <AparecerItem key={item.id} className="list-none">
              <MedalCard item={item} variant="earned" />
            </AparecerItem>
          ))}
        </ListaAparecer>
      ) : (
        <ListaAparecer className="flex flex-col gap-2" as="ul">
          {items.map((item) => (
            <AparecerItem key={item.id} className="list-none">
              <MedalCard item={item} variant="locked" />
            </AparecerItem>
          ))}
        </ListaAparecer>
      )}
    </section>
  );
}
