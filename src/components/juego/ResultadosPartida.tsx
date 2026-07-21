"use client";

import Image from "next/image";
import { Gem, Star } from "lucide-react";
import { motion, useReducedMotion } from "framer-motion";
import { useEffect, useState } from "react";
import { Aparecer, Boton, Pantalla } from "@/components/ui";
import { Confeti } from "@/components/juego/Confeti";
import { FanfarriaNuevaMedalla } from "@/components/juego/FanfarriaNuevaMedalla";
import { MISION_OBJETIVO, mensajeAnimo } from "@/lib/juego/reglas";
import type { MedallaDesbloqueada } from "@/lib/juego/medallas";
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
  medallasNuevas?: MedallaDesbloqueada[];
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
  medallasNuevas = [],
  errorGuardado,
  hrefOtraVez,
  hrefCambiar,
}: Props) {
  const otraVez =
    hrefOtraVez ??
    (modo === "mision"
      ? "/jugar/mision"
      : `/jugar/${asignaturaId}/${modo}`);
  const practicar = hrefCambiar ?? "/mundo";
  const reducir = useReducedMotion();
  const [mostrarDiamante, setMostrarDiamante] = useState(modo !== "mision");
  const [fanfarria, setFanfarria] = useState(false);
  const [indiceMedalla, setIndiceMedalla] = useState(0);
  const [fanfarriaHecha, setFanfarriaHecha] = useState(
    () => medallasNuevas.length === 0,
  );

  useEffect(() => {
    if (modo !== "mision") return;
    // Tras las 3 estrellas (~0.35 + 3*0.28)
    const t = window.setTimeout(
      () => setMostrarDiamante(true),
      reducir ? 200 : 1200,
    );
    return () => window.clearTimeout(t);
  }, [modo, reducir]);

  useEffect(() => {
    if (modo !== "mision" || !mostrarDiamante) return;
    if (medallasNuevas.length === 0) return;
    const t = window.setTimeout(
      () => setFanfarria(true),
      reducir ? 150 : 900,
    );
    return () => window.clearTimeout(t);
  }, [modo, mostrarDiamante, medallasNuevas.length, reducir]);

  function continuarMedalla() {
    if (indiceMedalla < medallasNuevas.length - 1) {
      setIndiceMedalla((i) => i + 1);
      return;
    }
    setFanfarria(false);
    setFanfarriaHecha(true);
  }

  if (modo === "mision") {
    return (
      <Pantalla centrar className="fondo-halo-sol overflow-hidden">
        <Confeti />

        {fanfarria ? (
          <FanfarriaNuevaMedalla
            medallas={medallasNuevas}
            indice={indiceMedalla}
            onContinuar={continuarMedalla}
          />
        ) : null}

        <div className="relative z-20 flex flex-col items-center text-center">
          <Aparecer>
            <Image
              src={publicAssetClient("assets/logos/solete_solo_logo.png")}
              alt=""
              width={120}
              height={120}
              unoptimized
              priority
              className="h-24 w-24 object-contain drop-shadow-sm"
              aria-hidden
            />
          </Aparecer>

          <Aparecer delay={0.08}>
            <h1 className="mt-4 font-titulo text-3xl font-semibold leading-tight text-sol sm:text-4xl">
              ¡Misión completada!
            </h1>
            <p className="mt-2 font-cuerpo text-lg text-black/55">
              Has acertado {aciertos} de {total}
            </p>
            {misionCorta ? (
              <p className="mt-1 font-cuerpo text-sm text-black/40">
                Misión cortita: había menos de {MISION_OBJETIVO} preguntas.
              </p>
            ) : null}
          </Aparecer>

          {/* Estrellas una a una (rebote) */}
          <div
            className="mt-8 flex items-end justify-center gap-3"
            aria-label={`${estrellas} estrellas`}
          >
            {[1, 2, 3].map((n) => {
              const ganada = n <= estrellas;
              return (
                <motion.div
                  key={n}
                  initial={
                    reducir
                      ? { opacity: ganada ? 1 : 0.3, scale: 1, y: 0 }
                      : { opacity: 0, scale: 0.2, y: 40 }
                  }
                  animate={{
                    opacity: ganada ? 1 : 0.28,
                    scale: ganada ? 1 : 0.85,
                    y: 0,
                  }}
                  transition={{
                    delay: reducir ? 0 : 0.25 + (n - 1) * 0.28,
                    type: "spring",
                    stiffness: 420,
                    damping: 12,
                    mass: 0.85,
                  }}
                  className="flex flex-col items-center"
                >
                  <Star
                    className={
                      ganada
                        ? "h-14 w-14 fill-[#FAC775] stroke-[#E8A84A] drop-shadow-sm sm:h-16 sm:w-16"
                        : "h-14 w-14 fill-[#D4CBBE] stroke-[#B8AFA3] sm:h-16 sm:w-16"
                    }
                    strokeWidth={1.5}
                    aria-hidden
                  />
                </motion.div>
              );
            })}
          </div>

          {/* Diamante */}
          <div className="mt-8 min-h-[4.5rem]">
            {mostrarDiamante ? (
              <motion.div
                initial={reducir ? false : { opacity: 0, scale: 0.7, y: 12 }}
                animate={{ opacity: 1, scale: 1, y: 0 }}
                transition={{ type: "spring", stiffness: 320, damping: 16 }}
                className="inline-flex flex-col items-center gap-2 rounded-[18px] bg-white/90 px-5 py-3 shadow-[0_8px_24px_-12px_rgba(216,90,48,0.35)]"
              >
                <div className="flex items-center gap-2 font-titulo text-xl font-semibold text-mar">
                  <Gem className="h-6 w-6 stroke-[1.75]" aria-hidden />
                  {diamantesGanados > 0
                    ? "+2 diamantes por jugar hoy"
                    : "¡Misión del día hecha!"}
                </div>
                <p className="font-titulo text-base text-sol">
                  {mensajeAnimo(modo, estrellas, aciertos, total)}
                </p>
                {rachaSumoHoy && rachaDias != null ? (
                  <p className="font-cuerpo text-sm text-black/50">
                    🔥 Racha: {rachaDias} {rachaDias === 1 ? "día" : "días"}
                  </p>
                ) : null}
              </motion.div>
            ) : null}
          </div>

          {errorGuardado ? (
            <p className="mt-3 text-sm text-fallo" role="alert">
              {errorGuardado}
            </p>
          ) : null}

          {mostrarDiamante && fanfarriaHecha ? (
            <Aparecer delay={0.1} className="mt-10 flex w-full max-w-sm flex-col gap-3">
              <Boton href={practicar} variant="primario">
                A practicar
              </Boton>
              <Boton href="/entrada" variant="secundario">
                Volver a casa
              </Boton>
            </Aparecer>
          ) : (
            <div className="mt-10 min-h-[7.5rem] w-full max-w-sm" aria-hidden />
          )}
        </div>
      </Pantalla>
    );
  }

  // Práctica
  return (
    <Pantalla centrar className="fondo-halo-sol">
      <div className="flex flex-col items-center text-center">
        <Aparecer>
          <Image
            src={publicAssetClient("assets/logos/solete_solo_logo.png")}
            alt=""
            width={112}
            height={112}
            unoptimized
            priority
            className="h-24 w-24 object-contain drop-shadow-sm"
            aria-hidden
          />
        </Aparecer>
        <Aparecer delay={0.08}>
          <h1 className="mt-4 font-titulo text-3xl font-semibold text-sol">
            ¡Descanso!
          </h1>
          <p className="mt-2 font-cuerpo text-lg text-black/55">
            {ninoNombre} · {asignaturaNombre}
          </p>
          <p className="mt-4 font-titulo text-xl text-mar">
            {aciertos} de {total} aciertos
          </p>
          <p className="mt-3 font-titulo text-lg text-sol">
            {mensajeAnimo(modo, estrellas, aciertos, total)}
          </p>
        </Aparecer>
        {errorGuardado ? (
          <p className="mt-3 text-sm text-fallo" role="alert">
            {errorGuardado}
          </p>
        ) : null}
        <Aparecer delay={0.2} className="mt-8 flex w-full max-w-sm flex-col gap-3">
          <Boton href={otraVez} variant="primario">
            Seguir practicando
          </Boton>
          <Boton href={practicar} variant="secundario">
            Volver a casa
          </Boton>
        </Aparecer>
      </div>
    </Pantalla>
  );
}
