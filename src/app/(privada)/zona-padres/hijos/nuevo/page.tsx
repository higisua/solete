import Link from "next/link";
import { ChevronLeft } from "lucide-react";
import { requireZonaPadres } from "@/app/actions/zona-padres";
import { FormularioNinoPadres } from "@/components/zona-padres/FormularioNinoPadres";
import { AVATARES } from "@/lib/avatares";
import { publicAsset } from "@/lib/public-asset";

export default async function NuevoHijoPage() {
  await requireZonaPadres();
  const avatares = AVATARES.map((a) => ({
    id: a.id,
    nombre: a.nombre,
    src: publicAsset(`assets/avatares/${a.id}`),
  }));

  return (
    <div>
      <Link
        href="/zona-padres/hijos"
        className="inline-flex items-center gap-1 font-titulo text-sm font-semibold text-mar"
      >
        <ChevronLeft className="h-4 w-4 stroke-[2]" aria-hidden />
        Volver
      </Link>
      <h1 className="mt-3 font-titulo text-2xl font-semibold text-sol">
        Nuevo perfil
      </h1>
      <div className="mt-6">
        <FormularioNinoPadres modo="crear" avatares={avatares} />
      </div>
    </div>
  );
}
