import { notFound } from "next/navigation";
import {
  actualizarTema,
  borrarPregunta,
  requireSuperadmin,
} from "@/app/actions/superadmin";
import { FormularioPregunta } from "@/components/zona-padres/FormularioPregunta";
import { Field, SuperadminForm } from "@/components/zona-padres/SuperadminForm";
import { MigasContenido } from "@/components/zona-padres/MigasContenido";
import { BotonBorrarConfirmado } from "@/components/zona-padres/BotonBorrarConfirmado";
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

  const { data: asignatura } = await supabase
    .from("asignaturas")
    .select("nombre")
    .eq("id", asignaturaId)
    .maybeSingle();

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
      <MigasContenido
        items={[
          { label: "Contenido", href: "/zona-padres/contenido" },
          {
            label: asignatura?.nombre ?? "Asignatura",
            href: `/zona-padres/contenido/${asignaturaId}`,
          },
          { label: tema.nombre },
        ]}
      />
      <h1 className="mt-3 font-titulo text-2xl font-semibold text-sol">
        {tema.nombre}
      </h1>
      <p className="mt-1 font-cuerpo text-sm text-black/50">
        Gestiona las preguntas de este tema
      </p>

      <section className="mt-6">
        <h2 className="font-titulo text-xl font-semibold text-sol">
          Preguntas ({preguntas.length})
        </h2>

        {preguntas.length === 0 ? (
          <p className="mt-3 rounded-[22px] bg-limon/30 px-4 py-3 font-cuerpo text-sm text-black/70">
            Todavía no hay preguntas. Usa el formulario de abajo para crear la
            primera.
          </p>
        ) : (
          <ul className="mt-3 flex flex-col gap-3">
            {preguntas.map((p) => (
              <li
                key={p.id}
                className="rounded-[22px] bg-white p-4 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.25)]"
              >
                <p className="font-titulo text-[11px] font-semibold uppercase tracking-wide text-black/40">
                  {etiquetaTipo(p.tipo)} · dificultad {p.dificultad}
                </p>
                <p className="mt-1 font-titulo text-lg font-semibold leading-snug text-sol">
                  {p.enunciado}
                </p>
                <details className="mt-3 group">
                  <summary className="cursor-pointer list-none font-titulo text-sm font-semibold text-mar marker:content-none [&::-webkit-details-marker]:hidden">
                    <span className="underline-offset-2 group-open:no-underline">
                      Editar pregunta
                    </span>
                  </summary>
                  <div className="mt-3 border-t border-black/[0.06] pt-3">
                    <FormularioPregunta
                      modo="editar"
                      asignaturaId={asignaturaId}
                      temaId={temaId}
                      pregunta={p}
                    />
                  </div>
                </details>
                <div className="mt-3">
                  <BotonBorrarConfirmado
                    action={borrarPregunta.bind(
                      null,
                      p.id,
                      asignaturaId,
                      temaId,
                    )}
                    confirmar="¿Borrar esta pregunta?"
                  >
                    Borrar pregunta
                  </BotonBorrarConfirmado>
                </div>
              </li>
            ))}
          </ul>
        )}
      </section>

      <section className="mt-8 rounded-[22px] border-2 border-sol/25 bg-white p-4 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.25)]">
        <h2 className="font-titulo text-xl font-semibold text-sol">
          Nueva pregunta
        </h2>
        <p className="mt-1 font-cuerpo text-sm text-black/50">
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

      <section className="mt-8 rounded-[22px] bg-white/80 p-4 shadow-[0_8px_22px_-14px_rgba(216,90,48,0.2)]">
        <h2 className="font-titulo text-lg font-semibold text-black/50">
          Ajustes del tema
        </h2>
        <div className="mt-3">
          <SuperadminForm action={actualizarTema} submitLabel="Guardar tema">
            <input type="hidden" name="id" value={tema.id} />
            <input type="hidden" name="asignatura_id" value={asignaturaId} />
            <Field
              label="Nombre"
              name="nombre"
              required
              defaultValue={tema.nombre}
            />
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
