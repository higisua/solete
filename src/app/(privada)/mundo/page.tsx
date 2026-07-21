import { redirect } from "next/navigation";
import { cambiarDeNino } from "@/app/actions/juego";
import { MundoVista } from "@/components/mundo/MundoVista";
import { getNinosDeMiFamilia } from "@/lib/familia";
import {
  getAsignaturasPorCurso,
  getNinoActivoValidado,
  getTotalesProgreso,
} from "@/lib/juego";
import { AVATARES } from "@/lib/avatares";
import { publicAsset } from "@/lib/public-asset";

export default async function MundoPage() {
  let nino = await getNinoActivoValidado();

  if (!nino) {
    const ninos = await getNinosDeMiFamilia();
    if (ninos.length === 0) {
      redirect("/familia");
    }
    if (ninos.length === 1) {
      // Fija cookie en Route Handler (no se puede desde un Server Component)
      redirect("/entrada");
    } else {
      redirect("/quien-juega");
    }
  }

  const [asignaturas, totales, hermanos] = await Promise.all([
    getAsignaturasPorCurso(nino.curso),
    getTotalesProgreso(nino.id),
    getNinosDeMiFamilia(),
  ]);

  const avatarMeta = AVATARES.find((a) => a.id === nino.avatar);

  return (
    <MundoVista
      nombre={nino.nombre}
      curso={nino.curso}
      avatarSrc={
        avatarMeta
          ? publicAsset(`assets/avatares/${avatarMeta.id}`)
          : null
      }
      avatarAlt={avatarMeta?.nombre ?? nino.nombre}
      iniciales={nino.nombre.slice(0, 1)}
      estrellas={totales.estrellas}
      puntos={totales.puntos}
      racha={nino.racha_dias ?? 0}
      mostrarCambiarJugador={hermanos.length > 1}
      cambiarJugadorAction={cambiarDeNino}
      asignaturas={asignaturas.map((a) => ({
        id: a.id,
        nombre: a.nombre,
        icono: a.icono,
      }))}
    />
  );
}
