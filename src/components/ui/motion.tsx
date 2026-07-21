"use client";

import { motion, useReducedMotion, type HTMLMotionProps } from "framer-motion";
import type { ReactNode } from "react";
import { cn } from "@/lib/cn";

/** Entrada suave: aparece desde abajo sin estridencia. */
export const varianteAparecer = {
  oculto: { opacity: 0, y: 14 },
  visible: {
    opacity: 1,
    y: 0,
    transition: { duration: 0.35, ease: [0.22, 1, 0.36, 1] as const },
  },
};

export const varianteLista = {
  oculto: {},
  visible: {
    transition: { staggerChildren: 0.07, delayChildren: 0.05 },
  },
};

const varianteInstantanea = {
  oculto: { opacity: 1, y: 0 },
  visible: { opacity: 1, y: 0 },
};

type AparecerProps = {
  children: ReactNode;
  className?: string;
  delay?: number;
  as?: "div" | "li" | "section" | "header";
};

/** Un bloque que entra con fade + ligero desplazamiento. */
export function Aparecer({
  children,
  className,
  delay = 0,
  as = "div",
}: AparecerProps) {
  const reducir = useReducedMotion();
  const Comp = motion[as];
  const variantes = reducir ? varianteInstantanea : varianteAparecer;

  return (
    <Comp
      className={className}
      initial="oculto"
      animate="visible"
      variants={{
        oculto: variantes.oculto,
        visible: {
          ...variantes.visible,
          transition: reducir
            ? { duration: 0 }
            : {
                ...varianteAparecer.visible.transition,
                delay,
              },
        },
      }}
    >
      {children}
    </Comp>
  );
}

type ListaAparecerProps = {
  children: ReactNode;
  className?: string;
  as?: "ul" | "div" | "ol";
};

/** Contenedor que escala la entrada de sus hijos (AparecerItem). */
export function ListaAparecer({
  children,
  className,
  as = "ul",
}: ListaAparecerProps) {
  const reducir = useReducedMotion();
  const Comp = motion[as];
  return (
    <Comp
      className={className}
      initial="oculto"
      animate="visible"
      variants={
        reducir
          ? { oculto: {}, visible: {} }
          : varianteLista
      }
    >
      {children}
    </Comp>
  );
}

export function AparecerItem({
  children,
  className,
  as = "li",
}: {
  children: ReactNode;
  className?: string;
  as?: "li" | "div";
}) {
  const reducir = useReducedMotion();
  const Comp = motion[as];
  return (
    <Comp
      className={className}
      variants={reducir ? varianteInstantanea : varianteAparecer}
    >
      {children}
    </Comp>
  );
}

type PulsableProps = HTMLMotionProps<"div"> & {
  children: ReactNode;
  className?: string;
  disabled?: boolean;
};

/** Feedback táctil al pulsar (escala suave). */
export function Pulsable({
  children,
  className,
  disabled,
  ...props
}: PulsableProps) {
  const reducir = useReducedMotion();
  return (
    <motion.div
      className={cn(disabled ? undefined : "cursor-pointer", className)}
      whileTap={disabled || reducir ? undefined : { scale: 0.97 }}
      transition={{ type: "spring", stiffness: 420, damping: 28 }}
      {...props}
    >
      {children}
    </motion.div>
  );
}
