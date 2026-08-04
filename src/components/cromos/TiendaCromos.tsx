"use client";

import { useRouter } from "next/navigation";
import { useMemo, useState, useTransition } from "react";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import {
  Aparecer,
  CabeceraNino,
  EstadoVacio,
  Pantalla,
} from "@/components/ui";
import { AnimacionSobre } from "@/components/cromos/AnimacionSobre";
import { CardItem } from "@/components/cromos/CardItem";
import { CompraIndividualGate } from "@/components/cromos/CompraIndividualGate";
import { PackShowcase } from "@/components/cromos/PackShowcase";
import { ShopFilters, type ShopFiltro } from "@/components/cromos/ShopFilters";
import { SaldoDiamantes } from "@/components/cromos/SaldoDiamantes";
import { Solete } from "@/components/solete";
import {
  abrirSobreAction,
  abrirSobreGrandeAction,
  comprarCromoAction,
} from "@/app/actions/cromos";
import type {
  ColeccionVista,
  CromoAlbumItem,
  ItemSobre,
} from "@/lib/juego/cromos";

type Props = {
  coleccion: ColeccionVista;
};

type Revelacion = {
  items: ItemSobre[];
  variante: "clasico" | "grande";
};

/**
 * Tienda de cromos: sobres = emoción principal; compra individual = herramienta.
 */
