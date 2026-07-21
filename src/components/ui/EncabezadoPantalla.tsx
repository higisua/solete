import type { ReactNode } from "react";
import { cn } from "@/lib/cn";

type Props = {
  titulo: string;
  subtitulo?: string;
  /** Contenido encima del título (avatar, mascota…). */
  superior?: ReactNode;
  /** Acción discreta arriba a la derecha (engranaje, etc.). */
  accion?: ReactNode;
  /** Alineación del bloque de título. */
  alineacion?: "centro" | "izquierda";
  className?: string;
  children?: ReactNode;
};

/**
 * Encabezado de pantalla infantil: jerarquía clara, mucho aire, sin clutter.
 */
export function EncabezadoPantalla({
  titulo,
  subtitulo,
  superior,
  accion,
  alineacion = "centro",
  className,
  children,
}: Props) {
  const centro = alineacion === "centro";

  return (
    <header className={cn("relative", className)}>
      {accion ? (
        <div className="absolute right-0 top-0 z-10">{accion}</div>
      ) : null}

      <div className={cn("flex flex-col", centro ? "items-center text-center" : "items-start text-left")}>
        {superior ? <div className="mb-4">{superior}</div> : null}

        <h1
          className={cn(
            "font-titulo text-3xl font-semibold leading-tight text-sol sm:text-4xl",
            accion && centro ? "px-10" : undefined,
          )}
        >
          {titulo}
        </h1>

        {subtitulo ? (
          <p className="mt-2 max-w-[22rem] text-lg leading-snug text-black/55">
            {subtitulo}
          </p>
        ) : null}

        {children ? <div className="mt-5 w-full">{children}</div> : null}
      </div>
    </header>
  );
}
