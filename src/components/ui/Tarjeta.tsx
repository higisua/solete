import type { ReactNode } from "react";
import { cn } from "@/lib/cn";

type Props = {
  children: ReactNode;
  className?: string;
  /** Padding interno. Por defecto cómodo para dedos infantiles. */
  padding?: "md" | "lg";
  /** Si true, sin fondo blanco (solo para anidar). */
  transparente?: boolean;
};

/**
 * Superficie redondeada y suave. Base de listas, stats y bloques de contenido.
 */
export function Tarjeta({
  children,
  className,
  padding = "md",
  transparente = false,
}: Props) {
  return (
    <div
      className={cn(
        "rounded-3xl",
        !transparente &&
          "bg-white shadow-[0_6px_20px_-8px_rgba(216,90,48,0.18),0_2px_6px_-2px_rgba(0,0,0,0.06)]",
        padding === "md" && "px-4 py-4",
        padding === "lg" && "px-5 py-5",
        className,
      )}
    >
      {children}
    </div>
  );
}
