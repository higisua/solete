"use client";

import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { X } from "lucide-react";
import { useEffect, useId, useRef, type ReactNode } from "react";
import { BotonIcono } from "@/components/ui/BotonIcono";
import { cn } from "@/lib/cn";

type Props = {
  abierto: boolean;
  onCerrar: () => void;
  titulo?: string;
  children: ReactNode;
  className?: string;
  /** Etiqueta accesible si no hay título visible. */
  "aria-label"?: string;
};

/**
 * Dialog accesible: Escape, scroll lock, focus al abrir, tap fuera.
 * Sin focus trap completo (evita dependencia nueva); el cierre está al alcance.
 */
export function ModalBase({
  abierto,
  onCerrar,
  titulo,
  children,
  className,
  "aria-label": ariaLabel,
}: Props) {
  const reducir = useReducedMotion();
  const tituloId = useId();
  const panelRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!abierto) return;
    function onKey(e: KeyboardEvent) {
      if (e.key === "Escape") onCerrar();
    }
    window.addEventListener("keydown", onKey);
    const prev = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    const t = window.setTimeout(() => {
      panelRef.current?.focus();
    }, 30);
    return () => {
      window.removeEventListener("keydown", onKey);
      document.body.style.overflow = prev;
      window.clearTimeout(t);
    };
  }, [abierto, onCerrar]);

  return (
    <AnimatePresence>
      {abierto ? (
        <motion.div
          className="fixed inset-0 z-50 flex items-end justify-center px-4 pb-[max(1.25rem,env(safe-area-inset-bottom))] pt-8 sm:items-center sm:pb-8"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          transition={{ duration: reducir ? 0 : 0.2 }}
        >
          <button
            type="button"
            className="absolute inset-0 bg-[#3A2A1A]/45 backdrop-blur-[2px]"
            aria-label="Cerrar"
            onClick={onCerrar}
          />

          <motion.div
            ref={panelRef}
            role="dialog"
            aria-modal
            aria-labelledby={titulo ? tituloId : undefined}
            aria-label={!titulo ? ariaLabel : undefined}
            tabIndex={-1}
            className={cn(
              "relative z-10 w-full max-w-sm rounded-card bg-surface p-5 shadow-elevated outline-none",
              className,
            )}
            initial={reducir ? false : { opacity: 0, y: 24, scale: 0.96 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={reducir ? undefined : { opacity: 0, y: 16, scale: 0.98 }}
            transition={{ duration: reducir ? 0 : 0.25, ease: [0.22, 1, 0.36, 1] }}
          >
            <div className="absolute right-3 top-3">
              <BotonIcono aria-label="Cerrar" onClick={onCerrar}>
                <X className="h-5 w-5 stroke-[2]" aria-hidden />
              </BotonIcono>
            </div>

            {titulo ? (
              <h2
                id={tituloId}
                className="pr-12 font-titulo text-2xl font-semibold text-primary"
              >
                {titulo}
              </h2>
            ) : null}

            <div className={cn(titulo ? "mt-4" : "mt-1")}>{children}</div>
          </motion.div>
        </motion.div>
      ) : null}
    </AnimatePresence>
  );
}
