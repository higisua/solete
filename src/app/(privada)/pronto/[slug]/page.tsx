import Link from "next/link";
import { notFound } from "next/navigation";
import { Aparecer, Pantalla } from "@/components/ui";
import { Solete } from "@/components/solete";

const SECCIONES: Record<
  string,
  { titulo: string; mensaje: string }
> = {
  coleccion: {
    titulo: "Mi colección",
    mensaje: "Aquí guardaremos tus tesoros y sorpresas. ¡Muy pronto!",
  },
  medallas: {
    titulo: "Medallas",
    mensaje: "Las medallas por tus logros llegarán muy pronto. ¡Sigue practicando!",
  },
  calendario: {
    titulo: "Calendario",
    mensaje: "Pronto verás aquí tu misión de cada día. ¡Vuelve más adelante!",
  },
};

type Props = {
  params: Promise<{ slug: string }>;
};

export default async function ProntoPage({ params }: Props) {
  const { slug } = await params;
  const seccion = SECCIONES[slug];
  if (!seccion) notFound();

  return (
    <Pantalla centrar className="fondo-halo-sol">
      <div className="flex flex-col items-center text-center">
        <Aparecer>
          <Solete mood="thinking" size="xl" priority alt="" />
        </Aparecer>
        <Aparecer delay={0.08}>
          <h1 className="mt-5 font-titulo text-3xl font-semibold text-primary">
            {seccion.titulo}
          </h1>
          <p className="mt-3 max-w-sm font-cuerpo text-lg text-readable">
            {seccion.mensaje}
          </p>
        </Aparecer>
        <Aparecer delay={0.16} className="mt-8 w-full max-w-xs">
          <Link
            href="/mundo"
            className="inline-flex min-h-12 w-full items-center justify-center rounded-2xl bg-mar px-5 font-titulo text-lg font-semibold text-white"
          >
            Volver
          </Link>
        </Aparecer>
      </div>
    </Pantalla>
  );
}
