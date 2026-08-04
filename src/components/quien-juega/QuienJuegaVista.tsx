"use client";

import Image from "next/image";
import { motion, useReducedMotion } from "framer-motion";
import {
  Aparecer,
  AparecerItem,
  ListaAparecer,
  Pantalla,
} from "@/components/ui";
import { Solete } from "@/components/solete";
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
    <Pantalla className="fondo-halo-sol flex flex-col pb-10 pt-8" sinAtmosfera>
      <Aparecer className="flex flex-col items-center text-center">
        <Solete mood="wave" size="lg" priority alt="" />
        <Image
          src={publicAssetClient("assets/logos/solete_texto.png")}
          alt="Solete"
          width={200}
          height={64}
          unoptimized
          priority
          className="mt-3 h-10 w-auto object-contain sm:h-12"
        />
        <h1 className="mt-5 font-titulo text-3xl font-semibold leading-tight text-primary sm:text-4xl">
          ¿Quién juega hoy?
        </h1>
        <p className="mt-2 max-w-[18rem] font-cuerpo text-base text-readable sm:text-lg">
          Toca tu foto para empezar
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
                whileTap={reducir ? undefined : { scale: 0.98 }}
                transition={{ duration: 0.12 }}
                className="flex min-h-[7rem] w-full items-center gap-4 rounded-card bg-surface px-4 py-4 text-left shadow-elevated transition focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus"
              >
                <div className="relative h-20 w-20 shrink-0 overflow-hidden rounded-full bg-surface-muted shadow-card ring-2 ring-white sm:h-24 sm:w-24">
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
                    <span className="flex h-full w-full items-center justify-center font-titulo text-3xl font-semibold text-primary">
                      {nino.iniciales}
                    </span>
                  )}
                </div>
                <span className="min-w-0 flex-1 font-titulo text-2xl font-semibold leading-snug text-primary sm:text-3xl">
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
