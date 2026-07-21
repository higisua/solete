import { redirect } from "next/navigation";
import { TiendaCromos } from "@/components/cromos/TiendaCromos";
import { getNinoActivoValidado } from "@/lib/juego";
import { getColeccionVista } from "@/lib/juego/cromos";

export default async function TiendaPage() {
  const nino = await getNinoActivoValidado();
  if (!nino) {
    redirect("/entrada");
  }

  const coleccion = await getColeccionVista(nino.id);
  if (!coleccion) {
    redirect("/entrada");
  }

  return <TiendaCromos coleccion={coleccion} />;
}
