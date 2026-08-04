"use client";

import { cn } from "@/lib/cn";

type Props = {
  message: string;
  className?: string;
};

/**
 * Mensaje diario corto (máx. dos líneas).
 */
export function DailyStatus({ message, className }: Props) {
  const lineas = message.split("\n").filter(Boolean);

  return (
    <div className={cn("text-center", className)}>
      {lineas.map((linea) => (
        <p
          key={linea}
          className="font-cuerpo text-base leading-snug text-readable sm:text-lg"
        >
          {linea}
        </p>
      ))}
    </div>
  );
}
