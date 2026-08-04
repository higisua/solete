"use client";

import Image from "next/image";
import {
  Gem,
  LogOut,
  Settings,
  Star,
  Users,
} from "lucide-react";
import type { ReactNode } from "react";
import { cerrarSesion } from "@/app/actions/auth";
import { Aparecer, BotonIcono, Pantalla } from "@/components/ui";
import { DailyStatus } from "@/components/mundo/DailyStatus";
import { Greeting } from "@/components/mundo/Greeting";
import { MissionCard } from "@/components/mundo/MissionCard";
import { QuickAccess } from "@/components/mundo/QuickAccess";
import { resolverDailyStatus } from "@/components/mundo/daily-status";
import { cn } from "@/lib/cn";

export type MundoVistaProps = {
  nombre: string;
  curso: string;
  avatarSrc: string | null;
  avatarAlt: string;
  iniciales: string;
  estrellas: number;
  diamantes: number;
  rachaDias: number;
  misionCompletadaHoy: boolean;
  estrellasHoy: number;
  mostrarCambiarJugador: boolean;
  cambiarJugadorAction: () => Promise<void>;
};

function ChipTesoro({
  icono,
  valor,
}: {
  icono: ReactNode;
  valor: number;
}) {
  return (
    <div className="inline-flex min-h-9 items-center gap-1 rounded-2xl bg-surface/80 px-2.5 py-1 font-titulo text-sm font-semibold text-primary shadow-card sm:min-h-10 sm:gap-1.5 sm:px-3 sm:text-base">
      {icono}
      <span>{valor}</span>
    </div>
  );
}

/**
 * Home infantil: El Mundo de Solete.
 * Una acción principal (misión). El resto es secundario.
 * Pensado para caber sin scroll en móviles normales.
 */
export function MundoVista({
  nombre,
  curso,
  avatarSrc,
  avatarAlt,
  iniciales,
  estrellas,
  diamantes,
  rachaDias,
  misionCompletadaHoy,
  estrellasHoy,
  mostrarCambiarJugador,
  cambiarJugadorAction,
}: MundoVistaProps) {
  const status = resolverDailyStatus({
    nombre,
    misionCompletadaHoy,
    rachaDias,
  });

  return (
    <Pantalla
      className={cn(
        "fondo-halo-sol flex h-dvh max-h-dvh flex-col overflow-hidden !pb-3 !pt-3 sm:!pb-4 sm:!pt-4",
      )}
      sinAtmosfera
    >
      {/* Barra superior compacta: identidad + tesoros + adultos */}
      <Aparecer>
        <header className="flex shrink-0 items-center justify-between gap-2">
          <div className="flex min-w-0 items-center gap-2">
            <div className="relative h-10 w-10 shrink-0 overflow-hidden rounded-full bg-surface shadow-card ring-2 ring-white sm:h-11 sm:w-11">
              {avatarSrc ? (
                <Image
                  src={avatarSrc}
                  alt={avatarAlt}
                  width={44}
                  height={44}
                  unoptimized
                  priority
                  className="h-full w-full object-contain p-0.5"
                />
              ) : (
                <div className="flex h-full w-full items-center justify-center bg-limon font-titulo text-lg text-primary">
                  {iniciales}
                </div>
              )}
            </div>
            <p className="truncate font-cuerpo text-xs text-readable sm:text-sm">
              {curso}º
            </p>
          </div>

          <div className="flex shrink-0 items-center gap-1.5 sm:gap-2">
            <ChipTesoro
              valor={estrellas}
              icono={
                <Star
                  className="h-3.5 w-3.5 fill-[#FAC775] stroke-[#E8A84A] sm:h-4 sm:w-4"
                  aria-hidden
                />
              }
            />
            <ChipTesoro
              valor={diamantes}
              icono={
                <Gem
                  className="h-3.5 w-3.5 stroke-mar stroke-[1.75] sm:h-4 sm:w-4"
                  aria-hidden
                />
              }
            />
            {mostrarCambiarJugador ? (
              <form action={cambiarJugadorAction}>
                <BotonIcono type="submit" aria-label="Cambiar de jugador">
                  <Users className="h-5 w-5 stroke-[1.75]" aria-hidden />
                </BotonIcono>
              </form>
            ) : null}
            <BotonIcono href="/zona-padres" aria-label="Zona padres">
              <Settings className="h-5 w-5 stroke-[1.75]" aria-hidden />
            </BotonIcono>
          </div>
        </header>
      </Aparecer>

      {/* Saludo + Solete */}
      <Aparecer delay={0.06} className="mt-2 shrink-0 sm:mt-3">
        <Greeting
          greeting={status.greeting}
          mood={status.mood}
          size="lg"
        />
      </Aparecer>

      <Aparecer delay={0.1} className="mt-1 shrink-0 sm:mt-1.5">
        <DailyStatus message={status.message} />
      </Aparecer>

      {/* Centro dominante: misión */}
      <Aparecer delay={0.14} className="mt-2 flex min-h-0 flex-1 flex-col sm:mt-3">
        <MissionCard
          completada={misionCompletadaHoy}
          estrellasHoy={estrellasHoy}
        />
      </Aparecer>

      {/* Accesos secundarios */}
      <Aparecer delay={0.18} className="mt-1 shrink-0 sm:mt-2">
        <QuickAccess />
      </Aparecer>

      <Aparecer delay={0.22} className="mt-1 shrink-0">
        <form action={cerrarSesion} className="flex justify-center">
          <button
            type="submit"
            className="inline-flex min-h-9 items-center gap-1 px-2 font-cuerpo text-xs text-readable/80 underline-offset-2 transition hover:text-text-primary hover:underline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus"
          >
            <LogOut className="h-3 w-3 stroke-[1.75]" aria-hidden />
            Cerrar sesión
          </button>
        </form>
      </Aparecer>
    </Pantalla>
  );
}
