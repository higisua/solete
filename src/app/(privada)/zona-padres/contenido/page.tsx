import Link from "next/link";
import { ChevronRight, Plus } from "lucide-react";
import { requireSuperadmin, borrarAsignatura } from "@/app/actions/superadmin";
import { BotonBorrarConfirmado } from "@/components/zona-padres/BotonBorrarConfirmado";
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
        <div>
          <h1 className="font-titulo text-2xl font-semibold text-sol">
            Contenido
          </h1>
          <p className="mt-0.5 font-cuerpo text-sm text-black/50">
            Asignaturas → temas → preguntas
          </p>
        </div>
        <Link
          href="/zona-padres/contenido/nueva"
          className="inline-flex min-h-11 items-center gap-1.5 rounded-2xl bg-sol px-4 font-titulo text-sm font-semibold text-white shadow-[0_4px_0_0_rgba(184,64,28,0.3)] transition active:translate-y-0.5 active:shadow-none"
        >
          <Plus className="h-4 w-4 stroke-[2.5]" aria-hidden />
          Nueva
        </Link>
      </div>

      <ul className="mt-6 flex flex-col gap-3">
        {(asignaturas ?? []).map((a) => (
          <li
            key={a.id}
            className="rounded-[22px] bg-white p-4 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.25)]"
          >
            <Link
              href={`/zona-padres/contenido/${a.id}`}
              className="flex items-center gap-3"
            >
              <span
                className="flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl bg-[#FFF8ED] text-2xl"
                aria-hidden
              >
                {iconoAsignatura(a.icono)}
              </span>
              <div className="min-w-0 flex-1">
                <p className="font-titulo text-lg font-semibold text-sol">
                  {a.nombre}
                </p>
                <p className="font-cuerpo text-sm text-black/50">
                  {a.curso}º primaria
                </p>
              </div>
              <ChevronRight
                className="h-5 w-5 shrink-0 stroke-black/25 stroke-[1.75]"
                aria-hidden
              />
            </Link>
            <div className="mt-3 flex gap-2">
              <Link
                href={`/zona-padres/contenido/${a.id}`}
                className="inline-flex min-h-11 flex-1 items-center justify-center rounded-2xl bg-mar/10 font-titulo text-sm font-semibold text-mar transition hover:bg-mar/15"
              >
                Abrir
              </Link>
              <BotonBorrarConfirmado
                action={borrarAsignatura.bind(null, a.id)}
                confirmar={`¿Borrar la asignatura «${a.nombre}» y todo su contenido?`}
                variante="peligro-bloque"
              />
            </div>
          </li>
        ))}
        {(asignaturas ?? []).length === 0 ? (
          <li className="rounded-[22px] bg-white px-4 py-6 text-center font-cuerpo text-black/50 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.2)]">
            No hay asignaturas todavía.
          </li>
        ) : null}
      </ul>
    </div>
  );
}
