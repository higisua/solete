import { createClient } from "@/lib/supabase/server";
import { getNinoActivoId } from "@/lib/nino-activo";
import type { Asignatura, Nino } from "@/types/database";

/**
 * Devuelve un niño si pertenece a la familia del adulto (RLS lo garantiza).
 * Consulta directa por id — evita listar todos los hermanos en cada llamada.
 */
export async function getNinoDeMiFamilia(ninoId: string): Promise<Nino | null> {
  const supabase = await createClient();
  const { data } = await supabase
    .from("ninos")
    .select("*")
    .eq("id", ninoId)
    .maybeSingle();
  return (data as Nino | null) ?? null;
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

/**
 * Totales para el mundo del niño:
 * - puntos ≈ diamantes acumulados (ninos.diamantes; fallback a progreso.puntos si aún no hay columna)
 * - estrellas = suma de estrellas de misiones_diarias (fallback a progreso.estrellas)
 */
export async function getTotalesProgreso(ninoId: string): Promise<{
  puntos: number;
  estrellas: number;
}> {
  const supabase = await createClient();

  const [{ data: nino }, { data: misiones }] = await Promise.all([
    supabase.from("ninos").select("diamantes").eq("id", ninoId).maybeSingle(),
    supabase
      .from("misiones_diarias")
      .select("estrellas")
      .eq("nino_id", ninoId)
      .eq("completada", true),
  ]);

  if (nino && typeof nino.diamantes === "number") {
    const estrellas = (misiones ?? []).reduce(
      (s, m) => s + (m.estrellas ?? 0),
      0,
    );
    return { puntos: nino.diamantes, estrellas };
  }

  // Fallback si aún no se ejecutó fase6
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
