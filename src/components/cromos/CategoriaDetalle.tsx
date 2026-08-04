"use client";

import { Check } from "lucide-react";
import {
  Aparecer,
  BarraProgreso,
  Boton,
  CabeceraNino,
  Pantalla,
} from "@/components/ui";
import { CardGrid } from "@/components/cromos/CardGrid";
import { LegendarySection } from "@/components/cromos/LegendarySection";
import { SaldoDiamantes } from "@/components/cromos/SaldoDiamantes";
import { Solete } from "@/components/solete";
import { tipCategoria } from "@/components/cromos/coleccion-mensajes";
import {
  MUNDO_COLORES,
  type MundoVista,
} from "@/components/cromos/mapa-coleccion";
import type { CromoAlbumItem } from "@/lib/juego/cromos";
import type { LegendarioProgresoItem } from "@/lib/juego/legendarios-eval";

type Props = {
  mundo: MundoVista;
  diamantes: number;
  onVolver: () => void;
  onVerCromo: (cromo: CromoAlbumItem) => void;
  onVerLegendario: (item: LegendarioProgresoItem) => void;
};

/**
 * Detalle de un mundo: cromos + legendarios siempre visibles.
 */
export function CategoriaDetalle({
  mundo,
  diamantes,
  onVolver,
  onVerCromo,
  onVerLegendario,
}: Props) {
  const colores = MUNDO_COLORES[mundo.tema.id];
  const tip = tipCategoria({
    normalesConseguidos: mundo.tema.conseguidos,
    normalesTotal: mundo.tema.total,
    legendariosConseguidos: mundo.legConseguidos,
    legendariosTotal: mundo.legTotal,
  });

  return (
    <Pantalla className="fondo-halo-sol pb-10 pt-5" sinAtmosfera ancho="ancho">
      <Aparecer>
        <CabeceraNino
          titulo={mundo.tema.nombre}
          onVolver={onVolver}
          labelVolver="Volver al mapa"
          trailing={<SaldoDiamantes diamantes={diamantes} size="sm" />}
        />
      </Aparecer>

      <Aparecer delay={0.05} className="mt-4 text-center">
        <span className="text-4xl" aria-hidden>
          {mundo.emoji}
        </span>
        <div className="mt-2 flex flex-wrap items-center justify-center gap-2">
          <span
            className="inline-flex items-center gap-1 rounded-full px-2.5 py-1 font-titulo text-xs font-semibold"
            style={{
              backgroundColor: colores.soft,
              color: colores.accent,
            }}
          >
            {mundo.normalesCompletos ? (
              <Check className="h-3.5 w-3.5 stroke-[2.5]" aria-hidden />
            ) : null}
            {mundo.tema.conseguidos}/{mundo.tema.total} cromos
          </span>
          {mundo.legTotal > 0 ? (
            <span className="inline-flex items-center gap-1 rounded-full bg-[#9B6DFF]/12 px-2.5 py-1 font-titulo text-xs font-semibold text-[#7A4FE0]">
              👑 {mundo.legConseguidos}/{mundo.legTotal}
            </span>
          ) : null}
        </div>
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

      <Aparecer delay={0.1} className="mt-5">
        <h2 className="font-titulo text-base font-semibold text-primary">
          Cromos
        </h2>
        <div className="mt-2.5">
          <CardGrid cromos={mundo.tema.cromos} onVerCromo={onVerCromo} />
        </div>
        <div className="mt-3">
          <BarraProgreso
            valor={mundo.tema.conseguidos}
            max={Math.max(mundo.tema.total, 1)}
            size="sm"
            tono={mundo.normalesCompletos ? "mar" : "sol"}
            aria-label={`${mundo.tema.conseguidos} de ${mundo.tema.total}`}
          />
        </div>
      </Aparecer>

      {mundo.legTotal > 0 ? (
        <Aparecer delay={0.12} className="mt-6">
          <div
            className="rounded-card px-3 py-3 shadow-card"
            style={{
              background: `linear-gradient(160deg, #FFFBF5 0%, rgba(155, 109, 255, 0.1) 100%)`,
            }}
          >
            <LegendarySection
              items={mundo.legendarios}
              onVer={onVerLegendario}
              className="mt-0 border-0 pt-0"
            />
            <div className="mt-3 px-1">
              <BarraProgreso
                valor={mundo.legConseguidos}
                max={mundo.legTotal}
                size="sm"
                tono={
                  mundo.legConseguidos >= mundo.legTotal ? "mar" : "sol"
                }
                aria-label={`${mundo.legConseguidos} de ${mundo.legTotal} legendarios`}
              />
            </div>
          </div>
        </Aparecer>
      ) : null}

      <Aparecer delay={0.14} className="mt-6">
        <Boton href="/tienda" variant="primario">
          Ir a la tienda
        </Boton>
      </Aparecer>
    </Pantalla>
  );
}
