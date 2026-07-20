"use client";

type Props = {
  onElegir: (valor: boolean) => void;
  disabled?: boolean;
};

export function PreguntaTrueFalse({ onElegir, disabled }: Props) {
  return (
    <div className="grid grid-cols-1 gap-3">
      <button
        type="button"
        disabled={disabled}
        onClick={() => onElegir(true)}
        className="min-h-16 rounded-3xl bg-acierto font-titulo text-2xl font-semibold text-white transition active:scale-[0.98] disabled:opacity-50"
      >
        Verdadero
      </button>
      <button
        type="button"
        disabled={disabled}
        onClick={() => onElegir(false)}
        className="min-h-16 rounded-3xl bg-fallo font-titulo text-2xl font-semibold text-white transition active:scale-[0.98] disabled:opacity-50"
      >
        Falso
      </button>
    </div>
  );
}
