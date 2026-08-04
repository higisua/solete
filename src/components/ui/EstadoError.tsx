import type { ReactNode } from "react";
import { Tarjeta } from "@/components/ui/Tarjeta";
import { cn } from "@/lib/cn";

type Props = {
  titulo?: string;
  mensaje: string;
  accion?: ReactNode;
  className?: string;
};

/** Error recuperable con CTA opcional de reintentar. */
export function EstadoError({
  titulo = "Algo no ha ido bien",
  mensaje,
  accion,
  className,
}: Props) {
  return (
    <div role="alert" className={className}>
      <Tarjeta className={cn("border-2 border-error/25 text-center")}>
        <p className="font-titulo text-xl font-semibold text-error">{titulo}</p>
        <p className="mt-2 font-cuerpo text-base text-readable">{mensaje}</p>
        {accion ? <div className="mt-5">{accion}</div> : null}
      </Tarjeta>
    </div>
  );
}
