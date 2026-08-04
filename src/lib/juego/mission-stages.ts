/**
 * Configuración de etapas de la misión diaria (Fase 5 · Aventura).
 * Cambiar questionsPerStage / stages aquí basta para reestructurar la aventura.
 * No afecta economía, estrellas ni evaluación de respuestas.
 */

/** Moods de Solete usados en la aventura (evita acoplar lib → components). */
export type MissionSoleteMood =
  | "wave"
  | "happy"
  | "thinking"
  | "nervous"
  | "cheer"
  | "love"
  | "sleep"
  | "gift"
  | "cry";

export type MissionStageDef = {
  id: string;
  /** Título infantil (sin mundos ni mapa). */
  title: string;
  emoji: string;
  /** Color de acento de la etapa (UI). */
  color: string;
  /** Fondo suave asociado. */
  colorSoft: string;
  /** Tras completar esta etapa (si no es la última). */
  completeTitle: string;
  completeBody: string;
  completeMood: MissionSoleteMood;
};

export type MissionStagesConfig = {
  questionsPerStage: number;
  stages: readonly MissionStageDef[];
  intro: {
    title: string;
    body: string;
    cta: string;
    mood: MissionSoleteMood;
  };
  /** Al empezar la última etapa del plan. */
  lastStage: {
    title: string;
    body: string;
    mood: MissionSoleteMood;
  };
  timings: {
    /** Puente entre etapas (ms). */
    stageBridgeMs: number;
    /** Intro del último reto (ms). */
    lastStageIntroMs: number;
  };
};

/**
 * Por defecto: 4 retos × 5 preguntas = 20.
 * Nombres con identidad infantil; sin narrativa de mapa.
 */
export const MISSION_STAGES: MissionStagesConfig = {
  questionsPerStage: 5,
  stages: [
    {
      id: "reto_1",
      title: "Primer reto",
      emoji: "☀️",
      color: "#E8A84A",
      colorSoft: "rgba(232, 168, 74, 0.16)",
      completeTitle: "¡Muy bien!",
      completeBody: "Primer reto superado.",
      completeMood: "happy",
    },
    {
      id: "reto_2",
      title: "Segundo reto",
      emoji: "🌟",
      color: "#4FB08D",
      colorSoft: "rgba(79, 176, 141, 0.16)",
      completeTitle: "¡Genial!",
      completeBody: "Segundo reto superado.",
      completeMood: "cheer",
    },
    {
      id: "reto_3",
      title: "Tercer reto",
      emoji: "🚀",
      color: "#3D7AB5",
      colorSoft: "rgba(61, 122, 181, 0.16)",
      completeTitle: "¡Qué bien!",
      completeBody: "Tercer reto superado.",
      completeMood: "happy",
    },
    {
      id: "reto_4",
      title: "Gran final",
      emoji: "🏆",
      color: "#D85A30",
      colorSoft: "rgba(216, 90, 48, 0.14)",
      completeTitle: "¡Lo lograste!",
      completeBody: "Gran final superado.",
      completeMood: "cheer",
    },
  ],
  intro: {
    title: "¡Hoy tenemos una nueva aventura!",
    body: "Vamos a superar 4 pequeños retos.",
    cta: "¡Empezar!",
    mood: "wave",
  },
  lastStage: {
    title: "¡Ya estamos en el último reto!",
    body: "El Gran final. ¡Tú puedes!",
    mood: "cheer",
  },
  timings: {
    stageBridgeMs: 1100,
    lastStageIntroMs: 1200,
  },
};

export type EtapaPlan = {
  /** Índice 0-based en el plan (puede ser < stages.length si misión corta). */
  index: number;
  def: MissionStageDef;
  /** Índice global de la primera pregunta (0-based). */
  startIndex: number;
  /** Número de preguntas en esta etapa. */
  size: number;
  isLast: boolean;
};

export type PosicionEtapa = {
  etapa: EtapaPlan;
  /** 1-based dentro de la etapa. */
  preguntaEnEtapa: number;
  /** Etapas completadas (0..n). */
  etapasCompletadas: number;
  totalEtapas: number;
  esUltimaPreguntaDeEtapa: boolean;
};

/**
 * Reparte `totalPreguntas` en etapas según `questionsPerStage`.
 * Misión corta: menos etapas o última más corta; la última del plan usa identidad de “final”.
 */
export function planificarEtapas(
  totalPreguntas: number,
  config: MissionStagesConfig = MISSION_STAGES,
): EtapaPlan[] {
  if (totalPreguntas <= 0) return [];

  const catalogo = config.stages;
  const per = Math.max(1, config.questionsPerStage);
  const maxStages = catalogo.length;
  const needed = Math.min(maxStages, Math.ceil(totalPreguntas / per));

  const planes: EtapaPlan[] = [];
  let restante = totalPreguntas;
  let start = 0;

  for (let i = 0; i < needed; i++) {
    const esUltima = i === needed - 1;
    const size = esUltima ? restante : Math.min(per, restante);
    const def = catalogo[Math.min(i, catalogo.length - 1)]!;

    planes.push({
      index: i,
      def,
      startIndex: start,
      size,
      isLast: esUltima,
    });
    start += size;
    restante -= size;
  }

  return planes;
}

export function posicionEnEtapa(
  questionIndex: number,
  plan: EtapaPlan[],
): PosicionEtapa | null {
  if (plan.length === 0 || questionIndex < 0) return null;
  const etapa =
    plan.find(
      (e) =>
        questionIndex >= e.startIndex &&
        questionIndex < e.startIndex + e.size,
    ) ?? plan[plan.length - 1]!;

  const preguntaEnEtapa = questionIndex - etapa.startIndex + 1;
  const esUltimaPreguntaDeEtapa = preguntaEnEtapa >= etapa.size;

  return {
    etapa,
    preguntaEnEtapa: Math.min(preguntaEnEtapa, etapa.size),
    etapasCompletadas: etapa.index,
    totalEtapas: plan.length,
    esUltimaPreguntaDeEtapa,
  };
}

/** Tras responder la pregunta en `questionIndex`, ¿hay puente de etapa? */
export function debeMostrarPuenteTras(
  questionIndex: number,
  plan: EtapaPlan[],
): boolean {
  const pos = posicionEnEtapa(questionIndex, plan);
  if (!pos) return false;
  if (!pos.esUltimaPreguntaDeEtapa) return false;
  // No puente tras la última etapa: va al gran final de resultados.
  return !pos.etapa.isLast;
}

export function cuerpoIntroDinamico(
  plan: EtapaPlan[],
  config: MissionStagesConfig = MISSION_STAGES,
): string {
  const n = plan.length;
  if (n === config.stages.length) return config.intro.body;
  if (n === 1) return "Vamos a superar un pequeño reto.";
  return `Vamos a superar ${n} pequeños retos.`;
}
