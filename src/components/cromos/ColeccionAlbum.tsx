"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { Check, ChevronLeft, X } from "lucide-react";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import {
  Aparecer,
  AparecerItem,
  Boton,
  ListaAparecer,
  Pantalla,
} from "@/components/ui";
import { CromoCara, EtiquetaRareza } from "@/components/cromos/CromoCara";
import { SaldoDiamantes } from "@/components/cromos/SaldoDiamantes";
import type {
  ColeccionVista,
  CromoAlbumItem,
  TematicaAlbum,
} from "@/lib/juego/cromos";
import { cn } from "@/lib/cn";

type Props = {
  coleccion: ColeccionVista;
};

export function ColeccionAlbum({ coleccion }: Props) {
  const [detalle, setDetalle] = useState<CromoAlbumItem | null>(null);

  return (
    <Pantalla className="fondo-halo-sol pb-10 pt-5">
      <Aparecer>
        <header className="relative flex items-center justify-center">
          <Link
            href="/mundo"
            aria-label="Volver"
            className="absolute left-0 flex h-11 w-11 items-center justify-center rounded-full bg-black/[0.06] text-black/45 transition hover:bg-black/10"
          >
            <ChevronLeft className="h-6 w-6 stroke-[1.75]" />
          </Link>
          <h1 className="px-14 font-titulo text-2xl font-semibold text-sol">
            Mi colección
          </h1>
          <div className="absolute right-0">
            <SaldoDiamantes diamantes={coleccion.diamantes} size="sm" />
          </div>
        </header>
      </Aparecer>

      <Aparecer delay={0.06} className="mt-5">
        <Boton href="/tienda" variant="primario">
          Ir a la tienda
        </Boton>
      </Aparecer>

      <Aparecer delay={0.1} className="mt-3 text-center">
        <p className="font-cuerpo text-sm text-black/50">
          {coleccion.conseguidos} de {coleccion.total} cromos
        </p>
      </Aparecer>

      <ListaAparecer className="mt-6 flex flex-col gap-4" as="div">
        {coleccion.tematicas.map((tema) => (
          <AparecerItem key={tema.id} as="div">
            <TarjetaCategoria
              tema={tema}
              onVerCromo={(c) => setDetalle(c)}
            />
          </AparecerItem>
        ))}
      </ListaAparecer>

      <ModalCromo
        cromo={detalle}
        onCerrar={() => setDetalle(null)}
      />
    </Pantalla>
  );
}

function TarjetaCategoria({
  tema,
  onVerCromo,
}: {
  tema: TematicaAlbum;
  onVerCromo: (cromo: CromoAlbumItem) => void;
}) {
  const completa = tema.conseguidos >= tema.total && tema.total > 0;
  const pct =
    tema.total > 0
      ? Math.min(100, Math.round((tema.conseguidos / tema.total) * 100))
      : 0;

  return (
    <section className="rounded-[24px] bg-white px-4 py-4 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.28)]">
      <div className="flex items-center justify-between gap-2">
        <h2 className="font-titulo text-xl font-semibold text-sol">
          {tema.nombre}
        </h2>
        <span
          className={cn(
            "inline-flex items-center gap-1 font-titulo text-sm font-semibold",
            completa ? "text-mar" : "text-black/45",
          )}
        >
          {completa ? (
            <Check className="h-4 w-4 stroke-[2.5]" aria-hidden />
          ) : null}
          {tema.conseguidos}/{tema.total}
        </span>
      </div>

      <div className="mt-3 grid grid-cols-4 gap-2">
        {tema.cromos.map((c) =>
          c.loTiene ? (
            <button
              key={c.id}
              type="button"
              onClick={() => onVerCromo(c)}
              className="rounded-xl text-left transition active:scale-[0.97] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-sol"
              aria-label={`Ver ${c.nombre}`}
            >
              <CromoCara
                loTiene
                nombre={c.nombre}
                imagenSrc={c.imagenSrc}
                rareza={c.rareza}
                size="sm"
              />
            </button>
          ) : (
            <CromoCara key={c.id} loTiene={false} size="sm" />
          ),
        )}
      </div>

      <div className="mt-3">
        <div
          className="h-2 overflow-hidden rounded-full bg-black/[0.06]"
          role="progressbar"
          aria-valuenow={tema.conseguidos}
          aria-valuemin={0}
          aria-valuemax={tema.total}
          aria-label={`${tema.conseguidos} de ${tema.total}`}
        >
          <div
            className={cn(
              "h-full rounded-full transition-[width] duration-500",
              completa ? "bg-mar" : "bg-sol-claro",
            )}
            style={{ width: `${pct}%` }}
          />
        </div>
      </div>
    </section>
  );
}

function ModalCromo({
  cromo,
  onCerrar,
}: {
  cromo: CromoAlbumItem | null;
  onCerrar: () => void;
}) {
  const reducir = useReducedMotion();

  useEffect(() => {
    if (!cromo) return;
    function onKey(e: KeyboardEvent) {
      if (e.key === "Escape") onCerrar();
    }
    window.addEventListener("keydown", onKey);
    const prev = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => {
      window.removeEventListener("keydown", onKey);
      document.body.style.overflow = prev;
    };
  }, [cromo, onCerrar]);

  return (
    <AnimatePresence>
      {cromo?.loTiene ? (
        <motion.div
          key={cromo.id}
          className="fixed inset-0 z-50 flex items-center justify-center px-6"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.2 }}
        >
          <button
            type="button"
            className="absolute inset-0 bg-[#3A2A1A]/45 backdrop-blur-[2px]"
            aria-label="Cerrar"
            onClick={onCerrar}
          />

          <motion.div
            role="dialog"
            aria-modal
            aria-label={cromo.nombre}
            className="relative z-10 w-full max-w-xs rounded-[28px] bg-white p-5 shadow-[0_20px_50px_-20px_rgba(0,0,0,0.45)]"
            initial={reducir ? false : { opacity: 0, scale: 0.88, y: 16 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={reducir ? undefined : { opacity: 0, scale: 0.92, y: 10 }}
            transition={{ type: "spring", stiffness: 380, damping: 22 }}
          >
            <button
              type="button"
              onClick={onCerrar}
              className="absolute right-3 top-3 flex h-10 w-10 items-center justify-center rounded-full bg-black/[0.06] text-black/45 transition hover:bg-black/10"
              aria-label="Cerrar"
            >
              <X className="h-5 w-5 stroke-[2]" />
            </button>

            <div className="mx-auto w-[85%]">
              <CromoCara
                loTiene
                nombre={cromo.nombre}
                imagenSrc={cromo.imagenSrc}
                rareza={cromo.rareza}
                size="lg"
              />
            </div>

            <div className="mt-4 flex flex-col items-center gap-2 text-center">
              <EtiquetaRareza rareza={cromo.rareza} />
              <h2 className="font-titulo text-2xl font-semibold text-sol">
                {cromo.nombre}
              </h2>
            </div>
          </motion.div>
        </motion.div>
      ) : null}
    </AnimatePresence>
  );
}
