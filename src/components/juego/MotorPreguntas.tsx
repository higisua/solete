"use client";

import { Star } from "lucide-react";
import { AnimatePresence, motion } from "framer-motion";
import { useEffect, useRef, useState, useTransition } from "react";
import {
  finalizarPartida,
  type ResultadoGuardado,
} from "@/app/actions/partida";
import { FeedbackCapa } from "@/components/juego/FeedbackCapa";
import { PreguntaMultiple } from "@/components/juego/PreguntaMultiple";
import { PreguntaTrueFalse } from "@/components/juego/PreguntaTrueFalse";
import { ResultadosPartida } from "@/components/juego/ResultadosPartida";
import { TecladoNumerico } from "@/components/juego/TecladoNumerico";
import {
  esRespuestaCorrecta,
  formatearRespuestaCorrecta,
  temaPredominante,
} from "@/lib/juego/reglas";
import type { ModoJuego, Pregunta } from "@/types/database";

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
};

type Fase = "pregunta" | "revelando" | "feedback" | "resultados";

type ContadorTema = { temaId: string; aciertos: number; intentos: number };

const MS_REVELAR = 500;
const MS_FEEDBACK_ACIERTO = 900;
const MS_FEEDBACK_FALLO = 1400;

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
}: Props) {
  const [cola, setCola] = useState<Pregunta[]>(preguntasIniciales);
  const [indice, setIndice] = useState(0);
  const [aciertos, setAciertos] = useState(0);
  const [respondidas, setRespondidas] = useState(0);
  const [porTema, setPorTema] = useState<ContadorTema[]>([]);
  const [fase, setFase] = useState<Fase>("pregunta");
  const [acertoUltima, setAcertoUltima] = useState(false);
  const [textoCorrecto, setTextoCorrecto] = useState("");
  const [respuestaElegida, setRespuestaElegida] = useState<unknown>(null);
  const [numericValor, setNumericValor] = useState("");
  const [resultado, setResultado] = useState<ResultadoGuardado | null>(null);
  const [errorGuardado, setErrorGuardado] = useState<string | null>(null);
  const [pending, startTransition] = useTransition();

  const porTemaRef = useRef(porTema);
  const aciertosRef = useRef(aciertos);
  const respondidasRef = useRef(respondidas);
  porTemaRef.current = porTema;
  aciertosRef.current = aciertos;
  respondidasRef.current = respondidas;

  const totalMision = preguntasIniciales.length;
  const preguntaActual = cola[indice] ?? null;
  const revelada = fase === "revelando" || fase === "feedback";
  const numeroActual = Math.min(indice + 1, Math.max(totalMision, 1));

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

  function evaluar(respuestaUsuario: unknown) {
    if (!preguntaActual || fase !== "pregunta") return;

    const ok = esRespuestaCorrecta(
      preguntaActual.tipo,
      respuestaUsuario,
      preguntaActual.respuesta,
    );

    setRespuestaElegida(respuestaUsuario);
    setAcertoUltima(ok);
    setTextoCorrecto(
      formatearRespuestaCorrecta(preguntaActual.tipo, preguntaActual.respuesta),
    );
    if (ok) setAciertos((a) => a + 1);
    setRespondidas((r) => r + 1);
    registrarTema(preguntaActual.tema_id, ok);
    setFase("revelando");
    setNumericValor(
      preguntaActual.tipo === "numeric" ? String(respuestaUsuario ?? "") : "",
    );
  }

  function siguiente() {
    if (modo === "mision") {
      const siguienteIndice = indice + 1;
      if (siguienteIndice >= cola.length) {
        cerrarPartida();
        return;
      }
      setIndice(siguienteIndice);
      setRespuestaElegida(null);
      setNumericValor("");
      setFase("pregunta");
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
      modo === "mision"
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

  // Revelar opciones → feedback
  useEffect(() => {
    if (fase !== "revelando") return;
    const t = window.setTimeout(() => setFase("feedback"), MS_REVELAR);
    return () => window.clearTimeout(t);
  }, [fase]);

  // Feedback → auto-avance (sin botón Siguiente)
  useEffect(() => {
    if (fase !== "feedback") return;
    const ms = acertoUltima ? MS_FEEDBACK_ACIERTO : MS_FEEDBACK_FALLO;
    const t = window.setTimeout(() => siguiente(), ms);
    return () => window.clearTimeout(t);
    // eslint-disable-next-line react-hooks/exhaustive-deps -- avance intencional al entrar en feedback
  }, [fase, acertoUltima]);

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
        errorGuardado={errorGuardado}
        hrefOtraVez={hrefOtraVez}
        hrefCambiar={hrefCambiar}
      />
    );
  }

  if (!preguntaActual) {
    return (
      <main className="fondo-halo-sol mx-auto flex min-h-dvh w-full max-w-md flex-col justify-center px-5 text-center">
        <p className="font-titulo text-2xl text-sol">No hay más preguntas</p>
        <button
          type="button"
          onClick={() => cerrarPartida()}
          className="mt-6 min-h-12 rounded-2xl bg-mar px-5 font-titulo text-lg text-white"
        >
          Ver resultados
        </button>
      </main>
    );
  }

  const progresoPct =
    modo === "mision"
      ? (respondidas / Math.max(totalMision, 1)) * 100
      : 0;

  return (
    <main className="fondo-halo-sol relative mx-auto flex min-h-dvh w-full max-w-md flex-col px-5 pb-8 pt-5">
      {/* Cabecera */}
      <div className="flex items-center gap-3">
        <div className="min-w-0 flex-1">
          {modo === "mision" ? (
            <>
              <div className="mb-1.5 flex items-center justify-between gap-2">
                <p className="font-titulo text-base font-semibold text-sol">
                  {numeroActual} / {totalMision}
                </p>
                <div
                  className="inline-flex items-center gap-1 rounded-full bg-white/90 px-2.5 py-1 font-titulo text-sm font-semibold text-sol shadow-sm"
                  aria-label={`${aciertos} aciertos`}
                >
                  <Star
                    className="h-4 w-4 fill-limon stroke-sol"
                    aria-hidden
                  />
                  {aciertos}
                </div>
              </div>
              <div className="h-3.5 w-full overflow-hidden rounded-full bg-white shadow-inner">
                <motion.div
                  className="h-full rounded-full bg-mar"
                  initial={false}
                  animate={{ width: `${progresoPct}%` }}
                  transition={{ type: "spring", stiffness: 120, damping: 20 }}
                />
              </div>
            </>
          ) : (
            <div className="flex items-center justify-between gap-3">
              <p className="font-titulo text-base font-semibold text-sol">
                {respondidas}{" "}
                {respondidas === 1 ? "pregunta" : "preguntas"}
              </p>
              <button
                type="button"
                onClick={terminarLibre}
                disabled={pending || respondidas === 0 || revelada}
                className="min-h-11 rounded-2xl bg-white px-3 font-titulo text-sm font-semibold text-sol shadow-sm disabled:opacity-40"
              >
                Terminar
              </button>
            </div>
          )}
        </div>
      </div>

      {/* Pregunta + respuestas */}
      <div className="relative mt-6 flex flex-1 flex-col">
        <AnimatePresence mode="wait">
          <motion.div
            key={preguntaActual.id + String(indice)}
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -8 }}
            transition={{ duration: 0.22 }}
            className="flex flex-1 flex-col"
          >
            <h1 className="font-titulo text-[1.65rem] font-semibold leading-[1.35] text-sol sm:text-3xl sm:leading-snug">
              {preguntaActual.enunciado}
            </h1>

            <div className="mt-8 flex-1">
              {preguntaActual.tipo === "numeric" ? (
                <TecladoNumerico
                  valor={
                    revelada && numericValor
                      ? numericValor
                      : numericValor
                  }
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
