"use client";

import Image from "next/image";
import Link from "next/link";
import {
  Award,
  BookOpen,
  CalendarDays,
  Check,
  Gem,
  LayoutGrid,
  Settings,
  Star,
  Users,
  type LucideIcon,
} from "lucide-react";
import { motion, useReducedMotion } from "framer-motion";
import type { ReactNode } from "react";
import { Aparecer, AparecerItem, ListaAparecer, Pantalla } from "@/components/ui";
import { MISION_OBJETIVO } from "@/lib/juego/reglas";
import { publicAssetClient } from "@/lib/public-asset-client";

export type MundoVistaProps = {
  nombre: string;
  curso: string;
  avatarSrc: string | null;
  avatarAlt: string;
  iniciales: string;
  estrellas: number;
  diamantes: number;
  misionCompletadaHoy: boolean;
  estrellasHoy: number;
  mostrarCambiarJugador: boolean;
  cambiarJugadorAction: () => Promise<void>;
};

const SECUNDARIAS: Array<{
  nombre: string;
  href: string;
  icono: LucideIcon;
}> = [
  { nombre: "Práctica", href: "/practica", icono: BookOpen },
  { nombre: "Mi colección", href: "/pronto/coleccion", icono: LayoutGrid },
  { nombre: "Medallas", href: "/pronto/medallas", icono: Award },
  { nombre: "Calendario", href: "/pronto/calendario", icono: CalendarDays },
];

const btnCabecera =
  "flex h-11 w-11 shrink-0 items-center justify-center rounded-full bg-black/[0.06] text-black/40 transition hover:bg-black/10 hover:text-black/55";

function ChipTesoro({
  icono,
  valor,
  delay,
}: {
  icono: ReactNode;
  valor: number;
  delay: number;
}) {
  return (
    <Aparecer delay={delay}>
      <div className="inline-flex min-h-10 items-center gap-1.5 rounded-2xl bg-white px-3 py-1.5 font-titulo text-base font-semibold text-sol shadow-[0_4px_14px_-6px_rgba(216,90,48,0.28)]">
        {icono}
        <span>{valor}</span>
      </div>
    </Aparecer>
  );
}

