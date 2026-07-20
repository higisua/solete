import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { PublicImage } from "@/components/PublicImage";

function faltanClavesSupabase() {
  return (
    !process.env.NEXT_PUBLIC_SUPABASE_URL?.trim() ||
    !process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY?.trim()
  );
}

export default async function HomePage() {
  if (faltanClavesSupabase()) {
    return (
      <main className="mx-auto flex min-h-dvh w-full max-w-md flex-col items-center justify-center px-6 py-10 text-center">
        <PublicImage
          path="assets/logos/solete_logo.png"
          alt="Solete"
          width={400}
          height={200}
          priority
          className="h-auto w-full max-w-[320px]"
        />
        <h1 className="mt-6 font-titulo text-3xl font-semibold text-sol">
          Faltan las claves de Supabase
        </h1>
        <p className="mt-3 text-base text-black/70">
          Abre <code className="rounded bg-white px-1.5 py-0.5">.env.local</code> y
          rellena <strong>NEXT_PUBLIC_SUPABASE_URL</strong> y{" "}
          <strong>NEXT_PUBLIC_SUPABASE_ANON_KEY</strong> (Settings → API en el
          dashboard). Luego reinicia <code className="rounded bg-white px-1.5 py-0.5">npm run dev</code>.
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

  return (
    <main className="mx-auto flex min-h-dvh w-full max-w-md flex-col items-center justify-center px-6 py-10 text-center">
      <PublicImage
        path="assets/logos/solete_logo.png"
        alt="Solete"
        width={400}
        height={200}
        priority
        className="h-auto w-full max-w-[320px]"
      />
      <h1 className="mt-6 font-titulo text-3xl font-semibold text-sol">
        Repasa en verano, ¡jugando!
      </h1>
      <p className="mt-3 text-base text-black/70">
        Para familias con niños de 1º y 2º de primaria. El adulto crea la cuenta; los
        niños eligen su avatar y practican.
      </p>
      <div className="mt-8 flex w-full flex-col gap-3">
        <Link
          href="/registro"
          className="inline-flex min-h-12 w-full items-center justify-center rounded-2xl bg-sol px-5 font-titulo text-lg font-semibold text-white hover:bg-sol-claro"
        >
          Crear cuenta familiar
        </Link>
        <Link
          href="/login"
          className="inline-flex min-h-12 w-full items-center justify-center rounded-2xl border-2 border-sol bg-white px-5 font-titulo text-lg font-semibold text-sol hover:bg-sol-claro/20"
        >
          Ya tengo cuenta
        </Link>
      </div>
    </main>
  );
}
