"use client";

import { useMemo, useState } from "react";
import { ModalBase } from "@/components/ui";
import { CategoriaDetalle } from "@/components/cromos/CategoriaDetalle";
import { CromoCara, EtiquetaRareza } from "@/components/cromos/CromoCara";
import { MapaColeccion } from "@/components/cromos/MapaColeccion";
import { mundosDesdeColeccion } from "@/components/cromos/mapa-coleccion";
import { tipColeccion } from "@/components/cromos/coleccion-mensajes";
import type {
  ColeccionVista,
  CromoAlbumItem,
} from "@/lib/juego/cromos";
import type { LegendarioProgresoItem } from "@/lib/juego/legendarios-eval";
import type { TematicaId } from "@/lib/juego/cromos-catalogo";

type Props = {
  coleccion: ColeccionVista;
};

/**
 * Álbum Concepto B: mapa de mundos (hub) + detalle por categoría.
 */
export function ColeccionAlbum({ coleccion }: Props) {
  const [mundoId, setMundoId] = useState<TematicaId | null>(null);
  const [detalle, setDetalle] = useState<CromoAlbumItem | null>(null);
  const [detalleLeg, setDetalleLeg] = useState<LegendarioProgresoItem | null>(
    null,
  );
  const legendarios = coleccion.legendarios;

  const mundos = useMemo(
    () =>
      mundosDesdeColeccion(coleccion.tematicas, legendarios.porCategoria),
    [coleccion.tematicas, legendarios.porCategoria],
  );

  const tip = useMemo(() => {
    const categoriasCompletas = coleccion.tematicas.filter(
      (t) => t.total > 0 && t.conseguidos >= t.total,
    ).length;

    let mejorFaltan: number | null = null;
    for (const t of coleccion.tematicas) {
      if (t.total <= 0 || t.conseguidos >= t.total) continue;
      const faltan = t.total - t.conseguidos;
      if (mejorFaltan == null || faltan < mejorFaltan) mejorFaltan = faltan;
    }

    return tipColeccion({
      normalesConseguidos: coleccion.conseguidos,
      normalesTotal: coleccion.total,
      legendariosConseguidos: legendarios.conseguidos,
      categoriasCompletas,
      categoriasTotal: coleccion.tematicas.length,
      faltanEnMejorCategoria: mejorFaltan,
    });
  }, [coleccion, legendarios.conseguidos]);

  const mundoActivo = mundoId
    ? mundos.find((m) => m.tema.id === mundoId) ?? null
    : null;

  const modales = (
    <>
      <ModalBase
        abierto={Boolean(detalle?.loTiene)}
        onCerrar={() => setDetalle(null)}
        aria-label={detalle?.nombre ?? "Cromo"}
      >
        {detalle?.loTiene ? (
          <>
            <div className="mx-auto w-full max-w-[16rem]">
              <CromoCara
                loTiene
                nombre={detalle.nombre}
                imagenSrc={detalle.imagenSrc}
                rareza={detalle.rareza}
                size="lg"
              />
            </div>
            <div className="mt-5 flex flex-col items-center gap-2 text-center">
              <EtiquetaRareza rareza={detalle.rareza} />
              <h2 className="font-titulo text-2xl font-semibold text-primary">
                {detalle.nombre}
              </h2>
            </div>
          </>
        ) : null}
      </ModalBase>

      <ModalBase
        abierto={Boolean(detalleLeg)}
        onCerrar={() => setDetalleLeg(null)}
        aria-label={
          detalleLeg?.loTiene ? detalleLeg.def.title : "Legendario pendiente"
        }
      >
        {detalleLeg ? (
          <>
            <div className="mx-auto w-full max-w-[16rem]">
              {detalleLeg.loTiene ? (
                <CromoCara
                  loTiene
                  nombre={detalleLeg.def.title}
                  imagenSrc={detalleLeg.imagenSrc}
                  rareza="legendary"
                  size="lg"
                />
              ) : (
                <CromoCara
                  loTiene={false}
                  imagenBloqueada={detalleLeg.imagenSrc}
                  rarezaBloqueada="legendary"
                  size="lg"
                />
              )}
            </div>
            <div className="mt-5 flex flex-col items-center gap-2 text-center">
              <EtiquetaRareza rareza="legendary" />
              <h2 className="font-titulo text-2xl font-semibold text-primary">
                {detalleLeg.def.emoji}{" "}
                {detalleLeg.loTiene || !detalleLeg.def.hidden
                  ? detalleLeg.def.title
                  : "???"}
              </h2>
              <p className="font-cuerpo text-base text-readable">
                {detalleLeg.def.description}
              </p>
              <p className="font-titulo text-base font-semibold text-[#7A4FE0]">
                Progreso · {detalleLeg.progresoTexto}
              </p>
            </div>
          </>
        ) : null}
      </ModalBase>
    </>
  );

  if (mundoActivo) {
    return (
      <>
        <CategoriaDetalle
          mundo={mundoActivo}
          diamantes={coleccion.diamantes}
          onVolver={() => setMundoId(null)}
          onVerCromo={(c) => setDetalle(c)}
          onVerLegendario={(l) => setDetalleLeg(l)}
        />
        {modales}
      </>
    );
  }

  return (
    <>
      <MapaColeccion
        diamantes={coleccion.diamantes}
        conseguidos={coleccion.conseguidos}
        total={coleccion.total}
        legendariosConseguidos={legendarios.conseguidos}
        legendariosTotal={legendarios.total}
        mundos={mundos}
        tip={tip}
        onAbrirMundo={setMundoId}
      />
      {modales}
    </>
  );
}
