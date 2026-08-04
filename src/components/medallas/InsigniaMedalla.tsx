"use client";

import { motion, useReducedMotion } from "framer-motion";
import { cn } from "@/lib/cn";
import { ICONOS_MEDALLA } from "@/lib/juego/medallas-iconos";
import type { MedallaId } from "@/lib/juego/medallas-catalogo";

export type InsigniaEstado = "earned" | "almost" | "locked";

type Props = {
  id: MedallaId;
  conseguida?: boolean;
  /** Estado visual; si no se pasa, se deriva de `conseguida`. */
  estado?: InsigniaEstado;
  /** sm = rejilla · md = featured · lg = fanfarria */
  size?: "sm" | "md" | "lg";
  className?: string;
  /** Halo pulsante (fanfarria / conseguida). */
  conHalo?: boolean;
};

const TAM = {
  sm: { caja: "h-14 w-14", icono: "h-6 w-6", destello: "h-2 w-2" },
  md: { caja: "h-16 w-16", icono: "h-7 w-7", destello: "h-2.5 w-2.5" },
  lg: { caja: "h-36 w-36", icono: "h-16 w-16", destello: "h-4 w-4" },
} as const;

/**
 * Insignia circular: dorada (conseguida), viva (casi), crema curiosa (bloqueada).
 */
export function InsigniaMedalla({
  id,
  conseguida = false,
  estado,
  size = "sm",
  className,
  conHalo = false,
}: Props) {
  const Icono = ICONOS_MEDALLA[id];
  const t = TAM[size];
  const reducir = useReducedMotion();
  const visual: InsigniaEstado =
    estado ?? (conseguida ? "earned" : "locked");

  return (
    <div className={cn("relative inline-flex items-center justify-center", className)}>
      {conHalo && visual === "earned" && !reducir ? (
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
          visual === "earned" &&
            "bg-[linear-gradient(145deg,#FFE9A8_0%,#F0C05A_38%,#D4A017_72%,#B8860B_100%)] shadow-[0_8px_22px_-6px_rgba(180,120,20,0.6)] ring-2 ring-[#F8E0A0]/80",
          visual === "almost" &&
            "bg-[linear-gradient(145deg,#FFF3DC_0%,#FAC775_55%,#E8A84A_100%)] shadow-[0_6px_16px_-8px_rgba(216,90,48,0.35)] ring-2 ring-sol/35",
          visual === "locked" &&
            "bg-[linear-gradient(145deg,#FFF8ED_0%,#F3E6D0_100%)] shadow-card ring-1 ring-black/5",
        )}
      >
        {visual === "earned" ? (
          <span
            aria-hidden
            className={cn(
              "absolute right-[12%] top-[12%] rounded-full bg-white/85 blur-[0.5px]",
              t.destello,
            )}
          />
        ) : null}
        <Icono
          className={cn(
            t.icono,
            visual === "earned" && "stroke-[#5C3D0A] stroke-[1.85]",
            visual === "almost" && "stroke-[#9A4E1C] stroke-[1.75]",
            visual === "locked" && "stroke-[#B8A48A] stroke-[1.6]",
          )}
          aria-hidden
        />
      </div>
    </div>
  );
}
