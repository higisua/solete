/** Une clases CSS omitiendo valores falsy. */
export function cn(
  ...clases: Array<string | false | null | undefined | 0 | 0n | "">
): string {
  return clases.filter(Boolean).join(" ");
}
