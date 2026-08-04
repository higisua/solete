import type { ButtonHTMLAttributes, InputHTMLAttributes, ReactNode } from "react";
import { Boton } from "@/components/ui/Boton";
import { Campo } from "@/components/ui/Campo";
import { EstadoError } from "@/components/ui/EstadoError";

type ButtonProps = ButtonHTMLAttributes<HTMLButtonElement> & {
  variant?: "sol" | "mar" | "suave";
  children: ReactNode;
};

/** @deprecated Preferir `Boton` de `@/components/ui`. Puente de compatibilidad. */
export function Button({
  variant = "sol",
  className = "",
  children,
  ...props
}: ButtonProps) {
  const map = {
    sol: "primario",
    mar: "secundario",
    suave: "suave",
  } as const;

  return (
    <Boton variant={map[variant]} size="md" className={className} {...props}>
      {children}
    </Boton>
  );
}

type FieldProps = InputHTMLAttributes<HTMLInputElement> & {
  label: string;
  hint?: string;
};

/** @deprecated Preferir `Campo` de `@/components/ui`. */
export function Field(props: FieldProps) {
  return <Campo {...props} />;
}

export function AuthShell({
  title,
  subtitle,
  children,
}: {
  title: string;
  subtitle?: string;
  children: ReactNode;
}) {
  return (
    <main className="fondo-halo-sol mx-auto flex min-h-dvh w-full max-w-lg flex-col justify-center px-5 py-8 safe-pb">
      <h1 className="font-titulo text-3xl font-semibold text-primary">{title}</h1>
      {subtitle ? (
        <p className="mt-2 font-cuerpo text-base text-readable">{subtitle}</p>
      ) : null}
      <div className="mt-8 flex flex-col gap-4">{children}</div>
    </main>
  );
}

export function ErrorBox({ message }: { message: string }) {
  return <EstadoError mensaje={message} titulo="Atención" />;
}

export function SuccessBox({ message }: { message: string }) {
  return (
    <p
      role="status"
      className="rounded-2xl border border-success/40 bg-success/15 px-4 py-3 font-cuerpo text-sm text-[#0f5c44]"
    >
      {message}
    </p>
  );
}
