"use client";

import { Gem, Star } from "lucide-react";
import { motion, useReducedMotion } from "framer-motion";
import { useEffect, useState } from "react";
import { Aparecer, Boton, Pantalla } from "@/components/ui";
import { DesbloqueoLegendario } from "@/components/juego/DesbloqueoLegendario";
import { FanfarriaNuevaMedalla } from "@/components/juego/FanfarriaNuevaMedalla";
import { Solete } from "@/components/solete";
import { MISSION_STAGES } from "@/lib/juego/mission-stages";
import { MISION_OBJETIVO, mensajeAnimo } from "@/lib/juego/reglas";
import type { MedallaDesbloqueada } from "@/lib/juego/medallas";
import type { LegendarioDesbloqueado } from "@/lib/juego/legendarios-eval";
import type { ModoJuego } from "@/types/database";

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
  legendariosNuevos?: LegendarioDesbloqueado[];
  /** Nº de retos de la aventura (Fase 5). */
  etapasTotales?: number;
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
  legendariosNuevos = [],
  etapasTotales = MISSION_STAGES.stages.length,
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
  const [mostrarCta, setMostrarCta] = useState(modo !== "mision");
  const [fanfarria, setFanfarria] = useState(false);
  const [indiceMedalla, setIndiceMedalla] = useState(0);
  const [fanfarriaHecha, setFanfarriaHecha] = useState(
    () => medallasNuevas.length === 0,
  );
  const [celebraLeg, setCelebraLeg] = useState(false);
  const [indiceLeg, setIndiceLeg] = useState(0);
  const [legHechos, setLegHechos] = useState(
    () => legendariosNuevos.length === 0,
  );

  useEffect(() => {
    if (modo !== "mision") return;
    const t = window.setTimeout(
      () => setMostrarDiamante(true),
      reducir ? 180 : 1100,
    );
    return () => window.clearTimeout(t);
  }, [modo, reducir]);

  useEffect(() => {
    if (modo !== "mision" || !mostrarDiamante) return;
    const t = window.setTimeout(
      () => setMostrarCta(true),
      reducir ? 80 : 380,
    );
    return () => window.clearTimeout(t);
  }, [modo, mostrarDiamante, reducir]);

  useEffect(() => {
    if (modo !== "mision" || !mostrarDiamante) return;
    if (medallasNuevas.length === 0) return;
    const t = window.setTimeout(
      () => setFanfarria(true),
      reducir ? 150 : 900,
    );
    return () => window.clearTimeout(t);
  }, [modo, mostrarDiamante, medallasNuevas.length, reducir]);

  useEffect(() => {
    if (!fanfarriaHecha) return;
    if (legendariosNuevos.length === 0) return;
    if (legHechos) return;
    const t = window.setTimeout(
      () => setCelebraLeg(true),
      reducir ? 80 : 420,
    );
    return () => window.clearTimeout(t);
  }, [fanfarriaHecha, legendariosNuevos.length, legHechos, reducir]);

  useEffect(() => {
    if (modo === "mision") return;
    if (legendariosNuevos.length === 0) return;
    const t = window.setTimeout(
      () => setCelebraLeg(true),
      reducir ? 80 : 500,
    );
    return () => window.clearTimeout(t);
  }, [modo, legendariosNuevos.length, reducir]);

  function continuarMedalla() {
    if (indiceMedalla < medallasNuevas.length - 1) {
      setIndiceMedalla((i) => i + 1);
      return;
    }
    setFanfarria(false);
    setFanfarriaHecha(true);
  }

  function continuarLegendario() {
    if (indiceLeg < legendariosNuevos.length - 1) {
      setIndiceLeg((i) => i + 1);
      return;
    }
    setCelebraLeg(false);
    setLegHechos(true);
  }

  if (modo === "mision") {
    const retosMostrados = MISSION_STAGES.stages.slice(0, etapasTotales);

    return (
      <Pantalla
        centrar
        className="fondo-halo-sol overflow-hidden"
        sinAtmosfera
      >
        {fanfarria ? (
          <FanfarriaNuevaMedalla
            medallas={medallasNuevas}
            indice={indiceMedalla}
            onContinuar={continuarMedalla}
          />
        ) : null}

        {celebraLeg ? (
          <DesbloqueoLegendario
            legendarios={legendariosNuevos}
            indice={indiceLeg}
            onContinuar={continuarLegendario}
          />
        ) : null}

        <div className="relative z-20 flex w-full max-w-sm flex-col items-center text-center">
          <motion.div
            initial={reducir ? false : { opacity: 0, scale: 0.82, y: 16 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            transition={
              reducir
                ? { duration: 0 }
                : { type: "spring", stiffness: 280, damping: 16 }
            }
          >
            <Solete
              mood={estrellas >= 2 ? "cheer" : "love"}
              size="hero"
              priority
              alt=""
            />
          </motion.div>

          <motion.div
            className="mt-3"
            initial={reducir ? false : { opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: reducir ? 0 : 0.12, duration: 0.28 }}
          >
            <p className="font-titulo text-base font-semibold text-sol">
              🎉 Gran final
            </p>
            <h1 className="mt-1 font-titulo text-3xl font-semibold leading-tight text-primary sm:text-4xl">
              ¡Aventura completada!
            </h1>
            <p className="mt-2 font-cuerpo text-lg text-readable">
              Has superado{" "}
              <span className="font-titulo font-semibold text-primary">
                {etapasTotales} {etapasTotales === 1 ? "reto" : "retos"}
              </span>
            </p>
            <p className="mt-1 font-cuerpo text-base text-readable/90">
              {aciertos} de {total} aciertos
            </p>
            {misionCorta ? (
              <p className="mt-1 font-cuerpo text-sm text-readable/80">
                Aventura cortita: había menos de {MISION_OBJETIVO} preguntas.
              </p>
            ) : null}
          </motion.div>

          <motion.div
            className="mt-5 flex w-full gap-1.5"
            initial={reducir ? false : { opacity: 0, y: 8 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: reducir ? 0 : 0.18 }}
            aria-label="Retos superados"
          >
            {retosMostrados.map((reto, i) => (
              <div
                key={reto.id}
                className="flex flex-1 flex-col items-center gap-1"
              >
                <motion.div
                  className="h-2.5 w-full rounded-full"
                  style={{ backgroundColor: reto.color }}
                  initial={reducir ? false : { scaleX: 0.3, opacity: 0.4 }}
                  animate={{ scaleX: 1, opacity: 1 }}
                  transition={{
                    delay: reducir ? 0 : 0.22 + i * 0.1,
                    type: "spring",
                    stiffness: 260,
                    damping: 18,
                  }}
                />
                <span className="font-titulo text-[10px] font-semibold text-readable sm:text-xs">
                  {reto.emoji}
                </span>
              </div>
            ))}
          </motion.div>

          <div
            className="mt-7 flex items-end justify-center gap-3 sm:gap-4"
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
                      : { opacity: 0, scale: 0.15, y: 48, rotate: -12 }
                  }
                  animate={{
                    opacity: ganada ? 1 : 0.28,
                    scale: ganada ? 1 : 0.85,
                    y: 0,
                    rotate: 0,
                  }}
                  transition={{
                    delay: reducir ? 0 : 0.28 + (n - 1) * 0.26,
                    type: "spring",
                    stiffness: 380,
                    damping: 11,
                    mass: 0.8,
                  }}
                  className="flex flex-col items-center"
                >
                  <Star
                    className={
                      ganada
                        ? "h-16 w-16 fill-[#FAC775] stroke-[#E8A84A] drop-shadow-[0_6px_12px_rgba(232,168,74,0.45)] sm:h-[4.5rem] sm:w-[4.5rem]"
                        : "h-16 w-16 fill-[#D4CBBE] stroke-[#B8AFA3] sm:h-[4.5rem] sm:w-[4.5rem]"
                    }
                    strokeWidth={1.5}
                    aria-hidden
                  />
                </motion.div>
              );
            })}
          </div>

          <div className="mt-8 min-h-[5rem] w-full">
            {mostrarDiamante ? (
              <motion.div
                initial={reducir ? false : { opacity: 0, scale: 0.75, y: 18 }}
                animate={{ opacity: 1, scale: 1, y: 0 }}
                transition={{ type: "spring", stiffness: 300, damping: 15 }}
                className="mx-auto flex w-full flex-col items-center gap-2 rounded-card bg-surface/95 px-5 py-4 shadow-elevated"
              >
                <motion.div
                  className="flex items-center gap-2 font-titulo text-xl font-semibold text-mar"
                  initial={reducir ? false : { scale: 0.9 }}
                  animate={{ scale: [1, 1.06, 1] }}
                  transition={
                    reducir
                      ? { duration: 0 }
                      : { delay: 0.15, duration: 0.55 }
                  }
                >
                  <Gem className="h-6 w-6 stroke-[1.75]" aria-hidden />
                  {diamantesGanados > 0
                    ? `+${diamantesGanados} diamantes`
                    : "¡Aventura del día hecha!"}
                </motion.div>
                <p className="font-titulo text-base text-primary">
                  {mensajeAnimo(modo, estrellas, aciertos, total)}
                </p>
                {rachaSumoHoy && rachaDias != null ? (
                  <p className="font-cuerpo text-sm text-readable">
                    Racha: {rachaDias} {rachaDias === 1 ? "día" : "días"}
                  </p>
                ) : null}
              </motion.div>
            ) : null}
          </div>

          {errorGuardado ? (
            <p className="mt-3 text-sm text-error" role="alert">
              {errorGuardado}
            </p>
          ) : null}

          {mostrarCta && fanfarriaHecha && legHechos ? (
            <motion.div
              className="mt-8 flex w-full flex-col gap-3"
              initial={reducir ? false : { opacity: 0, y: 16 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{
                delay: reducir ? 0 : 0.08,
                type: "spring",
                stiffness: 260,
                damping: 18,
              }}
            >
              <Boton href={practicar} variant="primario" size="lg">
                A practicar
              </Boton>
              <Boton href="/entrada" variant="suave" size="md">
                Volver a casa
              </Boton>
            </motion.div>
          ) : (
            <div className="mt-8 min-h-[7.5rem] w-full" aria-hidden />
          )}
        </div>
      </Pantalla>
    );
  }

  return (
    <Pantalla centrar className="fondo-halo-sol" sinAtmosfera>
      {celebraLeg ? (
        <DesbloqueoLegendario
          legendarios={legendariosNuevos}
          indice={indiceLeg}
          onContinuar={continuarLegendario}
        />
      ) : null}

      <div className="flex flex-col items-center text-center">
        <Aparecer>
          <Solete mood="happy" size="xl" priority alt="" />
        </Aparecer>
        <Aparecer delay={0.08}>
          <h1 className="mt-4 font-titulo text-3xl font-semibold text-primary">
            ¡Descanso!
          </h1>
          <p className="mt-2 font-cuerpo text-lg text-readable">
            {ninoNombre} · {asignaturaNombre}
          </p>
          <p className="mt-4 font-titulo text-xl text-mar">
            {aciertos} de {total} aciertos
          </p>
          <p className="mt-3 font-titulo text-lg text-primary">
            {mensajeAnimo(modo, estrellas, aciertos, total)}
          </p>
        </Aparecer>
        {errorGuardado ? (
          <p className="mt-3 text-sm text-error" role="alert">
            {errorGuardado}
          </p>
        ) : null}
        {legHechos ? (
          <Aparecer delay={0.2} className="mt-8 flex w-full max-w-sm flex-col gap-3">
            <Boton href={otraVez} variant="primario">
              Seguir practicando
            </Boton>
            <Boton href={practicar} variant="suave">
              Volver a casa
            </Boton>
          </Aparecer>
        ) : (
          <div className="mt-8 min-h-[7.5rem] w-full" aria-hidden />
        )}
      </div>
    </Pantalla>
  );
}
