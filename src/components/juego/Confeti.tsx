"use client";

import { useMemo } from "react";
import { motion, useReducedMotion } from "framer-motion";

const COLORES = ["#D85A30", "#1D9E75", "#FAC775", "#F0997B", "#5DCAA5", "#FFF3DC"];

type Props = {
  cantidad?: number;
};

/** Confeti ligero con colores de marca. Solo decorativo. */
export function Confeti({ cantidad = 36 }: Props) {
  const reducir = useReducedMotion();
  const piezas = useMemo(
    () =>
      Array.from({ length: cantidad }, (_, i) => ({
        id: i,
        left: `${(i * 17 + 7) % 100}%`,
        delay: (i % 10) * 0.12,
        duracion: 2.4 + (i % 5) * 0.35,
        color: COLORES[i % COLORES.length],
        rotacion: (i * 47) % 360,
        ancho: 6 + (i % 4) * 2,
        alto: 8 + (i % 3) * 3,
      })),
    [cantidad],
  );

  if (reducir) return null;

  return (
    <div
      className="pointer-events-none absolute inset-0 z-10 overflow-hidden"
      aria-hidden
    >
      {piezas.map((p) => (
        <motion.span
          key={p.id}
          className="absolute top-[-12px] rounded-sm"
          style={{
            left: p.left,
            width: p.ancho,
            height: p.alto,
            backgroundColor: p.color,
          }}
          initial={{ y: -20, opacity: 0, rotate: p.rotacion }}
          animate={{
            y: ["0vh", "110vh"],
            opacity: [0, 1, 1, 0],
            rotate: p.rotacion + 180,
          }}
          transition={{
            duration: p.duracion,
            delay: p.delay,
            repeat: Infinity,
            ease: "linear",
          }}
        />
      ))}
    </div>
  );
}
