import { hoyMadridISO, sumarDiasCiviles } from "@/lib/fecha-madrid";

export type DiaMisionCalendario = {
  fecha: string;
  estrellas: number;
};

export type MesCivil = {
  year: number;
  month: number; // 1–12
};

/** Mes civil actual en Europe/Madrid. */
export function mesActualMadrid(ahora: Date = new Date()): MesCivil {
  const hoy = hoyMadridISO(ahora);
  const [y, m] = hoy.split("-").map(Number);
  return { year: y, month: m };
}

/** Parsea `YYYY-MM` o `YYYY-M`; si inválido, mes actual. */
export function parseMesParam(
  raw: string | undefined,
  tope: MesCivil = mesActualMadrid(),
): MesCivil {
  if (!raw || !/^\d{4}-\d{1,2}$/.test(raw)) return tope;
  const [y, m] = raw.split("-").map(Number);
  if (m < 1 || m > 12) return tope;
  const candidato = { year: y, month: m };
  if (compararMes(candidato, tope) > 0) return tope;
  return candidato;
}

/** -1 si a < b, 0 si igual, 1 si a > b */
export function compararMes(a: MesCivil, b: MesCivil): number {
  if (a.year !== b.year) return a.year < b.year ? -1 : 1;
  if (a.month !== b.month) return a.month < b.month ? -1 : 1;
  return 0;
}

export function mesAnterior(mes: MesCivil): MesCivil {
  if (mes.month === 1) return { year: mes.year - 1, month: 12 };
  return { year: mes.year, month: mes.month - 1 };
}

export function mesSiguiente(mes: MesCivil): MesCivil {
  if (mes.month === 12) return { year: mes.year + 1, month: 1 };
  return { year: mes.year, month: mes.month + 1 };
}

export function mesAParam(mes: MesCivil): string {
  return `${mes.year}-${String(mes.month).padStart(2, "0")}`;
}

export function nombreMesEs(mes: MesCivil): string {
  const d = new Date(Date.UTC(mes.year, mes.month - 1, 1));
  const nombre = new Intl.DateTimeFormat("es-ES", {
    month: "long",
    timeZone: "UTC",
  }).format(d);
  return nombre.charAt(0).toUpperCase() + nombre.slice(1);
}

/** Primer día del mes como YYYY-MM-DD. */
export function inicioMesISO(mes: MesCivil): string {
  return `${mes.year}-${String(mes.month).padStart(2, "0")}-01`;
}

/** Último día del mes como YYYY-MM-DD. */
export function finMesISO(mes: MesCivil): string {
  const d = new Date(Date.UTC(mes.year, mes.month, 0));
  const dd = String(d.getUTCDate()).padStart(2, "0");
  return `${mes.year}-${String(mes.month).padStart(2, "0")}-${dd}`;
}

/**
 * Celdas del calendario: lunes = primera columna.
 * `dia` null = hueco del mes anterior/siguiente.
 */
export type CeldaCalendario = {
  dia: number | null;
  fecha: string | null;
};

export function celdasMes(mes: MesCivil): CeldaCalendario[] {
  const [y, m] = [mes.year, mes.month];
  const dowDomingo = new Date(Date.UTC(y, m - 1, 1)).getUTCDay();
  const offsetLunes = (dowDomingo + 6) % 7;
  const ultimo = Number(finMesISO(mes).slice(8, 10));

  const celdas: CeldaCalendario[] = [];
  for (let i = 0; i < offsetLunes; i += 1) {
    celdas.push({ dia: null, fecha: null });
  }
  for (let d = 1; d <= ultimo; d += 1) {
    const fecha = `${y}-${String(m).padStart(2, "0")}-${String(d).padStart(2, "0")}`;
    celdas.push({ dia: d, fecha });
  }
  while (celdas.length % 7 !== 0) {
    celdas.push({ dia: null, fecha: null });
  }
  return celdas;
}

export { sumarDiasCiviles };
