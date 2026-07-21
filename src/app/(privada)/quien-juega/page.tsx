import { redirect } from "next/navigation";
import { seleccionarNino } from "@/app/actions/juego";
import { QuienJuegaVista } from "@/components/quien-juega/QuienJuegaVista";
import { getNinosDeMiFamilia } from "@/lib/familia";
import { AVATARES } from "@/lib/avatares";
import { publicAsset } from "@/lib/public-asset";

export default async function QuienJuegaPage() {
  const ninos = await getNinosDeMiFamilia();

  if (ninos.length === 0) {
    redirect("/familia");
  }

  if (ninos.length === 1) {
    redirect("/entrada");
  }

  return (
    <QuienJuegaVista
      ninos={ninos.map((nino) => {
        const avatarMeta = AVATARES.find((a) => a.id === nino.avatar);
        return {
          id: nino.id,
          nombre: nino.nombre,
          avatarSrc: avatarMeta
            ? publicAsset(`assets/avatares/${avatarMeta.id}`)
            : null,
          avatarAlt: avatarMeta?.nombre ?? nino.nombre,
          iniciales: nino.nombre.slice(0, 1),
          action: seleccionarNino.bind(null, nino.id),
        };
      })}
    />
  );
}
