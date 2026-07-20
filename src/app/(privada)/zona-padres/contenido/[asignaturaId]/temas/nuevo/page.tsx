import Link from "next/link";
import { crearTema, requireSuperadmin } from "@/app/actions/superadmin";
import { Field, SuperadminForm } from "@/components/zona-padres/SuperadminForm";

type Props = { params: Promise<{ asignaturaId: string }> };

export default async function NuevoTemaPage({ params }: Props) {
  await requireSuperadmin();
  const { asignaturaId } = await params;

  return (
    <div>
      <Link
        href={`/zona-padres/contenido/${asignaturaId}`}
        className="text-sm font-semibold text-mar"
      >
        ← Volver
      </Link>
      <h1 className="mt-3 font-titulo text-2xl font-semibold text-sol">Nuevo tema</h1>
      <div className="mt-6">
        <SuperadminForm action={crearTema} submitLabel="Crear tema">
          <input type="hidden" name="asignatura_id" value={asignaturaId} />
          <Field label="Nombre" name="nombre" required placeholder="Sumas hasta 10" />
          <Field label="Orden" name="orden" type="number" defaultValue="1" />
        </SuperadminForm>
      </div>
    </div>
  );
}
