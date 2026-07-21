"use client";

import Image from "next/image";
import { useState, useTransition } from "react";
import { unstable_rethrow } from "next/navigation";
import {
  actualizarNinoZonaPadres,
  crearNinoZonaPadres,
} from "@/app/actions/zona-padres";
import { AVATARES } from "@/lib/avatares";
import { Button, ErrorBox, Field } from "@/components/auth-ui";
import type { Nino } from "@/types/database";

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
    <form action={onSubmit} className="flex flex-col gap-5">
      {modo === "editar" && nino ? (
        <input type="hidden" name="nino_id" value={nino.id} />
      ) : null}
      <input type="hidden" name="curso" value={curso} />
      <input type="hidden" name="avatar" value={avatar} />

      <Field
        label="Nombre"
        name="nombre"
        required
        maxLength={40}
        defaultValue={nino?.nombre}
        placeholder="Ej. Lucía"
      />

      <fieldset>
        <legend className="mb-2 font-titulo text-base text-sol">Curso</legend>
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
              className={`min-h-12 rounded-2xl border-2 font-titulo text-lg font-semibold ${
                curso === op.value
                  ? "border-mar bg-mar text-white"
                  : "border-mar-claro/60 bg-white text-mar"
              }`}
            >
              {op.label}
            </button>
          ))}
        </div>
      </fieldset>

      <fieldset>
        <legend className="mb-2 font-titulo text-base text-sol">Avatar</legend>
        <div className="grid grid-cols-3 gap-2">
          {avatares.map((item) => (
            <button
              key={item.id}
              type="button"
              onClick={() => setAvatar(item.id)}
              className={`flex flex-col items-center rounded-2xl border-4 bg-white p-2 ${
                avatar === item.id ? "border-sol" : "border-transparent"
              }`}
            >
              <Image
                src={item.src}
                alt={item.nombre}
                width={56}
                height={56}
                unoptimized
                className="h-14 w-14 object-contain"
              />
              <span className="text-xs">{item.nombre}</span>
            </button>
          ))}
        </div>
      </fieldset>

      {error ? <ErrorBox message={error} /> : null}
      <Button type="submit" disabled={pending || !curso || !avatar}>
        {pending ? "Guardando…" : modo === "crear" ? "Crear perfil" : "Guardar"}
      </Button>
    </form>
  );
}
