"use client";

import type { ReactNode } from "react";
import { useState, useTransition } from "react";
import { unstable_rethrow } from "next/navigation";
import { Boton, Campo } from "@/components/ui";
import { ErrorBox } from "@/components/auth-ui";
import type { ActionResult } from "@/types/database";

type Props = {
  action: (formData: FormData) => Promise<ActionResult>;
  children: ReactNode;
  submitLabel: string;
  className?: string;
};

export function SuperadminForm({
  action,
  children,
  submitLabel,
  className,
}: Props) {
  const [error, setError] = useState<string | null>(null);
  const [pending, startTransition] = useTransition();

  function onSubmit(formData: FormData) {
    setError(null);
    startTransition(async () => {
      try {
        const result = await action(formData);
        if (!result.ok) setError(result.error);
      } catch (err) {
        unstable_rethrow(err);
        setError("Ha ocurrido un error.");
      }
    });
  }

  return (
    <form action={onSubmit} className={className ?? "flex flex-col gap-4"}>
      {children}
      {error ? <ErrorBox message={error} /> : null}
      <Boton type="submit" disabled={pending}>
        {pending ? "Guardando…" : submitLabel}
      </Boton>
    </form>
  );
}

/** Alias para formularios legacy; usa Campo del sistema visual. */
export { Campo as Field };
