"use client";

import { useState, useTransition } from "react";
import { unstable_rethrow } from "next/navigation";
import { verificarPinZonaPadres } from "@/app/actions/zona-padres";
import { ErrorBox } from "@/components/auth-ui";

const TECLAS = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0", "borrar"] as const;

export function PinGate() {
  const [pin, setPin] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [pending, startTransition] = useTransition();

  function pulsar(tecla: (typeof TECLAS)[number]) {
    if (pending || !tecla) return;
    if (tecla === "borrar") {
      setPin((p) => p.slice(0, -1));
      return;
    }
    if (pin.length >= 4) return;
    const siguiente = pin + tecla;
    setPin(siguiente);
    if (siguiente.length === 4) {
      enviar(siguiente);
    }
  }

  function enviar(valor: string) {
    setError(null);
    const fd = new FormData();
    fd.set("pin", valor);
    startTransition(async () => {
      try {
        const result = await verificarPinZonaPadres(fd);
        if (!result.ok) {
          setError(result.error);
          setPin("");
        }
      } catch (err) {
        unstable_rethrow(err);
        setError("Ha ocurrido un error. Inténtalo de nuevo.");
        setPin("");
      }
    });
  }

  return (
    <main className="mx-auto flex min-h-dvh w-full max-w-md flex-col justify-center px-5 py-8">
      <h1 className="text-center font-titulo text-3xl font-semibold text-sol">
        Zona padres
      </h1>
      <p className="mt-2 text-center text-base text-black/65">
        Introduce el PIN de 4 dígitos
      </p>

      <div className="mt-8 flex justify-center gap-3" aria-label="PIN">
        {[0, 1, 2, 3].map((i) => (
          <span
            key={i}
            className={`flex h-14 w-14 items-center justify-center rounded-2xl border-2 font-titulo text-2xl ${
              pin.length > i
                ? "border-sol bg-sol text-white"
                : "border-sol-claro/60 bg-white text-transparent"
            }`}
          >
            •
          </span>
        ))}
      </div>

      {error ? (
        <div className="mt-4">
          <ErrorBox message={error} />
        </div>
      ) : null}
      {pending ? (
        <p className="mt-4 text-center text-sm text-black/50">Comprobando…</p>
      ) : null}

      <div className="mt-8 grid grid-cols-3 gap-2">
        {TECLAS.map((tecla, idx) =>
          tecla === "" ? (
            <span key={`empty-${idx}`} />
          ) : (
            <button
              key={tecla + idx}
              type="button"
              disabled={pending}
              onClick={() => pulsar(tecla)}
              className="min-h-14 rounded-2xl bg-white font-titulo text-2xl font-semibold text-sol shadow-sm transition active:scale-95 disabled:opacity-50"
            >
              {tecla === "borrar" ? "⌫" : tecla}
            </button>
          ),
        )}
      </div>
    </main>
  );
}
