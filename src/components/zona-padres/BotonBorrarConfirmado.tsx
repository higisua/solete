"use client";

import type { ReactNode } from "react";
import { Trash2 } from "lucide-react";
import { cn } from "@/lib/cn";

type Props = {
  /** Server Action ya enlazada (bind). */
  action: (formData: FormData) => void | Promise<void>;
  /** Texto del diálogo de confirmación. */
  confirmar: string;
  children?: ReactNode;
  className?: string;
  /** Estilo del botón. */
  variante?: "peligro" | "peligro-bloque";
};

/**
 * Borrado con confirmación nativa. No cambia la action del servidor.
 */
export function BotonBorrarConfirmado({
  action,
  confirmar,
  children = "Borrar",
  className,
  variante = "peligro",
}: Props) {
  return (
    <form
      action={action}
      onSubmit={(e) => {
        if (!window.confirm(confirmar)) {
          e.preventDefault();
        }
      }}
      className={variante === "peligro-bloque" ? "flex-1" : undefined}
    >
      <button
        type="submit"
        className={cn(
          "inline-flex min-h-11 items-center justify-center gap-1.5 rounded-2xl bg-fallo/15 px-3 font-titulo text-sm font-semibold text-[#8a3b28] transition hover:bg-fallo/25",
          variante === "peligro-bloque" && "w-full",
          className,
        )}
      >
        <Trash2 className="h-3.5 w-3.5 stroke-[2]" aria-hidden />
        {children}
      </button>
    </form>
  );
}
