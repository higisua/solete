"use client";

import {
  useId,
  useRef,
  useState,
  type ChangeEvent,
  type ClipboardEvent,
  type KeyboardEvent,
} from "react";
import { cn } from "@/lib/cn";

type Props = {
  /** Nombre del input oculto que envía el PIN completo (4 dígitos). */
  name?: string;
  label?: string;
  className?: string;
};

/**
 * PIN de 4 casillas: avanza al escribir y retrocede con Backspace.
 * El valor completo va en un input hidden para FormData.
 */
export function PinCuatroDigitos({
  name = "pin",
  label = "PIN de la zona de padres",
  className,
}: Props) {
  const baseId = useId();
  const [digitos, setDigitos] = useState(["", "", "", ""]);
  const refs = useRef<Array<HTMLInputElement | null>>([null, null, null, null]);

  function actualizar(index: number, valor: string) {
    const soloDigito = valor.replace(/\D/g, "").slice(-1);
    const siguiente = [...digitos];
    siguiente[index] = soloDigito;
    setDigitos(siguiente);
    if (soloDigito && index < 3) {
      refs.current[index + 1]?.focus();
    }
  }

  function onChange(index: number, e: ChangeEvent<HTMLInputElement>) {
    actualizar(index, e.target.value);
  }

  function onKeyDown(index: number, e: KeyboardEvent<HTMLInputElement>) {
    if (e.key === "Backspace" && !digitos[index] && index > 0) {
      refs.current[index - 1]?.focus();
      const siguiente = [...digitos];
      siguiente[index - 1] = "";
      setDigitos(siguiente);
      e.preventDefault();
    }
  }

  function onPaste(e: ClipboardEvent<HTMLInputElement>) {
    e.preventDefault();
    const texto = e.clipboardData.getData("text").replace(/\D/g, "").slice(0, 4);
    if (!texto) return;
    const siguiente = ["", "", "", ""];
    for (let i = 0; i < texto.length; i += 1) {
      siguiente[i] = texto[i];
    }
    setDigitos(siguiente);
    const foco = Math.min(texto.length, 3);
    refs.current[foco]?.focus();
  }

  return (
    <fieldset className={cn("w-full", className)}>
      <legend className="sr-only">{label}</legend>
      <input type="hidden" name={name} value={digitos.join("")} />
      <div className="flex justify-center gap-2.5">
        {digitos.map((d, i) => (
          <input
            key={i}
            ref={(el) => {
              refs.current[i] = el;
            }}
            id={`${baseId}-${i}`}
            type="text"
            inputMode="numeric"
            autoComplete={i === 0 ? "one-time-code" : "off"}
            maxLength={1}
            value={d}
            aria-label={`Dígito ${i + 1} del PIN`}
            onChange={(e) => onChange(i, e)}
            onKeyDown={(e) => onKeyDown(i, e)}
            onPaste={onPaste}
            className="h-14 w-12 rounded-[14px] border-2 border-[#E8D9C8] bg-[#FFFCFA] text-center font-titulo text-2xl font-semibold text-sol outline-none transition focus:border-sol-claro focus:shadow-[0_0_0_3px_rgba(240,153,123,0.28)]"
          />
        ))}
      </div>
    </fieldset>
  );
}
