"use client";

import { motion, useReducedMotion } from "framer-motion";
import { cn } from "@/lib/cn";
import { ICONOS_MEDALLA } from "@/lib/juego/medallas-iconos";
import type { MedallaId } from "@/lib/juego/medallas-catalogo";

type Props = {
  id: MedallaId;
  conseguida: boolean;
  /** sm = rejilla · lg = fanfarria */
  size?: "sm" | "lg";
  className?: string;
  /** Halo pulsante (fanfarria). */
  conHalo?: boolean;
};

const TAM = {
  sm: { caja: "h-16 w-16", icono: "h-7 w-7", destello: "h-2.5 w-2.5" },
  lg: { caja: "h-36 w-36", icono: "h-16 w-16", destello: "h-4 w-4" },
} as const;

/**
 * Insignia circular compartida: dorada si conseguida, gris si pendiente.
 */
export function InsigniaMedalla({
  id,
  conseguida,
  size = "sm",
  className,
  conHalo = false,
}: Props) {
  const Icono = ICONOS_MEDALLA[id];
  const t = TAM[size];
  const reducir = useReducedMotion();

  return (
    <div className={cn("relative inline-flex items-center justify-center", className)}>
      {conHalo && conseguida && !reducir ? (
        <motion.span
          aria-hidden
          className="absolute inset-[-18%] rounded-full bg-[radial-gradient(circle,rgba(250,199,117,0.55)_0%,rgba(216,90,48,0.12)_55%,transparent_72%)]"
          animate={{ opacity: [0.55, 1, 0.55], scale: [0.92, 1.08, 0.92] }}
          transition={{ duration: 2.2, repeat: Infinity, ease: "easeInOut" }}
        />
      ) : null}

      <div
        className={cn(
          "relative flex items-center justify-center rounded-full",
          t.caja,
          conseguida
            ? "bg-[linear-gradient(145deg,#F8E0A0_0%,#E8B84A_42%,#C98A1A_100%)] shadow-[0_8px_20px_-6px_rgba(180,120,20,0.55)]"
            : "bg-[#E4E0D8] shadow-inner",
        )}
      >
        {conseguida ? (
          <span
            aria-hidden
            className={cn(
              "absolute right-[14%] top-[14%] rounded-full bg-white/80 blur-[0.5px]",
              t.destello,
            )}
          />
        ) : null}
        <Icono
          className={cn(
            t.icono,
            conseguida
              ? "stroke-[#6B4A12] stroke-[1.75]"
              : "stroke-[#9A958C] stroke-[1.6]",
          )}
          aria-hidden
        />
      </div>
    </div>
  );
}
