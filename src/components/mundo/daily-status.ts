/**
 * Mensajes dinámicos de la home (Fase 6 · Mundo de Solete).
 * Máximo dos líneas. Sin lógica de juego nueva.
 */

import type { SoleteMood } from "@/components/solete/moods";

export type DailyStatusInput = {
  nombre: string;
  misionCompletadaHoy: boolean;
  rachaDias: number;
};

export type DailyStatusResult = {
  greeting: string;
  message: string;
  mood: SoleteMood;
};

const SALUDOS = [
  (nombre: string) => `¡Hola ${nombre}!`,
  (nombre: string) => `¡Hola, ${nombre}!`,
  () => "¡Qué bien verte!",
] as const;

/**
 * Elige saludo + mensaje corto según el día del niño.
 */
export function resolverDailyStatus(input: DailyStatusInput): DailyStatusResult {
  const { nombre, misionCompletadaHoy, rachaDias } = input;

  // Variación ligera estable por longitud del nombre (sin random en SSR/CSR mismatch).
  const saludoFn = SALUDOS[nombre.length % SALUDOS.length]!;
  const greeting = saludoFn(nombre);

  if (misionCompletadaHoy) {
    if (rachaDias >= 2) {
      return {
        greeting,
        message: `¡Llevas ${rachaDias} días aprendiendo!\n¡Buen trabajo! Descansa hasta mañana.`,
        mood: "love",
      };
    }
    return {
      greeting,
      message: "¡Buen trabajo! Descansa hasta mañana.",
      mood: "sleep",
    };
  }

  if (rachaDias >= 2) {
    return {
      greeting,
      message: `¡Llevas ${rachaDias} días aprendiendo!\n¡Vamos a comenzar la aventura!`,
      mood: "wave",
    };
  }

  return {
    greeting,
    message: "¡Vamos a comenzar la aventura!",
    mood: "happy",
  };
}
