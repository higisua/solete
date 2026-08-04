"use client";

import Image from "next/image";
import { cn } from "@/lib/cn";
import { COLORES_RAREZA } from "@/lib/juego/cromos-estilo";
import type { RarezaCromo } from "@/lib/juego/cromos-catalogo";

type PropsPoseido = {
  loTiene: true;
  nombre: string;
  imagenSrc: string;
  rareza: RarezaCromo;
  className?: string;
  size?: "sm" | "md" | "lg";
};

type PropsHueco = {
  loTiene: false;
  className?: string;
  size?: "sm" | "md" | "lg";
  nombre?: never;
  imagenSrc?: never;
  rareza?: never;
};

type Props = PropsPoseido | PropsHueco;

const RADIOS = {
  sm: "rounded-xl",
  md: "rounded-2xl",
  lg: "rounded-[22px]",
} as const;

/**
 * Cromo poseído (imagen + marco de rareza) o hueco pendiente (?).
 */
export function CromoCara(props: Props) {
  const size = props.size ?? "md";
  const radio = RADIOS[size];

  if (!props.loTiene) {
    return (
      <div
        className={cn(
          "relative aspect-square w-full border-[2.5px] border-dashed border-black/15 bg-[#EDE8E0]/80",
          radio,
          props.className,
        )}
        aria-label="Cromo pendiente"
      >
        <span className="absolute inset-0 flex items-center justify-center font-titulo text-2xl font-semibold text-black/25 sm:text-3xl">
          ?
        </span>
      </div>
    );
  }

  const color = COLORES_RAREZA[props.rareza].hex;

  return (
    <div
      className={cn(
        "relative aspect-square w-full overflow-hidden bg-white shadow-[0_6px_16px_-8px_rgba(0,0,0,0.25)]",
        radio,
        props.className,
      )}
      style={{
        boxShadow: `0 0 0 3px ${color}, 0 8px 18px -10px rgba(0,0,0,0.28)`,
      }}
    >
      <Image
        src={props.imagenSrc}
        alt={props.nombre}
        fill
        sizes={
          size === "lg"
            ? "(max-width: 448px) 70vw, 280px"
            : size === "md"
              ? "(max-width: 448px) 45vw, 180px"
              : "(max-width: 448px) 22vw, 96px"
        }
        className="object-cover"
      />
    </div>
  );
}

export function EtiquetaRareza({
  rareza,
  className,
}: {
  rareza: RarezaCromo;
  className?: string;
}) {
  const { hex, label } = COLORES_RAREZA[rareza];
  return (
    <span
      className={cn(
        "inline-flex rounded-full px-2 py-0.5 font-titulo text-[11px] font-semibold text-white",
        className,
      )}
      style={{ backgroundColor: hex }}
    >
      {label}
    </span>
  );
}
