import Link from "next/link";
import { solicitarRecuperacion } from "@/app/actions/auth";
import { AuthForm, Field } from "@/components/AuthForm";

export default function RecuperarPage() {
  return (
    <AuthForm
      action={solicitarRecuperacion}
      title="Recuperar contraseña"
      subtitle="Te enviaremos un enlace mágico a tu email para elegir una nueva contraseña."
      submitLabel="Enviar enlace"
      successMessage="Si el email existe, recibirás un enlace en unos minutos. Revisa también la carpeta de spam."
      footer={
        <p className="mt-2 text-center text-sm text-black/65">
          <Link href="/login" className="font-semibold text-sol underline underline-offset-2">
            Volver al inicio de sesión
          </Link>
        </p>
      }
    >
      <Field
        label="Email"
        name="email"
        type="email"
        autoComplete="email"
        required
        placeholder="tu@email.com"
      />
    </AuthForm>
  );
}
