/** Zona horaria civil de Solete (misión diaria + racha). */
export const ZONA_SOLETE = "Europe/Madrid";

/**
 * Día civil YYYY-MM-DD en Europe/Madrid.
 * A las 23:00 en España sigue siendo "hoy" español, aunque en UTC sea el día siguiente.
 */
export function hoyMadridISO(ahora: Date = new Date()): string {
  return fechaEnZonaISO(ZONA_SOLETE, ahora);
}

/** Día civil de ayer respecto al "hoy" de Europe/Madrid. */
export function ayerMadridISO(ahora: Date = new Date()): string {
  return sumarDiasCiviles(hoyMadridISO(ahora), -1);
}

export function fechaEnZonaISO(timeZone: string, fecha: Date = new Date()): string {
  // en-CA → YYYY-MM-DD
  return new Intl.DateTimeFormat("en-CA", {
    timeZone,
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).format(fecha);
}

/** Aritmética sobre fechas civiles YYYY-MM-DD (sin DST raro). */
export function sumarDiasCiviles(ymd: string, dias: number): string {
  const [y, m, d] = ymd.split("-").map(Number);
  const utc = new Date(Date.UTC(y, m - 1, d + dias));
  const yy = utc.getUTCFullYear();
  const mm = String(utc.getUTCMonth() + 1).padStart(2, "0");
  const dd = String(utc.getUTCDate()).padStart(2, "0");
  return `${yy}-${mm}-${dd}`;
}
