import { createClient } from "@/lib/supabase/server";
import type { Familia, Nino } from "@/types/database";

export async function getFamiliaActual(): Promise<Familia | null> {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) return null;

  const { data } = await supabase
    .from("familias")
    .select("*")
    .eq("user_id", user.id)
    .maybeSingle();

  return data as Familia | null;
}

export async function getNinosDeMiFamilia(): Promise<Nino[]> {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) return [];

  const { data: familia } = await supabase
    .from("familias")
    .select("id")
    .eq("user_id", user.id)
    .maybeSingle();

  if (!familia) return [];

  const { data } = await supabase
    .from("ninos")
    .select("*")
    .eq("familia_id", familia.id)
    .order("creado_en", { ascending: true });

  return (data as Nino[]) ?? [];
}
