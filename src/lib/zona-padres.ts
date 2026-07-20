import { createHmac, timingSafeEqual } from "crypto";
import { cookies } from "next/headers";

export const COOKIE_ZONA_PADRES = "solete_zona_padres";

const MAX_AGE_MS = 1000 * 60 * 60 * 2; // 2 horas

function secreto(): string {
  return (
    process.env.ZONA_PADRES_SECRET?.trim() ||
    `${process.env.NEXT_PUBLIC_SUPABASE_URL ?? ""}:${process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ?? "solete-dev"}`
  );
}

function firmar(payload: string): string {
  return createHmac("sha256", secreto()).update(payload).digest("hex");
}

/** Token httpOnly firmado: familiaId.exp.firma — no lleva el PIN ni el hash. */
export function crearTokenZonaPadres(familiaId: string): string {
  const exp = Date.now() + MAX_AGE_MS;
  const payload = `${familiaId}.${exp}`;
  return `${payload}.${firmar(payload)}`;
}

export function verificarTokenZonaPadres(
  token: string | undefined,
  familiaIdEsperada: string,
): boolean {
  if (!token) return false;
  const partes = token.split(".");
  if (partes.length !== 3) return false;
  const [familiaId, expStr, firma] = partes;
  if (familiaId !== familiaIdEsperada) return false;
  const exp = Number(expStr);
  if (!Number.isFinite(exp) || Date.now() > exp) return false;

  const payload = `${familiaId}.${expStr}`;
  const esperada = firmar(payload);
  try {
    const a = Buffer.from(firma);
    const b = Buffer.from(esperada);
    if (a.length !== b.length) return false;
    return timingSafeEqual(a, b);
  } catch {
    return false;
  }
}

export async function setAccesoZonaPadres(familiaId: string): Promise<void> {
  const jar = await cookies();
  jar.set(COOKIE_ZONA_PADRES, crearTokenZonaPadres(familiaId), {
    httpOnly: true,
    sameSite: "lax",
    secure: process.env.NODE_ENV === "production",
    path: "/",
    maxAge: Math.floor(MAX_AGE_MS / 1000),
  });
}

export async function clearAccesoZonaPadres(): Promise<void> {
  const jar = await cookies();
  jar.delete(COOKIE_ZONA_PADRES);
}

export async function tieneAccesoZonaPadres(familiaId: string): Promise<boolean> {
  const jar = await cookies();
  return verificarTokenZonaPadres(jar.get(COOKIE_ZONA_PADRES)?.value, familiaId);
}
