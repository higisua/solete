import type { ButtonHTMLAttributes, InputHTMLAttributes, ReactNode } from "react";

type ButtonProps = ButtonHTMLAttributes<HTMLButtonElement> & {
  variant?: "sol" | "mar" | "suave";
  children: ReactNode;
};

export function Button({
  variant = "sol",
  className = "",
  children,
  ...props
}: ButtonProps) {
  const variants = {
    sol: "bg-sol text-white hover:bg-sol-claro",
    mar: "bg-mar text-white hover:bg-mar-claro",
    suave: "bg-white text-sol border-2 border-sol hover:bg-sol-claro/20",
  };

  return (
    <button
      className={`inline-flex min-h-12 w-full items-center justify-center rounded-2xl px-5 font-titulo text-lg font-semibold transition disabled:cursor-not-allowed disabled:opacity-60 ${variants[variant]} ${className}`}
      {...props}
    >
      {children}
    </button>
  );
}

type FieldProps = InputHTMLAttributes<HTMLInputElement> & {
  label: string;
  hint?: string;
};

export function Field({ label, hint, id, className = "", ...props }: FieldProps) {
  const fieldId = id ?? props.name;

  return (
    <label className="block w-full" htmlFor={fieldId}>
      <span className="mb-1.5 block font-titulo text-base text-sol">{label}</span>
      <input
        id={fieldId}
        className={`min-h-12 w-full rounded-2xl border-2 border-sol-claro/60 bg-white px-4 text-base outline-none focus:border-sol ${className}`}
        {...props}
      />
      {hint ? <span className="mt-1 block text-sm text-black/55">{hint}</span> : null}
    </label>
  );
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
    <main className="mx-auto flex min-h-dvh w-full max-w-md flex-col justify-center px-5 py-8">
      <h1 className="font-titulo text-3xl font-semibold text-sol">{title}</h1>
      {subtitle ? <p className="mt-2 text-base text-black/70">{subtitle}</p> : null}
      <div className="mt-8 flex flex-col gap-4">{children}</div>
    </main>
  );
}

export function ErrorBox({ message }: { message: string }) {
  return (
    <p
      role="alert"
      className="rounded-2xl border border-fallo/40 bg-fallo/15 px-4 py-3 text-sm text-[#8a3b28]"
    >
      {message}
    </p>
  );
}

export function SuccessBox({ message }: { message: string }) {
  return (
    <p
      role="status"
      className="rounded-2xl border border-acierto/40 bg-acierto/15 px-4 py-3 text-sm text-[#0f5c44]"
    >
      {message}
    </p>
  );
}
