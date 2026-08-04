import Link from "next/link";
import { redirect } from "next/navigation";
import { Flame, Gem, Sparkles } from "lucide-react";
import {
  getAsignaturasPorCurso,
  getNinoActivoValidado,
  getTemasActivosDeAsignatura,
} from "@/lib/juego";
import {
  DIAMANTES_PRACTICA_DIARIA,
  DIAMANTES_PRACTICA_EXTREMA_LOTE,
  PRACTICA_EXTREMA_ACIERTOS_POR_LOTE,
  PRACTICA_PREGUNTAS_PARA_DIAMANTE,
  esNivelPractica,
  type NivelPractica,
} from "@/lib/juego/economia";
import { iconoAsignatura } from "@/lib/iconos";
import { Aparecer, Pantalla, Tarjeta } from "@/components/ui";

type Props = {
  searchParams: Promise<{ nivel?: string }>;
};

/** Elige nivel y luego asignatura/tema para el modo práctica. */
export default async function PracticaPage({ searchParams }: Props) {
  const nino = await getNinoActivoValidado();
  if (!nino) {
    redirect("/entrada");
  }

  const sp = await searchParams;
  const nivelRaw = sp.nivel;
  const nivel: NivelPractica | null = esNivelPractica(nivelRaw)
    ? nivelRaw
    : null;

  if (!nivel) {
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
            Elige cómo quieres practicar
          </p>
        </Aparecer>

        <div className="mt-8 flex flex-col gap-4">
          <Aparecer delay={0.06}>
            <Link
              href="/practica?nivel=normal"
              className="block rounded-[24px] bg-white px-5 py-5 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.28)] transition active:scale-[0.98]"
            >
              <div className="flex items-start gap-3">
                <span className="flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl bg-limon/60 text-mar">
                  <Sparkles className="h-6 w-6 stroke-[2]" aria-hidden />
                </span>
                <div className="min-w-0">
                  <h2 className="font-titulo text-xl font-semibold text-sol">
                    Normal
                  </h2>
                  <p className="mt-1 font-cuerpo text-sm text-black/55">
                    Todas las dificultades.{" "}
                    <span className="inline-flex items-center gap-0.5 font-titulo font-semibold text-mar">
                      +{DIAMANTES_PRACTICA_DIARIA}
                      <Gem className="h-3.5 w-3.5 stroke-[2]" aria-hidden />
                    </span>{" "}
                    al llegar a {PRACTICA_PREGUNTAS_PARA_DIAMANTE} preguntas
                    (máx. 1 vez al día).
                  </p>
                </div>
              </div>
            </Link>
          </Aparecer>

          <Aparecer delay={0.1}>
            <Link
              href="/practica?nivel=extremo"
              className="block rounded-[24px] bg-[linear-gradient(145deg,#FFF5F0_0%,#FFE0D4_100%)] px-5 py-5 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.35)] ring-1 ring-sol/15 transition active:scale-[0.98]"
            >
              <div className="flex items-start gap-3">
                <span className="flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl bg-sol/15 text-sol">
                  <Flame className="h-6 w-6 stroke-[2]" aria-hidden />
                </span>
                <div className="min-w-0">
                  <h2 className="font-titulo text-xl font-semibold text-sol">
                    Extremo
                  </h2>
                  <p className="mt-1 font-cuerpo text-sm text-black/55">
                    Preguntas más difíciles.{" "}
                    <span className="inline-flex items-center gap-0.5 font-titulo font-semibold text-mar">
                      +{DIAMANTES_PRACTICA_EXTREMA_LOTE}
                      <Gem className="h-3.5 w-3.5 stroke-[2]" aria-hidden />
                    </span>{" "}
                    cada {PRACTICA_EXTREMA_ACIERTOS_POR_LOTE} aciertos, sin
                    límite.
                  </p>
                </div>
              </div>
            </Link>
          </Aparecer>
        </div>

        <Aparecer delay={0.18} className="mt-8">
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

  const asignaturas = await getAsignaturasPorCurso(nino.curso);
  const conTemas = await Promise.all(
    asignaturas.map(async (asig) => ({
      ...asig,
      temas: await getTemasActivosDeAsignatura(nino.id, asig.id),
    })),
  );

  const q = `nivel=${nivel}`;
  const tituloNivel = nivel === "extremo" ? "Extremo" : "Normal";

  return (
    <Pantalla className="fondo-halo-sol">
      <Aparecer>
        <p className="text-center font-cuerpo text-sm text-black/45">
          {nino.nombre} · {tituloNivel}
        </p>
        <h1 className="mt-1 text-center font-titulo text-3xl font-semibold text-sol">
          Práctica
        </h1>
        <p className="mt-2 text-center font-cuerpo text-base text-black/50">
          {nivel === "extremo"
            ? `Preguntas difíciles · +${DIAMANTES_PRACTICA_EXTREMA_LOTE}💎 cada ${PRACTICA_EXTREMA_ACIERTOS_POR_LOTE} aciertos`
            : `+${DIAMANTES_PRACTICA_DIARIA}💎 con ${PRACTICA_PREGUNTAS_PARA_DIAMANTE} preguntas (1/día)`}
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
                  href={`/jugar/${asig.id}/libre?${q}`}
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
                          href={`/jugar/${asig.id}/libre?tema=${tema.id}&${q}`}
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

      <Aparecer delay={0.2} className="mt-8 flex flex-col gap-3">
        <Link
          href="/practica"
          className="inline-flex min-h-12 w-full items-center justify-center rounded-2xl border-2 border-sol/25 bg-white font-titulo text-lg font-semibold text-sol"
        >
          Cambiar nivel
        </Link>
        <Link
          href="/mundo"
          className="inline-flex min-h-12 w-full items-center justify-center rounded-2xl border-2 border-transparent font-titulo text-lg font-semibold text-black/45"
        >
          Volver al mundo
        </Link>
      </Aparecer>
    </Pantalla>
  );
}
