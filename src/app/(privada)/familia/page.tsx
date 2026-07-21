import Link from "next/link";
import { redirect } from "next/navigation";
import { cerrarSesion } from "@/app/actions/auth";
import { CompletarFamiliaForm } from "@/components/CompletarFamiliaForm";
import { Button } from "@/components/auth-ui";
import { PublicImage } from "@/components/PublicImage";
import { createClient } from "@/lib/supabase/server";
import { getFamiliaActual, getNinosDeMiFamilia } from "@/lib/familia";
import { AVATARES } from "@/lib/avatares";

export default async function FamiliaPage() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  const familia = await getFamiliaActual();

  // Usuario Auth sin fila en familias (falló el alta o no se guardó).
  if (!familia) {
    return <CompletarFamiliaForm email={user.email ?? "tu cuenta"} />;
  }

  const ninos = await getNinosDeMiFamilia();

  if (ninos.length === 0) {
    return (
      <main className="mx-auto flex min-h-dvh w-full max-w-md flex-col items-center justify-center px-5 py-10 text-center">
        <PublicImage
          path="assets/logos/solete_solo_logo.png"
          alt="Sol"
          width={160}
          height={160}
          priority
          className="h-36 w-36 object-contain"
        />
        <h1 className="mt-6 font-titulo text-3xl font-semibold text-sol">
          ¡Hola, {familia.nombre}!
        </h1>
        <p className="mt-3 text-base text-black/70">
          Todavía no hay niños en vuestra familia. Añade el primero para empezar a
          repasar.
        </p>
        <Link
          href="/onboarding"
          className="mt-8 inline-flex min-h-12 w-full items-center justify-center rounded-2xl bg-sol px-5 font-titulo text-lg font-semibold text-white hover:bg-sol-claro"
        >
          Añadir primer niño
        </Link>
        <form action={cerrarSesion} className="mt-4 w-full">
          <Button type="submit" variant="suave">
            Cerrar sesión
          </Button>
        </form>
      </main>
    );
  }

  return (
    <main className="mx-auto min-h-dvh w-full max-w-md px-5 py-8">
      <div className="flex items-start justify-between gap-3">
        <div>
          <p className="text-sm text-black/55">Familia</p>
          <h1 className="font-titulo text-3xl font-semibold text-sol">{familia.nombre}</h1>
        </div>
        <form action={cerrarSesion}>
          <button
            type="submit"
            className="min-h-12 rounded-2xl px-3 text-sm font-semibold text-sol underline underline-offset-2"
          >
            Salir
          </button>
        </form>
      </div>

      <p className="mt-2 text-base text-black/70">
        Perfiles de los niños. Desde aquí puedes añadir más o ir a jugar.
      </p>

      <ul className="mt-8 flex flex-col gap-3">
        {ninos.map((nino) => {
          const avatarMeta = AVATARES.find((a) => a.id === nino.avatar);
          return (
            <li
              key={nino.id}
              className="flex min-h-16 items-center gap-4 rounded-2xl bg-white px-4 py-3 shadow-sm"
            >
              {avatarMeta ? (
                <PublicImage
                  path={`assets/avatares/${avatarMeta.id}`}
                  alt={avatarMeta.nombre}
                  width={56}
                  height={56}
                  className="h-14 w-14 object-contain"
                />
              ) : (
                <div className="flex h-14 w-14 items-center justify-center rounded-full bg-limon/50 font-titulo text-xl text-sol">
                  {nino.nombre.slice(0, 1)}
                </div>
              )}
              <div>
                <p className="font-titulo text-xl text-sol">{nino.nombre}</p>
                <p className="text-sm text-black/60">{nino.curso}º de primaria</p>
              </div>
            </li>
          );
        })}
      </ul>

      <Link
        href="/entrada"
        className="mt-8 inline-flex min-h-12 w-full items-center justify-center rounded-2xl bg-sol px-5 font-titulo text-lg font-semibold text-white hover:bg-sol-claro"
      >
        ¡A jugar!
      </Link>
      <Link
        href="/ninos/nuevo"
        className="mt-3 inline-flex min-h-12 w-full items-center justify-center rounded-2xl bg-mar px-5 font-titulo text-lg font-semibold text-white hover:bg-mar-claro"
      >
        Añadir otro niño
      </Link>
    </main>
  );
}
