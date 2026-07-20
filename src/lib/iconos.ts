/** Icono visual simple a partir del campo texto `icono` de asignaturas. */
export function iconoAsignatura(icono: string): string {
  const clave = icono.toLowerCase();
  if (clave.includes("calc") || clave.includes("mate")) return "🔢";
  if (clave.includes("libro") || clave.includes("leng")) return "📖";
  if (clave.includes("ciencia") || clave.includes("medio")) return "🌍";
  if (clave.includes("arte")) return "🎨";
  if (clave.includes("deporte")) return "⚽";
  return "⭐";
}
