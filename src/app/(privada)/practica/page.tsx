import Link from "next/link";
import { redirect } from "next/navigation";
import { Flame, Gem, Sparkles } from "lucide-react";
import {
  getAsignaturasPorCurso,
  getNinoActivoValidado,
  getTemasActivosDeAsignatura,
  listarAsignaturasParaPracticaExtrema,
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
import {
  Aparecer,
  Boton,
  CabeceraNino,
  EstadoVacio,
  Pantalla,
  Tarjeta,
} from "@/components/ui";

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
      <Pantalla className="fondo-halo-sol" sinAtmosfera>
        <Aparecer>
          <CabeceraNino titulo="Práctica" />
          <p className="mt-3 text-center font-cuerpo text-base text-readable">
            Elige cómo practicar
          </p>
        </Aparecer>

        <div className="mt-6 flex flex-col gap-3">
          <Aparecer delay={0.06}>
            <Link
              href="/practica?nivel=normal"
              className="block rounded-card bg-surface px-5 py-5 shadow-elevated transition active:scale-[0.98] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus"
            >
              <div className="flex items-start gap-3">
                <span className="flex h-14 w-14 shrink-0 items-center justify-center rounded-2xl bg-limon/60 text-mar">
                  <Sparkles className="h-7 w-7 stroke-[2]" aria-hidden />
                </span>
                <div className="min-w-0">
                  <p className="font-cuerpo text-xs font-medium uppercase tracking-wide text-mar">
                    Recomendado
                  </p>
                  <h2 className="mt-0.5 font-titulo text-2xl font-semibold text-primary">
                    Normal
                  </h2>
                  <p className="mt-1.5 font-cuerpo text-base leading-snug text-readable">
                    Todas las dificultades. Suma del día (da igual la
                    asignatura).{" "}
                    <span className="inline-flex items-center gap-0.5 font-titulo font-semibold text-mar">
                      +{DIAMANTES_PRACTICA_DIARIA}
                      <Gem className="h-3.5 w-3.5 stroke-[2]" aria-hidden />
                    </span>{" "}
                    cada {PRACTICA_PREGUNTAS_PARA_DIAMANTE} preguntas (1 vez al
                    día).
                  </p>
                </div>
              </div>
            </Link>
          </Aparecer>

          <Aparecer delay={0.1}>
            <Link
              href="/practica?nivel=extremo"
              className="block rounded-card bg-[linear-gradient(145deg,#FFF5F0_0%,#FFE0D4_100%)] px-5 py-4 shadow-card ring-1 ring-sol/15 transition active:scale-[0.98] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus"
            >
              <div className="flex items-start gap-3">
                <span className="flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl bg-sol/15 text-primary">
                  <Flame className="h-6 w-6 stroke-[2]" aria-hidden />
                </span>
                <div className="min-w-0">
                  <h2 className="font-titulo text-xl font-semibold text-primary">
                    Extremo
                  </h2>
                  <p className="mt-1 font-cuerpo text-sm leading-snug text-readable">
                    Solo preguntas del curso siguiente (1º→2º, 2º→3º).{" "}
                    <span className="inline-flex items-center gap-0.5 font-titulo font-semibold text-mar">
                      +{DIAMANTES_PRACTICA_EXTREMA_LOTE}
                      <Gem className="h-3.5 w-3.5 stroke-[2]" aria-hidden />
                    </span>{" "}
                    cada {PRACTICA_EXTREMA_ACIERTOS_POR_LOTE} aciertos · sin
                    límite.
                  </p>
                </div>
              </div>
            </Link>
          </Aparecer>
        </div>
      </Pantalla>
    );
  }

  const asignaturas = await getAsignaturasPorCurso(nino.curso);
  const cursoNino = nino.curso === "1" || nino.curso === "2" ? nino.curso : null;

  const conTemas =
    nivel === "extremo"
      ? cursoNino
        ? await listarAsignaturasParaPracticaExtrema(cursoNino, asignaturas)
        : []
      : await Promise.all(
          asignaturas.map(async (asig) => ({
            ...asig,
            temas: await getTemasActivosDeAsignatura(nino.id, asig.id),
          })),
        );

  const q = `nivel=${nivel}`;
  const tituloNivel = nivel === "extremo" ? "Extremo" : "Normal";
  const etiquetaCursoSig =
    nino.curso === "1" ? "2º" : nino.curso === "2" ? "3º" : "siguiente";

  return (
    <Pantalla className="fondo-halo-sol" sinAtmosfera>
      <Aparecer>
        <CabeceraNino titulo="Práctica" hrefVolver="/practica" labelVolver="Cambiar nivel" />
        <p className="mt-2 text-center font-cuerpo text-sm text-readable">
          {nino.nombre} · {tituloNivel}
        </p>
        <p className="mt-1 text-center font-cuerpo text-base text-readable">
          {nivel === "extremo"
            ? `Preguntas de ${etiquetaCursoSig} · +${DIAMANTES_PRACTICA_EXTREMA_LOTE}💎 / ${PRACTICA_EXTREMA_ACIERTOS_POR_LOTE} aciertos`
            : `+${DIAMANTES_PRACTICA_DIARIA}💎 con ${PRACTICA_PREGUNTAS_PARA_DIAMANTE} preguntas (1/día)`}
        </p>
      </Aparecer>

      {conTemas.length === 0 ? (
        <Aparecer delay={0.08} className="mt-8">
          <EstadoVacio
            titulo={
              nivel === "extremo"
                ? `Sin contenido de ${etiquetaCursoSig}`
                : "Sin asignaturas"
            }
            descripcion={
              nivel === "extremo"
                ? `Aún no hay asignaturas de ${etiquetaCursoSig} con el mismo nombre. Pide a un adulto que cargue ese contenido.`
                : "Aún no hay asignaturas para tu curso."
            }
            accion={<Boton href="/mundo" variant="suave">Volver</Boton>}
          />
        </Aparecer>
      ) : (
        <ul className="mt-6 flex flex-col gap-4">
          {conTemas.map((asig, i) => (
            <li key={asig.id}>
              <Aparecer delay={0.06 + i * 0.04}>
                <Tarjeta padding="sm" className="overflow-hidden !p-0">
                  <Link
                    href={`/jugar/${asig.id}/libre?${q}`}
                    className="flex min-h-[4.5rem] items-center gap-4 px-4 py-3 transition hover:bg-surface-muted/50 focus-visible:outline-2 focus-visible:outline-offset-[-2px] focus-visible:outline-focus active:scale-[0.99]"
                  >
                    <span
                      className="flex h-14 w-14 shrink-0 items-center justify-center rounded-2xl bg-limon/50 text-3xl"
                      aria-hidden
                    >
                      {iconoAsignatura(asig.icono)}
                    </span>
                    <span className="min-w-0 flex-1">
                      <span className="block font-titulo text-xl font-semibold text-primary">
                        {asig.nombre}
                      </span>
                      <span className="mt-0.5 block font-cuerpo text-sm text-readable">
                        {nivel === "extremo"
                          ? `Toda la asignatura · ${etiquetaCursoSig}`
                          : "Toda la asignatura"}
                      </span>
                    </span>
                  </Link>

                  {asig.temas.length > 0 ? (
                    <ul className="border-t border-border/60 px-2 py-2">
                      {asig.temas.map((tema) => (
                        <li key={tema.id}>
                          <Link
                            href={`/jugar/${asig.id}/libre?tema=${tema.id}&${q}`}
                            className="flex min-h-12 items-center rounded-xl px-3 font-cuerpo text-base text-secondary transition hover:bg-mar/8 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus"
                          >
                            {tema.nombre}
                          </Link>
                        </li>
                      ))}
                    </ul>
                  ) : null}
                </Tarjeta>
              </Aparecer>
            </li>
          ))}
        </ul>
      )}

      <Aparecer delay={0.2} className="mt-8">
        <Boton href="/mundo" variant="suave">
          Volver al mundo
        </Boton>
      </Aparecer>
    </Pantalla>
  );
}
