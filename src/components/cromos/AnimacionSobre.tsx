"use client";

import Image from "next/image";
import { useEffect, useState } from "react";
import { Gem } from "lucide-react";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { Boton } from "@/components/ui";
import { Confeti } from "@/components/juego/Confeti";
import { CromoCara, EtiquetaRareza } from "@/components/cromos/CromoCara";
import { COLORES_RAREZA } from "@/lib/juego/cromos-estilo";
import type { CromoObtenido, ItemSobre } from "@/lib/juego/cromos";
import { cn } from "@/lib/cn";

type Props = {
  /** Un cromo (sobre clásico) o varios (sobre grande). */
  items: ItemSobre[];
  /** Color del sobre en la animación inicial. */
  varianteSobre?: "clasico" | "grande";
  onCerrar: () => void;
};

type Fase = "temblor" | "flash" | "revelacion";

/**
 * Fanfarria al abrir un sobre: temblor → flash → revelación.
 */
export function AnimacionSobre({
  items,
  varianteSobre = "clasico",
  onCerrar,
}: Props) {
  const reducir = useReducedMotion();
  const [fase, setFase] = useState<Fase>(reducir ? "revelacion" : "temblor");
  const multi = items.length > 1;
  const primer = items[0]!;
  const hayEspecial = items.some((i) => !i.repetido && i.cromo.rareza === "especial");
  const hayRaro = items.some(
    (i) => !i.repetido && (i.cromo.rareza === "raro" || i.cromo.rareza === "especial"),
  );
  const devolucionTotal = items.reduce((s, i) => s + i.diamantesDevueltos, 0);
  const nuevos = items.filter((i) => !i.repetido).length;

  useEffect(() => {
    if (reducir) return;
    const t1 = window.setTimeout(() => setFase("flash"), 1000);
    const t2 = window.setTimeout(() => setFase("revelacion"), 1300);
    return () => {
      window.clearTimeout(t1);
      window.clearTimeout(t2);
    };
  }, [reducir]);

  const mensaje = multi
    ? nuevos === 0
      ? `¡Repetidos! Te devolvemos ${devolucionTotal}`
      : nuevos === items.length
        ? "¡Tres cromos nuevos!"
        : `¡${nuevos} nuevos en el sobre!`
    : primer.repetido
      ? `¡Ya lo tenías! Te devolvemos ${primer.diamantesDevueltos}`
      : primer.cromo.rareza === "especial"
        ? "¡Guau! ¡Un cromo especial!"
        : "¡Nuevo para tu colección!";

  const estilo = COLORES_RAREZA[primer.cromo.rareza];
  const conConfeti = hayRaro;
  const cantidadConfeti = hayEspecial ? 56 : 36;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-[#FFF8ED]/94 backdrop-blur-[2px]">
      {fase === "revelacion" && conConfeti ? (
        <Confeti cantidad={cantidadConfeti} colores={estilo.confeti} />
      ) : null}

      <div className="relative z-20 flex w-full max-w-sm flex-col items-center px-5 text-center">
        <AnimatePresence mode="wait">
          {fase === "temblor" || fase === "flash" ? (
            <motion.div
              key="sobre"
              className="relative flex flex-col items-center"
              exit={{ opacity: 0, scale: 1.4 }}
              transition={{ duration: 0.2 }}
            >
              <SobreVisual
                temblando={fase === "temblor" && !reducir}
                flash={fase === "flash"}
                variante={varianteSobre}
              />
              {fase === "flash" ? (
                <motion.div
                  className="pointer-events-none absolute inset-[-40%] rounded-full bg-white"
                  initial={{ opacity: 0 }}
                  animate={{ opacity: [0, 1, 0] }}
                  transition={{ duration: 0.35 }}
                  aria-hidden
                />
              ) : null}
            </motion.div>
          ) : (
            <motion.div
              key="revelacion"
              className="flex w-full flex-col items-center"
              initial={reducir ? false : { opacity: 0 }}
              animate={{ opacity: 1 }}
            >
              <p className="inline-flex flex-wrap items-center justify-center gap-1.5 font-titulo text-2xl font-semibold text-sol sm:text-3xl">
                <span>{mensaje}</span>
                {(multi ? devolucionTotal > 0 : primer.repetido) ? (
                  <span className="inline-flex items-center gap-1 text-mar">
                    <Gem className="h-6 w-6 stroke-[2]" aria-hidden />
                  </span>
                ) : null}
              </p>

              {multi ? (
                <div className="mt-6 grid w-full grid-cols-3 gap-2">
                  {items.map((item, i) => (
                    <motion.div
                      key={`${item.cromo.id}-${i}`}
                      className="flex flex-col items-center gap-1.5"
                      initial={
                        reducir ? false : { opacity: 0, scale: 0.4, y: 24 }
                      }
                      animate={{ opacity: 1, scale: 1, y: 0 }}
                      transition={{
                        type: "spring",
                        stiffness: 380,
                        damping: 16,
                        delay: i * 0.12,
                      }}
                    >
                      <CromoCara
                        loTiene
                        nombre={item.cromo.nombre}
                        imagenSrc={item.cromo.imagenSrc}
                        rareza={item.cromo.rareza}
                        size="sm"
                      />
                      <EtiquetaRareza rareza={item.cromo.rareza} />
                      <p className="line-clamp-2 font-titulo text-xs font-semibold leading-tight text-sol">
                        {item.cromo.nombre}
                      </p>
                      {item.repetido ? (
                        <p className="font-cuerpo text-[10px] text-black/45">
                          repetido
                        </p>
                      ) : null}
                    </motion.div>
                  ))}
                </div>
              ) : (
                <>
                  <div className="relative mt-8 flex w-[11.5rem] items-center justify-center sm:w-52">
                    {!primer.repetido &&
                    primer.cromo.rareza === "especial" &&
                    !reducir ? (
                      <motion.div
                        aria-hidden
                        className="absolute inset-[-35%] rounded-full"
                        style={{
                          background:
                            "conic-gradient(from 0deg, transparent 0deg, #E09A2E88 40deg, transparent 80deg, #F0C05A77 140deg, transparent 180deg, #E09A2E66 260deg, transparent 320deg)",
                        }}
                        animate={{ rotate: 360 }}
                        transition={{
                          duration: 8,
                          repeat: Infinity,
                          ease: "linear",
                        }}
                      />
                    ) : null}

                    <motion.div
                      className="relative w-full"
                      initial={
                        reducir ? false : { opacity: 0, scale: 0.35, y: 48 }
                      }
                      animate={{ opacity: 1, scale: 1, y: 0 }}
                      transition={{
                        type: "spring",
                        stiffness: 380,
                        damping: 14,
                        mass: 0.9,
                      }}
                    >
                      <CromoCara
                        loTiene
                        nombre={primer.cromo.nombre}
                        imagenSrc={primer.cromo.imagenSrc}
                        rareza={primer.cromo.rareza}
                        size="lg"
                      />
                    </motion.div>
                  </div>

                  <div className="mt-5 flex flex-col items-center gap-2">
                    <EtiquetaRareza rareza={primer.cromo.rareza} />
                    <h2 className="font-titulo text-2xl font-semibold text-sol">
                      {primer.cromo.nombre}
                    </h2>
                  </div>
                </>
              )}

              <div className="mt-10 w-full">
                <Boton type="button" variant="primario" onClick={onCerrar}>
                  ¡Genial!
                </Boton>
              </div>
            </motion.div>
          )}
        </AnimatePresence>
      </div>
    </div>
  );
}

