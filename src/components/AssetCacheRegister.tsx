"use client";

import { useEffect } from "react";

/**
 * Retira el service worker de assets (causaba cromos/imágenes repetidas
 * al cachear /_next/image sin distinguir la query) y limpia Cache Storage.
 * La caché HTTP de /assets/* en next.config sigue activa.
 */
export function AssetCacheRegister() {
  useEffect(() => {
    if (typeof window === "undefined") return;

    void (async () => {
      try {
        if ("serviceWorker" in navigator) {
          const regs = await navigator.serviceWorker.getRegistrations();
          await Promise.all(regs.map((r) => r.unregister()));
        }
        if ("caches" in window) {
          const keys = await caches.keys();
          await Promise.all(keys.map((k) => caches.delete(k)));
        }
      } catch {
        /* silencioso */
      }
    })();
  }, []);

  return null;
}
