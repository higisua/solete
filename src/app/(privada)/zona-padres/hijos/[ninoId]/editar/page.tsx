import Link from "next/link";
import { notFound } from "next/navigation";
import { requireZonaPadres } from "@/app/actions/zona-padres";
import { FormularioNinoPadres } from "@/components/zona-padres/FormularioNinoPadres";
import { getNinosDeMiFamilia } from "@/lib/familia";
import { AVATARES } from "@/lib/avatares";
import { publicAsset } from "@/lib/public-asset";

type Props = { params: Promise<{ ninoId: string }> };

export default async function EditarHijoPage({ params }: Props) {
  await requireZonaPadres();
  const { ninoId } = await params;
  const ninos = await getNinosDeMiFamilia();
  const nino = ninos.find((n) => n.id === ninoId);
  if (!nino) notFound();

  const avatares = AVATARES.map((a) => ({
    id: a.id,
    nombre: a.nombre,
    src: publicAsset(`assets/avatares/${a.id}`),
  }));

  return (
    <div>
      <Link href="/zona-padres/hijos" className="text-sm font-semibold text-mar">
        ← Volver
      </Link>
      <h1 className="mt-3 font-titulo text-2xl font-semibold text-sol">
        Editar {nino.nombre}
      </h1>
      <div className="mt-6">
        <FormularioNinoPadres modo="editar" nino={nino} avatares={avatares} />
      </div>
    </div>
  );
}
