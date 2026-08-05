import { redirect } from "next/navigation";
import { MedallasVista } from "@/components/medallas/MedallasVista";
import { getNinoActivoValidado } from "@/lib/juego";
import { getMedallasVista } from "@/lib/juego/medallas-vista";

export default async function MedallasPage() {
  const nino = await getNinoActivoValidado();
  if (!nino) {
    redirect("/entrada");
  }

  const data = await getMedallasVista(nino.id);

  return (
    <MedallasVista
      conseguidas={data.conseguidas}
      total={data.total}
      items={data.items}
    />
  );
}
