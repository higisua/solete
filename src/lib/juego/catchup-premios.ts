import { after } from "next/server";
import { cookies } from "next/headers";
import { hoyMadridISO } from "@/lib/fecha-madrid";

const COOKIE_CATCHUP = "solete_catchup_dia";

/**
 * Programa reconciliación de premios/medallas DESPUÉS de enviar la respuesta.
 * Como máximo una vez por día Madrid y niño (cookie), para no frenar navegación.
 */
export function programarCatchupPremios(
  ninoId: string,
  diamantesActuales: number,
): void {
  after(async () => {
    try {
      const jar = await cookies();
      const hoy = hoyMadridISO();
      const marca = `${ninoId.slice(0, 8)}:${hoy}`;
      if (jar.get(COOKIE_CATCHUP)?.value === marca) return;

      const { reconciliarPremioPracticaHoy } = await import(
        "@/lib/juego/practica-diaria"
      );
      const { sincronizarMedallasPendientes } = await import(
        "@/lib/juego/medallas"
      );

      await reconciliarPremioPracticaHoy(ninoId, diamantesActuales);
      await sincronizarMedallasPendientes(ninoId);

      jar.set(COOKIE_CATCHUP, marca, {
        httpOnly: true,
        sameSite: "lax",
        secure: process.env.NODE_ENV === "production",
        path: "/",
        maxAge: 60 * 60 * 26,
      });
    } catch (err) {
      console.warn("[catchup] premios:", err);
    }
  });
}
