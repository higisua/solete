import Link from "next/link";
import { notFound } from "next/navigation";
import {
  actualizarTema,
  borrarPregunta,
  requireSuperadmin,
} from "@/app/actions/superadmin";
import { FormularioPregunta } from "@/components/zona-padres/FormularioPregunta";
import { Field, SuperadminForm } from "@/components/zona-padres/SuperadminForm";
import { createClient } from "@/lib/supabase/server";
import type { Pregunta } from "@/types/database";

type Props = { params: Promise<{ asignaturaId: string; temaId: string }> };

function etiquetaTipo(tipo: string): string {
  if (tipo === "numeric") return "Numérica";
  if (tipo === "true_false") return "V / F";
  if (tipo === "multiple_choice") return "Opción múltiple";
  return tipo;
}

export default async function TemaDetailPage({ params }: Props) {
  await requireSuperadmin();
  const { asignaturaId, temaId } = await params;
  const supabase = await createClient();

  const { data: tema } = await supabase
    .from("temas")
    .select("*")
    .eq("id", temaId)
    .maybeSingle();
  if (!tema) notFound();

  const { data: preguntasRaw } = await supabase
    .from("preguntas")
    .select("*")
    .eq("tema_id", temaId)
    .order("creado_en", { ascending: true });

  const preguntas = (preguntasRaw ?? []).map((p) => ({
    ...(p as Pregunta),
    opciones: Array.isArray(p.opciones) ? (p.opciones as string[]) : null,
  }));

  return (
    <div>
      <Link
        href={`/zona-padres/contenido/${asignaturaId}`}
        className="text-sm font-semibold text-mar"
      >
        ← Asignatura
      </Link>
      <h1 className="mt-3 font-titulo text-2xl font-semibold text-sol">{tema.nombre}</h1>
      <p className="mt-1 text-sm text-black/55">
        Aquí gestionas las preguntas de este tema.
      </p>

      {/* Preguntas primero: es lo más importante */}
      <section className="mt-6">
        <h2 className="font-titulo text-xl text-sol">
          Preguntas ({preguntas.length})
        </h2>

        {preguntas.length === 0 ? (
          <p className="mt-3 rounded-2xl bg-limon/25 px-4 py-3 text-sm text-black/70">
            Todavía no hay preguntas. Usa el formulario de abajo para crear la
            primera.
          </p>
        ) : (
          <ul className="mt-3 flex flex-col gap-3">
            {preguntas.map((p) => (
              <li key={p.id} className="rounded-2xl bg-white p-4 shadow-sm">
                <p className="text-xs font-semibold uppercase tracking-wide text-black/45">
                  {etiquetaTipo(p.tipo)} · dificultad {p.dificultad}
                </p>
                <p className="mt-1 font-titulo text-lg text-sol">{p.enunciado}</p>
                <details className="mt-3">
                  <summary className="cursor-pointer font-titulo text-sm font-semibold text-mar">
                    Editar pregunta
                  </summary>
                  <div className="mt-3 border-t border-black/5 pt-3">
                    <FormularioPregunta
                      modo="editar"
                      asignaturaId={asignaturaId}
                      temaId={temaId}
                      pregunta={p}
                    />
                  </div>
                </details>
                <form
                  action={borrarPregunta.bind(null, p.id, asignaturaId, temaId)}
                  className="mt-3"
                >
                  <button
                    type="submit"
                    className="min-h-11 rounded-xl bg-fallo/20 px-4 font-titulo text-sm font-semibold text-[#8a3b28]"
                  >
                    Borrar pregunta
                  </button>
                </form>
              </li>
            ))}
          </ul>
        )}
      </section>

      <section className="mt-8 rounded-2xl border-2 border-sol/30 bg-white p-4 shadow-sm">
        <h2 className="font-titulo text-xl text-sol">Nueva pregunta</h2>
        <p className="mt-1 text-sm text-black/55">
          Elige el tipo y se mostrarán los campos adecuados.
        </p>
        <div className="mt-4">
          <FormularioPregunta
            modo="crear"
            asignaturaId={asignaturaId}
            temaId={temaId}
          />
        </div>
      </section>

      <section className="mt-8 rounded-2xl bg-white/70 p-4">
        <h2 className="font-titulo text-lg text-black/55">Ajustes del tema</h2>
        <div className="mt-3">
          <SuperadminForm action={actualizarTema} submitLabel="Guardar tema">
            <input type="hidden" name="id" value={tema.id} />
            <input type="hidden" name="asignatura_id" value={asignaturaId} />
            <Field label="Nombre" name="nombre" required defaultValue={tema.nombre} />
            <Field
              label="Orden"
              name="orden"
              type="number"
              defaultValue={String(tema.orden)}
            />
          </SuperadminForm>
        </div>
      </section>
    </div>
  );
}