/** Compat: revelación de un solo cromo (API antigua). */
export function AnimacionSobreSimple({
  cromo,
  repetido,
  diamantesDevueltos,
  onCerrar,
}: {
  cromo: CromoObtenido;
  repetido: boolean;
  diamantesDevueltos: number;
  onCerrar: () => void;
}) {
  return (
    <AnimacionSobre
      items={[{ cromo, repetido, diamantesDevueltos }]}
      onCerrar={onCerrar}
    />
  );
}

function SobreVisual({
  temblando,
  flash,
  variante,
}: {
  temblando: boolean;
  flash: boolean;
  variante: "clasico" | "grande";
}) {
  const grande = variante === "grande";
  return (
    <motion.div
      className={cn("relative", grande ? "h-44 w-52" : "h-40 w-48")}
      animate={
        temblando
          ? {
              rotate: [-8, 8, -10, 10, -6, 6, 0],
              x: [-4, 4, -5, 5, -2, 2, 0],
              y: [0, -3, 2, -4, 1, 0],
            }
          : flash
            ? { scale: 1.15, opacity: 0.3 }
            : { rotate: [-3, 3, -3], y: [0, -4, 0] }
      }
      transition={
        temblando
          ? { duration: 0.12, repeat: Infinity }
          : flash
            ? { duration: 0.25 }
            : { duration: 2.4, repeat: Infinity, ease: "easeInOut" }
      }
    >
      <div
        className={cn(
          "absolute inset-x-2 bottom-0 top-10 rounded-b-2xl shadow-[0_12px_28px_-10px_rgba(0,0,0,0.35)]",
          grande
            ? "bg-[linear-gradient(160deg,#7EB8E8_0%,#3D7AB5_100%)]"
            : "bg-[linear-gradient(160deg,#F0997B_0%,#D85A30_100%)]",
        )}
      />
      <div
        className="absolute inset-x-2 top-2 h-24 origin-top"
        style={{
          clipPath: "polygon(0 0, 50% 55%, 100% 0)",
          background: grande
            ? "linear-gradient(180deg, #B8D9F5 0%, #6FA3D4 100%)"
            : "linear-gradient(180deg, #FAC775 0%, #E8A84A 100%)",
        }}
      />
      <div className="absolute inset-x-0 bottom-6 flex justify-center">
        <Image
          src="/assets/logos/solete_solo_logo.png"
          alt=""
          width={48}
          height={48}
          className="h-12 w-12 object-contain opacity-90 drop-shadow-sm"
          aria-hidden
        />
      </div>
      {grande ? (
        <span className="absolute bottom-2 left-1/2 -translate-x-1/2 font-titulo text-xs font-bold tracking-wide text-white/90">
          ×3
        </span>
      ) : null}
    </motion.div>
  );
}
