"use client";

import { useState, useTransition } from "react";
import Image from "next/image";
import { unstable_rethrow } from "next/navigation";
import { Delete } from "lucide-react";
import { motion, useReducedMotion } from "framer-motion";
import { verificarPinZonaPadres } from "@/app/actions/zona-padres";
import { Aparecer, Pantalla } from "@/components/ui";
import { publicAssetClient } from "@/lib/public-asset-client";
import { cn } from "@/lib/cn";

const TECLAS = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0", "borrar"] as const;

export function PinGate() {
  const [pin, setPin] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [pending, startTransition] = useTransition();
  const reducir = useReducedMotion();

  function pulsar(tecla: (typeof TECLAS)[number]) {
    if (pending || !tecla) return;
    if (tecla === "borrar") {
      setPin((p) => p.slice(0, -1));
      setError(null);
      return;
    }
    if (pin.length >= 4) return;
    const siguiente = pin + tecla;
    setPin(siguiente);
    setError(null);
    if (siguiente.length === 4) {
      enviar(siguiente);
    }
  }

  function enviar(valor: string) {
    setError(null);
    const fd = new FormData();
    fd.set("pin", valor);
    startTransition(async () => {
      try {
        const result = await verificarPinZonaPadres(fd);
        if (!result.ok) {
          setError(result.error);
          setPin("");
        }
      } catch (err) {
        unstable_rethrow(err);
        setError("Ha ocurrido un error. Inténtalo de nuevo.");
        setPin("");
      }
    });
  }

  return (
    <Pantalla centrar className="fondo-halo-sol">
      <Aparecer className="flex flex-col items-center text-center">
        <Image
          src={publicAssetClient("assets/logos/solete_solo_logo.png")}
          alt=""
          width={72}
          height={72}
          unoptimized
          priority
          className="h-16 w-16 object-contain drop-shadow-sm"
          aria-hidden
        />
        <h1 className="mt-4 font-titulo text-3xl font-semibold text-sol">
          Zona padres
        </h1>
        <p className="mt-2 max-w-[16rem] font-cuerpo text-base text-black/55">
          Introduce el PIN de 4 dígitos
        </p>
      </Aparecer>

      <Aparecer delay={0.06} className="mt-8">
        <div className="flex justify-center gap-3" aria-label="PIN">
          {[0, 1, 2, 3].map((i) => {
            const lleno = pin.length > i;
            return (
              <motion.span
                key={i}
                animate={
                  reducir
                    ? undefined
                    : lleno
                      ? { scale: [1, 1.08, 1] }
                      : { scale: 1 }
                }
                transition={{ duration: 0.2 }}
                className={cn(
                  "flex h-14 w-14 items-center justify-center rounded-2xl border-[2.5px] shadow-[0_4px_14px_-8px_rgba(216,90,48,0.3)]",
                  lleno
                    ? "border-sol bg-sol"
                    : "border-sol/20 bg-white",
                )}
              >
                {lleno ? (
                  <span className="h-3 w-3 rounded-full bg-white" aria-hidden />
                ) : null}
              </motion.span>
            );
          })}
        </div>
      </Aparecer>

      {error ? (
        <motion.p
          role="alert"
          initial={reducir ? false : { opacity: 0, y: 6 }}
          animate={{ opacity: 1, y: 0 }}
          className="mt-4 rounded-2xl border border-fallo/35 bg-fallo/15 px-4 py-3 text-center font-cuerpo text-sm text-[#8a3b28]"
        >
          {error}
        </motion.p>
      ) : null}
      {pending ? (
        <p className="mt-4 text-center font-cuerpo text-sm text-black/45">
          Comprobando…
        </p>
      ) : null}

      <Aparecer delay={0.1} className="mt-8">
        <div className="grid grid-cols-3 gap-2.5">
          {TECLAS.map((tecla, idx) =>
            tecla === "" ? (
              <span key={`empty-${idx}`} />
            ) : (
              <motion.button
                key={tecla + idx}
                type="button"
                disabled={pending}
                onClick={() => pulsar(tecla)}
                whileTap={reducir || pending ? undefined : { scale: 0.94 }}
                transition={{ type: "spring", stiffness: 420, damping: 28 }}
                className={cn(
                  "flex min-h-14 items-center justify-center rounded-2xl bg-white font-titulo text-2xl font-semibold text-sol shadow-[0_6px_18px_-10px_rgba(216,90,48,0.35)] transition disabled:opacity-50",
                  tecla === "borrar" && "text-black/45",
                )}
                aria-label={tecla === "borrar" ? "Borrar" : tecla}
              >
                {tecla === "borrar" ? (
                  <Delete className="h-6 w-6 stroke-[1.75]" aria-hidden />
                ) : (
                  tecla
                )}
              </motion.button>
            ),
          )}
        </div>
      </Aparecer>
    </Pantalla>
  );
}
