"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { ChevronLeft, ChevronRight, Star } from "lucide-react";
import { motion, useReducedMotion } from "framer-motion";
import { Aparecer, BotonIcono, CabeceraNino, Pantalla, Tarjeta } from "@/components/ui";
import { Solete } from "@/components/solete";
import {
  celdasMes,
  compararMes,
  mesAParam,
  mesAnterior,
  mesSiguiente,
  nombreMesEs,
  type DiaMisionCalendario,
  type MesCivil,
} from "@/lib/juego/calendario";
import { cn } from "@/lib/cn";


const DIAS_SEMANA = ["L", "M", "X", "J", "V", "S", "D"] as const;

type Props = {
  mes: MesCivil;
  mesMaximo: MesCivil;
  hoyISO: string;
  misiones: DiaMisionCalendario[];
};

export function CalendarioVista({ mes, mesMaximo, hoyISO, misiones }: Props) {
  const router = useRouter();
  const reducir = useReducedMotion();
  const mapa = new Map(misiones.map((m) => [m.fecha, m.estrellas]));
  const diasJugados = misiones.length;
  const celdas = celdasMes(mes);
  const puedeSiguiente = compararMes(mes, mesMaximo) < 0;
  const esMesActual = compararMes(mes, mesMaximo) === 0;

  function irA(siguiente: MesCivil) {
    if (compararMes(siguiente, mesMaximo) > 0) return;
    router.push(`/calendario?mes=${mesAParam(siguiente)}`);
  }

  return (
    <Pantalla className="fondo-halo-sol pb-10 pt-5" sinAtmosfera>
      <Aparecer>
        <CabeceraNino titulo="Mi calendario" />
      </Aparecer>

      <Aparecer delay={0.06} className="mt-5">
        <Tarjeta className="flex items-center gap-4">
          <Solete
            mood={diasJugados > 0 ? "happy" : "wave"}
            size="md"
            priority
            alt=""
          />
          <div className="min-w-0 text-left">
            <p className="font-titulo text-xl font-semibold leading-snug text-primary">
              {diasJugados === 0
                ? esMesActual
                  ? "¡Empieza tu racha este mes!"
                  : "Sin misiones este mes"
                : diasJugados === 1
                  ? "¡1 día este mes!"
                  : `¡${diasJugados} días este mes!`}
            </p>
            <p className="mt-1 font-cuerpo text-sm leading-snug text-readable">
              {diasJugados > 0
                ? "Sigue así, lo estás haciendo genial"
                : "Cada misión cuenta. ¡Tú puedes!"}
            </p>
          </div>
        </Tarjeta>
      </Aparecer>

      <Aparecer delay={0.12} className="mt-4">
        <Tarjeta padding="md" className="px-3.5 sm:px-4">
          <div className="mb-3 flex items-center justify-between gap-2">
            <BotonIcono
              aria-label="Mes anterior"
              onClick={() => irA(mesAnterior(mes))}
              className="bg-sol/8 text-primary hover:bg-sol/15"
            >
              <ChevronLeft className="h-5 w-5 stroke-[1.75]" aria-hidden />
            </BotonIcono>
            <h2 className="font-titulo text-xl font-semibold text-primary">
              {nombreMesEs(mes)}
            </h2>
            <BotonIcono
              aria-label="Mes siguiente"
              disabled={!puedeSiguiente}
              onClick={() => irA(mesSiguiente(mes))}
              className="bg-sol/8 text-primary hover:bg-sol/15 disabled:opacity-30"
            >
              <ChevronRight className="h-5 w-5 stroke-[1.75]" aria-hidden />
            </BotonIcono>
          </div>

          <div className="mb-2 grid grid-cols-7 gap-1">
            {DIAS_SEMANA.map((d) => (
              <div
                key={d}
                className="py-1 text-center font-cuerpo text-xs font-medium text-readable"
              >
                {d}
              </div>
            ))}
          </div>

          <div className="grid grid-cols-7 gap-1.5">
            {celdas.map((celda, i) => {
              if (!celda.dia || !celda.fecha) {
                return <div key={`vacio-${i}`} className="aspect-square" />;
              }

              const estrellas = mapa.get(celda.fecha);
              const jugado = estrellas != null;
              const esHoy = celda.fecha === hoyISO;
              const esFuturo = celda.fecha > hoyISO;
              const esPasadoSinJugar = !jugado && !esHoy && !esFuturo;

              const contenido = (
                <>
                  <span
                    className={cn(
                      "font-titulo text-sm font-semibold leading-none",
                      jugado && "text-[#8B5A2B]",
                      esHoy && !jugado && "text-mar",
                      esPasadoSinJugar && "text-readable",
                      esFuturo && "text-readable/60",
                    )}
                  >
                    {celda.dia}
                  </span>
                  {jugado ? (
                    <span className="mt-0.5 flex items-center justify-center gap-px">
                      {Array.from({ length: estrellas }, (_, s) => (
                        <Star
                          key={s}
                          className="h-2.5 w-2.5 fill-[#FAC775] stroke-[#E8A84A]"
                          strokeWidth={1}
                          aria-hidden
                        />
                      ))}
                    </span>
                  ) : esHoy ? (
                    <span className="mt-0.5 font-cuerpo text-[0.65rem] font-medium leading-none text-mar">
                      hoy
                    </span>
                  ) : null}
                </>
              );

              const clasesCasilla = cn(
                "flex min-h-11 aspect-square flex-col items-center justify-center rounded-[12px] transition",
                jugado && "bg-[#FBE3C4]",
                esPasadoSinJugar && "bg-[#F7F1E8]",
                esFuturo && "bg-[#F7F1E8]/70 opacity-60",
                esHoy && "ring-2 ring-mar ring-offset-1 ring-offset-white",
                esHoy && jugado && "bg-[#FBE3C4]",
                esHoy && !jugado && "bg-surface",
              );

              if (esHoy && !jugado) {
                return (
                  <Link
                    key={celda.fecha}
                    href="/jugar/mision"
                    className={clasesCasilla}
                    aria-label="Hoy: ¡haz la misión!"
                  >
                    {contenido}
                  </Link>
                );
              }

              return (
                <motion.div
                  key={celda.fecha}
                  className={clasesCasilla}
                  initial={
                    jugado && !reducir
                      ? { scale: 0.6, opacity: 0 }
                      : false
                  }
                  animate={{ scale: 1, opacity: 1 }}
                  transition={
                    jugado && !reducir
                      ? {
                          delay: 0.02 * (celda.dia % 7),
                          type: "spring",
                          stiffness: 380,
                          damping: 16,
                        }
                      : undefined
                  }
                  aria-label={
                    jugado
                      ? `${celda.dia}: ${estrellas} estrellas`
                      : undefined
                  }
                >
                  {contenido}
                </motion.div>
              );
            })}
          </div>
        </Tarjeta>
      </Aparecer>

      {/* Leyenda */}
      <Aparecer delay={0.18} className="mt-5">
        <ul className="flex flex-wrap items-center justify-center gap-x-5 gap-y-2">
          <Leyenda color="#FBE3C4" borde="transparent" label="Jugado" />
          <Leyenda color="#FFFFFF" borde="#1D9E75" label="Hoy" />
          <Leyenda color="#F7F1E8" borde="transparent" label="Sin jugar" />
        </ul>
      </Aparecer>
    </Pantalla>
  );
}

function Leyenda({
  color,
  borde,
  label,
}: {
  color: string;
  borde: string;
  label: string;
}) {
  return (
    <li className="inline-flex items-center gap-1.5 font-cuerpo text-sm text-readable">
      <span
        className="h-3 w-3 rounded-full"
        style={{
          backgroundColor: color,
          boxShadow: borde !== "transparent" ? `inset 0 0 0 2px ${borde}` : undefined,
        }}
        aria-hidden
      />
      {label}
    </li>
  );
}
