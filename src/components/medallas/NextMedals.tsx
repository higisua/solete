"use client";

import { AparecerItem, ListaAparecer } from "@/components/ui";
import { MedalCard } from "@/components/medallas/MedalCard";
import type { MedallaVistaItem } from "@/lib/juego/medallas-vista";
import { cn } from "@/lib/cn";

type Props = {
  items: MedallaVistaItem[];
  className?: string;
};

/**
 * Sección protagonista: medallas a punto de conseguir.
 */
export function NextMedals({ items, className }: Props) {
  if (items.length === 0) return null;

  return (
    <section className={cn("w-full", className)} aria-label="A punto de conseguir">
      <h2 className="font-titulo text-lg font-semibold text-primary sm:text-xl">
        A punto de conseguir
      </h2>
      <p className="mt-0.5 font-cuerpo text-sm text-readable">
        ¡Estás muy cerca!
      </p>

      <ListaAparecer className="mt-3 flex flex-col gap-2.5" as="ul">
        {items.map((item) => (
          <AparecerItem key={item.id} className="list-none">
            <MedalCard item={item} variant="featured" />
          </AparecerItem>
        ))}
      </ListaAparecer>
    </section>
  );
}
