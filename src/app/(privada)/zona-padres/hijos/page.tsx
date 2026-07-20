import Image from "next/image";
import Link from "next/link";
import { borrarNinoZonaPadres, requireZonaPadres } from "@/app/actions/zona-padres";
import { getNinosDeMiFamilia } from "@/lib/familia";
import { AVATARES } from "@/lib/avatares";
import { publicAsset } from "@/lib/public-asset";

export default async function HijosPage() {
  await requireZonaPadres();
  const ninos = await getNinosDeMiFamilia();

  return (
    <div>
      <div className="flex items-center justify-between gap-3">
        <h1 className="font-titulo text-2xl font-semibold text-sol">Hijos</h1>
        <Link
          href="/zona-padres/hijos/nuevo"
          className="inline-flex min-h-11 items-center rounded-2xl bg-sol px-4 font-titulo text-sm font-semibold text-white"
        >
          Añadir
        </Link>
      </div>

      {ninos.length === 0 ? (
        <p className="mt-6 text-base text-black/60">
          Todavía no hay perfiles. Añade el primero.
        </p>
      ) : (
        <ul className="mt-6 flex flex-col gap-3">
          {ninos.map((nino) => {
            const avatar = AVATARES.find((a) => a.id === nino.avatar);
            return (
              <li
                key={nino.id}
                className="rounded-2xl bg-white px-4 py-3 shadow-sm"
              >
                <div className="flex items-center gap-3">
                  {avatar ? (
                    <Image
                      src={publicAsset(`assets/avatares/${avatar.id}`)}
                      alt=""
                      width={52}
                      height={52}
                      unoptimized
                      className="h-[52px] w-[52px] object-contain"
                    />
                  ) : null}
                  <div className="min-w-0 flex-1">
                    <p className="font-titulo text-xl text-sol">{nino.nombre}</p>
                    <p className="text-sm text-black/55">{nino.curso}º primaria</p>
                  </div>
                </div>
                <div className="mt-3 flex gap-2">
                  <Link
                    href={`/zona-padres/hijos/${nino.id}/editar`}
                    className="inline-flex min-h-11 flex-1 items-center justify-center rounded-xl bg-mar/10 font-titulo text-sm font-semibold text-mar"
                  >
                    Editar
                  </Link>
                  <form action={borrarNinoZonaPadres.bind(null, nino.id)} className="flex-1">
                    <button
                      type="submit"
                      className="min-h-11 w-full rounded-xl bg-fallo/20 font-titulo text-sm font-semibold text-[#8a3b28]"
                    >
                      Borrar
                    </button>
                  </form>
                </div>
              </li>
            );
          })}
        </ul>
      )}
    </div>
  );
}
