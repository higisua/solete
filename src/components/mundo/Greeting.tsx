"use client";

import { Solete, type SoleteMood } from "@/components/solete";
import { cn } from "@/lib/cn";

type Props = {
  greeting: string;
  mood: SoleteMood;
  className?: string;
  /** Tamaño de Solete en la cabecera del mundo. */
  size?: "md" | "lg" | "xl";
};

/**
 * Saludo personalizado + Solete (zona superior del Mundo).
 */
export function Greeting({
  greeting,
  mood,
  className,
  size = "lg",
}: Props) {
  return (
    <div
      className={cn(
        "flex flex-col items-center text-center",
        className,
      )}
    >
      <Solete mood={mood} size={size} priority alt="" animate />
      <h1 className="mt-1 font-titulo text-2xl font-semibold leading-tight text-primary sm:text-3xl">
        {greeting}
      </h1>
    </div>
  );
}
