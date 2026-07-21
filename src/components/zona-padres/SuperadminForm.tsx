"use client";

import { useState, useTransition } from "react";
import { unstable_rethrow } from "next/navigation";
import { Button, ErrorBox, Field } from "@/components/auth-ui";
import type { ActionResult } from "@/types/database";

type Props = {
  action: (formData: FormData) => Promise<ActionResult>;
  children: React.ReactNode;
  submitLabel: string;
};

export function SuperadminForm({ action, children, submitLabel }: Props) {
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
    <form action={onSubmit} className="flex flex-col gap-4">
      {children}
      {error ? <ErrorBox message={error} /> : null}
      <Button type="submit" disabled={pending}>
        {pending ? "Guardando…" : submitLabel}
      </Button>
    </form>
  );
}

export { Field };
