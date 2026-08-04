"use client";

import { Star } from "lucide-react";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { useEffect, useMemo, useRef, useState, useTransition } from "react";
import {
  finalizarPartida,
  type ResultadoGuardado,
} from "@/app/actions/partida";
import { FeedbackCapa } from "@/components/juego/FeedbackCapa";
import { MisionIntro } from "@/components/juego/MisionIntro";
import { MisionPuenteEtapa } from "@/components/juego/MisionPuenteEtapa";
import { PreguntaMultiple } from "@/components/juego/PreguntaMultiple";
import { PreguntaTrueFalse } from "@/components/juego/PreguntaTrueFalse";
import { ProgresoMisionEtapas } from "@/components/juego/ProgresoMisionEtapas";
import { ResultadosPartida } from "@/components/juego/ResultadosPartida";
import { TecladoNumerico } from "@/components/juego/TecladoNumerico";
import { Boton } from "@/components/ui";
import { Solete, type SoleteMood } from "@/components/solete";
import { cn } from "@/lib/cn";
import {
  MISSION_STAGES,
  cuerpoIntroDinamico,
  debeMostrarPuenteTras,
  planificarEtapas,
  posicionEnEtapa,
  type EtapaPlan,
} from "@/lib/juego/mission-stages";
import {
  esRespuestaCorrecta,
  formatearRespuestaCorrecta,
  temaPredominante,
} from "@/lib/juego/reglas";
import type { ModoJuego, Pregunta } from "@/types/database";
import type { NivelPractica } from "@/lib/juego/economia";

type Props = {
  ninoId: string;
  ninoNombre: string;
  asignaturaId: string;
  asignaturaNombre: string;
  modo: ModoJuego;
  preguntasIniciales: Pregunta[];
  misionCorta: boolean;
  misionDiariaId?: string | null;
  hrefOtraVez?: string;
  hrefCambiar?: string;
  nivelPractica?: NivelPractica;
};

type Fase =
  | "intro"
  | "pregunta"
  | "revelando"
  | "feedback"
  | "puente_etapa"
  | "inicio_ultima"
  | "resultados";

type ContadorTema = { temaId: string; aciertos: number; intentos: number };

type PuentePendiente = {
  etapaCompletada: EtapaPlan;
  nextIndex: number;
};

/** Reacción en tarjeta + Solete (~card feel inmediato). */
const MS_REVELAR = 320;
/** Desde el toque hasta la siguiente ≈ 900 ms en acierto. */
const MS_FEEDBACK_ACIERTO = 580;
/** Un poco más para leer la respuesta correcta. */
const MS_FEEDBACK_FALLO = 880;

const TRANSICION_PREGUNTA = {
  duration: 0.23,
  ease: [0.22, 1, 0.36, 1] as const,
};

function shuffle<T>(items: T[]): T[] {
  const arr = [...items];
  for (let i = arr.length - 1; i > 0; i -= 1) {
    const j = Math.floor(Math.random() * (i + 1));
    [arr[i], arr[j]] = [arr[j], arr[i]];
  }
  return arr;
}

