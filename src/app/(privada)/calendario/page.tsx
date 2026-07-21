import { redirect } from "next/navigation";
import { CalendarioVista } from "@/components/calendario/CalendarioVista";
import { hoyMadridISO } from "@/lib/fecha-madrid";
import { getNinoActivoValidado } from "@/lib/juego";
import {
  mesActualMadrid,
  parseMesParam,
} from "@/lib/juego/calendario";
import { getMisionesCompletadasDelMes } from "@/lib/juego/calendario-datos";

type Props = {
  searchParams: Promise<{ mes?: string }>;
};

export default async function CalendarioPage({ searchParams }: Props) {
  const nino = await getNinoActivoValidado();
  if (!nino) {
    redirect("/entrada");
  }

  const params = await searchParams;
  const mesMaximo = mesActualMadrid();
  const mes = parseMesParam(params.mes, mesMaximo);
  const misiones = await getMisionesCompletadasDelMes(nino.id, mes);

  return (
    <CalendarioVista
      mes={mes}
      mesMaximo={mesMaximo}
      hoyISO={hoyMadridISO()}
      misiones={misiones}
    />
  );
}
