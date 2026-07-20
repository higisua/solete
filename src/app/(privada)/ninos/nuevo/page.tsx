import { NinoForm } from "@/components/NinoForm";
import { AVATARES } from "@/lib/avatares";
import { publicAsset } from "@/lib/public-asset";

export default function NuevoNinoPage() {
  const avatares = AVATARES.map((a) => ({
    id: a.id,
    nombre: a.nombre,
    src: publicAsset(`assets/avatares/${a.id}`),
  }));

  return (
    <main className="min-h-dvh">
      <NinoForm
        titulo="Añadir niño o niña"
        submitLabel="Guardar perfil"
        siguiente="/entrada"
        avatares={avatares}
      />
    </main>
  );
}
