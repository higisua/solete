"use client";

import Link from "next/link";
import {
  Award,
  BookOpen,
  CalendarDays,
  LayoutGrid,
  ShoppingBag,
  type LucideIcon,
} from "lucide-react";
import { AparecerItem, ListaAparecer } from "@/components/ui";
import { cn } from "@/lib/cn";

export type QuickAccessItem = {
  nombre: string;
  href: string;
  icono: LucideIcon;
};

export const QUICK_ACCESS_DEFAULT: QuickAccessItem[] = [
  { nombre: "Práctica", href: "/practica", icono: BookOpen },
  { nombre: "Álbum", href: "/coleccion", icono: LayoutGrid },
  { nombre: "Tienda", href: "/tienda", icono: ShoppingBag },
  { nombre: "Medallas", href: "/medallas", icono: Award },
  { nombre: "Calendario", href: "/calendario", icono: CalendarDays },
];

type Props = {
  items?: QuickAccessItem[];
  className?: string;
};

/**
 * Accesos secundarios: iconos grandes, sin competir con la misión.
 */
export function QuickAccess({
  items = QUICK_ACCESS_DEFAULT,
  className,
}: Props) {
  return (
    <nav aria-label="Más cosas" className={cn("w-full", className)}>
      <ListaAparecer
        as="ul"
        className="grid grid-cols-5 gap-1 sm:gap-2"
      >
        {items.map((item) => {
          const Icono = item.icono;
          return (
            <AparecerItem key={item.href} as="li">
              <Link
                href={item.href}
                className="flex flex-col items-center gap-1 rounded-2xl px-0.5 py-2 text-center transition active:scale-[0.96] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus"
              >
                <span className="flex h-12 w-12 items-center justify-center rounded-2xl bg-surface/70 text-sol shadow-[0_2px_0_0_rgba(216,90,48,0.1)] sm:h-14 sm:w-14">
                  <Icono
                    className="h-6 w-6 stroke-[1.75] sm:h-7 sm:w-7"
                    aria-hidden
                  />
                </span>
                <span className="max-w-[4.5rem] truncate font-titulo text-[11px] font-semibold leading-tight text-primary sm:text-xs">
                  {item.nombre}
                </span>
              </Link>
            </AparecerItem>
          );
        })}
      </ListaAparecer>
    </nav>
  );
}