export function MundoVista({
  nombre,
  curso,
  avatarSrc,
  avatarAlt,
  iniciales,
  estrellas,
  diamantes,
  misionCompletadaHoy,
  estrellasHoy,
  mostrarCambiarJugador,
  cambiarJugadorAction,
}: MundoVistaProps) {
  const reducir = useReducedMotion();

  return (
    <Pantalla className="fondo-halo-sol pb-8 pt-5">
      {/* Cabecera */}
      <Aparecer>
        <header className="flex items-start justify-between gap-3">
          <div className="flex min-w-0 items-center gap-3">
            <div className="relative h-14 w-14 shrink-0 overflow-hidden rounded-full bg-white shadow-[0_6px_16px_-6px_rgba(216,90,48,0.35)] ring-2 ring-white">
              {avatarSrc ? (
                <Image
                  src={avatarSrc}
                  alt={avatarAlt}
                  width={56}
                  height={56}
                  unoptimized
                  priority
                  className="h-full w-full object-contain p-0.5"
                />
              ) : (
                <div className="flex h-full w-full items-center justify-center bg-limon font-titulo text-2xl text-sol">
                  {iniciales}
                </div>
              )}
            </div>
            <div className="min-w-0">
              <h1 className="truncate font-titulo text-2xl font-semibold leading-tight text-sol">
                ¡Hola, {nombre}!
              </h1>
              <p className="font-cuerpo text-sm text-black/45">
                {curso}º de primaria
              </p>
            </div>
          </div>

          <div className="flex shrink-0 items-center gap-2">
            {mostrarCambiarJugador ? (
              <form action={cambiarJugadorAction}>
                <button
                  type="submit"
                  aria-label="Cambiar de jugador"
                  className={btnCabecera}
                >
                  <Users className="h-5 w-5 stroke-[1.75]" />
                </button>
              </form>
            ) : null}
            <Link
              href="/zona-padres"
              aria-label="Zona padres"
              className={btnCabecera}
            >
              <Settings className="h-5 w-5 stroke-[1.75]" />
            </Link>
          </div>
        </header>
      </Aparecer>

      {/* Chips tesoros */}
      <div className="mt-3.5 flex flex-wrap justify-center gap-2.5">
        <ChipTesoro
          delay={0.06}
          valor={estrellas}
          icono={
            <Star
              className="h-4 w-4 fill-[#FAC775] stroke-[#E8A84A]"
              aria-hidden
            />
          }
        />
        <ChipTesoro
          delay={0.12}
          valor={diamantes}
          icono={<Gem className="h-4 w-4 stroke-mar stroke-[1.75]" aria-hidden />}
        />
      </div>

      {/* Bloque misión */}
      <Aparecer delay={0.16} className="mt-4">
        <div className="relative">
          <div
            aria-hidden
            className="pointer-events-none absolute left-1/2 top-8 h-36 w-36 -translate-x-1/2 rounded-full bg-[#FFF3DC] blur-2xl"
          />
          <div className="relative flex flex-col items-center rounded-[26px] bg-white px-5 pb-5 pt-4 text-center shadow-[0_14px_40px_-18px_rgba(216,90,48,0.35),0_4px_12px_-4px_rgba(0,0,0,0.06)]">
            <div className="relative">
              <motion.div
                animate={reducir ? undefined : { y: [0, -8, 0] }}
                transition={
                  reducir
                    ? undefined
                    : { duration: 3.2, repeat: Infinity, ease: "easeInOut" }
                }
              >
                <Image
                  src={publicAssetClient("assets/logos/solete_solo_logo.png")}
                  alt=""
                  width={168}
                  height={168}
                  unoptimized
                  priority
                  className="h-[7.5rem] w-[7.5rem] object-contain drop-shadow-sm sm:h-36 sm:w-36"
                  aria-hidden
                />
              </motion.div>
              <motion.span
                aria-hidden
                className="absolute right-0 top-2 font-titulo text-xl text-limon"
                animate={
                  reducir
                    ? undefined
                    : { opacity: [0.2, 1, 0.2], scale: [0.85, 1.1, 0.85] }
                }
                transition={
                  reducir
                    ? undefined
                    : { duration: 2.2, repeat: Infinity, ease: "easeInOut" }
                }
              >
                ✦
              </motion.span>
            </div>

            {misionCompletadaHoy ? (
              <>
                <span className="mt-2 inline-flex items-center gap-1 rounded-full bg-mar/15 px-3 py-1 font-titulo text-sm font-semibold text-mar">
                  <Check className="h-3.5 w-3.5 stroke-[2.5]" aria-hidden />
                  Misión de hoy completada
                </span>
                <h2 className="mt-2.5 font-titulo text-2xl font-semibold leading-tight text-sol sm:text-3xl">
                  ¡Bien hecho, {nombre}!
                </h2>
                <div
                  className="mt-3 flex items-center justify-center gap-2.5"
                  aria-label={`${estrellasHoy} estrellas hoy`}
                >
                  {[1, 2, 3].map((n) => {
                    const ganada = n <= estrellasHoy;
                    return (
                      <motion.span
                        key={n}
                        initial={
                          reducir
                            ? false
                            : { opacity: 0, scale: 0.3, y: 16 }
                        }
                        animate={{
                          opacity: ganada ? 1 : 0.3,
                          scale: ganada ? 1 : 0.85,
                          y: 0,
                        }}
                        transition={{
                          delay: reducir ? 0 : 0.35 + (n - 1) * 0.18,
                          type: "spring",
                          stiffness: 400,
                          damping: 14,
                        }}
                      >
                        <Star
                          className={
                            ganada
                              ? "h-14 w-14 fill-[#FAC775] stroke-[#E8A84A] drop-shadow-[0_4px_8px_rgba(232,168,74,0.45)] sm:h-16 sm:w-16"
                              : "h-14 w-14 fill-[#D4CBBE] stroke-[#B8AFA3] sm:h-16 sm:w-16"
                          }
                          strokeWidth={1.5}
                          aria-hidden
                        />
                      </motion.span>
                    );
                  })}
                </div>
                <p className="mt-2.5 font-cuerpo text-base text-black/50">
                  ¡Vuelve mañana! Mientras, puedes practicar.
                </p>
                <Link
                  href="/practica"
                  className="mt-4 inline-flex min-h-14 w-full items-center justify-center rounded-2xl bg-mar-claro px-5 font-titulo text-lg font-semibold text-white shadow-[0_4px_0_0_rgba(29,158,117,0.28)] transition active:translate-y-0.5 active:shadow-none"
                >
                  Seguir practicando
                </Link>
              </>
            ) : (
              <>
                <span className="mt-2 inline-flex rounded-full bg-sol/12 px-3 py-1 font-titulo text-sm font-semibold text-sol">
                  Misión de hoy
                </span>
                <h2 className="mt-2.5 font-titulo text-2xl font-semibold leading-tight text-sol sm:text-3xl">
                  ¡Tu misión te espera!
                </h2>
                <p className="mt-1.5 font-cuerpo text-base text-black/50">
                  {MISION_OBJETIVO} preguntas para ganar estrellas
                </p>
                <Link
                  href="/jugar/mision"
                  className="mt-4 inline-flex min-h-14 w-full items-center justify-center rounded-2xl bg-gradient-to-b from-mar-claro to-mar px-5 font-titulo text-xl font-semibold text-white shadow-[0_4px_0_0_rgba(18,110,80,0.35)] transition active:translate-y-0.5 active:shadow-none"
                >
                  ¡Empezar!
                </Link>
              </>
            )}
          </div>
        </div>
      </Aparecer>

      {/* Cuadrícula 2×2 */}
      <ListaAparecer as="div" className="mt-4 grid grid-cols-2 gap-3">
        {SECUNDARIAS.map((item) => {
          const Icono = item.icono;
          return (
            <AparecerItem key={item.nombre} as="div">
              <Link
                href={item.href}
                className="flex min-h-[6.25rem] flex-col items-center justify-center gap-2 rounded-[22px] bg-white px-3 py-3.5 text-center shadow-[0_8px_22px_-12px_rgba(216,90,48,0.28)] transition active:scale-[0.98]"
              >
                <span className="flex h-12 w-12 items-center justify-center rounded-[14px] bg-[#FDEFDF] text-[#D8894A]">
                  <Icono className="h-6 w-6 stroke-[1.75]" aria-hidden />
                </span>
                <span className="font-titulo text-base font-semibold text-sol">
                  {item.nombre}
                </span>
              </Link>
            </AparecerItem>
          );
        })}
      </ListaAparecer>
    </Pantalla>
  );
}
