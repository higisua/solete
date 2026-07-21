import type { InputHTMLAttributes, ReactNode, TextareaHTMLAttributes } from "react";
import { cn } from "@/lib/cn";

const inputBase =
  "min-h-12 w-full rounded-2xl border-2 border-sol-claro/55 bg-white px-4 font-cuerpo text-base text-black outline-none transition placeholder:text-black/35 focus:border-sol focus:shadow-[0_0_0_3px_rgba(216,90,48,0.12)]";

type CampoProps = InputHTMLAttributes<HTMLInputElement> & {
  label: string;
  hint?: string;
  error?: string;
};

/** Campo de formulario amable: etiqueta clara, alto táctil, focus visible. */
export function Campo({
  label,
  hint,
  error,
  id,
  className,
  ...props
}: CampoProps) {
  const fieldId = id ?? props.name;

  return (
    <label className="block w-full" htmlFor={fieldId}>
      <span className="mb-1.5 block font-titulo text-base font-semibold text-sol">
        {label}
      </span>
      <input
        id={fieldId}
        className={cn(inputBase, error && "border-fallo focus:border-fallo", className)}
        aria-invalid={error ? true : undefined}
        {...props}
      />
      {error ? (
        <span className="mt-1.5 block text-sm text-[#8a3b28]" role="alert">
          {error}
        </span>
      ) : hint ? (
        <span className="mt-1.5 block text-sm text-black/50">{hint}</span>
      ) : null}
    </label>
  );
}

type AreaProps = TextareaHTMLAttributes<HTMLTextAreaElement> & {
  label: string;
  hint?: string;
};

export function CampoArea({ label, hint, id, className, ...props }: AreaProps) {
  const fieldId = id ?? props.name;
  return (
    <label className="block w-full" htmlFor={fieldId}>
      <span className="mb-1.5 block font-titulo text-base font-semibold text-sol">
        {label}
      </span>
      <textarea
        id={fieldId}
        className={cn(inputBase, "min-h-28 py-3", className)}
        {...props}
      />
      {hint ? <span className="mt-1.5 block text-sm text-black/50">{hint}</span> : null}
    </label>
  );
}

export function CampoGrupo({ children, className }: { children: ReactNode; className?: string }) {
  return <div className={cn("flex flex-col gap-4", className)}>{children}</div>;
}
