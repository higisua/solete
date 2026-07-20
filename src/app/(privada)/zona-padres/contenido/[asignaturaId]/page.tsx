import Link from "next/link";
import { notFound } from "next/navigation";
import {
  actualizarAsignatura,
  borrarTema,
  requireSuperadmin,
} from "@/app/actions/superadmin";
import { Field, SuperadminForm } from "@/components/zona-padres/SuperadminForm";
import { SelectorEmojiAsignatura } from "@/components/zona-padres/SelectorEmojiAsignatura";
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
      ? await supabase.from("preguntas").select("id, tema_id").in("tema_id", temaIds)
      : { data: [] as { id: string; tema_id: string }[] };

  const countByTema = new Map<string, number>();
  for (const p of preguntas ?? []) {
    countByTema.set(p.tema_id, (countByTema.get(p.tema_id) ?? 0) + 1);
  }

  return (
    <div>
      <Link href="/zona-padres/contenido" className="text-sm font-semibold text-mar">
        ← Contenido
      </Link>
      <h1 className="mt-3 font-titulo text-2xl font-semibold text-sol">
        <span className="mr-2" aria-hidden>
          {iconoAsignatura(asignatura.icono)}
        </span>
        {asignatura.nombre}
      </h1>

      <section className="mt-6 rounded-2xl bg-white p-4 shadow-sm">
        <h2 className="font-titulo text-lg text-sol">Editar asignatura</h2>
        <div className="mt-3">
          <SuperadminForm action={actualizarAsignatura} submitLabel="Guardar">
            <input type="hidden" name="id" value={asignatura.id} />
            <Field label="Nombre" name="nombre" required defaultValue={asignatura.nombre} />
            <SelectorEmojiAsignatura defaultValue={asignatura.icono} />
            <label className="block">
              <span className="mb-1.5 block font-titulo text-base text-sol">Curso</span>
              <select
                name="curso"
                defaultValue={asignatura.curso}
                className="min-h-12 w-full rounded-2xl border-2 border-sol-claro/60 bg-white px-4"
              >
                <option value="1">1º</option>
                <option value="2">2º</option>
              </select>
            </label>
          </SuperadminForm>
        </div>
      </section>

      <section className="mt-8">
        <div className="flex items-center justify-between">
          <h2 className="font-titulo text-lg text-sol">Temas</h2>
          <Link
            href={`/zona-padres/contenido/${asignaturaId}/temas/nuevo`}
            className="inline-flex min-h-11 items-center rounded-2xl bg-mar px-3 font-titulo text-sm font-semibold text-white"
          >
            + Tema
          </Link>
        </div>
        <p className="mt-1 text-sm text-black/55">
          Entra en un tema para crear y editar sus preguntas.
        </p>
        <ul className="mt-3 flex flex-col gap-3">
          {(temas ?? []).map((t) => {
            const nPreg = countByTema.get(t.id) ?? 0;
            return (
              <li key={t.id} className="rounded-2xl bg-white p-4 shadow-sm">
                <p className="font-titulo text-lg text-sol">
                  {t.orden}. {t.nombre}
                </p>
                <p className="text-sm text-black/55">
                  {nPreg} {nPreg === 1 ? "pregunta" : "preguntas"}
                </p>
                <div className="mt-3 flex gap-2">
                  <Link
                    href={`/zona-padres/contenido/${asignaturaId}/temas/${t.id}`}
                    className="inline-flex min-h-12 flex-1 items-center justify-center rounded-xl bg-sol font-titulo text-sm font-semibold text-white"
                  >
                    Gestionar preguntas
                  </Link>
                  <form action={borrarTema.bind(null, t.id, asignaturaId)}>
                    <button
                      type="submit"
                      className="min-h-12 rounded-xl bg-fallo/20 px-3 font-titulo text-sm font-semibold text-[#8a3b28]"
                    >
                      Borrar
                    </button>
                  </form>
                </div>
              </li>
            );
          })}
          {(temas ?? []).length === 0 ? (
            <li className="text-sm text-black/55">Sin temas. Crea uno para añadir preguntas.</li>
          ) : null}
        </ul>
      </section>
    </div>
  );
}
