"use server";

import bcrypt from "bcryptjs";
import { redirect } from "next/navigation";
import { mensajeErrorAuth } from "@/lib/auth-errors";
import { AVATARES } from "@/lib/avatares";
import { createClient } from "@/lib/supabase/server";
import type { ActionResult } from "@/types/database";

const BCRYPT_ROUNDS = 12;

function texto(formData: FormData, key: string): string {
  return String(formData.get(key) ?? "").trim();
}

export async function registrarFamilia(formData: FormData): Promise<ActionResult> {
  const nombre = texto(formData, "nombre");
  const email = texto(formData, "email").toLowerCase();
  const password = String(formData.get("password") ?? "");
  const pin = texto(formData, "pin");

  if (!nombre || !email || !password || !pin) {
    return { ok: false, error: "Rellena todos los campos." };
  }
  if (password.length < 6) {
    return { ok: false, error: "La contraseña debe tener al menos 6 caracteres." };
  }
  if (!/^\d{4}$/.test(pin)) {
    return { ok: false, error: "El PIN debe ser exactamente 4 dígitos." };
  }

  const supabase = await createClient();

  const { data: authData, error: authError } = await supabase.auth.signUp({
    email,
    password,
  });

  if (authError || !authData.user) {
    return { ok: false, error: mensajeErrorAuth(authError) };
  }

  if (!authData.session) {
    const { error: signInError } = await supabase.auth.signInWithPassword({
      email,
      password,
    });
    if (signInError) {
      return {
        ok: false,
        error:
          "La cuenta se creó, pero hay que confirmar el email antes de continuar. En Supabase → Authentication → Providers → Email, desactiva «Confirm email».",
      };
    }
  }

  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    return {
      ok: false,
      error:
        "La cuenta se creó, pero no hay sesión activa. Prueba a iniciar sesión; si no tienes familia, completa el alta desde /familia.",
    };
  }

  const { data: familiaExistente } = await supabase
    .from("familias")
    .select("id")
    .eq("user_id", user.id)
    .maybeSingle();

  if (!familiaExistente) {
    const pin_hash = await bcrypt.hash(pin, BCRYPT_ROUNDS);

    const { error: familiaError } = await supabase.from("familias").insert({
      user_id: user.id,
      nombre,
      pin_hash,
      rol: "user",
    });

    if (familiaError) {
      console.error("[registrarFamilia] insert familias:", familiaError);
      return {
        ok: false,
        error: `No pudimos guardar la familia (${familiaError.code ?? "sin código"}: ${familiaError.message}). Ejecuta supabase/fase3_permisos.sql en el SQL Editor.`,
      };
    }
  }

  return { ok: true };
}

/** Completa la fila en familias cuando el usuario Auth existe pero no tiene familia. */
export async function completarFamilia(formData: FormData): Promise<ActionResult> {
  const nombre = texto(formData, "nombre");
  const pin = texto(formData, "pin");

  if (!nombre) {
    return { ok: false, error: "Escribe el nombre de la familia." };
  }
  if (!/^\d{4}$/.test(pin)) {
    return { ok: false, error: "El PIN debe ser exactamente 4 dígitos." };
  }

  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    return { ok: false, error: "Debes iniciar sesión." };
  }

  const { data: existente } = await supabase
    .from("familias")
    .select("id")
    .eq("user_id", user.id)
    .maybeSingle();

  if (existente) {
    redirect("/onboarding");
  }

  const pin_hash = await bcrypt.hash(pin, BCRYPT_ROUNDS);
  const { error } = await supabase.from("familias").insert({
    user_id: user.id,
    nombre,
    pin_hash,
    rol: "user",
  });

  if (error) {
    console.error("[completarFamilia]", error);
    return {
      ok: false,
      error: `No pudimos guardar la familia (${error.code ?? "sin código"}: ${error.message}).`,
    };
  }

  redirect("/onboarding");
}

export async function iniciarSesion(formData: FormData): Promise<ActionResult> {
  const email = texto(formData, "email").toLowerCase();
  const password = String(formData.get("password") ?? "");

  if (!email || !password) {
    return { ok: false, error: "Escribe tu email y contraseña." };
  }

  const supabase = await createClient();
  const { error } = await supabase.auth.signInWithPassword({ email, password });

  if (error) {
    return { ok: false, error: mensajeErrorAuth(error) };
  }

  return { ok: true };
}

export async function cerrarSesion(): Promise<void> {
  const { clearAccesoZonaPadres } = await import("@/lib/zona-padres");
  const { clearNinoActivoId } = await import("@/lib/nino-activo");
  await clearAccesoZonaPadres();
  await clearNinoActivoId();
  const supabase = await createClient();
  await supabase.auth.signOut();
  redirect("/login");
}

export async function solicitarRecuperacion(formData: FormData): Promise<ActionResult> {
  const email = texto(formData, "email").toLowerCase();

  if (!email) {
    return { ok: false, error: "Escribe el email de tu cuenta." };
  }

  const supabase = await createClient();
  const origen = process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000";

  const { error } = await supabase.auth.resetPasswordForEmail(email, {
    redirectTo: `${origen}/auth/callback?next=/actualizar-contrasena`,
  });

  if (error) {
    return { ok: false, error: mensajeErrorAuth(error) };
  }

  return { ok: true };
}

export async function actualizarContrasena(formData: FormData): Promise<ActionResult> {
  const password = String(formData.get("password") ?? "");
  const password2 = String(formData.get("password2") ?? "");

  if (password.length < 6) {
    return { ok: false, error: "La contraseña debe tener al menos 6 caracteres." };
  }
  if (password !== password2) {
    return { ok: false, error: "Las contraseñas no coinciden." };
  }

  const supabase = await createClient();
  const { error } = await supabase.auth.updateUser({ password });

  if (error) {
    return { ok: false, error: mensajeErrorAuth(error) };
  }

  redirect("/entrada");
}

export async function crearNino(formData: FormData): Promise<ActionResult> {
  const nombre = texto(formData, "nombre");
  const curso = texto(formData, "curso");
  const avatar = texto(formData, "avatar");
  const siguiente = texto(formData, "siguiente") || "/entrada";

  if (!nombre) {
    return { ok: false, error: "Escribe el nombre del niño o la niña." };
  }
  if (curso !== "1" && curso !== "2") {
    return { ok: false, error: "Elige el curso: 1º o 2º de primaria." };
  }
  if (!AVATARES.some((a) => a.id === avatar)) {
    return { ok: false, error: "Elige un avatar de la lista." };
  }

  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    return { ok: false, error: "Debes iniciar sesión." };
  }

  const { data: familia, error: familiaError } = await supabase
    .from("familias")
    .select("id")
    .eq("user_id", user.id)
    .single();

  if (familiaError || !familia) {
    return { ok: false, error: "No encontramos tu familia. Completa el alta familiar primero." };
  }

  const { data: creado, error } = await supabase
    .from("ninos")
    .insert({
      familia_id: familia.id,
      nombre,
      curso,
      avatar,
    })
    .select("id")
    .single();

  if (error || !creado) {
    return { ok: false, error: "No se pudo guardar el perfil. Inténtalo de nuevo." };
  }

  try {
    const { otorgarMedallaBienvenida } = await import("@/lib/juego/medallas");
    await otorgarMedallaBienvenida(creado.id);
  } catch (err) {
    console.warn("[crearNino] medalla bienvenida:", err);
  }

  redirect(siguiente);
}
