"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { salirZonaPadres } from "@/app/actions/zona-padres";
import type { TabZonaPadres } from "@/lib/zona-padres-tabs";

type Props = {
  tabs: TabZonaPadres[];
  children: React.ReactNode;
  tituloFamilia: string;
};

export function ZonaPadresShell({ tabs, children, tituloFamilia }: Props) {
  const pathname = usePathname();

  return (
    <div className="mx-auto flex min-h-dvh w-full max-w-md flex-col bg-crema">
      <header className="flex items-center justify-between gap-2 border-b border-black/5 px-4 py-3">
        <div>
          <p className="text-xs text-black/45">Zona padres</p>
          <p className="font-titulo text-lg font-semibold text-sol">{tituloFamilia}</p>
        </div>
        <form action={salirZonaPadres}>
          <button
            type="submit"
            className="min-h-11 rounded-2xl bg-white px-3 text-sm font-semibold text-mar shadow-sm"
          >
            Volver al juego
          </button>
        </form>
      </header>

      <div className="flex-1 overflow-y-auto px-4 py-4 pb-24">{children}</div>

      <nav className="fixed bottom-0 left-0 right-0 border-t border-black/5 bg-white/95 backdrop-blur">
        <div className="mx-auto flex max-w-md justify-around px-1 py-1">
          {tabs.map((tab) => {
            const activo = pathname.startsWith(tab.href);
            return (
              <Link
                key={tab.href}
                href={tab.href}
                className={`flex min-h-14 min-w-[4.5rem] flex-col items-center justify-center rounded-xl px-2 text-xs font-semibold ${
                  activo ? "bg-limon/40 text-sol" : "text-black/45"
                }`}
              >
                <span className="text-lg" aria-hidden>
                  {tab.icono}
                </span>
                {tab.label}
              </Link>
            );
          })}
        </div>
      </nav>
    </div>
  );
}
