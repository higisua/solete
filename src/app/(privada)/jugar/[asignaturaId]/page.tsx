import Link from "next/link";
import { redirect } from "next/navigation";
import {
  getAsignaturasPorCurso,
  getNinoActivoValidado,
  getTemasActivosDeAsignatura,
} from "@/lib/juego";
import { MISION_OBJETIVO } from "@/lib/juego/reglas";

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

  const temas = await getTemasActivosDeAsignatura(nino.id, asignaturaId);

  return (
    <main className="mx-auto flex min-h-dvh w-full max-w-md flex-col px-5 py-8">
      <p className="text-center text-base text-black/55">{nino.nombre}</p>
      <h1 className="mt-1 text-center font-titulo text-3xl font-semibold text-sol">
        {asignatura.nombre}
      </h1>
      <p className="mt-2 text-center text-lg text-black/65">¿Cómo quieres jugar?</p>

      <div className="mt-10 flex flex-col gap-4">
        <Link
          href="/jugar/mision"
          className="flex min-h-[100px] flex-col items-start justify-center rounded-3xl bg-sol px-5 py-4 text-left text-white shadow-sm transition active:scale-[0.98]"
        >
          <span className="text-3xl" aria-hidden>
            🎯
          </span>
          <span className="mt-1 font-titulo text-2xl font-semibold">Misión del día</span>
          <span className="mt-1 text-sm text-white/90">
            {MISION_OBJETIVO} preguntas de todas las asignaturas. Una al día.
          </span>
        </Link>

        <Link
          href={`/jugar/${asignaturaId}/libre`}
          className="flex min-h-[100px] flex-col items-start justify-center rounded-3xl bg-mar px-5 py-4 text-left text-white shadow-sm transition active:scale-[0.98]"
        >
          <span className="text-3xl" aria-hidden>
            🎮
          </span>
          <span className="mt-1 font-titulo text-2xl font-semibold">Práctica</span>
          <span className="mt-1 text-sm text-white/90">
            Sin límite en {asignatura.nombre}. Sin diamantes ni estrellas.
          </span>
        </Link>
      </div>

      {temas.length > 0 ? (
        <div className="mt-8">
          <h2 className="font-titulo text-xl font-semibold text-sol">
            Practicar un tema
          </h2>
          <ul className="mt-3 flex flex-col gap-2">
            {temas.map((tema) => (
              <li key={tema.id}>
                <Link
                  href={`/jugar/${asignaturaId}/libre?tema=${tema.id}`}
                  className="flex min-h-12 items-center rounded-2xl bg-white px-4 font-titulo text-lg text-sol shadow-sm"
                >
                  {tema.nombre}
                </Link>
              </li>
            ))}
          </ul>
        </div>
      ) : null}

      <Link
        href="/mundo"
        className="mt-8 inline-flex min-h-12 items-center justify-center rounded-2xl border-2 border-sol bg-white font-titulo text-lg font-semibold text-sol"
      >
        Volver
      </Link>
    </main>
  );
}
