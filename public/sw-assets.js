/* Solete — caché en dispositivo de assets estáticos (cromos, mascota, avatares).
 * Cache-first + revalidación en segundo plano. Compatible con iOS Safari.
 */
const CACHE = "solete-assets-v2";

const PRECACHE = [
  "/assets/mascot/wave.png",
  "/assets/mascot/happy.png",
  "/assets/mascot/thinking.png",
  "/assets/mascot/cheer.png",
  "/assets/mascot/gift.png",
  "/assets/mascot/love.png",
  "/assets/mascot/nervous.png",
  "/assets/mascot/cry.png",
  "/assets/mascot/sleep.png",
  "/assets/logos/solete_texto.png",
  "/assets/logos/solete-favicon.png",
];

function esPeticionAsset(request) {
  if (request.method !== "GET") return false;
  const url = new URL(request.url);
  if (url.origin !== self.location.origin) return false;
  if (url.pathname.startsWith("/assets/")) return true;
  if (url.pathname === "/_next/image") {
    const raw = url.searchParams.get("url") ?? "";
    try {
      const decoded = decodeURIComponent(raw);
      return decoded.startsWith("/assets/");
    } catch {
      return false;
    }
  }
  return false;
}

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches
      .open(CACHE)
      .then((cache) => cache.addAll(PRECACHE))
      .then(() => self.skipWaiting())
      .catch(() => self.skipWaiting()),
  );
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches
      .keys()
      .then((keys) =>
        Promise.all(
          keys.filter((k) => k !== CACHE).map((k) => caches.delete(k)),
        ),
      )
      .then(() => self.clients.claim()),
  );
});

self.addEventListener("fetch", (event) => {
  if (!esPeticionAsset(event.request)) return;

  event.respondWith(
    (async () => {
      const cache = await caches.open(CACHE);
      // ignoreSearch: misma imagen con ?v=mtime o params de next/image
      const cached = await cache.match(event.request, { ignoreSearch: true });
      if (cached) {
        event.waitUntil(
          fetch(event.request)
            .then((res) => {
              if (res.ok) return cache.put(event.request, res.clone());
            })
            .catch(() => undefined),
        );
        return cached;
      }

      const res = await fetch(event.request);
      if (res.ok) {
        event.waitUntil(cache.put(event.request, res.clone()));
      }
      return res;
    })(),
  );
});
