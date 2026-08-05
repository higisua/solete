"use client";

import { useEffect, useRef } from "react";
import { ejecutarCatchupPremiosSiToca } from "@/app/actions/catchup-premios";

/**
 * Tras pintar la UI, aplica premios/medallas pendientes (1 vez/día).
 * Usa Server Action con sesión; no bloquea el TTFB.
 */
export function CatchupPremios() {
  const hecho = useRef(false);

  useEffect(() => {
    if (hecho.current) return;
    hecho.current = true;
    void ejecutarCatchupPremiosSiToca().catch(() => {
      /* silencioso: no debe romper la UI */
    });
  }, []);

  return null;
}
