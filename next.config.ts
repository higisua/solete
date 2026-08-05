import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  images: {
    // next/image: reutiliza optimizaciones en dispositivo ~30 días
    minimumCacheTTL: 60 * 60 * 24 * 30,
  },
  async headers() {
    return [
      {
        // Cromos, mascota, avatares, logos: caché HTTP larga en el dispositivo
        source: "/assets/:path*",
        headers: [
          {
            key: "Cache-Control",
            value:
              "public, max-age=2592000, stale-while-revalidate=604800, immutable",
          },
        ],
      },
      {
        source: "/sw-assets.js",
        headers: [
          {
            key: "Cache-Control",
            value: "public, max-age=0, must-revalidate",
          },
          {
            key: "Service-Worker-Allowed",
            value: "/",
          },
        ],
      },
    ];
  },
};

export default nextConfig;
