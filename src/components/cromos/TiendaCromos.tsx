"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { useMemo, useState, useTransition, type ReactNode } from "react";
import { ChevronLeft, Gem } from "lucide-react";
import { motion, useReducedMotion } from "framer-motion";
import {
  Aparecer,
  Boton,
  Pantalla,
} from "@/components/ui";
import { AnimacionSobre } from "@/components/cromos/AnimacionSobre";
import { CromoCara, EtiquetaRareza } from "@/components/cromos/CromoCara";
import { SaldoDiamantes } from "@/components/cromos/SaldoDiamantes";
import {
  abrirSobreAction,
  comprarCromoAction,
} from "@/app/actions/cromos";
import {
  CROMOS_ECONOMIA,
  TEMATICAS_CROMOS,
  precioPorRareza,
  type TematicaId,
} from "@/lib/juego/cromos-catalogo";
import type {
  ColeccionVista,
  CromoAlbumItem,
  CromoObtenido,
} from "@/lib/juego/cromos";
import { cn } from "@/lib/cn";

type Filtro = "todas" | TematicaId;

type Props = {
  coleccion: ColeccionVista;
};

type ResultadoSobreOk = {
  cromo: CromoObtenido;
  repetido: boolean;
  diamantesDevueltos: number;
  diamantesTotales: number;
};

