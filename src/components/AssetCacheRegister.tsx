"use client";

import { useEffect } from "react";

/**
 * Registra el service worker que cachea /assets/* (y /_next/image de assets)
 * en el dispositivo. Fallo silencioso si el navegador no lo soporta.
 */
export function AssetCacheRegister() {
  useEffect(() => {
    if (typeof window === "undefined") return;
    if (!("serviceWorker" in navigator)) return;

    const registrar = () => {
      navigator.serviceWorker.register("/sw-assets.js", { scope: "/" }).catch(() => {
        /* sin SW: sigue Cache-Control HTTP */
      });
    };

    if (document.readyState === "complete") {
      registrar();
    } else {
      window.addEventListener("load", registrar, { once: true });
    }
  }, []);

  return null;
}
