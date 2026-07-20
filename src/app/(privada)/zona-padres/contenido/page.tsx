import Link from "next/link";
import { requireSuperadmin, borrarAsignatura } from "@/app/actions/superadmin";
import { iconoAsignatura } from "@/lib/iconos";
import { createClient } from "@/lib/supabase/server";

export default async function ContenidoPage() {
  await requireSuperadmin();
  const supabase = await createClient();
  const { data: asignaturas } = await supabase
    .from("asignaturas")
    .select("*")
    .order("curso")
    .order("nombre");

  return (
    <div>
      <div className="flex items-center justify-between gap-3">
        <h1 className="font-titulo text-2xl font-semibold text-sol">Contenido</h1>
        <Link
          href="/zona-padres/contenido/nueva"
          className="inline-flex min-h-11 items-center rounded-2xl bg-sol px-4 font-titulo text-sm font-semibold text-white"
        >
          Nueva
        </Link>
      </div>
      <p className="mt-1 text-sm text-black/55">Asignaturas, temas y preguntas</p>

      <ul className="mt-6 flex flex-col gap-3">
        {(asignaturas ?? []).map((a) => (
          <li key={a.id} className="rounded-2xl bg-white p-4 shadow-sm">
            <Link href={`/zona-padres/contenido/${a.id}`} className="block">
              <p className="font-titulo text-xl text-sol">
                <span className="mr-1" aria-hidden>
                  {iconoAsignatura(a.icono)}
                </span>
                {a.nombre}
              </p>
              <p className="text-sm text-black/55">{a.curso}º primaria</p>
            </Link>
            <div className="mt-3 flex gap-2">
              <Link
                href={`/zona-padres/contenido/${a.id}`}
                className="inline-flex min-h-11 flex-1 items-center justify-center rounded-xl bg-mar/10 font-titulo text-sm font-semibold text-mar"
              >
                Abrir
              </Link>
              <form action={borrarAsignatura.bind(null, a.id)} className="flex-1">
                <button
                  type="submit"
                  className="min-h-11 w-full rounded-xl bg-fallo/20 font-titulo text-sm font-semibold text-[#8a3b28]"
                >
                  Borrar
                </button>
              </form>
            </div>
          </li>
        ))}
        {(asignaturas ?? []).length === 0 ? (
          <li className="text-black/55">No hay asignaturas todavía.</li>
        ) : null}
      </ul>
    </div>
  );
}
