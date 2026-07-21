import { redirect } from "next/navigation";

/** El registro vive en la misma pantalla de acceso, pestaña «Crear cuenta». */
export default function RegistroPage() {
  redirect("/login?tab=crear");
}
