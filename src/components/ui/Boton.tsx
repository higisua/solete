"use client";

import { motion, useReducedMotion } from "framer-motion";
import Link from "next/link";
import type { ButtonHTMLAttributes, ReactNode } from "react";
import { cn } from "@/lib/cn";

const base =
  "inline-flex w-full items-center justify-center gap-2 rounded-2xl px-5 font-titulo font-semibold transition-[colors,box-shadow,transform] duration-150 disabled:cursor-not-allowed disabled:opacity-50 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus";

const variantes = {
  primario:
    "bg-primary text-text-inverse shadow-[var(--shadow-press)] hover:bg-primary-hover active:translate-y-0.5 active:shadow-none",
  secundario:
    "bg-secondary text-text-inverse shadow-[var(--shadow-press-mar)] hover:bg-mar-claro active:translate-y-0.5 active:shadow-none",
  suave:
    "border-[2.5px] border-sol/25 bg-surface text-primary shadow-[0_3px_0_0_rgba(216,90,48,0.12)] hover:border-sol/45 active:translate-y-0.5 active:shadow-none",
  peligro:
    "border-[2.5px] border-error/35 bg-surface text-error shadow-[0_3px_0_0_rgba(181,74,50,0.12)] hover:border-error/55 active:translate-y-0.5 active:shadow-none",
} as const;

const tamanos = {
  sm: "min-h-11 text-base",
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
  /** Muestra estado de carga sin cambiar el ancho del botón. */
  isLoading?: boolean;
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
 * - secundario: turquesa
 * - suave: blanco con borde (terciario)
 * - peligro: acción destructiva / adulta
 */
export function Boton(props: BotonProps) {
  const {
    variant = "primario",
    size = "lg",
    className,
    children,
    isLoading = false,
  } = props;

  const reducir = useReducedMotion();
  const clases = clasesBoton(variant, size, className);
  const tap = reducir ? undefined : ({ scale: 0.98 } as const);
  const tapTransition = { duration: 0.12 } as const;
  const contenido = isLoading ? (
    <span className="inline-flex items-center gap-2">
      <span
        className="h-4 w-4 animate-spin rounded-full border-2 border-current border-r-transparent"
        aria-hidden
      />
      <span className="opacity-90">{children}</span>
    </span>
  ) : (
    children
  );

  if ("href" in props && props.href) {
    const { href, disabled } = props;
    if (disabled || isLoading) {
      return (
        <span className={cn(clases, "pointer-events-none opacity-50")} aria-disabled>
          {contenido}
        </span>
      );
    }
    return (
      <motion.div whileTap={tap} transition={tapTransition} className="w-full">
        <Link href={href} className={clases}>
          {contenido}
        </Link>
      </motion.div>
    );
  }

  const buttonProps = props as BotonButtonProps;
  const { type = "button", disabled, ...rest } = buttonProps;
  const bloqueado = disabled || isLoading;

  return (
    <motion.div
      whileTap={bloqueado ? undefined : tap}
      transition={tapTransition}
      className="w-full"
    >
      <button
        type={type}
        disabled={bloqueado}
        aria-busy={isLoading || undefined}
        className={clases}
        {...rest}
      >
        {contenido}
      </button>
    </motion.div>
  );
}
