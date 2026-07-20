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

export type ModoJuego = "mision" | "libre";

export type ActionResult =
  | { ok: true }
  | { ok: false; error: string };
