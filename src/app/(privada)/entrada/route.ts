import { NextResponse } from "next/server";
import { getNinosDeMiFamilia } from "@/lib/familia";
import {
  COOKIE_NINO_ACTIVO,
  opcionesCookieNino,
} from "@/lib/nino-activo";

/**
 * Tras login / alta: decide a dónde ir según cuántos niños hay.
 * Usa Route Handler para poder escribir la cookie del niño activo.
 */
export async function GET(request: Request) {
  const ninos = await getNinosDeMiFamilia();
  const origen = new URL(request.url);

  if (ninos.length === 0) {
    return NextResponse.redirect(new URL("/familia", origen));
  }

  if (ninos.length === 1) {
    const res = NextResponse.redirect(new URL("/mundo", origen));
    res.cookies.set(COOKIE_NINO_ACTIVO, ninos[0].id, opcionesCookieNino);
    return res;
  }

  return NextResponse.redirect(new URL("/quien-juega", origen));
}
