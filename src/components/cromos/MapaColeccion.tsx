"use client";

import {
  Aparecer,
  AparecerItem,
  Boton,
  CabeceraNino,
  ListaAparecer,
  Pantalla,
} from "@/components/ui";
import { SaldoDiamantes } from "@/components/cromos/SaldoDiamantes";
import { MundoCategoriaCard } from "@/components/cromos/MundoCategoriaCard";
import { Solete } from "@/components/solete";
import {
  siguienteObjetivoMundo,
  type MundoVista,
} from "@/components/cromos/mapa-coleccion";
import type { TipColeccion } from "@/components/cromos/coleccion-mensajes";
import type { TematicaId } from "@/lib/juego/cromos-catalogo";
import { cn } from "@/lib/cn";

type Props = {
  diamantes: number;
  conseguidos: number;
  total: number;
  legendariosConseguidos: number;
  legendariosTotal: number;
  mundos: MundoVista[];
  tip: TipColeccion | null;
  onAbrirMundo: (id: TematicaId) => void;
};

/**
 * Hub del álbum: mapa de mundos / categorías.
 */
export function MapaColeccion({
  diamantes,
  conseguidos,
  total,
  legendariosConseguidos,
  legendariosTotal,
  mundos,
  tip,
  onAbrirMundo,
}: Props) {
  const objetivo = siguienteObjetivoMundo(mundos);

  return (
    <Pantalla className="fondo-halo-sol pb-10 pt-5" sinAtmosfera ancho="ancho">
      <Aparecer>
        <CabeceraNino
          titulo="Mi colección"
          trailing={<SaldoDiamantes diamantes={diamantes} size="sm" />}
        />
      </Aparecer>

      <Aparecer delay={0.05} className="mt-3 text-center">
        <p className="font-cuerpo text-base text-readable">
          <span className="font-titulo font-semibold text-primary">
            {conseguidos}
          </span>{" "}
          / {total} cromos
          <span className="mx-1.5 text-readable/40" aria-hidden>
            ·
          </span>
          <span className="font-titulo font-semibold text-[#7A4FE0]">
            {legendariosConseguidos}
          </span>{" "}
          / {legendariosTotal} 👑
        </p>
      </Aparecer>

      {tip ? (
        <Aparecer delay={0.08} className="mt-3">
          <div className="flex items-center justify-center gap-2 rounded-2xl bg-limon/30 px-3 py-2.5">
            <Solete mood={tip.mood} size="xs" alt="" />
            <p className="font-titulo text-sm font-semibold text-primary">
              {tip.text}
            </p>
          </div>
        </Aparecer>
      ) : null}

      {objetivo && !objetivo.mundoCompleto ? (
        <Aparecer delay={0.1} className="mt-4">
          <button
            type="button"
            onClick={() => onAbrirMundo(objetivo.tema.id)}
            className={cn(
              "flex w-full items-center gap-3 rounded-card bg-surface px-4 py-3.5 text-left shadow-elevated ring-2 ring-sol/25 transition active:scale-[0.99] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus",
            )}
          >
            <span className="text-3xl" aria-hidden>
              {objetivo.emoji}
            </span>
            <div className="min-w-0 flex-1">
              <p className="font-titulo text-xs font-semibold uppercase tracking-wide text-sol">
                Siguiente objetivo
              </p>
              <p className="font-titulo text-lg font-semibold text-primary">
                {objetivo.tema.nombre}
              </p>
              <p className="font-cuerpo text-sm text-readable">
                {objetivo.faltanNormales > 0
                  ? objetivo.faltanNormales === 1
                    ? "Solo te falta 1 cromo"
                    : `Te faltan ${objetivo.faltanNormales} cromos`
                  : "¡A por los legendarios!"}
              </p>
            </div>
          </button>
        </Aparecer>
      ) : null}

      <Aparecer delay={0.12} className="mt-5">
        <h2 className="font-titulo text-base font-semibold text-primary">
          Tus mundos
        </h2>
        <p className="mt-0.5 font-cuerpo text-sm text-readable">
          Elige uno para ver tu colección
        </p>
      </Aparecer>

      <ListaAparecer className="mt-3 flex flex-col gap-3" as="div">
        {mundos.map((m) => (
          <AparecerItem key={m.tema.id} as="div">
            <MundoCategoriaCard
              mundo={m}
              onAbrir={onAbrirMundo}
              destacado={objetivo?.tema.id === m.tema.id && !m.mundoCompleto}
            />
          </AparecerItem>
        ))}
      </ListaAparecer>

      <Aparecer delay={0.16} className="mt-6">
        <Boton href="/tienda" variant="primario">
          Ir a la tienda
        </Boton>
      </Aparecer>
    </Pantalla>
  );
}
