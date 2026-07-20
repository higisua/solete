"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { useState, useTransition } from "react";
import { mensajeErrorAuth } from "@/lib/auth-errors";
import { createClient } from "@/lib/supabase/client";
import { AuthShell, Button, ErrorBox, Field } from "@/components/ui";

export default function LoginPage() {
  const router = useRouter();
  const [error, setError] = useState<string | null>(null);
  const [pending, startTransition] = useTransition();

  function onSubmit(formData: FormData) {
    const email = String(formData.get("email") ?? "")
      .trim()
      .toLowerCase();
    const password = String(formData.get("password") ?? "");

    setError(null);
    startTransition(async () => {
      if (!email || !password) {
        setError("Escribe tu email y contraseña.");
        return;
      }

      const supabase = createClient();
      const { error: signInError } = await supabase.auth.signInWithPassword({
        email,
        password,
      });

      if (signInError) {
        setError(mensajeErrorAuth(signInError));
        return;
      }

      router.push("/entrada");
      router.refresh();
    });
  }

  return (
    <AuthShell
      title="Iniciar sesión"
      subtitle="Entra con el email del adulto de la familia."
    >
      <form action={onSubmit} className="flex flex-col gap-4">
        <Field
          label="Email"
          name="email"
          type="email"
          autoComplete="email"
          required
          placeholder="tu@email.com"
        />
        <Field
          label="Contraseña"
          name="password"
          type="password"
          autoComplete="current-password"
          required
          placeholder="Tu contraseña"
        />
        {error ? <ErrorBox message={error} /> : null}
        <Button type="submit" disabled={pending}>
          {pending ? "Un momento…" : "Entrar"}
        </Button>
      </form>
      <div className="mt-2 flex flex-col gap-3 text-center text-sm">
        <Link href="/recuperar" className="text-mar underline underline-offset-2">
          He olvidado mi contraseña
        </Link>
        <p className="text-black/65">
          ¿Primera vez?{" "}
          <Link href="/registro" className="font-semibold text-sol underline underline-offset-2">
            Crear cuenta familiar
          </Link>
        </p>
      </div>
    </AuthShell>
  );
}
