import Link from "next/link";
import { redirect } from "next/navigation";
import {
  getAsignaturasPorCurso,
  getNinoActivoValidado,
  getTemasActivosDeAsignatura,
} from "@/lib/juego";
import { iconoAsignatura } from "@/lib/iconos";
import { Aparecer, Pantalla, Tarjeta } from "@/components/ui";

/** Elige asignatura (y opcionalmente tema) para el modo práctica. */
export default async function PracticaPage() {
  const nino = await getNinoActivoValidado();
  if (!nino) {
    redirect("/entrada");
  }

  const asignaturas = await getAsignaturasPorCurso(nino.curso);

  const conTemas = await Promise.all(
    asignaturas.map(async (asig) => ({
      ...asig,
      temas: await getTemasActivosDeAsignatura(nino.id, asig.id),
    })),
  );

  return (
    <Pantalla className="fondo-halo-sol">
      <Aparecer>
        <p className="text-center font-cuerpo text-sm text-black/45">
          {nino.nombre}
        </p>
        <h1 className="mt-1 text-center font-titulo text-3xl font-semibold text-sol">
          Práctica
        </h1>
        <p className="mt-2 text-center font-cuerpo text-base text-black/50">
          Elige una asignatura o un tema. Sin límite, sin diamantes.
        </p>
      </Aparecer>

      {conTemas.length === 0 ? (
        <Aparecer delay={0.08} className="mt-8">
          <Tarjeta>
            <p className="text-center font-cuerpo text-black/55">
              Aún no hay asignaturas para tu curso.
            </p>
          </Tarjeta>
        </Aparecer>
      ) : (
        <ul className="mt-8 flex flex-col gap-5">
          {conTemas.map((asig, i) => (
            <li key={asig.id}>
              <Aparecer delay={0.06 + i * 0.05}>
                <Link
                  href={`/jugar/${asig.id}/libre`}
                  className="flex min-h-[72px] items-center gap-4 rounded-[22px] bg-white px-4 py-3 shadow-[0_8px_22px_-12px_rgba(216,90,48,0.28)] transition active:scale-[0.98]"
                >
                  <span
                    className="flex h-14 w-14 shrink-0 items-center justify-center rounded-2xl bg-limon/50 text-3xl"
                    aria-hidden
                  >
                    {iconoAsignatura(asig.icono)}
                  </span>
                  <span className="font-titulo text-xl font-semibold text-sol">
                    {asig.nombre}
                  </span>
                </Link>

                {asig.temas.length > 0 ? (
                  <ul className="mt-2 flex flex-col gap-1.5 pl-2">
                    {asig.temas.map((tema) => (
                      <li key={tema.id}>
                        <Link
                          href={`/jugar/${asig.id}/libre?tema=${tema.id}`}
                          className="flex min-h-11 items-center rounded-2xl px-3 font-cuerpo text-base text-mar underline-offset-2 hover:underline"
                        >
                          {tema.nombre}
                        </Link>
                      </li>
                    ))}
                  </ul>
                ) : null}
              </Aparecer>
            </li>
          ))}
        </ul>
      )}

      <Aparecer delay={0.2} className="mt-8">
        <Link
          href="/mundo"
          className="inline-flex min-h-12 w-full items-center justify-center rounded-2xl border-2 border-sol/25 bg-white font-titulo text-lg font-semibold text-sol"
        >
          Volver
        </Link>
      </Aparecer>
    </Pantalla>
  );
}
