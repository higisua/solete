/* Solete — apaga el SW antiguo y limpia cachés corruptas.
 * v2 cacheaba /_next/image con ignoreSearch y servía el mismo cromo a todos.
 */
self.addEventListener("install", (event) => {
  event.waitUntil(self.skipWaiting());
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    (async () => {
      const keys = await caches.keys();
      await Promise.all(keys.map((k) => caches.delete(k)));
      await self.registration.unregister();
      await self.clients.claim();
    })(),
  );
});
