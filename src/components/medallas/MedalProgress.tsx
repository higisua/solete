"use client";

import { cn } from "@/lib/cn";

type Props = {
  actual: number;
  meta: number;
  /** Destaca la barra (casi conseguida). */
  destacada?: boolean;
  className?: string;
  "aria-label"?: string;
};

/**
 * Progreso protagonista: número grande + barra viva.
 */
export function MedalProgress({
  actual,
  meta,
  destacada = false,
  className,
  "aria-label": ariaLabel,
}: Props) {
  const safeMeta = Math.max(meta, 1);
  const capped = Math.min(Math.max(actual, 0), safeMeta);
  const pct = capped / safeMeta;

  return (
    <div className={cn("w-full", className)}>
      <div className="mb-1.5 flex items-baseline justify-between gap-2">
        <p
          className={cn(
            "font-titulo font-semibold tabular-nums",
            destacada
              ? "text-lg text-primary sm:text-xl"
              : "text-sm text-primary",
          )}
          aria-label={ariaLabel ?? `${capped} de ${safeMeta}`}
        >
          {capped}
          <span className="text-readable/70"> / {safeMeta}</span>
        </p>
        {destacada ? (
          <span className="font-titulo text-xs font-semibold text-sol">
            {Math.round(pct * 100)}%
          </span>
        ) : null}
      </div>
      <div
        className={cn(
          "overflow-hidden rounded-full bg-black/[0.07]",
          destacada ? "h-3" : "h-2",
        )}
        role="progressbar"
        aria-valuenow={capped}
        aria-valuemin={0}
        aria-valuemax={safeMeta}
      >
        <div
          className={cn(
            "h-full rounded-full transition-[width] duration-500 ease-out",
            destacada
              ? "bg-[linear-gradient(90deg,#FAC775_0%,#D85A30_100%)]"
              : "bg-sol",
          )}
          style={{ width: `${Math.round(pct * 100)}%` }}
        />
      </div>
    </div>
  );
}
