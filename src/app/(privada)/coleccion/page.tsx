import { redirect } from "next/navigation";
import { ColeccionAlbum } from "@/components/cromos/ColeccionAlbum";
import { getNinoActivoValidado } from "@/lib/juego";
import { getColeccionVista } from "@/lib/juego/cromos";

export default async function ColeccionPage() {
  const nino = await getNinoActivoValidado();
  if (!nino) {
    redirect("/entrada");
  }

  const coleccion = await getColeccionVista(nino.id);
  if (!coleccion) {
    redirect("/entrada");
  }

  return <ColeccionAlbum coleccion={coleccion} />;
}
