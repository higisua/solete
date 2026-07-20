import Link from "next/link";
import Image from "next/image";
import { redirect } from "next/navigation";
import { cambiarDeNino } from "@/app/actions/juego";
import { getNinosDeMiFamilia } from "@/lib/familia";
import {
  getAsignaturasPorCurso,
  getNinoActivoValidado,
  getTotalesProgreso,
} from "@/lib/juego";
import { iconoAsignatura } from "@/lib/iconos";
import { AVATARES } from "@/lib/avatares";
import { publicAsset } from "@/lib/public-asset";
import { setNinoActivoId } from "@/lib/nino-activo";

export default async function MundoPage() {
  let nino = await getNinoActivoValidado();

  if (!nino) {
    const ninos = await getNinosDeMiFamilia();
    if (ninos.length === 0) {
      redirect("/familia");
    }
    if (ninos.length === 1) {
      await setNinoActivoId(ninos[0].id);
      nino = ninos[0];
    } else {
      redirect("/quien-juega");
    }
  }

  const [asignaturas, totales, hermanos] = await Promise.all([
    getAsignaturasPorCurso(nino.curso),
    getTotalesProgreso(nino.id),
    getNinosDeMiFamilia(),
  ]);

  const avatarMeta = AVATARES.find((a) => a.id === nino.avatar);
  const racha = nino.racha_dias ?? 0;

  return (
    <main className="relative mx-auto min-h-dvh w-full max-w-md px-5 pb-10 pt-6">
      {/* Acceso discreto a zona padres */}
      <Link
        href="/zona-padres"
        aria-label="Zona padres"
        className="absolute right-4 top-4 flex h-11 w-11 items-center justify-center rounded-full text-2xl text-black/35 transition hover:bg-white/70 hover:text-black/55"
      >
        ⚙️
      </Link>

      {hermanos.length > 1 ? (
        <form action={cambiarDeNino} className="mb-2">
          <button
            type="submit"
            className="min-h-11 text-sm font-semibold text-mar underline underline-offset-2"
          >
            Cambiar de jugador
          </button>
        </form>
      ) : null}

      <div className="mt-6 flex flex-col items-center text-center">
        {avatarMeta ? (
          <Image
            src={publicAsset(`assets/avatares/${avatarMeta.id}`)}
            alt={avatarMeta.nombre}
            width={120}
            height={120}
            unoptimized
            priority
            className="h-28 w-28 object-contain"
          />
        ) : (
          <div className="flex h-28 w-28 items-center justify-center rounded-full bg-limon font-titulo text-5xl text-sol">
            {nino.nombre.slice(0, 1)}
          </div>
        )}
        <h1 className="mt-4 font-titulo text-3xl font-semibold text-sol sm:text-4xl">
          ¡Hola, {nino.nombre}!
        </h1>
        <p className="mt-1 text-lg text-black/60">{nino.curso}º de primaria</p>

        <div className="mt-4 flex flex-wrap justify-center gap-3">
          <div className="rounded-2xl bg-white px-4 py-2 font-titulo text-lg text-sol shadow-sm">
            ⭐ {totales.estrellas}
          </div>
          <div className="rounded-2xl bg-white px-4 py-2 font-titulo text-lg text-mar shadow-sm">
            💎 {totales.puntos}
          </div>
          {racha > 0 ? (
            <div className="rounded-2xl bg-white px-4 py-2 font-titulo text-lg text-sol shadow-sm">
              🔥 {racha}
            </div>
          ) : null}
        </div>
      </div>

      <h2 className="mt-10 font-titulo text-2xl font-semibold text-sol">
        ¿Qué repasamos?
      </h2>

      {asignaturas.length === 0 ? (
        <p className="mt-4 text-base text-black/60">
          Aún no hay asignaturas para tu curso. ¡Vuelve pronto!
        </p>
      ) : (
        <ul className="mt-4 flex flex-col gap-3">
          {asignaturas.map((asig) => (
            <li key={asig.id}>
              <Link
                href={`/jugar/${asig.id}`}
                className="flex min-h-[72px] items-center gap-4 rounded-3xl bg-white px-4 py-3 shadow-sm transition active:scale-[0.98] hover:bg-mar-claro/25"
              >
                <span
                  className="flex h-14 w-14 items-center justify-center rounded-2xl bg-limon/50 text-3xl"
                  aria-hidden
                >
                  {iconoAsignatura(asig.icono)}
                </span>
                <span className="font-titulo text-2xl font-semibold text-sol">
                  {asig.nombre}
                </span>
              </Link>
            </li>
          ))}
        </ul>
      )}
    </main>
  );
}
