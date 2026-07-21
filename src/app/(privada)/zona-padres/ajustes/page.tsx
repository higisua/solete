import { requireZonaPadres } from "@/app/actions/zona-padres";
import { AjustesForm } from "@/components/zona-padres/AjustesForm";

export default async function AjustesPage() {
  const familia = await requireZonaPadres();

  return (
    <div>
      <h1 className="font-titulo text-2xl font-semibold text-sol">Ajustes</h1>
      <p className="mt-1 font-cuerpo text-sm text-black/50">
        Familia, PIN y sesión
      </p>
      <div className="mt-6">
        <AjustesForm nombreFamilia={familia.nombre} />
      </div>
    </div>
  );
}
