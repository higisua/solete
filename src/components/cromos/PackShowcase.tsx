"use client";

import { Gem } from "lucide-react";
import { motion, useReducedMotion } from "framer-motion";
import { Boton } from "@/components/ui";
import { Solete } from "@/components/solete";
import { CROMOS_ECONOMIA } from "@/lib/juego/cromos-catalogo";
import { cn } from "@/lib/cn";

type Props = {
  diamantes: number;
  pending: boolean;
  abriendo: "clasico" | "grande" | null;
  onAbrirClasico: () => void;
  onAbrirGrande: () => void;
  className?: string;
};

/**
 * Escaparate de sobres: acción principal de la tienda.
 */
export function PackShowcase({
  diamantes,
  pending,
  abriendo,
  onAbrirClasico,
  onAbrirGrande,
  className,
}: Props) {
  const reducir = useReducedMotion();
  const puedeSobre = diamantes >= CROMOS_ECONOMIA.precioSobre;
  const puedeGrande = diamantes >= CROMOS_ECONOMIA.precioSobreGrande;

  return (
    <section className={cn("w-full", className)} aria-label="Abrir sobres">
      <div className="flex flex-col items-center text-center">
        <Solete mood="gift" size="lg" priority alt="" />
        <h2 className="mt-2 font-titulo text-2xl font-semibold text-primary sm:text-3xl">
          ¡Abre un sobre!
        </h2>
        <p className="mt-1 max-w-[18rem] font-cuerpo text-base text-readable">
          ¿Qué cromo te tocará hoy?
        </p>
      </div>

      <div className="mt-6 flex flex-col gap-3.5">
        <PackHero
          titulo="Sobre sorpresa"
          detalle="1 cromo al azar"
          precio={CROMOS_ECONOMIA.precioSobre}
          tono="sol"
          reducir={Boolean(reducir)}
          disabled={!puedeSobre || pending || Boolean(abriendo)}
          loading={abriendo === "clasico"}
          onClick={onAbrirClasico}
          cta="¡Abrir!"
          destacado
        />
        <PackHero
          titulo="Sobre grande"
          detalle="¡3 cromos de una vez!"
          precio={CROMOS_ECONOMIA.precioSobreGrande}
          tono="mar"
          reducir={Boolean(reducir)}
          disabled={!puedeGrande || pending || Boolean(abriendo)}
          loading={abriendo === "grande"}
          onClick={onAbrirGrande}
          cta="¡Abrir ×3!"
          badge="×3"
        />
      </div>
    </section>
  );
}

function PackHero({
  titulo,
  detalle,
  precio,
  tono,
  reducir,
  disabled,
  loading,
  onClick,
  cta,
  badge,
  destacado = false,
}: {
  titulo: string;
  detalle: string;
  precio: number;
  tono: "sol" | "mar";
  reducir: boolean;
  disabled: boolean;
  loading: boolean;
  onClick: () => void;
  cta: string;
  badge?: string;
  destacado?: boolean;
}) {
  const sol = tono === "sol";

  return (
    <div
      className={cn(
        "relative overflow-hidden rounded-card px-4 py-5 text-center shadow-elevated",
        sol
          ? "bg-[linear-gradient(145deg,#FFF8ED_0%,#FFE4C8_50%,#F0997B33_100%)]"
          : "bg-[linear-gradient(145deg,#F2F8FD_0%,#D6EAF8_50%,#7EB8E844_100%)]",
        destacado && "ring-2 ring-sol/30",
      )}
    >
      <div
        aria-hidden
        className="pointer-events-none absolute -right-8 -top-10 h-28 w-28 rounded-full bg-white/40 blur-2xl"
      />

      <motion.div
        className={cn("relative mx-auto", sol ? "h-24 w-28" : "h-28 w-32")}
        animate={
          reducir || disabled
            ? undefined
            : { rotate: [-4, 4, -4], y: [0, -6, 0] }
        }
        transition={{ duration: 2.6, repeat: Infinity, ease: "easeInOut" }}
        aria-hidden
      >
        <div
          className={cn(
            "absolute inset-x-1 bottom-0 top-6 rounded-b-xl shadow-md",
            sol
              ? "bg-[linear-gradient(160deg,#F0997B_0%,#D85A30_100%)]"
              : "bg-[linear-gradient(160deg,#7EB8E8_0%,#3D7AB5_100%)]",
          )}
        />
        <div
          className="absolute inset-x-1 top-1 h-14"
          style={{
            clipPath: "polygon(0 0, 50% 58%, 100% 0)",
            background: sol
              ? "linear-gradient(180deg, #FAC775 0%, #E8A84A 100%)"
              : "linear-gradient(180deg, #B8D9F5 0%, #6FA3D4 100%)",
          }}
        />
        {badge ? (
          <span className="absolute bottom-1.5 left-1/2 -translate-x-1/2 font-titulo text-xs font-bold text-white/95">
            {badge}
          </span>
        ) : null}
      </motion.div>

      <h3
        className={cn(
          "mt-3 font-titulo text-xl font-semibold",
          sol ? "text-primary" : "text-[#2F5F8A]",
        )}
      >
        {titulo}
      </h3>
      <p className="mt-0.5 font-cuerpo text-sm text-readable">{detalle}</p>

      <motion.div
        className="mx-auto mt-4 w-full max-w-xs"
        animate={
          reducir || disabled || !destacado
            ? undefined
            : { scale: [1, 1.03, 1] }
        }
        transition={
          reducir || !destacado
            ? undefined
            : {
                duration: 2.2,
                repeat: Infinity,
                repeatDelay: 2.4,
                ease: "easeInOut",
              }
        }
      >
        <Boton
          type="button"
          variant={sol ? "primario" : "secundario"}
          size="lg"
          disabled={disabled}
          isLoading={loading}
          onClick={onClick}
          className={cn(!sol && "border-[#3D7AB5]/30 text-[#2F5F8A]")}
        >
          {loading ? (
            "Abriendo…"
          ) : (
            <>
              {cta} · {precio}{" "}
              <Gem className="h-5 w-5 stroke-[2]" aria-hidden />
            </>
          )}
        </Boton>
      </motion.div>
    </div>
  );
}
