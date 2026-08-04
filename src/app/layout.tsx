import type { Metadata } from "next";
import { Mali, Quicksand } from "next/font/google";
import "./globals.css";

const mali = Mali({
  variable: "--font-mali",
  subsets: ["latin"],
  weight: ["500", "600", "700"],
  display: "swap",
});

const quicksand = Quicksand({
  variable: "--font-quicksand",
  subsets: ["latin"],
  weight: ["400", "600"],
  display: "swap",
});

export const metadata: Metadata = {
  title: "Solete",
  description: "Repasa asignaturas en verano, de forma divertida",
  icons: {
    icon: [
      { url: "/favicon.ico", sizes: "any" },
      { url: "/assets/logos/solete-favicon.png", type: "image/png" },
    ],
    apple: [{ url: "/assets/logos/solete-favicon.png", type: "image/png" }],
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html
      lang="es"
      className={`${mali.variable} ${quicksand.variable} h-full antialiased`}
    >
      <body className="min-h-full font-cuerpo">{children}</body>
    </html>
  );
}
