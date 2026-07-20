import Link from "next/link";
import { redirect } from "next/navigation";
import {
  getAsignaturasPorCurso,
  getNinoActivoValidado,
} from "@/lib/juego";

type Props = {
  params: Promise<{ asignaturaId: string }>;
};

export default async function ElegirModoPage({ params }: Props) {
  const { asignaturaId } = await params;
  const nino = await getNinoActivoValidado();

  if (!nino) {
    redirect("/entrada");
  }

  const asignaturas = await getAsignaturasPorCurso(nino.curso);
  const asignatura = asignaturas.find((a) => a.id === asignaturaId);

  if (!asignatura) {
    return (
      <main className="mx-auto flex min-h-dvh max-w-md flex-col justify-center px-5 text-center">
        <h1 className="font-titulo text-2xl text-sol">Asignatura no disponible</h1>
        <Link href="/mundo" className="mt-6 font-titulo text-mar underline">
          Volver
        </Link>
      </main>
    );
  }

  return (
    <main className="mx-auto flex min-h-dvh w-full max-w-md flex-col px-5 py-8">
      <p className="text-center text-base text-black/55">{nino.nombre}</p>
      <h1 className="mt-1 text-center font-titulo text-3xl font-semibold text-sol">
        {asignatura.nombre}
      </h1>
      <p className="mt-2 text-center text-lg text-black/65">¿Cómo quieres jugar?</p>

      <div className="mt-10 flex flex-col gap-4">
        <Link
          href={`/jugar/${asignaturaId}/mision`}
          className="flex min-h-[100px] flex-col items-start justify-center rounded-3xl bg-sol px-5 py-4 text-left text-white shadow-sm transition active:scale-[0.98]"
        >
          <span className="text-3xl" aria-hidden>
            🎯
          </span>
          <span className="mt-1 font-titulo text-2xl font-semibold">Misión del día</span>
          <span className="mt-1 text-sm text-white/90">
            10 preguntas. ¡Gana estrellas y suma a tu racha!
          </span>
        </Link>

        <Link
          href={`/jugar/${asignaturaId}/libre`}
          className="flex min-h-[100px] flex-col items-start justify-center rounded-3xl bg-mar px-5 py-4 text-left text-white shadow-sm transition active:scale-[0.98]"
        >
          <span className="text-3xl" aria-hidden>
            🎮
          </span>
          <span className="mt-1 font-titulo text-2xl font-semibold">Juego libre</span>
          <span className="mt-1 text-sm text-white/90">
            Juega sin límite. Suma puntos y para cuando quieras.
          </span>
        </Link>
      </div>

      <Link
        href="/mundo"
        className="mt-8 inline-flex min-h-12 items-center justify-center rounded-2xl border-2 border-sol bg-white font-titulo text-lg font-semibold text-sol"
      >
        Volver
      </Link>
    </main>
  );
}
