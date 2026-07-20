import Link from "next/link";

export default function ZonaPadresPage() {
  return (
    <main className="mx-auto flex min-h-dvh w-full max-w-md flex-col justify-center px-5 py-10 text-center">
      <h1 className="font-titulo text-3xl font-semibold text-sol">Zona padres</h1>
      <p className="mt-3 text-base text-black/70">
        Aquí irá el acceso con PIN (Fase 5): gestionar niños, temas activos y
        progreso.
      </p>
      <div className="mt-8 flex flex-col gap-3">
        <Link
          href="/familia"
          className="inline-flex min-h-12 items-center justify-center rounded-2xl bg-sol px-5 font-titulo text-lg font-semibold text-white"
        >
          Ir a gestión familiar (temporal)
        </Link>
        <Link
          href="/mundo"
          className="inline-flex min-h-12 items-center justify-center rounded-2xl border-2 border-sol bg-white px-5 font-titulo text-lg font-semibold text-sol"
        >
          Volver al mundo del niño
        </Link>
      </div>
    </main>
  );
}
