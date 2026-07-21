"use server";

import { redirect } from "next/navigation";
import { getNinosDeMiFamilia } from "@/lib/familia";
import { getNinoDeMiFamilia } from "@/lib/juego";
import { clearNinoActivoId, setNinoActivoId } from "@/lib/nino-activo";

/**
 * Tras login / alta: decide a dónde ir según cuántos niños hay.
 * Preferible GET /entrada (Route Handler) tras login; esta action
 * sirve si se invoca explícitamente como Server Action.
 */
export async function resolverEntradaJuego(): Promise<never> {
  redirect("/entrada");
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
