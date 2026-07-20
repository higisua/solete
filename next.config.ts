import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  images: {
    // Evita que el optimizador de Next cachee assets locales entre cambios.
    minimumCacheTTL: 0,
  },
  async headers() {
    return [
      {
        source: "/assets/:path*",
        headers: [
          {
            key: "Cache-Control",
            value: "no-store, must-revalidate",
          },
        ],
      },
    ];
  },
};

export default nextConfig;
