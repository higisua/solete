import { cn } from "@/lib/cn";

type Props = {
  className?: string;
};

/** Placeholder de carga con forma conocida (evita pantalla vacía). */
export function Skeleton({ className }: Props) {
  return (
    <div
      className={cn(
        "animate-pulse rounded-2xl bg-black/[0.08]",
        className,
      )}
      aria-hidden
    />
  );
}

export function PantallaCargando() {
  return (
    <div
      className="fondo-halo-sol mx-auto flex min-h-dvh w-full max-w-md flex-col gap-4 px-5 pb-12 pt-8"
      role="status"
      aria-label="Cargando"
    >
      <div className="flex items-center justify-between">
        <Skeleton className="h-11 w-11 rounded-full" />
        <Skeleton className="h-7 w-36" />
        <Skeleton className="h-11 w-11 rounded-full" />
      </div>
      <Skeleton className="mt-4 h-40 w-full rounded-card" />
      <div className="mt-2 grid grid-cols-2 gap-3">
        <Skeleton className="h-24 rounded-card" />
        <Skeleton className="h-24 rounded-card" />
        <Skeleton className="h-24 rounded-card" />
        <Skeleton className="h-24 rounded-card" />
      </div>
      <span className="sr-only">Cargando…</span>
    </div>
  );
}
