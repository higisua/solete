"use client";

import Link from "next/link";
import { useState, useTransition } from "react";
import {
  finalizarPartida,
  type ResultadoGuardado,
} from "@/app/actions/partida";
import { PreguntaMultiple } from "@/components/juego/PreguntaMultiple";
import { PreguntaTrueFalse } from "@/components/juego/PreguntaTrueFalse";
import { TecladoNumerico } from "@/components/juego/TecladoNumerico";
import {
  esRespuestaCorrecta,
  formatearRespuestaCorrecta,
  mensajeAnimo,
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
};

type Fase = "pregunta" | "feedback" | "resultados";

type ContadorTema = { temaId: string; aciertos: number; intentos: number };

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
}: Props) {
  const [cola, setCola] = useState<Pregunta[]>(preguntasIniciales);
  const [indice, setIndice] = useState(0);
  const [aciertos, setAciertos] = useState(0);
  const [respondidas, setRespondidas] = useState(0);
  const [porTema, setPorTema] = useState<ContadorTema[]>([]);
  const [fase, setFase] = useState<Fase>("pregunta");
  const [acertoUltima, setAcertoUltima] = useState(false);
  const [textoCorrecto, setTextoCorrecto] = useState("");
  const [numericValor, setNumericValor] = useState("");
  const [resultado, setResultado] = useState<ResultadoGuardado | null>(null);
  const [errorGuardado, setErrorGuardado] = useState<string | null>(null);
  const [pending, startTransition] = useTransition();

  const totalMision = preguntasIniciales.length;
  const preguntaActual = cola[indice] ?? null;

  const barraTexto =
    modo === "mision"
      ? `Pregunta ${Math.min(respondidas + (fase === "resultados" ? 0 : 1), totalMision)} / ${totalMision}`
      : `${respondidas} ${respondidas === 1 ? "pregunta" : "preguntas"}`;

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

    setAcertoUltima(ok);
    setTextoCorrecto(
      formatearRespuestaCorrecta(preguntaActual.tipo, preguntaActual.respuesta),
    );
    if (ok) setAciertos((a) => a + 1);
    setRespondidas((r) => r + 1);
    registrarTema(preguntaActual.tema_id, ok);
    setFase("feedback");
    setNumericValor("");
  }

  function siguiente() {
    if (modo === "mision") {
      const siguienteIndice = indice + 1;
      if (siguienteIndice >= cola.length) {
        cerrarPartida();
        return;
      }
      setIndice(siguienteIndice);
      setFase("pregunta");
      return;
    }

    // Libre: avanzar; si se acaba el pool, rebarajar (pueden repetirse respecto a antes)
    const siguienteIndice = indice + 1;
    if (siguienteIndice >= cola.length) {
      setCola(shuffle(preguntasIniciales));
      setIndice(0);
    } else {
      setIndice(siguienteIndice);
    }
    setFase("pregunta");
  }

  function cerrarPartida(forzarPorTema?: ContadorTema[], forzarAciertos?: number, forzarTotal?: number) {
    const temas = forzarPorTema ?? porTema;
    const ac = forzarAciertos ?? aciertos;
    // En feedback acabamos de sumar respondidas; usar el estado puede ir un tick atrasado
    const tot = forzarTotal ?? respondidas;

    // Recalcular desde temas si hace falta sincronía
    const aciertosCalc = temas.reduce((s, t) => s + t.aciertos, 0);
    const totalCalc = temas.reduce((s, t) => s + t.intentos, 0);
    const aciertosFinal = Math.max(ac, aciertosCalc);
    const totalFinal = Math.max(tot, totalCalc);

    const preguntasUsadas =
      modo === "mision"
        ? preguntasIniciales.slice(0, totalFinal)
        : // en libre usamos las del pool inicial para predominante aproximado
          preguntasIniciales;

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
        estrellas: 0,
        aciertos: 0,
        total: 0,
        rachaDias: null,
        rachaSumoHoy: false,
        misionCorta,
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
    // Si estamos en feedback, incluir esa respuesta ya contabilizada
    cerrarPartida();
  }

  // --- Resultados ---
  if (fase === "resultados") {
    const r = resultado;
    const estrellas = r?.estrellas ?? 0;
    const pts = r?.puntos ?? 0;
    const ac = r?.aciertos ?? aciertos;
    const tot = r?.total ?? respondidas;

    return (
      <main className="mx-auto flex min-h-dvh w-full max-w-md flex-col justify-center px-5 py-10 text-center">
        <h1 className="font-titulo text-3xl font-semibold text-sol">
          {modo === "mision" ? "¡Misión terminada!" : "¡Descanso!"}
        </h1>
        <p className="mt-2 text-lg text-black/65">
          {ninoNombre} · {asignaturaNombre}
        </p>

        {modo === "mision" ? (
          <div className="mt-6 flex justify-center gap-2 text-4xl" aria-label={`${estrellas} estrellas`}>
            {[1, 2, 3].map((n) => (
              <span key={n} className={n <= estrellas ? "opacity-100" : "opacity-25"}>
                ⭐
              </span>
            ))}
          </div>
        ) : null}

        <p className="mt-4 font-titulo text-2xl text-mar">+{pts} puntos</p>
        <p className="mt-1 text-lg text-black/70">
          {ac} de {tot} aciertos
        </p>
        {misionCorta && modo === "mision" ? (
          <p className="mt-2 text-sm text-black/50">
            Había menos de 10 preguntas; misión más cortita.
          </p>
        ) : null}
        <p className="mt-4 font-titulo text-xl text-sol">
          {mensajeAnimo(modo, estrellas, ac, tot)}
        </p>
        {r?.rachaSumoHoy && r.rachaDias != null ? (
          <p className="mt-2 text-base text-mar">
            🔥 Racha: {r.rachaDias} {r.rachaDias === 1 ? "día" : "días"}
          </p>
        ) : null}
        {errorGuardado ? (
          <p className="mt-3 text-sm text-fallo">{errorGuardado}</p>
        ) : null}

        <div className="mt-8 flex flex-col gap-3">
          <Link
            href={`/jugar/${asignaturaId}/${modo}`}
            className="inline-flex min-h-12 items-center justify-center rounded-2xl bg-sol px-5 font-titulo text-lg font-semibold text-white"
          >
            Jugar otra vez
          </Link>
          <Link
            href="/mundo"
            className="inline-flex min-h-12 items-center justify-center rounded-2xl bg-mar px-5 font-titulo text-lg font-semibold text-white"
          >
            Cambiar asignatura
          </Link>
          <Link
            href="/entrada"
            className="inline-flex min-h-12 items-center justify-center rounded-2xl border-2 border-sol bg-white px-5 font-titulo text-lg font-semibold text-sol"
          >
            Inicio
          </Link>
        </div>
      </main>
    );
  }

  if (!preguntaActual) {
    return (
      <main className="mx-auto flex min-h-dvh w-full max-w-md flex-col justify-center px-5 text-center">
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

  return (
    <main className="mx-auto flex min-h-dvh w-full max-w-md flex-col px-5 py-6">
      <div className="flex items-center justify-between gap-3">
        <p className="font-titulo text-base text-sol">{barraTexto}</p>
        {modo === "libre" ? (
          <button
            type="button"
            onClick={terminarLibre}
            disabled={pending || respondidas === 0}
            className="min-h-11 rounded-2xl bg-white px-3 font-titulo text-sm font-semibold text-sol shadow-sm disabled:opacity-40"
          >
            Terminar
          </button>
        ) : null}
      </div>

      {modo === "mision" ? (
        <div className="mt-2 h-3 w-full overflow-hidden rounded-full bg-white">
          <div
            className="h-full rounded-full bg-mar transition-all"
            style={{ width: `${(respondidas / Math.max(totalMision, 1)) * 100}%` }}
          />
        </div>
      ) : null}

      {fase === "feedback" ? (
        <div
          className={`mt-8 flex flex-1 flex-col items-center justify-center rounded-3xl px-4 py-10 text-center ${
            acertoUltima ? "bg-acierto/20" : "bg-fallo/25"
          }`}
        >
          <p className="font-titulo text-3xl font-semibold text-sol">
            {acertoUltima ? "¡Muy bien!" : "¡Casi!"}
          </p>
          {!acertoUltima ? (
            <p className="mt-3 text-lg text-black/70">
              La respuesta era: <strong>{textoCorrecto}</strong>
            </p>
          ) : (
            <p className="mt-3 text-lg text-black/70">+10 puntos</p>
          )}
          <button
            type="button"
            onClick={siguiente}
            className="mt-8 min-h-14 w-full max-w-xs rounded-2xl bg-sol font-titulo text-xl font-semibold text-white"
          >
            {modo === "mision" && indice + 1 >= cola.length ? "Ver resultados" : "Siguiente"}
          </button>
        </div>
      ) : (
        <div className="mt-8 flex flex-1 flex-col">
          <h1 className="font-titulo text-2xl font-semibold leading-snug text-sol sm:text-3xl">
            {preguntaActual.enunciado}
          </h1>

          <div className="mt-8">
            {preguntaActual.tipo === "numeric" ? (
              <TecladoNumerico
                valor={numericValor}
                onChange={setNumericValor}
                onConfirmar={() => {
                  if (!numericValor.trim()) return;
                  evaluar(numericValor);
                }}
              />
            ) : null}
            {preguntaActual.tipo === "true_false" ? (
              <PreguntaTrueFalse onElegir={(v) => evaluar(v)} />
            ) : null}
            {preguntaActual.tipo === "multiple_choice" ? (
              <PreguntaMultiple
                opciones={preguntaActual.opciones ?? []}
                onElegir={(v) => evaluar(v)}
              />
            ) : null}
          </div>
        </div>
      )}
    </main>
  );
}
