/**
 * @deprecated El catch-up real va por CatchupPremios + Server Action (con sesión).
 * Se mantiene por compatibilidad; no hace trabajo pesado.
 */
export function programarCatchupPremios(
  _ninoId: string,
  _diamantesActuales: number,
): void {
  // no-op: ver src/components/CatchupPremios.tsx
}
