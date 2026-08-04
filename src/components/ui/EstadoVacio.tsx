import type { ReactNode } from "react";
import { Tarjeta } from "@/components/ui/Tarjeta";
import { cn } from "@/lib/cn";

type Props = {
  titulo: string;
  descripcion?: string;
  accion?: ReactNode;
  className?: string;
};

/** Estado vacío amable, sin pantalla en blanco. */
export function EstadoVacio({
  titulo,
  descripcion,
  accion,
  className,
}: Props) {
  return (
    <Tarjeta className={cn("text-center", className)}>
      <p className="font-titulo text-xl font-semibold text-primary">{titulo}</p>
      {descripcion ? (
        <p className="mt-2 font-cuerpo text-base text-readable">{descripcion}</p>
      ) : null}
      {accion ? <div className="mt-5">{accion}</div> : null}
    </Tarjeta>
  );
}
