import Image from "next/image";
import Link from "next/link";
import { Pencil, Plus, Trash2 } from "lucide-react";
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
        <div>
          <h1 className="font-titulo text-2xl font-semibold text-sol">Hijos</h1>
          <p className="mt-0.5 font-cuerpo text-sm text-black/50">
            Perfiles de la familia
          </p>
        </div>
        <Link
          href="/zona-padres/hijos/nuevo"
          className="inline-flex min-h-11 items-center gap-1.5 rounded-2xl bg-sol px-4 font-titulo text-sm font-semibold text-white shadow-[0_4px_0_0_rgba(184,64,28,0.3)] transition active:translate-y-0.5 active:shadow-none"
        >
          <Plus className="h-4 w-4 stroke-[2.5]" aria-hidden />
          Añadir
        </Link>
      </div>

      {ninos.length === 0 ? (
        <p className="mt-8 rounded-[22px] bg-white px-4 py-6 text-center font-cuerpo text-base text-black/55 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.25)]">
          Todavía no hay perfiles. Añade el primero.
        </p>
      ) : (
        <ul className="mt-6 flex flex-col gap-3">
          {ninos.map((nino) => {
            const avatar = AVATARES.find((a) => a.id === nino.avatar);
            return (
              <li
                key={nino.id}
                className="rounded-[22px] bg-white px-4 py-4 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.28)]"
              >
                <div className="flex items-center gap-3">
                  <div className="relative h-14 w-14 shrink-0 overflow-hidden rounded-full bg-[#FFF8ED] ring-2 ring-white shadow-[0_4px_12px_-4px_rgba(216,90,48,0.35)]">
                    {avatar ? (
                      <Image
                        src={publicAsset(`assets/avatares/${avatar.id}`)}
                        alt=""
                        width={56}
                        height={56}
                        unoptimized
                        className="h-full w-full object-contain p-0.5"
                      />
                    ) : (
                      <span className="flex h-full w-full items-center justify-center font-titulo text-xl text-sol">
                        {nino.nombre.slice(0, 1)}
                      </span>
                    )}
                  </div>
                  <div className="min-w-0 flex-1">
                    <p className="font-titulo text-xl font-semibold text-sol">
                      {nino.nombre}
                    </p>
                    <p className="font-cuerpo text-sm text-black/50">
                      {nino.curso}º primaria
                    </p>
                  </div>
                </div>
                <div className="mt-3 flex gap-2">
                  <Link
                    href={`/zona-padres/hijos/${nino.id}/editar`}
                    className="inline-flex min-h-11 flex-1 items-center justify-center gap-1.5 rounded-2xl bg-mar/10 font-titulo text-sm font-semibold text-mar transition hover:bg-mar/15"
                  >
                    <Pencil className="h-3.5 w-3.5 stroke-[2]" aria-hidden />
                    Editar
                  </Link>
                  <form
                    action={borrarNinoZonaPadres.bind(null, nino.id)}
                    className="flex-1"
                  >
                    <button
                      type="submit"
                      className="inline-flex min-h-11 w-full items-center justify-center gap-1.5 rounded-2xl bg-fallo/15 font-titulo text-sm font-semibold text-[#8a3b28] transition hover:bg-fallo/25"
                    >
                      <Trash2 className="h-3.5 w-3.5 stroke-[2]" aria-hidden />
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
