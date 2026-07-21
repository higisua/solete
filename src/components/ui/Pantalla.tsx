import type { ReactNode } from "react";
import { cn } from "@/lib/cn";

type Props = {
  children: ReactNode;
  className?: string;
  /** Centra el contenido verticalmente (útil en resultados). */
  centrar?: boolean;
};

/**
 * Contenedor mobile-first compartido. Ancho cómodo de teléfono + padding generoso.
 */
export function Pantalla({ children, className, centrar = false }: Props) {
  return (
    <main
      className={cn(
        "relative mx-auto min-h-dvh w-full max-w-md px-5",
        centrar ? "flex flex-col justify-center py-10" : "pb-12 pt-6",
        className,
      )}
    >
      {/* Atmósfera suave: no compite con el contenido */}
      <div
        aria-hidden
        className="pointer-events-none absolute inset-0 -z-10 overflow-hidden"
      >
        <div className="absolute -right-16 -top-10 h-44 w-44 rounded-full bg-limon/35 blur-2xl" />
        <div className="absolute -left-20 top-1/3 h-52 w-52 rounded-full bg-mar-claro/25 blur-3xl" />
        <div className="absolute -bottom-8 right-0 h-40 w-40 rounded-full bg-sol-claro/20 blur-2xl" />
      </div>
      {children}
    </main>
  );
}
