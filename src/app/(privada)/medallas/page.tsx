import { redirect } from "next/navigation";
import { MedallasVista } from "@/components/medallas/MedallasVista";
import { getNinoActivoValidado } from "@/lib/juego";
import { programarCatchupPremios } from "@/lib/juego/catchup-premios";
import { getMedallasVista } from "@/lib/juego/medallas-vista";

export default async function MedallasPage() {
  const nino = await getNinoActivoValidado();
  if (!nino) {
    redirect("/entrada");
  }

  programarCatchupPremios(nino.id, nino.diamantes ?? 0);

  const data = await getMedallasVista(nino.id);

  return (
    <MedallasVista
      conseguidas={data.conseguidas}
      total={data.total}
      items={data.items}
    />
  );
}
