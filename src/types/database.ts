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
};

export type ActionResult =
  | { ok: true }
  | { ok: false; error: string };
