"use server";

import { redirect } from "next/navigation";
import { getNinosDeMiFamilia } from "@/lib/familia";
import { getNinoDeMiFamilia } from "@/lib/juego";
import { clearNinoActivoId, setNinoActivoId } from "@/lib/nino-activo";

/**
 * Tras login / alta: decide a dónde ir según cuántos niños hay.
 * - 0 → /familia (alta o vacío)
 * - 1 → fija cookie y /mundo
 * - 2+ → /quien-juega
 */
export async function resolverEntradaJuego(): Promise<never> {
  const ninos = await getNinosDeMiFamilia();

  if (ninos.length === 0) {
    redirect("/familia");
  }

  if (ninos.length === 1) {
    await setNinoActivoId(ninos[0].id);
    redirect("/mundo");
  }

  redirect("/quien-juega");
}

export async function seleccionarNino(
  ninoId: string,
  _formData?: FormData,
): Promise<void> {
  const nino = await getNinoDeMiFamilia(ninoId);
  if (!nino) {
    redirect("/quien-juega");
  }

  await setNinoActivoId(nino.id);
  redirect("/mundo");
}

export async function cambiarDeNino(): Promise<never> {
  await clearNinoActivoId();
  const ninos = await getNinosDeMiFamilia();
  if (ninos.length <= 1) {
    redirect("/mundo");
  }
  redirect("/quien-juega");
}
