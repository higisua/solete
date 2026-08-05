"use client";

import Image from "next/image";
import { useState, useTransition } from "react";
import { unstable_rethrow } from "next/navigation";
import {
  actualizarNinoZonaPadres,
  crearNinoZonaPadres,
} from "@/app/actions/zona-padres";
import { AVATARES } from "@/lib/avatares";
import { Boton, Campo, CampoGrupo } from "@/components/ui";
import { ErrorBox } from "@/components/auth-ui";
import type { Nino } from "@/types/database";
import { cn } from "@/lib/cn";

type AvatarOpcion = { id: string; nombre: string; src: string };

type Props = {
  modo: "crear" | "editar";
  nino?: Nino;
  avatares?: AvatarOpcion[];
};

export function FormularioNinoPadres({
  modo,
  nino,
  avatares = AVATARES.map((a) => ({
    id: a.id,
    nombre: a.nombre,
    src: a.src,
  })),
}: Props) {
  const [curso, setCurso] = useState<"1" | "2" | "">(nino?.curso ?? "");
  const [avatar, setAvatar] = useState(nino?.avatar ?? "");
  const [error, setError] = useState<string | null>(null);
  const [pending, startTransition] = useTransition();

  const action = modo === "crear" ? crearNinoZonaPadres : actualizarNinoZonaPadres;

  function onSubmit(formData: FormData) {
    setError(null);
    startTransition(async () => {
      try {
        const result = await action(formData);
        if (!result.ok) setError(result.error);
      } catch (err) {
        unstable_rethrow(err);
        setError("Ha ocurrido un error.");
      }
    });
  }

  return (
    <form
      action={onSubmit}
      className="rounded-[22px] bg-white p-4 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.25)]"
    >
      <CampoGrupo>
        {modo === "editar" && nino ? (
          <input type="hidden" name="nino_id" value={nino.id} />
        ) : null}
        <input type="hidden" name="curso" value={curso} />
        <input type="hidden" name="avatar" value={avatar} />

        <Campo
          label="Nombre"
          name="nombre"
          required
          maxLength={40}
          defaultValue={nino?.nombre}
          placeholder="Ej. Lucía"
        />

        {modo === "editar" ? (
          <Campo
            label="Diamantes"
            name="diamantes"
            type="number"
            inputMode="numeric"
            required
            min={0}
            max={999999}
            step={1}
            defaultValue={nino?.diamantes ?? 0}
            hint="Ajuste manual del saldo. No cambia medallas ni el historial."
          />
        ) : null}

        <fieldset>
          <legend className="mb-2 font-titulo text-base font-semibold text-sol">
            Curso
          </legend>
          <div className="grid grid-cols-2 gap-3">
            {(
              [
                { value: "1", label: "1º" },
                { value: "2", label: "2º" },
              ] as const
            ).map((op) => (
              <button
                key={op.value}
                type="button"
                onClick={() => setCurso(op.value)}
                className={cn(
                  "min-h-12 rounded-2xl border-[2.5px] font-titulo text-lg font-semibold transition",
                  curso === op.value
                    ? "border-mar bg-mar text-white shadow-[0_3px_0_0_rgba(18,110,80,0.3)]"
                    : "border-mar/25 bg-white text-mar",
                )}
              >
                {op.label}
              </button>
            ))}
          </div>
        </fieldset>

        <fieldset>
          <legend className="mb-2 font-titulo text-base font-semibold text-sol">
            Avatar
          </legend>
          <div className="grid grid-cols-3 gap-2">
            {avatares.map((item) => (
              <button
                key={item.id}
                type="button"
                onClick={() => setAvatar(item.id)}
                className={cn(
                  "flex flex-col items-center rounded-2xl border-[3px] bg-[#FFF8ED]/60 p-2 transition",
                  avatar === item.id
                    ? "border-sol shadow-[0_4px_12px_-6px_rgba(216,90,48,0.4)]"
                    : "border-transparent",
                )}
              >
                <Image
                  src={item.src}
                  alt={item.nombre}
                  width={56}
                  height={56}
                  unoptimized
                  className="h-14 w-14 object-contain"
                />
                <span className="mt-1 font-cuerpo text-xs text-black/55">
                  {item.nombre}
                </span>
              </button>
            ))}
          </div>
        </fieldset>

        {error ? <ErrorBox message={error} /> : null}
        <Boton type="submit" disabled={pending || !curso || !avatar}>
          {pending ? "Guardando…" : modo === "crear" ? "Crear perfil" : "Guardar"}
        </Boton>
      </CampoGrupo>
    </form>
  );
}
