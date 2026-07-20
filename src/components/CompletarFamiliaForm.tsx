"use client";

import { useState, useTransition } from "react";
import { unstable_rethrow } from "next/navigation";
import { completarFamilia } from "@/app/actions/auth";
import { Button, ErrorBox, Field } from "@/components/ui";

export function CompletarFamiliaForm({ email }: { email: string }) {
  const [error, setError] = useState<string | null>(null);
  const [pending, startTransition] = useTransition();

  function onSubmit(formData: FormData) {
    setError(null);
    startTransition(async () => {
      try {
        const result = await completarFamilia(formData);
        if (!result.ok) {
          setError(result.error);
        }
      } catch (err) {
        unstable_rethrow(err);
        setError("Ha ocurrido un error. Inténtalo de nuevo.");
      }
    });
  }

  return (
    <main className="mx-auto flex min-h-dvh w-full max-w-md flex-col justify-center px-5 py-8">
      <h1 className="font-titulo text-3xl font-semibold text-sol">
        Completa tu familia
      </h1>
      <p className="mt-2 text-base text-black/70">
        Has iniciado sesión como <strong>{email}</strong>, pero aún no hay una
        familia guardada. Rellena estos datos para continuar.
      </p>
      <form action={onSubmit} className="mt-8 flex flex-col gap-4">
        <Field
          label="Nombre de la familia"
          name="nombre"
          required
          placeholder="Ej. Familia García"
          maxLength={60}
        />
        <Field
          label="PIN de zona padres"
          name="pin"
          type="password"
          inputMode="numeric"
          pattern="[0-9]{4}"
          maxLength={4}
          required
          placeholder="4 dígitos"
          hint="Lo usarás más adelante para la zona padres."
          autoComplete="off"
        />
        {error ? <ErrorBox message={error} /> : null}
        <Button type="submit" disabled={pending}>
          {pending ? "Guardando…" : "Continuar"}
        </Button>
      </form>
    </main>
  );
}
