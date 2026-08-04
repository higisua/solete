import type { ReactNode } from "react";
import { cn } from "@/lib/cn";

type Props = {
  children: ReactNode;
  className?: string;
  /** Centra el contenido verticalmente (útil en resultados). */
  centrar?: boolean;
  /**
   * Ancho máximo. Infantil: teléfono cómodo.
   * adulto: formularios algo más contenidos.
   * ancho: álbum/tienda en tablet.
   */
  ancho?: "infantil" | "adulto" | "ancho";
  /** Desactiva los blurs decorativos (p. ej. si ya hay fondo-halo-sol). */
  sinAtmosfera?: boolean;
};

const anchos = {
  infantil: "max-w-md",
  adulto: "max-w-lg",
  ancho: "max-w-2xl",
} as const;

/**
 * Contenedor mobile-first compartido. Safe-area + padding generoso.
 */
export function Pantalla({
  children,
  className,
  centrar = false,
  ancho = "infantil",
  sinAtmosfera = false,
}: Props) {
  return (
    <main
      className={cn(
        "relative mx-auto min-h-dvh w-full px-5",
        anchos[ancho],
        centrar
          ? "flex flex-col justify-center py-10 safe-pb"
          : "safe-pt safe-pb pb-12 pt-6",
        className,
      )}
    >
      {!sinAtmosfera ? (
        <div
          aria-hidden
          className="pointer-events-none absolute inset-0 -z-10 overflow-hidden"
        >
          <div className="absolute -right-16 -top-10 h-44 w-44 rounded-full bg-limon/30 blur-2xl" />
          <div className="absolute -left-20 top-1/3 h-52 w-52 rounded-full bg-mar-claro/20 blur-3xl" />
          <div className="absolute -bottom-8 right-0 h-40 w-40 rounded-full bg-sol-claro/15 blur-2xl" />
        </div>
      ) : null}
      {children}
    </main>
  );
}
