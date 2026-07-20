"use client";

type Props = {
  valor: string;
  onChange: (valor: string) => void;
  onConfirmar: () => void;
  disabled?: boolean;
};

const TECLAS = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "borrar", "0", "ok"] as const;

export function TecladoNumerico({ valor, onChange, onConfirmar, disabled }: Props) {
  function pulsar(tecla: (typeof TECLAS)[number]) {
    if (disabled) return;
    if (tecla === "borrar") {
      onChange(valor.slice(0, -1));
      return;
    }
    if (tecla === "ok") {
      onConfirmar();
      return;
    }
    if (valor.length >= 6) return;
    onChange(valor + tecla);
  }

  return (
    <div className="w-full">
      <div
        className="mb-3 min-h-14 rounded-2xl border-2 border-sol-claro/50 bg-white px-4 py-3 text-center font-titulo text-3xl text-sol"
        aria-live="polite"
      >
        {valor || "—"}
      </div>
      <div className="grid grid-cols-3 gap-2">
        {TECLAS.map((tecla) => {
          const esOk = tecla === "ok";
          const esBorrar = tecla === "borrar";
          return (
            <button
              key={tecla}
              type="button"
              disabled={disabled}
              onClick={() => pulsar(tecla)}
              className={`min-h-14 rounded-2xl font-titulo text-2xl font-semibold transition active:scale-95 disabled:opacity-50 ${
                esOk
                  ? "bg-mar text-white"
                  : esBorrar
                    ? "bg-sol-claro/40 text-sol"
                    : "bg-white text-sol shadow-sm"
              }`}
            >
              {esBorrar ? "⌫" : esOk ? "OK" : tecla}
            </button>
          );
        })}
      </div>
    </div>
  );
}