export function MotorPreguntas({
  ninoId,
  ninoNombre,
  asignaturaId,
  asignaturaNombre,
  modo,
  preguntasIniciales,
  misionCorta,
  misionDiariaId = null,
  hrefOtraVez,
  hrefCambiar,
  nivelPractica = "normal",
}: Props) {
  const esMision = modo === "mision";
  const plan = useMemo(
    () => planificarEtapas(preguntasIniciales.length),
    [preguntasIniciales.length],
  );

  const [cola, setCola] = useState<Pregunta[]>(preguntasIniciales);
  const [indice, setIndice] = useState(0);
  const [aciertos, setAciertos] = useState(0);
  const [respondidas, setRespondidas] = useState(0);
  const [porTema, setPorTema] = useState<ContadorTema[]>([]);
  const [fase, setFase] = useState<Fase>(esMision ? "intro" : "pregunta");
  const [puente, setPuente] = useState<PuentePendiente | null>(null);
  const [acertoUltima, setAcertoUltima] = useState(false);
  const [textoCorrecto, setTextoCorrecto] = useState("");
  const [respuestaElegida, setRespuestaElegida] = useState<unknown>(null);
  const [numericValor, setNumericValor] = useState("");
  const [resultado, setResultado] = useState<ResultadoGuardado | null>(null);
  const [errorGuardado, setErrorGuardado] = useState<string | null>(null);
  const [pending, startTransition] = useTransition();
  const [moodPuente, setMoodPuente] = useState<SoleteMood | null>(null);
  const reducir = useReducedMotion();

  const porTemaRef = useRef(porTema);
  const aciertosRef = useRef(aciertos);
  const respondidasRef = useRef(respondidas);
  const rachaActualRef = useRef(0);
  const mejorRachaSesionRef = useRef(0);
  porTemaRef.current = porTema;
  aciertosRef.current = aciertos;
  respondidasRef.current = respondidas;

  const preguntaActual = cola[indice] ?? null;
  const revelada = fase === "revelando" || fase === "feedback";
  const pos = esMision ? posicionEnEtapa(indice, plan) : null;

  const moodSolete: SoleteMood =
    moodPuente ??
    (fase === "pregunta"
      ? "thinking"
      : acertoUltima
        ? "cheer"
        : "nervous");

  function registrarTema(temaId: string, acierto: boolean) {
    setPorTema((prev) => {
      const copia = [...prev];
      const i = copia.findIndex((t) => t.temaId === temaId);
      if (i === -1) {
        copia.push({
          temaId,
          aciertos: acierto ? 1 : 0,
          intentos: 1,
        });
      } else {
        copia[i] = {
          ...copia[i],
          aciertos: copia[i].aciertos + (acierto ? 1 : 0),
          intentos: copia[i].intentos + 1,
        };
      }
      return copia;
    });
  }

  function avanzarAPregunta(nextIndex: number) {
    setIndice(nextIndex);
    setRespuestaElegida(null);
    setNumericValor("");
    setMoodPuente(null);
    const nextPos = posicionEnEtapa(nextIndex, plan);
    if (nextPos?.etapa.isLast && nextPos.preguntaEnEtapa === 1) {
      setFase("inicio_ultima");
    } else {
      setFase("pregunta");
    }
  }

  function evaluar(respuestaUsuario: unknown) {
    if (!preguntaActual || fase !== "pregunta") return;

    const ok = esRespuestaCorrecta(
      preguntaActual.tipo,
      respuestaUsuario,
      preguntaActual.respuesta,
    );

    setMoodPuente(null);
    setRespuestaElegida(respuestaUsuario);
    setAcertoUltima(ok);
    setTextoCorrecto(
      formatearRespuestaCorrecta(preguntaActual.tipo, preguntaActual.respuesta),
    );
    if (ok) {
      setAciertos((a) => a + 1);
      rachaActualRef.current += 1;
      if (rachaActualRef.current > mejorRachaSesionRef.current) {
        mejorRachaSesionRef.current = rachaActualRef.current;
      }
    } else {
      rachaActualRef.current = 0;
    }
    setRespondidas((r) => r + 1);
    registrarTema(preguntaActual.tema_id, ok);
    setFase("revelando");
    setNumericValor(
      preguntaActual.tipo === "numeric" ? String(respuestaUsuario ?? "") : "",
    );
  }

  function siguiente() {
    setMoodPuente("happy");
    if (esMision) {
      const siguienteIndice = indice + 1;
      if (siguienteIndice >= cola.length) {
        setMoodPuente(null);
        cerrarPartida();
        return;
      }
      if (debeMostrarPuenteTras(indice, plan)) {
        const posActual = posicionEnEtapa(indice, plan);
        if (posActual) {
          setPuente({
            etapaCompletada: posActual.etapa,
            nextIndex: siguienteIndice,
          });
          setFase("puente_etapa");
          return;
        }
      }
      avanzarAPregunta(siguienteIndice);
      return;
    }

    const siguienteIndice = indice + 1;
    if (siguienteIndice >= cola.length) {
      setCola(shuffle(preguntasIniciales));
      setIndice(0);
    } else {
      setIndice(siguienteIndice);
    }
    setRespuestaElegida(null);
    setNumericValor("");
    setFase("pregunta");
  }

  function cerrarPartida(
    forzarPorTema?: ContadorTema[],
    forzarAciertos?: number,
    forzarTotal?: number,
  ) {
    const temas = forzarPorTema ?? porTemaRef.current;
    const ac = forzarAciertos ?? aciertosRef.current;
    const tot = forzarTotal ?? respondidasRef.current;

    const aciertosCalc = temas.reduce((s, t) => s + t.aciertos, 0);
    const totalCalc = temas.reduce((s, t) => s + t.intentos, 0);
    const aciertosFinal = Math.max(ac, aciertosCalc);
    const totalFinal = Math.max(tot, totalCalc);

    const preguntasUsadas =
      esMision
        ? preguntasIniciales.slice(0, totalFinal)
        : preguntasIniciales;

    const temaId =
      temaPredominante(
        temas.length
          ? temas.flatMap((t) =>
              Array.from({ length: t.intentos }, () => ({ tema_id: t.temaId })),
            )
          : preguntasUsadas,
      ) || preguntasIniciales[0]?.tema_id;

    if (!temaId || totalFinal === 0) {
      setFase("resultados");
      setResultado({
        puntos: 0,
        diamantesGanados: 0,
        diamantesTotales: null,
        estrellas: 0,
        aciertos: 0,
        total: 0,
        rachaDias: null,
        rachaSumoHoy: false,
        misionCorta,
        medallasNuevas: [],
        legendariosNuevos: [],
      });
      return;
    }

    startTransition(async () => {
      const res = await finalizarPartida({
        ninoId,
        modo,
        temaPredominanteId: temaId,
        aciertos: aciertosFinal,
        total: totalFinal,
        misionCorta,
        porTema: temas,
        misionDiariaId,
        nivelPractica: modo === "libre" ? nivelPractica : undefined,
        rachaCorrectasSesion: mejorRachaSesionRef.current,
      });

      if (!res.ok || !res.resultado) {
        setErrorGuardado(res.ok === false ? res.error : "Error al guardar");
        setFase("resultados");
        return;
      }

      setResultado(res.resultado);
      setFase("resultados");
    });
  }

  function terminarLibre() {
    cerrarPartida();
  }

  useEffect(() => {
    if (fase !== "pregunta" || !moodPuente) return;
    const t = window.setTimeout(() => setMoodPuente(null), reducir ? 0 : 280);
    return () => window.clearTimeout(t);
  }, [fase, moodPuente, reducir]);

  useEffect(() => {
    if (fase !== "revelando") return;
    const t = window.setTimeout(() => setFase("feedback"), MS_REVELAR);
    return () => window.clearTimeout(t);
  }, [fase]);

  useEffect(() => {
    if (fase !== "feedback") return;
    const ms = acertoUltima ? MS_FEEDBACK_ACIERTO : MS_FEEDBACK_FALLO;
    const t = window.setTimeout(() => siguiente(), ms);
    return () => window.clearTimeout(t);
    // eslint-disable-next-line react-hooks/exhaustive-deps -- avance intencional al entrar en feedback
  }, [fase, acertoUltima]);

  useEffect(() => {
    if (fase !== "puente_etapa" || !puente) return;
    const ms = reducir ? 200 : MISSION_STAGES.timings.stageBridgeMs;
    const t = window.setTimeout(() => {
      const next = puente.nextIndex;
      setPuente(null);
      avanzarAPregunta(next);
    }, ms);
    return () => window.clearTimeout(t);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [fase, puente, reducir]);

  useEffect(() => {
    if (fase !== "inicio_ultima") return;
    const ms = reducir ? 200 : MISSION_STAGES.timings.lastStageIntroMs;
    const t = window.setTimeout(() => setFase("pregunta"), ms);
    return () => window.clearTimeout(t);
  }, [fase, reducir]);

  if (fase === "resultados") {
    const r = resultado;
    return (
      <ResultadosPartida
        modo={modo}
        ninoNombre={ninoNombre}
        asignaturaNombre={asignaturaNombre}
        asignaturaId={asignaturaId}
        estrellas={r?.estrellas ?? 0}
        puntos={r?.puntos ?? 0}
        diamantesGanados={r?.diamantesGanados ?? 0}
        aciertos={r?.aciertos ?? aciertos}
        total={r?.total ?? respondidas}
        misionCorta={misionCorta}
        rachaDias={r?.rachaDias ?? null}
        rachaSumoHoy={r?.rachaSumoHoy ?? false}
        medallasNuevas={r?.medallasNuevas ?? []}
        legendariosNuevos={r?.legendariosNuevos ?? []}
        etapasTotales={plan.length}
        errorGuardado={errorGuardado}
        hrefOtraVez={hrefOtraVez}
        hrefCambiar={hrefCambiar}
      />
    );
  }

  if (fase === "intro" && esMision) {
    return (
      <MisionIntro
        title={MISSION_STAGES.intro.title}
        body={cuerpoIntroDinamico(plan)}
        cta={MISSION_STAGES.intro.cta}
        mood={MISSION_STAGES.intro.mood}
        onEmpezar={() => setFase("pregunta")}
      />
    );
  }

  if (fase === "puente_etapa" && puente) {
    const e = puente.etapaCompletada.def;
    return (
      <MisionPuenteEtapa
        emoji={e.emoji}
        title={e.completeTitle}
        body={e.completeBody}
        mood={e.completeMood}
        accentColor={e.color}
      />
    );
  }

  if (fase === "inicio_ultima") {
    const ultima = plan[plan.length - 1]?.def;
    return (
      <MisionPuenteEtapa
        emoji={ultima?.emoji ?? "🏆"}
        title={MISSION_STAGES.lastStage.title}
        body={MISSION_STAGES.lastStage.body}
        mood={MISSION_STAGES.lastStage.mood}
        accentColor={ultima?.color ?? "#D85A30"}
      />
    );
  }

  if (!preguntaActual) {
    return (
      <main className="fondo-halo-sol mx-auto flex min-h-dvh w-full max-w-md flex-col justify-center px-5 text-center safe-pb">
        <Solete mood="happy" size="lg" alt="" />
        <p className="mt-4 font-titulo text-2xl text-primary">No hay más preguntas</p>
        <div className="mx-auto mt-6 w-full max-w-xs">
          <Boton type="button" variant="secundario" onClick={() => cerrarPartida()}>
            Ver resultados
          </Boton>
        </div>
      </main>
    );
  }

  return (
    <main
      className="fondo-halo-sol relative mx-auto flex min-h-dvh w-full max-w-md flex-col px-5 pb-8 pt-5 safe-pt safe-pb"
      style={
        pos
          ? {
              backgroundImage: `radial-gradient(ellipse 90% 55% at 50% -10%, ${pos.etapa.def.colorSoft}, transparent 70%)`,
            }
          : undefined
      }
    >
      <div className="flex items-start gap-3">
        <div className="min-w-0 flex-1">
          {esMision && pos ? (
            <ProgresoMisionEtapas
              plan={plan}
              etapaIndex={pos.etapa.index}
              preguntaEnEtapa={pos.preguntaEnEtapa}
              preguntasEnEtapa={pos.etapa.size}
            />
          ) : (
            <div className="flex items-center justify-between gap-3">
              <p className="font-titulo text-base font-semibold text-primary">
                {respondidas}{" "}
                {respondidas === 1 ? "pregunta" : "preguntas"}
              </p>
              <button
                type="button"
                onClick={terminarLibre}
                disabled={pending || respondidas === 0 || revelada}
                className="inline-flex min-h-11 items-center justify-center rounded-2xl bg-surface px-4 font-titulo text-sm font-semibold text-primary shadow-card transition active:scale-[0.98] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus disabled:opacity-40"
              >
                Terminar
              </button>
            </div>
          )}
        </div>
        <div className="flex shrink-0 flex-col items-end gap-2">
          <Solete mood={moodSolete} size="sm" className="mt-0.5" alt="" />
          {esMision ? (
            <motion.div
              className="inline-flex min-h-9 items-center gap-1 rounded-full bg-surface px-2.5 py-1 font-titulo text-sm font-semibold text-primary shadow-card"
              aria-label={`${aciertos} aciertos`}
              key={aciertos}
              initial={reducir ? false : { scale: 0.92 }}
              animate={{ scale: 1 }}
              transition={{ type: "spring", stiffness: 400, damping: 18 }}
            >
              <Star className="h-4 w-4 fill-limon stroke-sol" aria-hidden />
              <AnimatePresence mode="popLayout" initial={false}>
                <motion.span
                  key={aciertos}
                  initial={reducir ? false : { y: 8, opacity: 0 }}
                  animate={{ y: 0, opacity: 1 }}
                  exit={reducir ? undefined : { y: -8, opacity: 0 }}
                  transition={{ duration: reducir ? 0 : 0.18 }}
                >
                  {aciertos}
                </motion.span>
              </AnimatePresence>
            </motion.div>
          ) : null}
        </div>
      </div>

      <div className="relative mt-5 flex min-h-[24rem] flex-1 flex-col sm:min-h-[28rem]">
        <AnimatePresence initial={false} mode="sync">
          <motion.div
            key={preguntaActual.id + String(indice)}
            initial={
              reducir ? false : { opacity: 0, x: 18 }
            }
            animate={{ opacity: 1, x: 0 }}
            exit={
              reducir
                ? undefined
                : { opacity: 0, x: -14 }
            }
            transition={
              reducir ? { duration: 0 } : TRANSICION_PREGUNTA
            }
            className="absolute inset-0 flex flex-col"
          >
            <h1 className="shrink-0 font-titulo text-[1.7rem] font-semibold leading-[1.28] text-primary sm:text-[1.85rem] sm:leading-snug">
              {preguntaActual.enunciado}
            </h1>

            <div
              className={cn(
                "mt-6 flex-1 overflow-y-auto pb-28",
                fase === "feedback" && "pointer-events-none",
              )}
            >
              {preguntaActual.tipo === "numeric" ? (
                <TecladoNumerico
                  valor={numericValor}
                  onChange={setNumericValor}
                  onConfirmar={() => {
                    if (!numericValor.trim()) return;
                    evaluar(numericValor);
                  }}
                  disabled={revelada}
                  revelada={revelada}
                  acerto={revelada ? acertoUltima : null}
                />
              ) : null}
              {preguntaActual.tipo === "true_false" ? (
                <PreguntaTrueFalse
                  onElegir={(v) => evaluar(v)}
                  disabled={revelada}
                  revelada={revelada}
                  elegida={
                    typeof respuestaElegida === "boolean"
                      ? respuestaElegida
                      : null
                  }
                  correcta={
                    typeof preguntaActual.respuesta === "boolean"
                      ? preguntaActual.respuesta
                      : preguntaActual.respuesta === "true" ||
                          preguntaActual.respuesta === true
                        ? true
                        : preguntaActual.respuesta === "false" ||
                            preguntaActual.respuesta === false
                          ? false
                          : null
                  }
                />
              ) : null}
              {preguntaActual.tipo === "multiple_choice" ? (
                <PreguntaMultiple
                  opciones={preguntaActual.opciones ?? []}
                  onElegir={(v) => evaluar(v)}
                  disabled={revelada}
                  revelada={revelada}
                  elegida={
                    typeof respuestaElegida === "string"
                      ? respuestaElegida
                      : null
                  }
                  correcta={
                    typeof preguntaActual.respuesta === "string"
                      ? preguntaActual.respuesta
                      : String(preguntaActual.respuesta ?? "")
                  }
                />
              ) : null}
            </div>
          </motion.div>
        </AnimatePresence>

        <AnimatePresence>
          {fase === "feedback" ? (
            <FeedbackCapa
              acierto={acertoUltima}
              textoCorrecto={textoCorrecto}
            />
          ) : null}
        </AnimatePresence>
      </div>
    </main>
  );
}
