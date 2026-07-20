import Link from "next/link";
import { registrarFamilia } from "@/app/actions/auth";
import { AuthForm, Field } from "@/components/AuthForm";

export default function RegistroPage() {
  return (
    <AuthForm
      action={registrarFamilia}
      title="Crear cuenta familiar"
      subtitle="Solo el adulto necesita email y contraseña. Luego añadiréis a los niños."
      submitLabel="Crear cuenta"
      redirectTo="/onboarding"
      footer={
        <p className="mt-2 text-center text-sm text-black/65">
          ¿Ya tenéis cuenta?{" "}
          <Link href="/login" className="font-semibold text-sol underline underline-offset-2">
            Iniciar sesión
          </Link>
        </p>
      }
    >
      <Field
        label="Nombre de la familia"
        name="nombre"
        autoComplete="organization"
        required
        placeholder="Ej. Familia García"
        maxLength={60}
      />
      <Field
        label="Email del adulto"
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
        autoComplete="new-password"
        required
        minLength={6}
        placeholder="Mínimo 6 caracteres"
        hint="La usará solo el adulto para entrar."
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
        hint="Lo usarás más adelante para la zona padres. No lo compartas con los niños."
        autoComplete="off"
      />
    </AuthForm>
  );
}
