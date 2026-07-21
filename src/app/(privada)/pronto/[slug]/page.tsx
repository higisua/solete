import Image from "next/image";
import Link from "next/link";
import { notFound } from "next/navigation";
import { Aparecer, Pantalla } from "@/components/ui";
import { publicAsset } from "@/lib/public-asset";

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
          <Image
            src={publicAsset("assets/logos/solete_solo_logo.png")}
            alt=""
            width={140}
            height={140}
            unoptimized
            priority
            className="h-28 w-28 object-contain drop-shadow-sm"
            aria-hidden
          />
        </Aparecer>
        <Aparecer delay={0.08}>
          <p className="mt-4 inline-flex rounded-full bg-limon/40 px-3 py-1 font-titulo text-sm font-semibold text-sol">
            ¡Muy pronto!
          </p>
          <h1 className="mt-3 font-titulo text-3xl font-semibold text-sol">
            {seccion.titulo}
          </h1>
          <p className="mt-3 max-w-xs font-cuerpo text-base leading-snug text-black/55">
            {seccion.mensaje}
          </p>
        </Aparecer>
        <Aparecer delay={0.16} className="mt-8 w-full max-w-xs">
          <Link
            href="/mundo"
            className="inline-flex min-h-14 w-full items-center justify-center rounded-2xl bg-sol px-5 font-titulo text-lg font-semibold text-white shadow-[0_4px_0_0_rgba(184,64,28,0.3)]"
          >
            Volver a casa
          </Link>
        </Aparecer>
      </div>
    </Pantalla>
  );
}
