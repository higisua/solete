"use client";

type Props = {
  opciones: string[];
  onElegir: (valor: string) => void;
  disabled?: boolean;
};

/**
 * 4 opciones grandes. Diseño preparado para ampliar a imagen+texto
 * (cada opción podría ser { texto, imagenUrl } en el futuro).
 */
export function PreguntaMultiple({ opciones, onElegir, disabled }: Props) {
  const visibles = opciones.slice(0, 4);

  return (
    <div className="grid grid-cols-1 gap-3">
      {visibles.map((opcion, index) => (
        <button
          key={`${index}-${opcion}`}
          type="button"
          disabled={disabled}
          onClick={() => onElegir(opcion)}
          className="flex min-h-16 items-center gap-3 rounded-3xl bg-white px-4 py-3 text-left shadow-sm transition active:scale-[0.98] disabled:opacity-50"
        >
          {/* Hueco para futura imagen de opción */}
          <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-limon/40 font-titulo text-lg text-sol">
            {String.fromCharCode(65 + index)}
          </span>
          <span className="font-titulo text-xl font-semibold text-sol">{opcion}</span>
        </button>
      ))}
    </div>
  );
}
