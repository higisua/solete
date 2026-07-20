"use client";

import Image from "next/image";
import { useState, useTransition } from "react";
import { unstable_rethrow } from "next/navigation";
import { crearNino } from "@/app/actions/auth";
import { AVATARES } from "@/lib/avatares";
import { Button, ErrorBox, Field } from "@/components/ui";

type AvatarOpcion = {
  id: string;
  nombre: string;
  src: string;
};

type Props = {
  titulo?: string;
  submitLabel?: string;
  siguiente?: string;
  /** Si viene del servidor, ya lleva ?v=mtime para evitar caché. */
  avatares?: AvatarOpcion[];
};

export function NinoForm({
  titulo = "Añadir niño o niña",
  submitLabel = "Guardar perfil",
  siguiente = "/familia",
  avatares = [...AVATARES],
}: Props) {
  const [curso, setCurso] = useState<"1" | "2" | "">("");
  const [avatar, setAvatar] = useState<string>("");
  const [error, setError] = useState<string | null>(null);
  const [pending, startTransition] = useTransition();

  function onSubmit(formData: FormData) {
    setError(null);
    startTransition(async () => {
      try {
        const result = await crearNino(formData);
        if (!result.ok) {
          setError(result.error);
        }
      } catch (err) {
        unstable_rethrow(err);
        setError("Ha ocurrido un error. Inténtalo de nuevo.");
      }
    });
  }

  return (
    <div className="mx-auto w-full max-w-md px-5 py-8">
      <h1 className="font-titulo text-3xl font-semibold text-sol">{titulo}</h1>
      <p className="mt-2 text-base text-black/70">
        Elige nombre, curso y un avatar divertido.
      </p>

      <form action={onSubmit} className="mt-8 flex flex-col gap-6">
        <input type="hidden" name="siguiente" value={siguiente} />
        <input type="hidden" name="curso" value={curso} />
        <input type="hidden" name="avatar" value={avatar} />

        <Field
          label="Nombre"
          name="nombre"
          autoComplete="given-name"
          placeholder="Ej. Lucía"
          required
          maxLength={40}
        />

        <fieldset>
          <legend className="mb-2 font-titulo text-base text-sol">Curso</legend>
          <div className="grid grid-cols-2 gap-3">
            {(
              [
                { value: "1", label: "1º primaria" },
                { value: "2", label: "2º primaria" },
              ] as const
            ).map((opcion) => {
              const activo = curso === opcion.value;
              return (
                <button
                  key={opcion.value}
                  type="button"
                  onClick={() => setCurso(opcion.value)}
                  className={`min-h-14 rounded-2xl border-2 px-3 font-titulo text-lg font-semibold transition ${
                    activo
                      ? "border-mar bg-mar text-white"
                      : "border-mar-claro/70 bg-white text-mar"
                  }`}
                >
                  {opcion.label}
                </button>
              );
            })}
          </div>
        </fieldset>

        <fieldset>
          <legend className="mb-2 font-titulo text-base text-sol">Avatar</legend>
          <div className="grid grid-cols-3 gap-3">
            {avatares.map((item) => {
              const activo = avatar === item.id;
              return (
                <button
                  key={item.id}
                  type="button"
                  onClick={() => setAvatar(item.id)}
                  aria-label={item.nombre}
                  className={`flex min-h-[96px] flex-col items-center justify-center rounded-2xl border-4 bg-white p-2 transition ${
                    activo ? "border-sol bg-limon/30" : "border-transparent shadow-sm"
                  }`}
                >
                  <Image
                    src={item.src}
                    alt={item.nombre}
                    width={72}
                    height={72}
                    unoptimized
                    className="h-16 w-16 object-contain"
                  />
                  <span className="mt-1 text-xs font-semibold text-black/70">
                    {item.nombre}
                  </span>
                </button>
              );
            })}
          </div>
        </fieldset>

        {error ? <ErrorBox message={error} /> : null}

        <Button type="submit" disabled={pending || !curso || !avatar}>
          {pending ? "Guardando…" : submitLabel}
        </Button>
      </form>
    </div>
  );
}
