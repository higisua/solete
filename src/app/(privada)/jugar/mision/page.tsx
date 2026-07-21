import Link from "next/link";
import { redirect } from "next/navigation";
import { MotorPreguntas } from "@/components/juego/MotorPreguntas";
import { getNinoActivoValidado } from "@/lib/juego";
import { obtenerMisionDiariaDeHoy } from "@/lib/juego/mision-diaria";

/** Misión diaria única (20 preguntas entre asignaturas, Europe/Madrid). */
export default async function MisionDiariaPage() {
  const nino = await getNinoActivoValidado();
  if (!nino) {
    redirect("/entrada");
  }

  const estado = await obtenerMisionDiariaDeHoy(nino.id, nino.curso);

  if (estado.estado === "completada") {
    return (
      <main className="mx-auto flex min-h-dvh w-full max-w-md flex-col justify-center px-5 py-10 text-center">
        <h1 className="font-titulo text-3xl font-semibold text-sol">
          ¡Misión de hoy hecha!
        </h1>
        <p className="mt-3 text-lg text-black/65">
          {nino.nombre} ya completó la misión de hoy (
          {estado.mision.aciertos}/{estado.mision.total}, {estado.mision.estrellas}{" "}
          ★). Vuelve mañana para una nueva.
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

  if (estado.estado === "sin_preguntas") {
    return (
      <main className="mx-auto flex min-h-dvh w-full max-w-md flex-col justify-center px-5 py-10 text-center">
        <h1 className="font-titulo text-3xl font-semibold text-sol">
          Aún no hay preguntas
        </h1>
        <p className="mt-3 text-lg text-black/65">
          No hay preguntas activas para la misión de {nino.nombre}. Pide a un
          adulto que active temas.
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
      asignaturaId=""
      asignaturaNombre="Misión del día"
      modo="mision"
      preguntasIniciales={estado.preguntas}
      misionCorta={estado.misionCorta}
      misionDiariaId={estado.mision.id || null}
      hrefOtraVez="/mundo"
      hrefCambiar="/mundo"
    />
  );
}