export function TiendaCromos({ coleccion: inicial }: Props) {
  const router = useRouter();
  const reducir = useReducedMotion();
  const [pending, startTransition] = useTransition();
  const [diamantes, setDiamantes] = useState(inicial.diamantes);
  const [tematicas, setTematicas] = useState(inicial.tematicas);
  const [filtro, setFiltro] = useState<Filtro>("todas");
  const [error, setError] = useState<string | null>(null);
  const [comprandoId, setComprandoId] = useState<string | null>(null);
  const [abriendo, setAbriendo] = useState(false);
  const [revelacion, setRevelacion] = useState<ResultadoSobreOk | null>(null);

  const faltan = useMemo(() => {
    const todos: CromoAlbumItem[] = tematicas.flatMap((t) => t.cromos);
    return todos.filter((c) => !c.loTiene);
  }, [tematicas]);

  const visibles = useMemo(() => {
    if (filtro === "todas") return faltan;
    return faltan.filter((c) => c.tematicaId === filtro);
  }, [faltan, filtro]);

  const puedeSobre = diamantes >= CROMOS_ECONOMIA.precioSobre;

  function marcarPoseido(cromoId: string, nuevosDiamantes: number) {
    setDiamantes(nuevosDiamantes);
    setTematicas((prev) =>
      prev.map((t) => {
        const cromos = t.cromos.map((c) =>
          c.id === cromoId
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
    const precio = precioPorRareza(cromo.rareza);
    if (diamantes < precio || pending || comprandoId) return;
    setError(null);
    setComprandoId(cromo.id);
    startTransition(async () => {
      const res = await comprarCromoAction(cromo.id);
      setComprandoId(null);
      if (!res.ok) {
        setError(res.error);
        return;
      }
      marcarPoseido(res.cromo.id, res.diamantesTotales);
      router.refresh();
    });
  }

  function abrirSobre() {
    if (!puedeSobre || pending || abriendo) return;
    setError(null);
    setAbriendo(true);
    startTransition(async () => {
      const res = await abrirSobreAction();
      setAbriendo(false);
      if (!res.ok) {
        setError(res.error);
        return;
      }
      setDiamantes(res.diamantesTotales);
      if (!res.repetido) {
        marcarPoseido(res.cromo.id, res.diamantesTotales);
      }
      setRevelacion({
        cromo: res.cromo,
        repetido: res.repetido,
        diamantesDevueltos: res.diamantesDevueltos,
        diamantesTotales: res.diamantesTotales,
      });
    });
  }

  function cerrarRevelacion() {
    setRevelacion(null);
    router.refresh();
  }

  return (
    <Pantalla className="fondo-halo-sol pb-10 pt-5">
      {revelacion ? (
        <AnimacionSobre
          cromo={revelacion.cromo}
          repetido={revelacion.repetido}
          diamantesDevueltos={revelacion.diamantesDevueltos}
          onCerrar={cerrarRevelacion}
        />
      ) : null}

      <Aparecer>
        <header className="relative flex items-center justify-center">
          <Link
            href="/coleccion"
            aria-label="Volver"
            className="absolute left-0 flex h-11 w-11 items-center justify-center rounded-full bg-black/[0.06] text-black/45 transition hover:bg-black/10"
          >
            <ChevronLeft className="h-6 w-6 stroke-[1.75]" />
          </Link>
          <h1 className="px-14 font-titulo text-2xl font-semibold text-sol">
            Tienda
          </h1>
          <div className="absolute right-0">
            <SaldoDiamantes diamantes={diamantes} size="sm" />
          </div>
        </header>
      </Aparecer>

      {/* Sobre sorpresa */}
      <Aparecer delay={0.06} className="mt-5">
        <div className="rounded-[24px] bg-[linear-gradient(145deg,#FFF8ED_0%,#FFE4C8_55%,#F0997B33_100%)] px-4 py-5 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.35)]">
          <div className="flex flex-col items-center text-center">
            <SobreBalanceo reducir={Boolean(reducir)} />
            <h2 className="mt-3 font-titulo text-xl font-semibold text-sol">
              Sobre sorpresa
            </h2>
            <p className="mt-1 max-w-[16rem] font-cuerpo text-sm text-black/55">
              ¡Ábrelo y descubre qué cromo te toca!
            </p>
            <div className="mt-4 w-full max-w-xs">
              <Boton
                type="button"
                variant="primario"
                disabled={!puedeSobre || pending || abriendo}
                onClick={abrirSobre}
              >
                {abriendo ? (
                  "Abriendo…"
                ) : (
                  <>
                    Abrir por {CROMOS_ECONOMIA.precioSobre}{" "}
                    <Gem className="h-5 w-5 stroke-[2]" aria-hidden />
                  </>
                )}
              </Boton>
            </div>
          </div>
        </div>
      </Aparecer>

      <Aparecer delay={0.1} className="mt-6">
        <p className="text-center font-titulo text-base text-black/40">
          o compra el que quieras
        </p>
      </Aparecer>

      {/* Filtros */}
      <Aparecer delay={0.12} className="mt-4">
        <div className="-mx-1 flex gap-2 overflow-x-auto px-1 pb-1 [scrollbar-width:none] [&::-webkit-scrollbar]:hidden">
          <FiltroChip
            activo={filtro === "todas"}
            onClick={() => setFiltro("todas")}
          >
            Todas
          </FiltroChip>
          {TEMATICAS_CROMOS.map((t) => (
            <FiltroChip
              key={t.id}
              activo={filtro === t.id}
              onClick={() => setFiltro(t.id)}
            >
              {t.nombre}
            </FiltroChip>
          ))}
        </div>
      </Aparecer>

      {error ? (
        <p className="mt-3 text-center font-cuerpo text-sm text-fallo" role="alert">
          {error}
        </p>
      ) : null}

      {visibles.length === 0 ? (
        <Aparecer delay={0.15} className="mt-8 text-center">
          <p className="font-titulo text-lg text-mar">
            {faltan.length === 0
              ? "¡Ya tienes todos los cromos!"
              : "No hay cromos en esta categoría"}
          </p>
        </Aparecer>
      ) : (
        <div className="mt-5 grid grid-cols-2 gap-3">
          {visibles.map((cromo) => {
            const precio = precioPorRareza(cromo.rareza);
            const puede = diamantes >= precio;
            const cargando = comprandoId === cromo.id;
            return (
              <article
                key={cromo.id}
                className="flex flex-col rounded-[22px] bg-white p-3 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.28)]"
              >
                <CromoCara
                  loTiene
                  nombre={cromo.nombre}
                  imagenSrc={cromo.imagenSrc}
                  rareza={cromo.rareza}
                  size="md"
                />
                <div className="mt-2 flex flex-col items-center gap-1 text-center">
                  <EtiquetaRareza rareza={cromo.rareza} />
                  <h3 className="font-titulo text-base font-semibold leading-snug text-sol">
                    {cromo.nombre}
                  </h3>
                </div>
                <div className="mt-3">
                  <Boton
                    type="button"
                    variant="secundario"
                    size="md"
                    disabled={!puede || pending || Boolean(comprandoId)}
                    onClick={() => comprar(cromo)}
                    className={cn(!puede && "opacity-45")}
                  >
                    {cargando ? (
                      "…"
                    ) : (
                      <>
                        {precio}{" "}
                        <Gem className="h-4 w-4 stroke-[2]" aria-hidden />
                      </>
                    )}
                  </Boton>
                </div>
              </article>
            );
          })}
        </div>
      )}
    </Pantalla>
  );
}

function FiltroChip({
  children,
  activo,
  onClick,
}: {
  children: ReactNode;
  activo: boolean;
  onClick: () => void;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={cn(
        "shrink-0 rounded-full px-3.5 py-2 font-titulo text-sm font-semibold transition",
        activo
          ? "bg-sol text-white shadow-[0_3px_0_0_rgba(184,64,28,0.3)]"
          : "bg-white/80 text-sol/80 shadow-[0_2px_8px_-4px_rgba(216,90,48,0.25)]",
      )}
    >
      {children}
    </button>
  );
}

function SobreBalanceo({ reducir }: { reducir: boolean }) {
  return (
    <motion.div
      className="relative h-24 w-28"
      animate={
        reducir
          ? undefined
          : { rotate: [-4, 4, -4], y: [0, -5, 0] }
      }
      transition={{ duration: 2.6, repeat: Infinity, ease: "easeInOut" }}
      aria-hidden
    >
      <div className="absolute inset-x-1 bottom-0 top-6 rounded-b-xl bg-[linear-gradient(160deg,#F0997B_0%,#D85A30_100%)] shadow-md" />
      <div
        className="absolute inset-x-1 top-1 h-14"
        style={{
          clipPath: "polygon(0 0, 50% 58%, 100% 0)",
          background: "linear-gradient(180deg, #FAC775 0%, #E8A84A 100%)",
        }}
      />
    </motion.div>
  );
}
