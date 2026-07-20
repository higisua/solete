import Link from "next/link";
import { redirect, notFound } from "next/navigation";
import { MotorPreguntas } from "@/components/juego/MotorPreguntas";
import {
  getAsignaturasPorCurso,
  getNinoActivoValidado,
} from "@/lib/juego";
import { getPreguntasParaPartida } from "@/lib/juego/preguntas";
import type { ModoJuego } from "@/types/database";

type Props = {
  params: Promise<{ asignaturaId: string; modo: string }>;
};

export default async function PartidaPage({ params }: Props) {
  const { asignaturaId, modo: modoRaw } = await params;

  if (modoRaw !== "mision" && modoRaw !== "libre") {
    notFound();
  }
  const modo = modoRaw as ModoJuego;

  const nino = await getNinoActivoValidado();
  if (!nino) {
    redirect("/entrada");
  }

  const asignaturas = await getAsignaturasPorCurso(nino.curso);
  const asignatura = asignaturas.find((a) => a.id === asignaturaId);
  if (!asignatura) {
    redirect("/mundo");
  }

  const { preguntas, misionCorta } = await getPreguntasParaPartida(
    nino.id,
    asignaturaId,
    modo,
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
          En {asignatura.nombre} no hay preguntas activas para {nino.nombre}.
          Prueba otra asignatura o pide a un adulto que active temas.
        </p>
        <Link
          href="/mundo"
          className="mt-8 inline-flex min-h-12 items-center justify-center rounded-2xl bg-mar px-5 font-titulo text-lg font-semibold text-white"
        >
          Volver al mundo
        </Link>
      </main>
    );
  }

  return (
    <MotorPreguntas
      ninoId={nino.id}
      ninoNombre={nino.nombre}
      asignaturaId={asignatura.id}
      asignaturaNombre={asignatura.nombre}
      modo={modo}
      preguntasIniciales={preguntas}
      misionCorta={misionCorta}
    />
  );
}
