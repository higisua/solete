export type Familia = {
  id: string;
  user_id: string;
  nombre: string;
  pin_hash: string | null;
  rol: "user" | "superadmin";
  creado_en: string;
};

export type Nino = {
  id: string;
  familia_id: string;
  nombre: string;
  curso: "1" | "2";
  avatar: string;
  creado_en: string;
  racha_dias?: number;
  ultima_mision_fecha?: string | null;
  /** Requiere supabase/fase6_mision_diaria.sql */
  diamantes?: number;
};

export type Asignatura = {
  id: string;
  nombre: string;
  icono: string;
  curso: "1" | "2";
  creado_en: string;
};

export type Tema = {
  id: string;
  asignatura_id: string;
  nombre: string;
  orden: number;
  creado_en: string;
};

export type TipoPregunta = "numeric" | "true_false" | "multiple_choice";

export type Pregunta = {
  id: string;
  tema_id: string;
  tipo: TipoPregunta;
  enunciado: string;
  opciones: string[] | null;
  respuesta: unknown;
  dificultad: number;
  creado_en: string;
};

/** mision = misión diaria; libre = práctica (sin recompensas). */
export type ModoJuego = "mision" | "libre";

export type MisionDiaria = {
  id: string;
  nino_id: string;
  fecha: string;
  completada: boolean;
  aciertos: number;
  total: number;
  estrellas: number;
  diamante_otorgado: boolean;
  pregunta_ids: string[];
  creada_en: string;
  completada_en: string | null;
};

/** Fila de medallas_nino (desbloqueo). Catálogo en código. */
export type MedallaNino = {
  id: string;
  nino_id: string;
  medalla_id: string;
  desbloqueada_en: string;
  diamantes_otorgados: number;
};

/** Fila de cromos_nino (posesión). Catálogo en código. */
export type CromoNino = {
  id: string;
  nino_id: string;
  cromo_id: string;
  obtenido_en: string;
  via: "compra" | "sobre";
  diamantes_gastados: number;
};

/** Fila de practica_diaria (conteo + diamante topado). */
export type PracticaDiaria = {
  id: string;
  nino_id: string;
  fecha: string;
  preguntas: number;
  diamante_otorgado: boolean;
  actualizado_en: string;
};

export type ActionResult =
  | { ok: true }
  | { ok: false; error: string };
