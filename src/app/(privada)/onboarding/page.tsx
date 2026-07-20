import { NinoForm } from "@/components/NinoForm";
import { AVATARES } from "@/lib/avatares";
import { publicAsset } from "@/lib/public-asset";

export default function OnboardingPage() {
  const avatares = AVATARES.map((a) => ({
    id: a.id,
    nombre: a.nombre,
    src: publicAsset(`assets/avatares/${a.id}`),
  }));

  return (
    <main className="min-h-dvh">
      <NinoForm
        titulo="¡Tu primer perfil!"
        submitLabel="Crear perfil"
        siguiente="/entrada"
        avatares={avatares}
      />
    </main>
  );
}
