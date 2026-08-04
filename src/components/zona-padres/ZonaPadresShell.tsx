"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import type { ReactNode } from "react";
import {
  Baby,
  BarChart3,
  BookOpen,
  Gamepad2,
  Pencil,
  Settings,
  Users,
  type LucideIcon,
} from "lucide-react";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { salirZonaPadres } from "@/app/actions/zona-padres";
import type { TabZonaPadres } from "@/lib/zona-padres-tabs";
import { cn } from "@/lib/cn";

const ICONOS: Record<TabZonaPadres["icono"], LucideIcon> = {
  hijos: Baby,
  temas: BookOpen,
  resultados: BarChart3,
  ajustes: Settings,
  contenido: Pencil,
  usuarios: Users,
};

type Props = {
  tabs: TabZonaPadres[];
  children: ReactNode;
  tituloFamilia: string;
};

export function ZonaPadresShell({ tabs, children, tituloFamilia }: Props) {
  const pathname = usePathname();
  const reducir = useReducedMotion();
  const muchasTabs = tabs.length > 4;

  return (
    <div className="fondo-halo-sol mx-auto flex min-h-dvh w-full max-w-lg flex-col">
      <header className="flex items-center justify-between gap-3 px-5 pb-3 pt-5 safe-pt">
        <div className="min-w-0">
          <p className="font-cuerpo text-xs text-readable">Zona padres</p>
          <p className="truncate font-titulo text-xl font-semibold text-primary">
            {tituloFamilia}
          </p>
        </div>
        <form action={salirZonaPadres}>
          <button
            type="submit"
            className="inline-flex min-h-11 items-center gap-1.5 rounded-2xl bg-surface px-3.5 font-titulo text-sm font-semibold text-secondary shadow-card transition active:scale-[0.97] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus"
          >
            <Gamepad2 className="h-4 w-4 stroke-[2]" aria-hidden />
            Al juego
          </button>
        </form>
      </header>

      <div className="flex-1 overflow-y-auto px-5 pb-28 pt-1">
        <AnimatePresence mode="wait">
          <motion.div
            key={pathname}
            initial={reducir ? false : { opacity: 0, y: 8 }}
            animate={{ opacity: 1, y: 0 }}
            exit={reducir ? undefined : { opacity: 0, y: -6 }}
            transition={{ duration: 0.22, ease: [0.22, 1, 0.36, 1] }}
          >
            {children}
          </motion.div>
        </AnimatePresence>
      </div>

      <nav
        className="fixed bottom-0 left-0 right-0 z-30 border-t border-black/[0.06] bg-surface/95 backdrop-blur-md safe-pb"
        aria-label="Secciones zona padres"
      >
        <div
          className={cn(
            "mx-auto flex max-w-md gap-0.5 px-2 py-2",
            muchasTabs ? "justify-between overflow-x-auto" : "justify-around",
          )}
        >
          {tabs.map((tab) => {
            const activo = pathname.startsWith(tab.href);
            const Icono = ICONOS[tab.icono];
            return (
              <Link
                key={tab.href}
                href={tab.href}
                className={cn(
                  "flex min-h-14 min-w-[4.25rem] flex-col items-center justify-center gap-0.5 rounded-2xl px-2 font-titulo text-[11px] font-semibold transition focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus",
                  activo
                    ? "bg-sol/10 text-primary shadow-[inset_0_0_0_1.5px_rgba(216,90,48,0.2)]"
                    : "text-readable hover:text-text-primary",
                )}
              >
                <Icono
                  className={cn(
                    "h-5 w-5 stroke-[1.75]",
                    activo ? "stroke-sol" : "stroke-current",
                  )}
                  aria-hidden
                />
                {tab.label}
              </Link>
            );
          })}
        </div>
      </nav>
    </div>
  );
}
