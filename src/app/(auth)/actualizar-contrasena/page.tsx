import { actualizarContrasena } from "@/app/actions/auth";
import { AuthForm, Field } from "@/components/AuthForm";

export default function ActualizarContrasenaPage() {
  return (
    <AuthForm
      action={actualizarContrasena}
      title="Nueva contraseña"
      subtitle="Elige una contraseña nueva para tu cuenta familiar."
      submitLabel="Guardar contraseña"
    >
      <Field
        label="Nueva contraseña"
        name="password"
        type="password"
        autoComplete="new-password"
        required
        minLength={6}
        placeholder="Mínimo 6 caracteres"
      />
      <Field
        label="Repetir contraseña"
        name="password2"
        type="password"
        autoComplete="new-password"
        required
        minLength={6}
        placeholder="Repite la contraseña"
      />
    </AuthForm>
  );
}
