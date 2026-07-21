"use client";

import { useState, useTransition } from "react";
import { useRouter } from "next/navigation";
import { unstable_rethrow } from "next/navigation";
import {
  actualizarNombreFamilia,
  cambiarPin,
} from "@/app/actions/zona-padres";
import { cerrarSesion } from "@/app/actions/auth";
import { Boton, Campo, CampoGrupo } from "@/components/ui";
import { ErrorBox, SuccessBox } from "@/components/auth-ui";

type Props = {
  nombreFamilia: string;
};

export function AjustesForm({ nombreFamilia }: Props) {
  const router = useRouter();
  const [errorNombre, setErrorNombre] = useState<string | null>(null);
  const [okNombre, setOkNombre] = useState(false);
  const [errorPin, setErrorPin] = useState<string | null>(null);
  const [okPin, setOkPin] = useState(false);
  const [pendingNombre, startNombre] = useTransition();
  const [pendingPin, startPin] = useTransition();

  function onNombre(formData: FormData) {
    setErrorNombre(null);
    setOkNombre(false);
    startNombre(async () => {
      try {
        const r = await actualizarNombreFamilia(formData);
        if (!r.ok) setErrorNombre(r.error);
        else {
          setOkNombre(true);
          router.refresh();
        }
      } catch (e) {
        unstable_rethrow(e);
        setErrorNombre("Error al guardar.");
      }
    });
  }

  function onPin(formData: FormData) {
    setErrorPin(null);
    setOkPin(false);
    startPin(async () => {
      try {
        const r = await cambiarPin(formData);
        if (!r.ok) setErrorPin(r.error);
        else setOkPin(true);
      } catch (e) {
        unstable_rethrow(e);
        setErrorPin("Error al cambiar el PIN.");
      }
    });
  }

  return (
    <div className="flex flex-col gap-5">
      <section className="rounded-[22px] bg-white p-4 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.25)]">
        <h2 className="font-titulo text-lg font-semibold text-sol">
          Nombre de la familia
        </h2>
        <form action={onNombre} className="mt-3">
          <CampoGrupo>
            <Campo
              label="Nombre"
              name="nombre"
              required
              defaultValue={nombreFamilia}
            />
            {errorNombre ? <ErrorBox message={errorNombre} /> : null}
            {okNombre ? <SuccessBox message="Nombre actualizado." /> : null}
            <Boton type="submit" disabled={pendingNombre}>
              {pendingNombre ? "Guardando…" : "Guardar nombre"}
            </Boton>
          </CampoGrupo>
        </form>
      </section>

      <section className="rounded-[22px] bg-white p-4 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.25)]">
        <h2 className="font-titulo text-lg font-semibold text-sol">
          Cambiar PIN
        </h2>
        <form action={onPin} className="mt-3">
          <CampoGrupo>
            <Campo
              label="PIN actual"
              name="pin_actual"
              type="password"
              inputMode="numeric"
              pattern="[0-9]{4}"
              maxLength={4}
              required
              autoComplete="off"
            />
            <Campo
              label="PIN nuevo"
              name="pin_nuevo"
              type="password"
              inputMode="numeric"
              pattern="[0-9]{4}"
              maxLength={4}
              required
              autoComplete="off"
            />
            <Campo
              label="Repetir PIN nuevo"
              name="pin_nuevo2"
              type="password"
              inputMode="numeric"
              pattern="[0-9]{4}"
              maxLength={4}
              required
              autoComplete="off"
            />
            {errorPin ? <ErrorBox message={errorPin} /> : null}
            {okPin ? <SuccessBox message="PIN actualizado." /> : null}
            <Boton type="submit" disabled={pendingPin}>
              {pendingPin ? "Guardando…" : "Cambiar PIN"}
            </Boton>
          </CampoGrupo>
        </form>
      </section>

      <section className="rounded-[22px] bg-white p-4 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.25)]">
        <h2 className="font-titulo text-lg font-semibold text-sol">Sesión</h2>
        <form action={cerrarSesion} className="mt-3">
          <Boton type="submit" variant="suave">
            Cerrar sesión
          </Boton>
        </form>
      </section>
    </div>
  );
}
