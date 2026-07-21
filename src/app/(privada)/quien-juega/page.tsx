import { redirect } from "next/navigation";
import { seleccionarNino } from "@/app/actions/juego";
import { getNinosDeMiFamilia } from "@/lib/familia";
import { AVATARES } from "@/lib/avatares";
import { publicAsset } from "@/lib/public-asset";
import Image from "next/image";

export default async function QuienJuegaPage() {
  const ninos = await getNinosDeMiFamilia();

  if (ninos.length === 0) {
    redirect("/familia");
  }

  if (ninos.length === 1) {
    redirect("/entrada");
  }

  return (
    <main className="mx-auto flex min-h-dvh w-full max-w-md flex-col px-5 py-8">
      <h1 className="text-center font-titulo text-3xl font-semibold text-sol sm:text-4xl">
        ¿Quién juega hoy?
      </h1>
      <p className="mt-2 text-center text-lg text-black/65">Toca tu avatar</p>

      <ul className="mt-8 grid grid-cols-1 gap-4">
        {ninos.map((nino) => {
          const avatarMeta = AVATARES.find((a) => a.id === nino.avatar);
          return (
            <li key={nino.id}>
              <form action={seleccionarNino.bind(null, nino.id)}>
                <button
                  type="submit"
                  className="flex min-h-[88px] w-full items-center gap-4 rounded-3xl bg-white px-4 py-3 text-left shadow-sm transition active:scale-[0.98] hover:bg-limon/30"
                >
                  {avatarMeta ? (
                    <Image
                      src={publicAsset(`assets/avatares/${avatarMeta.id}`)}
                      alt={avatarMeta.nombre}
                      width={72}
                      height={72}
                      unoptimized
                      className="h-[72px] w-[72px] object-contain"
                    />
                  ) : (
                    <div className="flex h-[72px] w-[72px] items-center justify-center rounded-full bg-limon font-titulo text-3xl text-sol">
                      {nino.nombre.slice(0, 1)}
                    </div>
                  )}
                  <span className="font-titulo text-2xl font-semibold text-sol">
                    {nino.nombre}
                  </span>
                </button>
              </form>
            </li>
          );
        })}
      </ul>
    </main>
  );
}
