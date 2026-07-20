import { statSync } from "fs";
import path from "path";

/**
 * URL de un archivo en /public con ?v=mtime para invalidar caché
 * del navegador y de next/image al sustituir el archivo.
 * Solo usar en Server Components / server code.
 */
export function publicAsset(relativePath: string): string {
  const clean = relativePath.replace(/^\/+/, "");
  const absolute = path.join(process.cwd(), "public", clean);

  try {
    const version = Math.trunc(statSync(absolute).mtimeMs);
    return `/${clean}?v=${version}`;
  } catch {
    return `/${clean}`;
  }
}
