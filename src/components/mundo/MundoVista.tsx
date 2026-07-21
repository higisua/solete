"use client";

import Image from "next/image";
import Link from "next/link";
import {
  Aparecer,
  AparecerItem,
  EncabezadoPantalla,
  ListaAparecer,
  Pantalla,
  Pulsable,
  Tarjeta,
} from "@/components/ui";
import { iconoAsignatura } from "@/lib/iconos";

export type AsignaturaMundo = {
  id: string;
  nombre: string;
  icono: string | null;
};

export type MundoVistaProps = {
  nombre: string;
  curso: string;
  avatarSrc: string | null;
  avatarAlt: string;
  iniciales: string;
  estrellas: number;
  puntos: number;
  racha: number;
  mostrarCambiarJugador: boolean;
  /** Server Action: cambia el niño activo. */
  cambiarJugadorAction: () => Promise<void>;
  asignaturas: AsignaturaMundo[];
};

function ChipStat({
  emoji,
  valor,
  tono,
}: {
  emoji: string;
  valor: number;
  tono: "sol" | "mar";
}) {
  return (
    <div
      className={`inline-flex min-h-11 items-center gap-1.5 rounded-2xl bg-white/90 px-3.5 py-2 font-titulo text-lg shadow-[0_3px_10px_-4px_rgba(0,0,0,0.12)] ${
        tono === "sol" ? "text-sol" : "text-mar"
      }`}
    >
      <span aria-hidden className="text-xl leading-none">
        {emoji}
      </span>
      <span>{valor}</span>
    </div>
  );
}

export function MundoVista({
  nombre,
  curso,
  avatarSrc,
  avatarAlt,
  iniciales,
  estrellas,
  puntos,
  racha,
  mostrarCambiarJugador,
  cambiarJugadorAction,
  asignaturas,
}: MundoVistaProps) {
  return (
    <Pantalla>
      <EncabezadoPantalla
        titulo={`¡Hola, ${nombre}!`}
        subtitulo={`${curso}º de primaria`}
        accion={
          <Link
            href="/zona-padres"
            aria-label="Zona padres"
            className="flex h-12 w-12 items-center justify-center rounded-full text-2xl text-black/30 transition hover:bg-white/80 hover:text-black/50"
          >
            ⚙️
          </Link>
        }
        superior={
          <Aparecer>
            {avatarSrc ? (
              <Image
                src={avatarSrc}
                alt={avatarAlt}
                width={128}
                height={128}
                unoptimized
                priority
                className="h-28 w-28 object-contain drop-shadow-sm"
              />
            ) : (
              <div className="flex h-28 w-28 items-center justify-center rounded-full bg-limon font-titulo text-5xl text-sol shadow-sm">
                {iniciales}
              </div>
            )}
          </Aparecer>
        }
      >
        <Aparecer delay={0.08}>
          <div className="flex flex-wrap justify-center gap-2.5">
            <ChipStat emoji="⭐" valor={estrellas} tono="sol" />
            <ChipStat emoji="💎" valor={puntos} tono="mar" />
            {racha > 0 ? <ChipStat emoji="🔥" valor={racha} tono="sol" /> : null}
          </div>
        </Aparecer>
      </EncabezadoPantalla>

      {mostrarCambiarJugador ? (
        <Aparecer delay={0.12} className="mt-4 flex justify-center">
          <form action={cambiarJugadorAction}>
            <button
              type="submit"
              className="min-h-11 px-2 font-titulo text-base font-semibold text-mar underline decoration-mar/40 underline-offset-4"
            >
              Cambiar de jugador
            </button>
          </form>
        </Aparecer>
      ) : null}

      <Aparecer delay={0.16} className="mt-10">
        <h2 className="font-titulo text-2xl font-semibold text-sol">
          ¿Qué repasamos?
        </h2>
      </Aparecer>

      {asignaturas.length === 0 ? (
        <Aparecer delay={0.2} className="mt-4">
          <Tarjeta>
            <p className="text-center text-base text-black/60">
              Aún no hay asignaturas para tu curso. ¡Vuelve pronto!
            </p>
          </Tarjeta>
        </Aparecer>
      ) : (
        <ListaAparecer className="mt-4 flex flex-col gap-3">
          {asignaturas.map((asig) => (
            <AparecerItem key={asig.id}>
              <Pulsable>
                <Link href={`/jugar/${asig.id}`} className="block">
                  <Tarjeta className="flex min-h-[76px] items-center gap-4 py-3.5 transition-colors hover:bg-mar-claro/15">
                    <span
                      className="flex h-[3.75rem] w-[3.75rem] shrink-0 items-center justify-center rounded-2xl bg-limon/55 text-4xl leading-none"
                      aria-hidden
                    >
                      {iconoAsignatura(asig.icono)}
                    </span>
                    <span className="font-titulo text-2xl font-semibold text-sol">
                      {asig.nombre}
                    </span>
                  </Tarjeta>
                </Link>
              </Pulsable>
            </AparecerItem>
          ))}
        </ListaAparecer>
      )}
    </Pantalla>
  );
}
