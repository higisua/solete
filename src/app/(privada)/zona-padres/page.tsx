import { redirect } from "next/navigation";
import { PinGate } from "@/components/zona-padres/PinGate";
import { getFamiliaActual } from "@/lib/familia";
import { tieneAccesoZonaPadres } from "@/lib/zona-padres";

export default async function ZonaPadresIndexPage() {
  const familia = await getFamiliaActual();
  if (!familia) {
    redirect("/login");
  }

  if (await tieneAccesoZonaPadres(familia.id)) {
    redirect("/zona-padres/hijos");
  }

  return <PinGate />;
}
