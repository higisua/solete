/** Emojis elegibles para asignaturas (se guardan tal cual en `icono`). */
export const EMOJIS_ASIGNATURA = [
  "📚",
  "📖",
  "➕",
  "🔢",
  "🧮",
  "🔤",
  "✏️",
  "🌱",
  "🔬",
  "🌍",
  "🎨",
  "🎵",
  "⚽",
  "🧩",
  "⭐",
  "🧠",
  "🗣️",
  "📝",
] as const;

const LEGACY_TEXTO_A_EMOJI: Record<string, string> = {
  calculadora: "🔢",
  libro: "📖",
  ciencia: "🌍",
  arte: "🎨",
  deporte: "⚽",
  estrella: "⭐",
  mate: "🔢",
  leng: "📖",
};

/**
 * Valor a mostrar en la UI del niño / panel.
 * - Si ya es un emoji (o está en la lista), se muestra tal cual.
 * - Si es texto legacy ("libro", "calculadora"…), se mapea a emoji.
 */
export function iconoAsignatura(icono: string | null | undefined): string {
  const raw = (icono ?? "").trim();
  if (!raw) return "⭐";

  if ((EMOJIS_ASIGNATURA as readonly string[]).includes(raw)) {
    return raw;
  }

  const clave = raw.toLowerCase();
  for (const [texto, emoji] of Object.entries(LEGACY_TEXTO_A_EMOJI)) {
    if (clave.includes(texto)) return emoji;
  }

  // Heurística: sin letras latinas → probablemente emoji
  if (!/[a-záéíóúñ]/i.test(raw)) {
    return raw;
  }

  return "⭐";
}
