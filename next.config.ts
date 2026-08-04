import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  images: {
    // Cache razonable para avatares/cromos/logos locales.
    minimumCacheTTL: 60 * 60 * 24 * 7,
  },
  async headers() {
    return [
      {
        source: "/assets/:path*",
        headers: [
          {
            key: "Cache-Control",
            value: "public, max-age=604800, stale-while-revalidate=86400",
          },
        ],
      },
    ];
  },
};

export default nextConfig;
