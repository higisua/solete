import { redirect } from "next/navigation";
import { ZonaPadresShell } from "@/components/zona-padres/ZonaPadresShell";
import { getFamiliaActual } from "@/lib/familia";
import { tabsZonaPadres } from "@/lib/zona-padres-tabs";
import { tieneAccesoZonaPadres } from "@/lib/zona-padres";

export default async function ZonaPadresLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const familia = await getFamiliaActual();
  if (!familia) {
    redirect("/login");
  }

  const acceso = await tieneAccesoZonaPadres(familia.id);
  if (!acceso) {
    // Sin PIN: solo el contenido de la página (gate), sin tabs.
    return <>{children}</>;
  }

  const tabs = tabsZonaPadres(familia.rol);

  return (
    <ZonaPadresShell tabs={tabs} tituloFamilia={familia.nombre}>
      {children}
    </ZonaPadresShell>
  );
}
