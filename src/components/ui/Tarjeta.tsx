import type { ReactNode } from "react";
import { cn } from "@/lib/cn";

type Props = {
  children: ReactNode;
  className?: string;
  /** Padding interno. Por defecto cómodo para dedos infantiles. */
  padding?: "sm" | "md" | "lg";
  /** Si true, sin fondo blanco (solo para anidar). */
  transparente?: boolean;
  /** Elevación: card estándar o hero (misión). */
  elevacion?: "card" | "elevated";
};

/**
 * Superficie redondeada unificada. Base de listas, stats y bloques.
 */
export function Tarjeta({
  children,
  className,
  padding = "md",
  transparente = false,
  elevacion = "card",
}: Props) {
  return (
    <div
      className={cn(
        "rounded-card",
        !transparente && "bg-surface",
        !transparente && elevacion === "card" && "shadow-card",
        !transparente && elevacion === "elevated" && "shadow-elevated",
        padding === "sm" && "px-3 py-3",
        padding === "md" && "px-4 py-4",
        padding === "lg" && "px-5 py-5",
        className,
      )}
    >
      {children}
    </div>
  );
}
