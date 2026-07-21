"use client";

import Link from "next/link";
import { ChevronLeft, Gem } from "lucide-react";
import {
  Aparecer,
  AparecerItem,
  ListaAparecer,
  Pantalla,
} from "@/components/ui";
import { InsigniaMedalla } from "@/components/medallas/InsigniaMedalla";
import type { MedallaVistaItem } from "@/lib/juego/medallas-vista";
import { cn } from "@/lib/cn";

type Props = {
  conseguidas: number;
  total: number;
  items: MedallaVistaItem[];
};

export function MedallasVista({ conseguidas, total, items }: Props) {
  return (
    <Pantalla className="fondo-halo-sol pb-10 pt-5">
      <Aparecer>
        <header className="relative flex items-center justify-center">
          <Link
            href="/mundo"
            aria-label="Volver"
            className="absolute left-0 flex h-11 w-11 items-center justify-center rounded-full bg-black/[0.06] text-black/45 transition hover:bg-black/10"
          >
            <ChevronLeft className="h-6 w-6 stroke-[1.75]" />
          </Link>
          <h1 className="font-titulo text-2xl font-semibold text-sol">
            Medallas
          </h1>
        </header>
      </Aparecer>

      <Aparecer delay={0.06} className="mt-3 text-center">
        <p className="font-cuerpo text-base text-black/55">
          Has conseguido{" "}
          <span className="font-titulo font-semibold text-sol">
            {conseguidas}
          </span>{" "}
          de{" "}
          <span className="font-titulo font-semibold text-sol">{total}</span>{" "}
          medallas
        </p>
      </Aparecer>

      <ListaAparecer className="mt-6 grid grid-cols-2 gap-3" as="ul">
        {items.map((m) => (
          <AparecerItem key={m.id} className="list-none">
            <TarjetaMedalla item={m} />
          </AparecerItem>
        ))}
      </ListaAparecer>
    </Pantalla>
  );
}

function TarjetaMedalla({ item }: { item: MedallaVistaItem }) {
  const { conseguida, progreso } = item;
  const pct =
    progreso && progreso.meta > 0
      ? Math.min(100, Math.round((progreso.actual / progreso.meta) * 100))
      : 0;

  return (
    <article
      className={cn(
        "flex h-full flex-col items-center rounded-[22px] bg-white px-3 pb-4 pt-4 text-center shadow-[0_10px_28px_-14px_rgba(216,90,48,0.28)]",
        !conseguida && "opacity-[0.92]",
      )}
    >
      <InsigniaMedalla id={item.id} conseguida={conseguida} size="sm" />

      <h2 className="mt-3 font-titulo text-base font-semibold leading-snug text-sol">
        {item.nombre}
      </h2>

      {conseguida ? (
        <p className="mt-2 inline-flex items-center gap-1 font-titulo text-sm font-semibold text-mar">
          <Gem className="h-3.5 w-3.5 stroke-[2]" aria-hidden />+
          {item.diamantes}
        </p>
      ) : (
        <>
          <p className="mt-2 font-cuerpo text-xs leading-snug text-black/45">
            {item.descripcion}
          </p>
          {progreso ? (
            <div className="mt-3 w-full px-1">
              <div
                className="h-2 overflow-hidden rounded-full bg-black/[0.06]"
                role="progressbar"
                aria-valuenow={progreso.actual}
                aria-valuemin={0}
                aria-valuemax={progreso.meta}
                aria-label={`${progreso.actual} de ${progreso.meta}`}
              >
                <div
                  className="h-full rounded-full bg-mar transition-[width] duration-500"
                  style={{ width: `${pct}%` }}
                />
              </div>
              <p className="mt-1 font-cuerpo text-[11px] text-black/40">
                {progreso.actual}/{progreso.meta}
              </p>
            </div>
          ) : null}
        </>
      )}
    </article>
  );
}
