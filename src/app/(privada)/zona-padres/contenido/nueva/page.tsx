import Link from "next/link";
import { crearAsignatura, requireSuperadmin } from "@/app/actions/superadmin";
import { Field, SuperadminForm } from "@/components/zona-padres/SuperadminForm";
import { SelectorEmojiAsignatura } from "@/components/zona-padres/SelectorEmojiAsignatura";

export default async function NuevaAsignaturaPage() {
  await requireSuperadmin();

  return (
    <div>
      <Link href="/zona-padres/contenido" className="text-sm font-semibold text-mar">
        ← Volver
      </Link>
      <h1 className="mt-3 font-titulo text-2xl font-semibold text-sol">
        Nueva asignatura
      </h1>
      <div className="mt-6">
        <SuperadminForm action={crearAsignatura} submitLabel="Crear">
          <Field label="Nombre" name="nombre" required placeholder="Matemáticas" />
          <SelectorEmojiAsignatura defaultValue="📚" />
          <label className="block">
            <span className="mb-1.5 block font-titulo text-base text-sol">Curso</span>
            <select
              name="curso"
              required
              className="min-h-12 w-full rounded-2xl border-2 border-sol-claro/60 bg-white px-4"
              defaultValue="1"
            >
              <option value="1">1º primaria</option>
              <option value="2">2º primaria</option>
            </select>
          </label>
        </SuperadminForm>
      </div>
    </div>
  );
}
