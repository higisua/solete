"use client";

import Image from "next/image";
import { motion } from "framer-motion";
import {
  Aparecer,
  Boton,
  EncabezadoPantalla,
  Pantalla,
  Tarjeta,
} from "@/components/ui";
import { MISION_OBJETIVO, mensajeAnimo } from "@/lib/juego/reglas";
import type { ModoJuego } from "@/types/database";
import { publicAssetClient } from "@/lib/public-asset-client";

type Props = {
  modo: ModoJuego;
  ninoNombre: string;
  asignaturaNombre: string;
  asignaturaId: string;
  estrellas: number;
  puntos: number;
  diamantesGanados?: number;
  aciertos: number;
  total: number;
  misionCorta: boolean;
  rachaDias: number | null;
  rachaSumoHoy: boolean;
  errorGuardado: string | null;
  hrefOtraVez?: string;
  hrefCambiar?: string;
};

export function ResultadosPartida({
  modo,
  ninoNombre,
  asignaturaNombre,
  asignaturaId,
  estrellas,
  diamantesGanados = 0,
  aciertos,
  total,
  misionCorta,
  rachaDias,
  rachaSumoHoy,
  errorGuardado,
  hrefOtraVez,
  hrefCambiar,
}: Props) {
  const otraVez =
    hrefOtraVez ??
    (modo === "mision"
      ? "/jugar/mision"
      : `/jugar/${asignaturaId}/${modo}`);
  const cambiar = hrefCambiar ?? "/mundo";

  return (
    <Pantalla centrar>
      <EncabezadoPantalla
        titulo={modo === "mision" ? "¡Misión terminada!" : "¡Descanso!"}
        subtitulo={`${ninoNombre} · ${asignaturaNombre}`}
        superior={
          <Aparecer>
            <Image
              src={publicAssetClient("assets/logos/solete_solo_logo.png")}
              alt="Solete"
              width={112}
              height={112}
              unoptimized
              priority
              className="h-24 w-24 object-contain drop-shadow-sm"
            />
          </Aparecer>
        }
      >
        {modo === "mision" ? (
          <Aparecer delay={0.1}>
            <div
              className="flex justify-center gap-2 text-5xl"
              aria-label={`${estrellas} estrellas`}
            >
              {[1, 2, 3].map((n) => (
                <motion.span
                  key={n}
                  initial={{ opacity: 0.2, scale: 0.6 }}
                  animate={{
                    opacity: n <= estrellas ? 1 : 0.22,
                    scale: n <= estrellas ? 1 : 0.85,
                  }}
                  transition={{
                    delay: 0.15 + n * 0.12,
                    type: "spring",
                    stiffness: 320,
                    damping: 18,
                  }}
                  aria-hidden
                >
                  ⭐
                </motion.span>
              ))}
            </div>
          </Aparecer>
        ) : null}
      </EncabezadoPantalla>

      <Aparecer delay={0.22} className="mt-6">
        <Tarjeta padding="lg" className="text-center">
          {modo === "mision" ? (
            <p className="font-titulo text-3xl font-semibold text-mar">
              {diamantesGanados > 0 ? "+1 diamante" : "Misión completada"}
            </p>
          ) : (
            <p className="font-titulo text-3xl font-semibold text-mar">
              Práctica terminada
            </p>
          )}
          <p className="mt-2 text-lg text-black/65">
            {aciertos} de {total} aciertos
          </p>
          {misionCorta && modo === "mision" ? (
            <p className="mt-2 text-sm text-black/45">
              Había menos de {MISION_OBJETIVO} preguntas; misión más cortita.
            </p>
          ) : null}
          <p className="mt-4 font-titulo text-xl leading-snug text-sol">
            {mensajeAnimo(modo, estrellas, aciertos, total)}
          </p>
          {rachaSumoHoy && rachaDias != null ? (
            <p className="mt-3 inline-flex items-center gap-1.5 rounded-2xl bg-limon/40 px-3 py-1.5 font-titulo text-base text-sol">
              <span aria-hidden>🔥</span>
              Racha: {rachaDias} {rachaDias === 1 ? "día" : "días"}
            </p>
          ) : null}
          {errorGuardado ? (
            <p className="mt-3 text-sm text-fallo" role="alert">
              {errorGuardado}
            </p>
          ) : null}
        </Tarjeta>
      </Aparecer>

      <Aparecer delay={0.3} className="mt-8 flex flex-col gap-3">
        {modo === "mision" ? (
          <Boton href="/mundo" variant="primario">
            Volver al mundo
          </Boton>
        ) : (
          <>
            <Boton href={otraVez} variant="primario">
              Seguir practicando
            </Boton>
            <Boton href={cambiar} variant="secundario">
              Cambiar asignatura
            </Boton>
          </>
        )}
        <Boton href="/entrada" variant="suave">
          Inicio
        </Boton>
      </Aparecer>
    </Pantalla>
  );
}
