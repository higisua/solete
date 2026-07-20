import { cookies } from "next/headers";

/** Nombre de la cookie con el niño activo en la sesión de juego. */
export const COOKIE_NINO_ACTIVO = "solete_nino_activo";

const MAX_AGE_SECONDS = 60 * 60 * 24 * 30; // 30 días

export async function getNinoActivoId(): Promise<string | null> {
  const jar = await cookies();
  return jar.get(COOKIE_NINO_ACTIVO)?.value ?? null;
}

export async function setNinoActivoId(ninoId: string): Promise<void> {
  const jar = await cookies();
  jar.set(COOKIE_NINO_ACTIVO, ninoId, {
    httpOnly: true,
    sameSite: "lax",
    secure: process.env.NODE_ENV === "production",
    path: "/",
    maxAge: MAX_AGE_SECONDS,
  });
}

export async function clearNinoActivoId(): Promise<void> {
  const jar = await cookies();
  jar.delete(COOKIE_NINO_ACTIVO);
}
