"use server";

import { cookies } from "next/headers";
import { hoyMadridISO } from "@/lib/fecha-madrid";
import { getNinoActivoValidado } from "@/lib/juego/nino";

const COOKIE_CATCHUP = "solete_catchup_dia";

/**
 * Catch-up con sesión del usuario (medallas/premios ya merecidos).
 * Llamar desde el cliente tras el primer paint; máx. 1 vez/día por niño.
 */
export async function ejecutarCatchupPremiosSiToca(): Promise<{
  ok: boolean;
  hecho: boolean;
}> {
  const nino = await getNinoActivoValidado();
  if (!nino) return { ok: false, hecho: false };

  const jar = await cookies();
  const hoy = hoyMadridISO();
  const marca = `${nino.id.slice(0, 8)}:${hoy}`;
  if (jar.get(COOKIE_CATCHUP)?.value === marca) {
    return { ok: true, hecho: false };
  }

  const { reconciliarPremioPracticaHoy } = await import(
    "@/lib/juego/practica-diaria"
  );
  const { sincronizarMedallasPendientes } = await import(
    "@/lib/juego/medallas"
  );

  await reconciliarPremioPracticaHoy(nino.id, nino.diamantes ?? 0);
  await sincronizarMedallasPendientes(nino.id);

  jar.set(COOKIE_CATCHUP, marca, {
    httpOnly: true,
    sameSite: "lax",
    secure: process.env.NODE_ENV === "production",
    path: "/",
    maxAge: 60 * 60 * 26,
  });

  return { ok: true, hecho: true };
}
