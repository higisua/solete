import Link from "next/link";
import { notFound } from "next/navigation";
import { Plus } from "lucide-react";
import {
  actualizarAsignatura,
  borrarTema,
  requireSuperadmin,
} from "@/app/actions/superadmin";
import { Field, SuperadminForm } from "@/components/zona-padres/SuperadminForm";
import { SelectorEmojiAsignatura } from "@/components/zona-padres/SelectorEmojiAsignatura";
import { MigasContenido } from "@/components/zona-padres/MigasContenido";
import { BotonBorrarConfirmado } from "@/components/zona-padres/BotonBorrarConfirmado";
import { iconoAsignatura } from "@/lib/iconos";
import { createClient } from "@/lib/supabase/server";

type Props = { params: Promise<{ asignaturaId: string }> };

export default async function AsignaturaDetailPage({ params }: Props) {
  await requireSuperadmin();
  const { asignaturaId } = await params;
  const supabase = await createClient();

  const { data: asignatura } = await supabase
    .from("asignaturas")
    .select("*")
    .eq("id", asignaturaId)
    .maybeSingle();
  if (!asignatura) notFound();

  const { data: temas } = await supabase
    .from("temas")
    .select("*")
    .eq("asignatura_id", asignaturaId)
    .order("orden");

  const temaIds = (temas ?? []).map((t) => t.id);
  const { data: preguntas } =
    temaIds.length > 0
      ? await supabase
          .from("preguntas")
          .select("id, tema_id")
          .in("tema_id", temaIds)
      : { data: [] as { id: string; tema_id: string }[] };

  const countByTema = new Map<string, number>();
  for (const p of preguntas ?? []) {
    countByTema.set(p.tema_id, (countByTema.get(p.tema_id) ?? 0) + 1);
  }

  return (
    <div>
      <MigasContenido
        items={[
          { label: "Contenido", href: "/zona-padres/contenido" },
          { label: asignatura.nombre },
        ]}
      />
      <h1 className="mt-3 flex items-center gap-2 font-titulo text-2xl font-semibold text-sol">
        <span
          className="flex h-11 w-11 items-center justify-center rounded-2xl bg-[#FFF8ED] text-2xl"
          aria-hidden
        >
          {iconoAsignatura(asignatura.icono)}
        </span>
        {asignatura.nombre}
      </h1>

      <section className="mt-6 rounded-[22px] bg-white p-4 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.25)]">
        <h2 className="font-titulo text-lg font-semibold text-sol">
          Editar asignatura
        </h2>
        <div className="mt-3">
          <SuperadminForm action={actualizarAsignatura} submitLabel="Guardar">
            <input type="hidden" name="id" value={asignatura.id} />
            <Field
              label="Nombre"
              name="nombre"
              required
              defaultValue={asignatura.nombre}
            />
            <SelectorEmojiAsignatura defaultValue={asignatura.icono} />
            <label className="block w-full">
              <span className="mb-1.5 block font-titulo text-base font-semibold text-sol">
                Curso
              </span>
              <select
                name="curso"
                defaultValue={asignatura.curso}
                className="min-h-12 w-full rounded-2xl border-2 border-sol-claro/55 bg-white px-4 font-cuerpo text-base outline-none transition focus:border-sol focus:shadow-[0_0_0_3px_rgba(216,90,48,0.12)]"
              >
                <option value="1">1º</option>
                <option value="2">2º</option>
              </select>
            </label>
          </SuperadminForm>
        </div>
      </section>

      <section className="mt-8">
        <div className="flex items-center justify-between gap-3">
          <div>
            <h2 className="font-titulo text-lg font-semibold text-sol">Temas</h2>
            <p className="mt-0.5 font-cuerpo text-sm text-black/50">
              Entra en un tema para gestionar preguntas
            </p>
          </div>
          <Link
            href={`/zona-padres/contenido/${asignaturaId}/temas/nuevo`}
            className="inline-flex min-h-11 shrink-0 items-center gap-1 rounded-2xl bg-mar px-3 font-titulo text-sm font-semibold text-white shadow-[0_3px_0_0_rgba(18,110,80,0.3)]"
          >
            <Plus className="h-4 w-4 stroke-[2.5]" aria-hidden />
            Tema
          </Link>
        </div>
        <ul className="mt-4 flex flex-col gap-3">
          {(temas ?? []).map((t) => {
            const nPreg = countByTema.get(t.id) ?? 0;
            return (
              <li
                key={t.id}
                className="rounded-[22px] bg-white p-4 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.25)]"
              >
                <p className="font-titulo text-lg font-semibold text-sol">
                  {t.orden}. {t.nombre}
                </p>
                <p className="font-cuerpo text-sm text-black/50">
                  {nPreg} {nPreg === 1 ? "pregunta" : "preguntas"}
                </p>
                <div className="mt-3 flex gap-2">
                  <Link
                    href={`/zona-padres/contenido/${asignaturaId}/temas/${t.id}`}
                    className="inline-flex min-h-12 flex-1 items-center justify-center rounded-2xl bg-sol font-titulo text-sm font-semibold text-white shadow-[0_3px_0_0_rgba(184,64,28,0.3)]"
                  >
                    Gestionar preguntas
                  </Link>
                  <BotonBorrarConfirmado
                    action={borrarTema.bind(null, t.id, asignaturaId)}
                    confirmar={`¿Borrar el tema «${t.nombre}» y sus preguntas?`}
                  />
                </div>
              </li>
            );
          })}
          {(temas ?? []).length === 0 ? (
            <li className="rounded-[22px] bg-white px-4 py-5 text-center font-cuerpo text-sm text-black/50 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.2)]">
              Sin temas. Crea uno para añadir preguntas.
            </li>
          ) : null}
        </ul>
      </section>
    </div>
  );
}
