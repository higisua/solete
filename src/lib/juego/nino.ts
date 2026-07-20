import { createClient } from "@/lib/supabase/server";
import { getNinoActivoId } from "@/lib/nino-activo";
import type { Asignatura, Nino } from "@/types/database";
import { getNinosDeMiFamilia } from "@/lib/familia";

/** Devuelve un niño solo si pertenece a la familia del adulto autenticado. */
export async function getNinoDeMiFamilia(ninoId: string): Promise<Nino | null> {
  const ninos = await getNinosDeMiFamilia();
  return ninos.find((n) => n.id === ninoId) ?? null;
}

/** Niño activo de la cookie, validado contra la familia del adulto. */
export async function getNinoActivoValidado(): Promise<Nino | null> {
  const id = await getNinoActivoId();
  if (!id) return null;
  return getNinoDeMiFamilia(id);
}

export async function getAsignaturasPorCurso(curso: "1" | "2"): Promise<Asignatura[]> {
  const supabase = await createClient();
  const { data } = await supabase
    .from("asignaturas")
    .select("*")
    .eq("curso", curso)
    .order("nombre", { ascending: true });

  return (data as Asignatura[]) ?? [];
}

/** Suma sencilla de puntos/estrellas del niño (0 si aún no hay filas). */
export async function getTotalesProgreso(ninoId: string): Promise<{
  puntos: number;
  estrellas: number;
}> {
  const supabase = await createClient();
  const { data } = await supabase
    .from("progreso")
    .select("puntos, estrellas")
    .eq("nino_id", ninoId);

  if (!data?.length) {
    return { puntos: 0, estrellas: 0 };
  }

  return data.reduce(
    (acc, fila) => ({
      puntos: acc.puntos + (fila.puntos ?? 0),
      estrellas: acc.estrellas + (fila.estrellas ?? 0),
    }),
    { puntos: 0, estrellas: 0 },
  );
}
