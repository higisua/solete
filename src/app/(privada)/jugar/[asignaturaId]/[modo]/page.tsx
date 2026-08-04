import Link from "next/link";
import { redirect, notFound } from "next/navigation";
import { MotorPreguntas } from "@/components/juego/MotorPreguntas";
import {
  getAsignaturasPorCurso,
  getNinoActivoValidado,
} from "@/lib/juego";
import { esNivelPractica, type NivelPractica } from "@/lib/juego/economia";
import { getPreguntasParaPractica } from "@/lib/juego/preguntas";
import type { ModoJuego } from "@/types/database";

type Props = {
  params: Promise<{ asignaturaId: string; modo: string }>;
  searchParams: Promise<{ tema?: string; nivel?: string }>;
};

export default async function PartidaPage({ params, searchParams }: Props) {
  const { asignaturaId, modo: modoRaw } = await params;
  const { tema: temaId, nivel: nivelRaw } = await searchParams;

  if (modoRaw === "mision") {
    redirect("/jugar/mision");
  }

  if (modoRaw !== "libre") {
    notFound();
  }
  const modo = "libre" as ModoJuego;
  const nivel: NivelPractica = esNivelPractica(nivelRaw) ? nivelRaw : "normal";

  const nino = await getNinoActivoValidado();
  if (!nino) {
    redirect("/entrada");
  }

  const asignaturas = await getAsignaturasPorCurso(nino.curso);
  const asignatura = asignaturas.find((a) => a.id === asignaturaId);
  if (!asignatura) {
    redirect("/mundo");
  }

  const preguntas = await getPreguntasParaPractica(
    nino.id,
    asignaturaId,
    temaId ?? null,
    nivel,
  );

  if (preguntas.length === 0) {
    return (
      <main className="mx-auto flex min-h-dvh w-full max-w-md flex-col justify-center px-5 py-10 text-center">
        <p className="text-5xl" aria-hidden>
          📭
        </p>
        <h1 className="mt-4 font-titulo text-3xl font-semibold text-sol">
          Aún no hay preguntas
        </h1>
        <p className="mt-3 text-lg text-black/65">
          En {asignatura.nombre} no hay preguntas
          {nivel === "extremo" ? " difíciles" : ""} activas para {nino.nombre}.
          Prueba otra asignatura o el modo normal.
        </p>
        <Link
          href={`/practica?nivel=${nivel}`}
          className="mt-8 inline-flex min-h-12 items-center justify-center rounded-2xl bg-mar px-5 font-titulo text-lg font-semibold text-white"
        >
          Volver a práctica
        </Link>
      </main>
    );
  }

  const etiquetaBase = temaId
    ? `${asignatura.nombre} (tema)`
    : asignatura.nombre;
  const etiqueta =
    nivel === "extremo" ? `${etiquetaBase} · Extremo` : etiquetaBase;

  const qs = new URLSearchParams();
  if (temaId) qs.set("tema", temaId);
  qs.set("nivel", nivel);
  const hrefOtraVez = `/jugar/${asignatura.id}/libre?${qs.toString()}`;

  return (
    <MotorPreguntas
      ninoId={nino.id}
      ninoNombre={nino.nombre}
      asignaturaId={asignatura.id}
      asignaturaNombre={etiqueta}
      modo={modo}
      preguntasIniciales={preguntas}
      misionCorta={false}
      nivelPractica={nivel}
      hrefOtraVez={hrefOtraVez}
      hrefCambiar={`/practica?nivel=${nivel}`}
    />
  );
}
