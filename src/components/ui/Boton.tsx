"use client";

import { motion } from "framer-motion";
import Link from "next/link";
import type { ButtonHTMLAttributes, ReactNode } from "react";
import { cn } from "@/lib/cn";

const base =
  "inline-flex w-full items-center justify-center gap-2 rounded-2xl px-5 font-titulo font-semibold transition-colors disabled:cursor-not-allowed disabled:opacity-50 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-sol";

const variantes = {
  primario:
    "bg-sol text-white shadow-[0_4px_0_0_rgba(184,64,28,0.35)] hover:bg-sol-claro active:shadow-none",
  secundario:
    "bg-mar text-white shadow-[0_4px_0_0_rgba(18,110,80,0.35)] hover:bg-mar-claro active:shadow-none",
  suave:
    "border-[2.5px] border-sol/25 bg-white text-sol shadow-[0_3px_0_0_rgba(216,90,48,0.12)] hover:border-sol/45 hover:bg-white active:shadow-none",
} as const;

const tamanos = {
  md: "min-h-12 text-lg",
  lg: "min-h-14 text-xl",
} as const;

type Variante = keyof typeof variantes;
type Tamano = keyof typeof tamanos;

type BotonComun = {
  variant?: Variante;
  size?: Tamano;
  children: ReactNode;
  className?: string;
};

type BotonButtonProps = BotonComun &
  Omit<ButtonHTMLAttributes<HTMLButtonElement>, "children" | "className"> & {
    href?: undefined;
  };

type BotonLinkProps = BotonComun & {
  href: string;
  type?: never;
  disabled?: boolean;
};

export type BotonProps = BotonButtonProps | BotonLinkProps;

function clasesBoton(
  variant: Variante,
  size: Tamano,
  className?: string,
): string {
  return cn(base, variantes[variant], tamanos[size], className);
}

/**
 * Botón táctil del sistema Solete.
 * - primario: coral (CTA principal)
 * - secundario: turquesa (acción positiva alternativa)
 * - suave: blanco con borde (salida / terciario)
 */
export function Boton(props: BotonProps) {
  const {
    variant = "primario",
    size = "lg",
    className,
    children,
  } = props;

  const clases = clasesBoton(variant, size, className);
  const tap = { scale: 0.97 } as const;
  const tapTransition = { type: "spring" as const, stiffness: 420, damping: 28 };

  if ("href" in props && props.href) {
    const { href, disabled } = props;
    if (disabled) {
      return (
        <span className={cn(clases, "pointer-events-none opacity-50")} aria-disabled>
          {children}
        </span>
      );
    }
    return (
      <motion.div whileTap={tap} transition={tapTransition} className="w-full">
        <Link href={href} className={clases}>
          {children}
        </Link>
      </motion.div>
    );
  }

  const buttonProps = props as BotonButtonProps;
  const { type = "button", disabled, ...rest } = buttonProps;

  return (
    <motion.div
      whileTap={disabled ? undefined : tap}
      transition={tapTransition}
      className="w-full"
    >
      <button type={type} disabled={disabled} className={clases} {...rest}>
        {children}
      </button>
    </motion.div>
  );
}
