"use client";

import { useState } from "react";
import { EMOJIS_ASIGNATURA, iconoAsignatura } from "@/lib/iconos";
import { cn } from "@/lib/cn";

type Props = {
  name?: string;
  defaultValue?: string;
  label?: string;
};

export function SelectorEmojiAsignatura({
  name = "icono",
  defaultValue = "📚",
  label = "Icono",
}: Props) {
  const inicial = iconoAsignatura(defaultValue);
  const [seleccionado, setSeleccionado] = useState(
    (EMOJIS_ASIGNATURA as readonly string[]).includes(inicial) ? inicial : "📚",
  );

  return (
    <fieldset>
      <legend className="mb-2 font-titulo text-base font-semibold text-sol">
        {label}
      </legend>
      <input type="hidden" name={name} value={seleccionado} />
      <div className="grid grid-cols-6 gap-2">
        {EMOJIS_ASIGNATURA.map((emoji) => {
          const activo = seleccionado === emoji;
          return (
            <button
              key={emoji}
              type="button"
              onClick={() => setSeleccionado(emoji)}
              aria-label={`Elegir ${emoji}`}
              aria-pressed={activo}
              className={cn(
                "flex min-h-12 items-center justify-center rounded-2xl text-2xl transition",
                activo
                  ? "bg-sol shadow-[0_0_0_2px_rgba(216,90,48,0.35)] ring-2 ring-sol/30"
                  : "bg-[#FFF8ED] shadow-[0_2px_8px_-4px_rgba(216,90,48,0.2)] hover:bg-limon/40",
              )}
            >
              {emoji}
            </button>
          );
        })}
      </div>
      <p className="mt-2 font-cuerpo text-sm text-black/50">
        Seleccionado:{" "}
        <span className="text-xl" aria-hidden>
          {seleccionado}
        </span>
      </p>
    </fieldset>
  );
}
