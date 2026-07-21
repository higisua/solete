"use client";

import { useRouter } from "next/navigation";
import { useState, useTransition, type ReactNode } from "react";
import { unstable_rethrow } from "next/navigation";
import type { ActionResult } from "@/types/database";
import { AuthShell, Button, ErrorBox, Field, SuccessBox } from "@/components/auth-ui";

type Props = {
  action: (formData: FormData) => Promise<ActionResult>;
  title: string;
  subtitle?: string;
  submitLabel: string;
  successMessage?: string;
  /** Si la action devuelve ok, navega aquí y refresca la sesión. */
  redirectTo?: string;
  children: ReactNode;
  footer?: ReactNode;
};

export function AuthForm({
  action,
  title,
  subtitle,
  submitLabel,
  successMessage = "Listo.",
  redirectTo,
  children,
  footer,
}: Props) {
  const router = useRouter();
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);
  const [pending, startTransition] = useTransition();

  function onSubmit(formData: FormData) {
    setError(null);
    setSuccess(false);
    startTransition(async () => {
      try {
        const result = await action(formData);
        if (!result.ok) {
          setError(result.error);
          return;
        }
        if (redirectTo) {
          router.push(redirectTo);
          router.refresh();
          return;
        }
        setSuccess(true);
      } catch (err) {
        unstable_rethrow(err);
        setError("Ha ocurrido un error. Inténtalo de nuevo.");
      }
    });
  }

  return (
    <AuthShell title={title} subtitle={subtitle}>
      <form action={onSubmit} className="flex flex-col gap-4">
        {children}
        {error ? <ErrorBox message={error} /> : null}
        {success ? <SuccessBox message={successMessage} /> : null}
        <Button type="submit" disabled={pending}>
          {pending ? "Un momento…" : submitLabel}
        </Button>
      </form>
      {footer}
    </AuthShell>
  );
}

export { Field };
