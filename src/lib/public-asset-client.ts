/**
 * URL pública para Client Components (sin fs).
 * Sin cache-busting por mtime; suficiente para assets estables de marca.
 */
export function publicAssetClient(relativePath: string): string {
  const clean = relativePath.replace(/^\/+/, "");
  return `/${clean}`;
}
