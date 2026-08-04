import { crearAsignatura, requireSuperadmin } from "@/app/actions/superadmin";
import { Field, SuperadminForm } from "@/components/zona-padres/SuperadminForm";
import { SelectorEmojiAsignatura } from "@/components/zona-padres/SelectorEmojiAsignatura";
import { MigasContenido } from "@/components/zona-padres/MigasContenido";

export default async function NuevaAsignaturaPage() {
  await requireSuperadmin();

  return (
    <div>
      <MigasContenido
        items={[
          { label: "Contenido", href: "/zona-padres/contenido" },
          { label: "Nueva asignatura" },
        ]}
      />
      <h1 className="mt-3 font-titulo text-2xl font-semibold text-sol">
        Nueva asignatura
      </h1>
      <div className="mt-6 rounded-[22px] bg-white p-4 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.25)]">
        <SuperadminForm action={crearAsignatura} submitLabel="Crear">
          <Field
            label="Nombre"
            name="nombre"
            required
            placeholder="Matemáticas"
          />
          <SelectorEmojiAsignatura defaultValue="📚" />
          <label className="block w-full">
            <span className="mb-1.5 block font-titulo text-base font-semibold text-sol">
              Curso
            </span>
            <select
              name="curso"
              required
              className="min-h-12 w-full rounded-2xl border-2 border-sol-claro/55 bg-white px-4 font-cuerpo text-base outline-none transition focus:border-sol focus:shadow-[0_0_0_3px_rgba(216,90,48,0.12)]"
              defaultValue="1"
            >
              <option value="1">1º primaria</option>
              <option value="2">2º primaria</option>
              <option value="3">3º primaria (extrema de 2º)</option>
            </select>
          </label>
        </SuperadminForm>
      </div>
    </div>
  );
}
