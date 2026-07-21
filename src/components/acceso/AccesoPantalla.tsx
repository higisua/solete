"use client";

import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { Lock, Mail, Shield, Users } from "lucide-react";
import Image from "next/image";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { unstable_rethrow } from "next/navigation";
import { useState, useTransition, type ReactNode } from "react";
import { registrarFamilia } from "@/app/actions/auth";
import { CampoAcceso } from "@/components/acceso/CampoAcceso";
import { PinCuatroDigitos } from "@/components/acceso/PinCuatroDigitos";
import { mensajeErrorAuth } from "@/lib/auth-errors";
import { publicAssetClient } from "@/lib/public-asset-client";
import { createClient } from "@/lib/supabase/client";

export type PestanaAcceso = "entrar" | "crear";

type Props = {
  pestanaInicial?: PestanaAcceso;
};

export function AccesoPantalla({ pestanaInicial = "entrar" }: Props) {
  const router = useRouter();
  const reducir = useReducedMotion();
  const [pestana, setPestana] = useState<PestanaAcceso>(pestanaInicial);
  const [error, setError] = useState<string | null>(null);
  const [pending, startTransition] = useTransition();

  function irA(siguiente: PestanaAcceso) {
    setError(null);
    setPestana(siguiente);
    const path = window.location.pathname.startsWith("/login") ? "/login" : "/";
    const url = siguiente === "crear" ? `${path}?tab=crear` : path;
    window.history.replaceState(null, "", url);
  }

  function onLogin(formData: FormData) {
    const email = String(formData.get("email") ?? "")
      .trim()
      .toLowerCase();
    const password = String(formData.get("password") ?? "");

    setError(null);
    startTransition(async () => {
      if (!email || !password) {
        setError("Escribe tu email y contraseña.");
        return;
      }

      const supabase = createClient();
      const { error: signInError } = await supabase.auth.signInWithPassword({
        email,
        password,
      });

      if (signInError) {
        setError(mensajeErrorAuth(signInError));
        return;
      }

      router.push("/entrada");
      router.refresh();
    });
  }

  function onRegistro(formData: FormData) {
    setError(null);
    startTransition(async () => {
      try {
        const result = await registrarFamilia(formData);
        if (!result.ok) {
          setError(result.error);
          return;
        }
        router.push("/onboarding");
        router.refresh();
      } catch (err) {
        unstable_rethrow(err);
        setError("Ha ocurrido un error. Inténtalo de nuevo.");
      }
    });
  }

  return (
    <main className="fondo-halo-sol flex min-h-dvh w-full flex-col items-center px-5 pb-10 pt-8 sm:pt-12">
      <div className="mx-auto flex w-full max-w-md flex-col items-center">
        <Image
          src={publicAssetClient("assets/logos/solete_texto.png")}
          alt="Solete"
          width={480}
          height={140}
          unoptimized
          priority
          className="h-auto w-[60%] max-w-[280px] object-contain"
        />

        <div className="mt-8 w-full rounded-[22px] bg-white px-5 pb-7 pt-5 shadow-[0_12px_40px_-16px_rgba(216,90,48,0.28),0_4px_12px_-4px_rgba(0,0,0,0.06)] sm:px-6">
          {/* Pestañas */}
          <div
            role="tablist"
            aria-label="Acceso"
            className="relative grid grid-cols-2 gap-1"
          >
            {(
              [
                { id: "entrar", label: "Entrar" },
                { id: "crear", label: "Crear cuenta" },
              ] as const
            ).map((tab) => {
              const activa = pestana === tab.id;
              return (
                <button
                  key={tab.id}
                  type="button"
                  role="tab"
                  aria-selected={activa}
                  onClick={() => irA(tab.id)}
                  className={`relative z-10 min-h-11 pb-2.5 font-titulo text-lg font-semibold transition-colors ${
                    activa ? "text-sol" : "text-black/40 hover:text-black/55"
                  }`}
                >
                  {tab.label}
                  {activa ? (
                    <motion.span
                      layoutId="acceso-tab-underline"
                      className="absolute inset-x-3 bottom-0 h-[3px] rounded-full bg-sol"
                      transition={
                        reducir
                          ? { duration: 0 }
                          : { type: "spring", stiffness: 380, damping: 32 }
                      }
                    />
                  ) : null}
                </button>
              );
            })}
          </div>

          {/* Mascota flotante */}
          <div className="mt-5 flex justify-center">
            <motion.div
              className="flex h-[5.5rem] w-[5.5rem] items-center justify-center rounded-full bg-[#FEF3DA]"
              animate={reducir ? undefined : { y: [0, -7, 0] }}
              transition={
                reducir
                  ? undefined
                  : { duration: 3.2, repeat: Infinity, ease: "easeInOut" }
              }
            >
              <Image
                src={publicAssetClient("assets/logos/solete_solo_logo.png")}
                alt=""
                width={88}
                height={88}
                unoptimized
                priority
                className="h-[4.25rem] w-[4.25rem] object-contain"
                aria-hidden
              />
            </motion.div>
          </div>

          <div className="mt-5 min-h-[20rem]">
            <AnimatePresence mode="wait" initial={false}>
              {pestana === "entrar" ? (
                <motion.div
                  key="entrar"
                  role="tabpanel"
                  initial={reducir ? false : { opacity: 0, y: 8 }}
                  animate={{ opacity: 1, y: 0 }}
                  exit={reducir ? undefined : { opacity: 0, y: -6 }}
                  transition={{ duration: 0.22, ease: [0.22, 1, 0.36, 1] }}
                >
                  <form action={onLogin} className="flex flex-col gap-4">
                    <CampoAcceso
                      label="Correo electrónico"
                      name="email"
                      type="email"
                      autoComplete="email"
                      required
                      placeholder="ana.suarez@email.com"
                      icono={Mail}
                    />
                    <CampoAcceso
                      label="Contraseña"
                      name="password"
                      autoComplete="current-password"
                      required
                      placeholder="Tu contraseña"
                      icono={Lock}
                      revelable
                    />
                    {error ? <ErrorAcceso message={error} /> : null}
                    <BotonAcceso disabled={pending}>
                      {pending ? "Un momento…" : "Entrar"}
                    </BotonAcceso>
                  </form>

                  <div className="mt-5 flex flex-col items-center gap-3 text-center">
                    <Link
                      href="/recuperar"
                      className="font-cuerpo text-sm font-medium text-mar underline underline-offset-2"
                    >
                      He olvidado mi contraseña
                    </Link>
                    <button
                      type="button"
                      onClick={() => irA("crear")}
                      className="font-cuerpo text-sm text-black/55"
                    >
                      ¿Primera vez?{" "}
                      <span className="font-semibold text-sol underline underline-offset-2">
                        Crea tu cuenta
                      </span>
                    </button>
                  </div>
                </motion.div>
              ) : (
                <motion.div
                  key="crear"
                  role="tabpanel"
                  initial={reducir ? false : { opacity: 0, y: 8 }}
                  animate={{ opacity: 1, y: 0 }}
                  exit={reducir ? undefined : { opacity: 0, y: -6 }}
                  transition={{ duration: 0.22, ease: [0.22, 1, 0.36, 1] }}
                >
                  <form action={onRegistro} className="flex flex-col gap-4">
                    <CampoAcceso
                      label="Nombre de la familia"
                      name="nombre"
                      autoComplete="organization"
                      required
                      maxLength={60}
                      placeholder="Los Suárez"
                      hint="Así os llamaremos dentro de la app"
                      icono={Users}
                    />
                    <CampoAcceso
                      label="Correo electrónico"
                      name="email"
                      type="email"
                      autoComplete="email"
                      required
                      placeholder="ana.suarez@email.com"
                      hint="Lo usarás para entrar y recuperar tu cuenta"
                      icono={Mail}
                    />
                    <CampoAcceso
                      label="Contraseña"
                      name="password"
                      autoComplete="new-password"
                      required
                      minLength={6}
                      placeholder="Mínimo 6 caracteres"
                      hint="Mínimo 6 caracteres"
                      icono={Lock}
                      revelable
                    />

                    <div className="rounded-[16px] bg-[#FDF4E8] px-4 py-4">
                      <div className="mb-1 flex items-center gap-2">
                        <Shield
                          className="h-[1.15rem] w-[1.15rem] stroke-[1.75] text-sol"
                          aria-hidden
                        />
                        <span className="font-titulo text-[0.95rem] font-semibold text-sol">
                          PIN de la zona de padres
                        </span>
                      </div>
                      <p className="mb-3 font-cuerpo text-sm leading-snug text-black/45">
                        4 números para entrar tú a los ajustes. Los peques no lo
                        sabrán.
                      </p>
                      <PinCuatroDigitos />
                    </div>

                    {error ? <ErrorAcceso message={error} /> : null}
                    <BotonAcceso disabled={pending}>
                      {pending ? "Un momento…" : "Empezar"}
                    </BotonAcceso>
                  </form>

                  <div className="mt-5 text-center">
                    <button
                      type="button"
                      onClick={() => irA("entrar")}
                      className="font-cuerpo text-sm text-black/55"
                    >
                      ¿Ya tienes cuenta?{" "}
                      <span className="font-semibold text-sol underline underline-offset-2">
                        Entrar
                      </span>
                    </button>
                  </div>
                </motion.div>
              )}
            </AnimatePresence>
          </div>
        </div>
      </div>
    </main>
  );
}

function BotonAcceso({
  children,
  disabled,
}: {
  children: ReactNode;
  disabled?: boolean;
}) {
  return (
    <motion.div
      className="w-full"
      whileTap={disabled ? undefined : { scale: 0.97 }}
      transition={{ type: "spring", stiffness: 420, damping: 28 }}
    >
      <button
        type="submit"
        disabled={disabled}
        className="inline-flex min-h-14 w-full items-center justify-center rounded-2xl bg-sol px-5 font-titulo text-xl font-semibold text-white shadow-[0_4px_0_0_rgba(184,64,28,0.3)] transition-colors hover:bg-sol-claro disabled:cursor-not-allowed disabled:opacity-60"
      >
        {children}
      </button>
    </motion.div>
  );
}

function ErrorAcceso({ message }: { message: string }) {
  return (
    <p
      role="alert"
      className="rounded-[14px] border border-fallo/40 bg-fallo/15 px-4 py-3 font-cuerpo text-sm text-[#8a3b28]"
    >
      {message}
    </p>
  );
}
