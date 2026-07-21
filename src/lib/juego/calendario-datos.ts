import { createClient } from "@/lib/supabase/server";
import {
  finMesISO,
  inicioMesISO,
  type DiaMisionCalendario,
  type MesCivil,
} from "@/lib/juego/calendario";

/**
 * Misiones completadas del niño en un mes civil (fechas Europe/Madrid en DATE).
 * RLS: solo filas del niño de la familia autenticada.
 * Solo Server Components / server actions.
 */
export async function getMisionesCompletadasDelMes(
  ninoId: string,
  mes: MesCivil,
): Promise<DiaMisionCalendario[]> {
  const supabase = await createClient();
  const desde = inicioMesISO(mes);
  const hasta = finMesISO(mes);

  const { data, error } = await supabase
    .from("misiones_diarias")
    .select("fecha, estrellas")
    .eq("nino_id", ninoId)
    .eq("completada", true)
    .gte("fecha", desde)
    .lte("fecha", hasta);

  if (error) {
    console.error("[getMisionesCompletadasDelMes]", error);
    return [];
  }

  return (data ?? []).map((row) => ({
    fecha: String(row.fecha).slice(0, 10),
    estrellas: Math.min(3, Math.max(0, Number(row.estrellas ?? 0))),
  }));
}