export function TiendaCromos({ coleccion: inicial }: Props) {
  const router = useRouter();
  const reducir = useReducedMotion();
  const [pending, startTransition] = useTransition();
  const [diamantes, setDiamantes] = useState(inicial.diamantes);
  const [tematicas, setTematicas] = useState(inicial.tematicas);
  const [filtro, setFiltro] = useState<ShopFiltro>("todas");
  const [error, setError] = useState<string | null>(null);
  const [comprandoId, setComprandoId] = useState<string | null>(null);
  const [abriendo, setAbriendo] = useState<"clasico" | "grande" | null>(null);
  const [revelacion, setRevelacion] = useState<Revelacion | null>(null);
  const [compraAbierta, setCompraAbierta] = useState(false);

  const faltan = useMemo(() => {
    const todos: CromoAlbumItem[] = tematicas.flatMap((t) => t.cromos);
    return todos.filter((c) => !c.loTiene);
  }, [tematicas]);

  const visibles = useMemo(() => {
    if (filtro === "todas") return faltan;
    return faltan.filter((c) => c.tematicaId === filtro);
  }, [faltan, filtro]);

  function marcarPoseidos(ids: string[], nuevosDiamantes: number) {
    setDiamantes(nuevosDiamantes);
    if (ids.length === 0) return;
    const setIds = new Set(ids);
    setTematicas((prev) =>
      prev.map((t) => {
        const cromos = t.cromos.map((c) =>
          setIds.has(c.id)
            ? { ...c, loTiene: true, obtenidoEn: new Date().toISOString() }
            : c,
        );
        return {
          ...t,
          cromos,
          conseguidos: cromos.filter((c) => c.loTiene).length,
        };
      }),
    );
  }

  function comprar(cromo: CromoAlbumItem) {
    if (pending || comprandoId) return;
    setError(null);
    setComprandoId(cromo.id);
    startTransition(async () => {
      const res = await comprarCromoAction(cromo.id);
      setComprandoId(null);
      if (!res.ok) {
        setError(res.error);
        return;
      }
      marcarPoseidos([res.cromo.id], res.diamantesTotales);
      router.refresh();
    });
  }

  function abrirClasico() {
    if (pending || abriendo) return;
    setError(null);
    setAbriendo("clasico");
    startTransition(async () => {
      const res = await abrirSobreAction();
      setAbriendo(null);
      if (!res.ok) {
        setError(res.error);
        return;
      }
      const items: ItemSobre[] = [
        {
          cromo: res.cromo,
          repetido: res.repetido,
          diamantesDevueltos: res.diamantesDevueltos,
        },
      ];
      setDiamantes(res.diamantesTotales);
      if (!res.repetido) {
        marcarPoseidos([res.cromo.id], res.diamantesTotales);
      }
      setRevelacion({ items, variante: "clasico" });
    });
  }

  function abrirGrande() {
    if (pending || abriendo) return;
    setError(null);
    setAbriendo("grande");
    startTransition(async () => {
      const res = await abrirSobreGrandeAction();
      setAbriendo(null);
      if (!res.ok) {
        setError(res.error);
        return;
      }
      setDiamantes(res.diamantesTotales);
      const nuevos = res.items.filter((i) => !i.repetido).map((i) => i.cromo.id);
      if (nuevos.length > 0) {
        marcarPoseidos(nuevos, res.diamantesTotales);
      }
      setRevelacion({ items: res.items, variante: "grande" });
    });
  }

  function cerrarRevelacion() {
    setRevelacion(null);
    router.refresh();
  }

  return (
    <Pantalla className="fondo-halo-sol pb-10 pt-5" sinAtmosfera>
      {revelacion ? (
        <AnimacionSobre
          items={revelacion.items}
          varianteSobre={revelacion.variante}
          onCerrar={cerrarRevelacion}
        />
      ) : null}

      <Aparecer>
        <CabeceraNino
          titulo="Tienda"
          hrefVolver="/coleccion"
          trailing={<SaldoDiamantes diamantes={diamantes} size="sm" />}
        />
      </Aparecer>

      {/* 1. Sobres = protagonista */}
      <Aparecer delay={0.06} className="mt-4">
        <PackShowcase
          diamantes={diamantes}
          pending={pending}
          abriendo={abriendo}
          onAbrirClasico={abrirClasico}
          onAbrirGrande={abrirGrande}
        />
      </Aparecer>

      {error ? (
        <p className="mt-3 text-center font-cuerpo text-sm text-error" role="alert">
          {error}
        </p>
      ) : null}

      {/* 2. Compra individual = secundaria */}
      <Aparecer delay={0.12} className="mt-6">
        <CompraIndividualGate
          faltan={faltan.length}
          abierto={compraAbierta}
          onToggle={() => setCompraAbierta((v) => !v)}
        />
      </Aparecer>

      <AnimatePresence initial={false}>
        {compraAbierta && faltan.length > 0 ? (
          <motion.div
            key="compra"
            initial={reducir ? false : { height: 0, opacity: 0 }}
            animate={{ height: "auto", opacity: 1 }}
            exit={reducir ? undefined : { height: 0, opacity: 0 }}
            transition={{ duration: reducir ? 0 : 0.28, ease: [0.22, 1, 0.36, 1] }}
            className="overflow-hidden"
          >
            <div className="mt-2 flex items-center justify-center gap-2 rounded-2xl bg-limon/25 px-3 py-2">
              <Solete mood="thinking" size="xs" alt="" />
              <p className="font-titulo text-sm font-semibold text-primary">
                Elige el que te falta
              </p>
            </div>

            <div className="mt-4">
              <ShopFilters filtro={filtro} onChange={setFiltro} />
            </div>

            {visibles.length === 0 ? (
              <div className="mt-6">
                <EstadoVacio
                  titulo="Nada en esta categoría"
                  descripcion="Prueba otra categoría o abre un sobre."
                />
              </div>
            ) : (
              <div className="mt-4 grid grid-cols-2 gap-2.5 sm:grid-cols-3 sm:gap-3">
                {visibles.map((cromo) => (
                  <CardItem
                    key={cromo.id}
                    cromo={cromo}
                    diamantes={diamantes}
                    pending={pending}
                    comprandoId={comprandoId}
                    onComprar={comprar}
                  />
                ))}
              </div>
            )}
          </motion.div>
        ) : null}
      </AnimatePresence>
    </Pantalla>
  );
}
