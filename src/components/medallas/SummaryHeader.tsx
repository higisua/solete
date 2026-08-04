"use client";

import { Solete, type SoleteMood } from "@/components/solete";
import { MedalProgress } from "@/components/medallas/MedalProgress";
import { cn } from "@/lib/cn";

type Props = {
  conseguidas: number;
  total: number;
  mensaje: string;
  mood: SoleteMood;
  className?: string;
};

/**
 * Cabecera potente: conteo, %, barra, tip Solete.
 */
export function SummaryHeader({
  conseguidas,
  total,
  mensaje,
  mood,
  className,
}: Props) {
  const pct = total > 0 ? Math.round((conseguidas / total) * 100) : 0;

  return (
    <section
      className={cn(
        "rounded-card bg-surface/95 px-4 py-4 text-center shadow-elevated",
        className,
      )}
      aria-label="Resumen de medallas"
    >
      <div className="flex flex-col items-center">
        <Solete mood={mood} size="md" priority alt="" />
        <p className="mt-2 font-titulo text-2xl font-semibold text-primary sm:text-3xl">
          <span aria-hidden>🏅 </span>
          {conseguidas}
          <span className="text-readable/70"> de {total}</span>
        </p>
        <p className="mt-0.5 font-titulo text-sm font-semibold text-sol">
          {pct}% completado
        </p>
      </div>

      <div className="mx-auto mt-3 max-w-xs">
        <MedalProgress
          actual={conseguidas}
          meta={Math.max(total, 1)}
          destacada
          aria-label={`${conseguidas} de ${total} medallas`}
        />
      </div>

      <p className="mt-3 font-cuerpo text-sm leading-snug text-readable sm:text-base">
        {mensaje}
      </p>
    </section>
  );
}
