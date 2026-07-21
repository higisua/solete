import { redirect } from "next/navigation";
import { AccesoPantalla } from "@/components/acceso/AccesoPantalla";
import { PublicImage } from "@/components/PublicImage";
import { createClient } from "@/lib/supabase/server";

function faltanClavesSupabase() {
  return (
    !process.env.NEXT_PUBLIC_SUPABASE_URL?.trim() ||
    !process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY?.trim()
  );
}

type Props = {
  searchParams: Promise<{ tab?: string }>;
};

export default async function HomePage({ searchParams }: Props) {
  if (faltanClavesSupabase()) {
    return (
      <main className="fondo-halo-sol mx-auto flex min-h-dvh w-full max-w-md flex-col items-center justify-center px-6 py-10 text-center">
        <PublicImage
          path="assets/logos/solete_texto.png"
          alt="Solete"
          width={400}
          height={140}
          priority
          className="h-auto w-[60%] max-w-[280px]"
        />
        <h1 className="mt-6 font-titulo text-3xl font-semibold text-sol">
          Faltan las claves de Supabase
        </h1>
        <p className="mt-3 font-cuerpo text-base text-black/70">
          Abre <code className="rounded bg-white px-1.5 py-0.5">.env.local</code> y
          rellena <strong>NEXT_PUBLIC_SUPABASE_URL</strong> y{" "}
          <strong>NEXT_PUBLIC_SUPABASE_ANON_KEY</strong> (Settings → API en el
          dashboard). Luego reinicia{" "}
          <code className="rounded bg-white px-1.5 py-0.5">npm run dev</code>.
        </p>
      </main>
    );
  }

  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (user) {
    redirect("/entrada");
  }

  const params = await searchParams;
  const pestanaInicial =
    params.tab === "crear" || params.tab === "registro" ? "crear" : "entrar";

  return <AccesoPantalla pestanaInicial={pestanaInicial} />;
}
