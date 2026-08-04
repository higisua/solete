import { redirect } from "next/navigation";
import { cambiarDeNino } from "@/app/actions/juego";
import { MundoVista } from "@/components/mundo/MundoVista";
import { getNinosDeMiFamilia } from "@/lib/familia";
import {
  getNinoActivoValidado,
  getResumenMisionHoy,
  getTotalesProgreso,
} from "@/lib/juego";
import { AVATARES } from "@/lib/avatares";
import { publicAsset } from "@/lib/public-asset";

export default async function MundoPage() {
  const nino = await getNinoActivoValidado();

  if (!nino) {
    const ninos = await getNinosDeMiFamilia();
    if (ninos.length === 0) {
      redirect("/familia");
    }
    if (ninos.length === 1) {
      redirect("/entrada");
    } else {
      redirect("/quien-juega");
    }
  }

  const [totales, hermanos, misionHoy] = await Promise.all([
    getTotalesProgreso(nino.id),
    getNinosDeMiFamilia(),
    getResumenMisionHoy(nino.id),
  ]);

  const avatarMeta = AVATARES.find((a) => a.id === nino.avatar);

  return (
    <MundoVista
      nombre={nino.nombre}
      curso={nino.curso}
      avatarSrc={
        avatarMeta ? publicAsset(`assets/avatares/${avatarMeta.id}`) : null
      }
      avatarAlt={avatarMeta?.nombre ?? nino.nombre}
      iniciales={nino.nombre.slice(0, 1)}
      estrellas={totales.estrellas}
      diamantes={totales.puntos}
      rachaDias={nino.racha_dias ?? 0}
      misionCompletadaHoy={misionHoy.completada}
      estrellasHoy={misionHoy.estrellasHoy}
      mostrarCambiarJugador={hermanos.length > 1}
      cambiarJugadorAction={cambiarDeNino}
    />
  );
}
