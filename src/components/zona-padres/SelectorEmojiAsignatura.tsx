"use client";

import { useState } from "react";
import { EMOJIS_ASIGNATURA, iconoAsignatura } from "@/lib/iconos";

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
      <legend className="mb-2 font-titulo text-base text-sol">{label}</legend>
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
              className={`flex min-h-12 items-center justify-center rounded-2xl text-2xl transition ${
                activo
                  ? "bg-sol text-white ring-2 ring-sol ring-offset-2"
                  : "bg-white shadow-sm hover:bg-limon/40"
              }`}
            >
              {emoji}
            </button>
          );
        })}
      </div>
      <p className="mt-2 text-sm text-black/55">
        Seleccionado: <span className="text-2xl">{seleccionado}</span>
      </p>
    </fieldset>
  );
}
