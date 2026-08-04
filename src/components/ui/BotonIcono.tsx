"use client";

import { motion, useReducedMotion } from "framer-motion";
import Link from "next/link";
import type { ButtonHTMLAttributes, ReactNode } from "react";
import { cn } from "@/lib/cn";

const base =
  "touch-target inline-flex shrink-0 items-center justify-center rounded-full bg-black/[0.06] text-text-secondary transition-colors hover:bg-black/10 hover:text-text-primary focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus disabled:opacity-40";

type Comun = {
  children: ReactNode;
  className?: string;
  /** Obligatorio para iconos sin texto visible. */
  "aria-label": string;
};

type PropsBoton = Comun &
  Omit<
    ButtonHTMLAttributes<HTMLButtonElement>,
    "children" | "className" | "aria-label"
  > & {
    href?: undefined;
  };

type PropsLink = Comun & {
  href: string;
};

export type BotonIconoProps = PropsBoton | PropsLink;

/** Chip circular ≥44×44 para acciones discretas (volver, ajustes…). */
export function BotonIcono(props: BotonIconoProps) {
  const reducir = useReducedMotion();
  const { children, className } = props;
  const ariaLabel = props["aria-label"];
  const clases = cn(base, className);
  const tap = reducir ? undefined : ({ scale: 0.94 } as const);

  if ("href" in props && props.href) {
    return (
      <motion.div whileTap={tap} transition={{ duration: 0.12 }} className="inline-flex">
        <Link href={props.href} aria-label={ariaLabel} className={clases}>
          {children}
        </Link>
      </motion.div>
    );
  }

  const buttonProps = props as PropsBoton;
  const { type = "button", disabled, ...rest } = buttonProps;

  return (
    <motion.div
      whileTap={disabled ? undefined : tap}
      transition={{ duration: 0.12 }}
      className="inline-flex"
    >
      <button
        type={type}
        disabled={disabled}
        className={clases}
        {...rest}
        aria-label={ariaLabel}
      >
        {children}
      </button>
    </motion.div>
  );
}
