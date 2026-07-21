import type { ModoJuego, TipoPregunta } from "@/types/database";

/** Preguntas objetivo de la misión diaria (reparto entre asignaturas). */
export const MISION_OBJETIVO = 20;
export const PUNTOS_POR_ACIERTO = 10;

/**
 * Estrellas de la misión diaria.
 * - Misión completa (≥20): 12–14 → 1, 15–17 → 2, 18–20 → 3.
 * - Misión corta: mismos umbrales en % (60% / 80% / 100%).
 */
export function calcularEstrellas(aciertos: number, total: number): number {
  if (total <= 0) return 0;

  if (total >= MISION_OBJETIVO) {
    if (aciertos >= 18) return 3;
    if (aciertos >= 15) return 2;
    if (aciertos >= 12) return 1;
    return 0;
  }

  const ratio = aciertos / total;
  if (ratio >= 1) return 3;
  if (ratio >= 0.8) return 2;
  if (ratio >= 0.6) return 1;
  return 0;
}

export function puntosPorAciertos(aciertos: number): number {
  return aciertos * PUNTOS_POR_ACIERTO;
}

export function esRespuestaCorrecta(
  tipo: TipoPregunta,
  respuestaUsuario: unknown,
  respuestaCorrecta: unknown,
): boolean {
  if (tipo === "true_false") {
    const a = normalizarBool(respuestaUsuario);
    const b = normalizarBool(respuestaCorrecta);
    return a !== null && b !== null && a === b;
  }

  if (tipo === "numeric") {
    const a = normalizarNumero(respuestaUsuario);
    const b = normalizarNumero(respuestaCorrecta);
    if (a === null || b === null) return false;
    return a === b;
  }

  return normalizarTexto(respuestaUsuario) === normalizarTexto(respuestaCorrecta);
}

function normalizarBool(valor: unknown): boolean | null {
  if (typeof valor === "boolean") return valor;
  if (valor === "true" || valor === true) return true;
  if (valor === "false" || valor === false) return false;
  if (typeof valor === "string") {
    const t = valor.trim().toLowerCase();
    if (t === "true" || t === "verdadero") return true;
    if (t === "false" || t === "falso") return false;
  }
  return null;
}

function normalizarNumero(valor: unknown): number | null {
  if (typeof valor === "number" && Number.isFinite(valor)) return valor;
  const t = String(valor ?? "")
    .trim()
    .replace(",", ".");
  if (!t) return null;
  const n = Number(t);
  return Number.isFinite(n) ? n : null;
}

function normalizarTexto(valor: unknown): string {
  if (typeof valor === "string") return valor.trim().toLowerCase();
  if (typeof valor === "number" || typeof valor === "boolean") {
    return String(valor).trim().toLowerCase();
  }
  if (valor == null) return "";
  return JSON.stringify(valor).trim().toLowerCase();
}

export function mensajeAnimo(modo: ModoJuego, estrellas: number, aciertos: number, total: number): string {
  if (modo === "mision") {
    if (estrellas >= 3) return "¡Increíble! ¡Tres estrellas!";
    if (estrellas === 2) return "¡Muy bien! ¡Dos estrellas!";
    if (estrellas === 1) return "¡Buen trabajo! ¡Una estrella!";
    if (aciertos > 0) return "¡Sigue practicando, lo vas a conseguir!";
    return "¡Ánimo! La próxima irá mejor.";
  }
  if (total === 0) return "¡Hasta la próxima!";
  if (aciertos === total) return "¡Todo correcto! ¡Eres un crack!";
  if (aciertos > total / 2) return "¡Muy bien! ¡Qué bien lo haces!";
  return "¡Buen esfuerzo! Vuelve cuando quieras.";
}

export function formatearRespuestaCorrecta(tipo: TipoPregunta, respuesta: unknown): string {
  if (tipo === "true_false") {
    return respuesta ? "Verdadero" : "Falso";
  }
  if (tipo === "numeric") {
    return String(normalizarNumero(respuesta) ?? respuesta ?? "");
  }
  if (typeof respuesta === "string") return respuesta;
  return String(respuesta ?? "");
}

/** Tema del que más preguntas salieron (para sesiones.tema_id). */
export function temaPredominante(preguntas: { tema_id: string }[]): string {
  const counts = new Map<string, number>();
  for (const p of preguntas) {
    counts.set(p.tema_id, (counts.get(p.tema_id) ?? 0) + 1);
  }
  let best = preguntas[0]?.tema_id ?? "";
  let bestCount = 0;
  for (const [id, n] of counts) {
    if (n > bestCount) {
      best = id;
      bestCount = n;
    }
  }
  return best;
}

/** Reparte `total` cupos entre `n` partes lo más equitativo posible. */
export function repartirCupos(total: number, n: number): number[] {
  if (n <= 0) return [];
  const base = Math.floor(total / n);
  let resto = total % n;
  const cupos = Array.from({ length: n }, () => base);
  for (let i = 0; i < n && resto > 0; i += 1) {
    cupos[i] += 1;
    resto -= 1;
  }
  return cupos;
}
