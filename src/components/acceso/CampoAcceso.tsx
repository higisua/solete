"use client";

import { Eye, EyeOff, type LucideIcon } from "lucide-react";
import { useId, useState, type InputHTMLAttributes, type ReactNode } from "react";
import { cn } from "@/lib/cn";

type Props = Omit<InputHTMLAttributes<HTMLInputElement>, "className"> & {
  label: string;
  hint?: string;
  icono: LucideIcon;
  /** Si true, muestra botón ojo para revelar contraseña. */
  revelable?: boolean;
  className?: string;
  trailing?: ReactNode;
};

export function CampoAcceso({
  label,
  hint,
  icono: Icono,
  revelable = false,
  id,
  type,
  className,
  trailing,
  ...props
}: Props) {
  const autoId = useId();
  const fieldId = id ?? props.name ?? autoId;
  const [visible, setVisible] = useState(false);
  const tipoFinal = revelable ? (visible ? "text" : "password") : type;

  return (
    <div className={cn("w-full", className)}>
      <label htmlFor={fieldId} className="block">
        <span className="mb-1 block font-titulo text-[0.95rem] font-semibold text-sol">
          {label}
        </span>
        {hint ? (
          <span className="mb-2 block font-cuerpo text-sm leading-snug text-black/45">
            {hint}
          </span>
        ) : null}
      </label>
      <div className="relative">
        <span
          className="pointer-events-none absolute left-3.5 top-1/2 -translate-y-1/2 text-[#A89080]"
          aria-hidden
        >
          <Icono className="h-[1.15rem] w-[1.15rem] stroke-[1.75]" />
        </span>
        <input
          id={fieldId}
          type={tipoFinal}
          className={cn(
            "min-h-12 w-full rounded-[14px] border-2 border-[#E8D9C8] bg-[#FFFCFA] py-2.5 pl-11 font-cuerpo text-base text-black outline-none transition placeholder:text-black/35",
            "focus:border-sol-claro focus:shadow-[0_0_0_3px_rgba(240,153,123,0.28)]",
            revelable || trailing ? "pr-12" : "pr-4",
          )}
          {...props}
        />
        {revelable ? (
          <button
            type="button"
            onClick={() => setVisible((v) => !v)}
            className="absolute right-2 top-1/2 flex h-10 w-10 -translate-y-1/2 items-center justify-center rounded-xl text-[#A89080] transition hover:bg-black/[0.04] hover:text-sol"
            aria-label={visible ? "Ocultar contraseña" : "Mostrar contraseña"}
          >
            {visible ? (
              <EyeOff className="h-5 w-5 stroke-[1.75]" />
            ) : (
              <Eye className="h-5 w-5 stroke-[1.75]" />
            )}
          </button>
        ) : trailing ? (
          <span className="absolute right-3 top-1/2 -translate-y-1/2">{trailing}</span>
        ) : null}
      </div>
    </div>
  );
}
