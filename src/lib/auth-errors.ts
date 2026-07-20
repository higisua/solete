/** Traduce errores de Supabase Auth a mensajes amables en español. */
export function mensajeErrorAuth(error: { message?: string; code?: string } | null): string {
  if (!error?.message && !error?.code) {
    return "Ha ocurrido un error. Inténtalo de nuevo.";
  }

  const raw = `${error.code ?? ""} ${error.message ?? ""}`.toLowerCase();

  if (raw.includes("user_already_exists") || raw.includes("already registered")) {
    return "Este email ya está registrado. Prueba a iniciar sesión.";
  }
  if (raw.includes("invalid_credentials") || raw.includes("invalid login")) {
    return "Email o contraseña incorrectos.";
  }
  if (raw.includes("email_not_confirmed")) {
    return "Debes confirmar tu email antes de entrar.";
  }
  if (raw.includes("weak_password") || raw.includes("password")) {
    if (raw.includes("least") || raw.includes("weak") || raw.includes("short")) {
      return "La contraseña es demasiado débil. Usa al menos 6 caracteres.";
    }
  }
  if (raw.includes("invalid") && raw.includes("email")) {
    return "El email no es válido.";
  }
  if (raw.includes("rate") || raw.includes("too many")) {
    return "Demasiados intentos. Espera un momento y vuelve a probar.";
  }
  if (raw.includes("same_password")) {
    return "La nueva contraseña debe ser distinta a la anterior.";
  }

  return "No se ha podido completar la acción. Revisa los datos e inténtalo de nuevo.";
}
