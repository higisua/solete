import { crearTema, requireSuperadmin } from "@/app/actions/superadmin";
import { Field, SuperadminForm } from "@/components/zona-padres/SuperadminForm";
import { MigasContenido } from "@/components/zona-padres/MigasContenido";
import { createClient } from "@/lib/supabase/server";

type Props = { params: Promise<{ asignaturaId: string }> };

export default async function NuevoTemaPage({ params }: Props) {
  await requireSuperadmin();
  const { asignaturaId } = await params;

  const supabase = await createClient();
  const { data: asignatura } = await supabase
    .from("asignaturas")
    .select("nombre")
    .eq("id", asignaturaId)
    .maybeSingle();

  return (
    <div>
      <MigasContenido
        items={[
          { label: "Contenido", href: "/zona-padres/contenido" },
          {
            label: asignatura?.nombre ?? "Asignatura",
            href: `/zona-padres/contenido/${asignaturaId}`,
          },
          { label: "Nuevo tema" },
        ]}
      />
      <h1 className="mt-3 font-titulo text-2xl font-semibold text-sol">
        Nuevo tema
      </h1>
      <div className="mt-6 rounded-[22px] bg-white p-4 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.25)]">
        <SuperadminForm action={crearTema} submitLabel="Crear tema">
          <input type="hidden" name="asignatura_id" value={asignaturaId} />
          <Field
            label="Nombre"
            name="nombre"
            required
            placeholder="Sumas hasta 10"
          />
          <Field label="Orden" name="orden" type="number" defaultValue="1" />
        </SuperadminForm>
      </div>
    </div>
  );
}
