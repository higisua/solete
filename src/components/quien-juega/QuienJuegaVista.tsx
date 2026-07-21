"use client";

import Image from "next/image";
import { motion, useReducedMotion } from "framer-motion";
import {
  Aparecer,
  AparecerItem,
  ListaAparecer,
  Pantalla,
} from "@/components/ui";
import { publicAssetClient } from "@/lib/public-asset-client";

export type NinoSelectorItem = {
  id: string;
  nombre: string;
  avatarSrc: string | null;
  avatarAlt: string;
  iniciales: string;
  /** Server Action ya enlazada al id del niño. */
  action: (formData: FormData) => Promise<void>;
};

type Props = {
  ninos: NinoSelectorItem[];
};

export function QuienJuegaVista({ ninos }: Props) {
  const reducir = useReducedMotion();

  return (
    <Pantalla className="fondo-halo-sol flex flex-col pb-10 pt-8">
      <Aparecer className="flex flex-col items-center text-center">
        <Image
          src={publicAssetClient("assets/logos/solete_texto.png")}
          alt="Solete"
          width={200}
          height={64}
          unoptimized
          priority
          className="h-12 w-auto object-contain sm:h-14"
        />
        <h1 className="mt-6 font-titulo text-3xl font-semibold leading-tight text-sol sm:text-4xl">
          ¿Quién juega hoy?
        </h1>
        <p className="mt-2 max-w-[18rem] font-cuerpo text-base text-black/55 sm:text-lg">
          Toca tu avatar para empezar
        </p>
      </Aparecer>

      <ListaAparecer
        className="mx-auto mt-8 flex w-full max-w-sm flex-col gap-4"
        as="ul"
      >
        {ninos.map((nino) => (
          <AparecerItem key={nino.id} className="list-none">
            <form action={nino.action}>
              <motion.button
                type="submit"
                whileTap={reducir ? undefined : { scale: 0.97 }}
                transition={{ type: "spring", stiffness: 420, damping: 28 }}
                className="flex min-h-[6.5rem] w-full items-center gap-4 rounded-[24px] bg-white px-4 py-4 text-left shadow-[0_10px_28px_-14px_rgba(216,90,48,0.3)] transition hover:bg-white focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-sol"
              >
                <div className="relative h-20 w-20 shrink-0 overflow-hidden rounded-full bg-[#FFF8ED] shadow-[0_6px_16px_-6px_rgba(216,90,48,0.35)] ring-2 ring-white sm:h-24 sm:w-24">
                  {nino.avatarSrc ? (
                    <Image
                      src={nino.avatarSrc}
                      alt={nino.avatarAlt}
                      width={96}
                      height={96}
                      unoptimized
                      className="h-full w-full object-contain p-1"
                    />
                  ) : (
                    <span className="flex h-full w-full items-center justify-center font-titulo text-3xl font-semibold text-sol">
                      {nino.iniciales}
                    </span>
                  )}
                </div>
                <span className="min-w-0 flex-1 font-titulo text-2xl font-semibold leading-snug text-sol sm:text-3xl">
                  {nino.nombre}
                </span>
              </motion.button>
            </form>
          </AparecerItem>
        ))}
      </ListaAparecer>
    </Pantalla>
  );
}
