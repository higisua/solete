"use client";

import { useState } from "react";
import {
  actualizarPregunta,
  crearPregunta,
} from "@/app/actions/superadmin";
import { Field, SuperadminForm } from "@/components/zona-padres/SuperadminForm";
import type { Pregunta, TipoPregunta } from "@/types/database";
import { cn } from "@/lib/cn";

type Props = {
  modo: "crear" | "editar";
  asignaturaId: string;
  temaId: string;
  pregunta?: Pregunta;
};

const TIPOS: Array<{ value: TipoPregunta; label: string; hint: string }> = [
  { value: "numeric", label: "Numérica", hint: "Respuesta número" },
  { value: "true_false", label: "V / F", hint: "Verdadero o falso" },
  { value: "multiple_choice", label: "Opciones", hint: "4 opciones" },
];

export function FormularioPregunta({
  modo,
  asignaturaId,
  temaId,
  pregunta,
}: Props) {
  const [tipo, setTipo] = useState<TipoPregunta>(pregunta?.tipo ?? "numeric");

  const opciones = Array.isArray(pregunta?.opciones)
    ? [...pregunta!.opciones!]
    : ["", "", "", ""];
  while (opciones.length < 4) opciones.push("");

  const respuestaDefault =
    pregunta?.tipo === "true_false"
      ? String(Boolean(pregunta.respuesta))
      : pregunta?.respuesta != null
        ? String(pregunta.respuesta)
        : "";

  const action = modo === "crear" ? crearPregunta : actualizarPregunta;

  return (
    <SuperadminForm
      action={action}
      submitLabel={modo === "crear" ? "Crear pregunta" : "Guardar"}
    >
      {modo === "editar" && pregunta ? (
        <input type="hidden" name="id" value={pregunta.id} />
      ) : null}
      <input type="hidden" name="tema_id" value={temaId} />
      <input type="hidden" name="asignatura_id" value={asignaturaId} />
      <input type="hidden" name="tipo" value={tipo} />

      <fieldset>
        <legend className="mb-2 font-titulo text-base font-semibold text-sol">
          Tipo de pregunta
        </legend>
        <div className="grid grid-cols-3 gap-2">
          {TIPOS.map((op) => (
            <button
              key={op.value}
              type="button"
              onClick={() => setTipo(op.value)}
              className={cn(
                "flex min-h-[3.25rem] flex-col items-center justify-center rounded-2xl border-[2.5px] px-1 py-2 text-center transition",
                tipo === op.value
                  ? "border-mar bg-mar text-white shadow-[0_3px_0_0_rgba(18,110,80,0.28)]"
                  : "border-black/8 bg-white text-sol",
              )}
            >
              <span className="font-titulo text-sm font-semibold leading-tight">
                {op.label}
              </span>
              <span
                className={cn(
                  "mt-0.5 font-cuerpo text-[10px] leading-tight",
                  tipo === op.value ? "text-white/80" : "text-black/40",
                )}
              >
                {op.hint}
              </span>
            </button>
          ))}
        </div>
      </fieldset>

      <Field
        label="Enunciado"
        name="enunciado"
        required
        defaultValue={pregunta?.enunciado}
        placeholder="¿Cuánto es 2 + 2?"
      />

      <label className="block w-full">
        <span className="mb-1.5 block font-titulo text-base font-semibold text-sol">
          Dificultad
        </span>
        <select
          name="dificultad"
          defaultValue={String(pregunta?.dificultad ?? 1)}
          className="min-h-12 w-full rounded-2xl border-2 border-sol-claro/55 bg-white px-4 font-cuerpo text-base outline-none transition focus:border-sol focus:shadow-[0_0_0_3px_rgba(216,90,48,0.12)]"
        >
          <option value="1">1 — fácil</option>
          <option value="2">2 — media</option>
          <option value="3">3 — difícil</option>
        </select>
      </label>

      {tipo === "multiple_choice" ? (
        <div className="flex flex-col gap-3 rounded-2xl bg-[#FFF8ED]/80 p-3">
          <p className="font-titulo text-base font-semibold text-sol">
            Opciones
          </p>
          {[0, 1, 2, 3].map((i) => (
            <Field
              key={i}
              label={`Opción ${i + 1}${i < 2 ? "" : " (opcional)"}`}
              name={`opcion_${i + 1}`}
              defaultValue={opciones[i] ?? ""}
              required={i < 2}
            />
          ))}
          <Field
            label="Respuesta correcta"
            name="respuesta"
            required
            defaultValue={respuestaDefault}
            hint="Copia el texto exacto de una de las opciones"
            placeholder="Texto de la opción correcta"
          />
        </div>
      ) : null}

      {tipo === "numeric" ? (
        <Field
          label="Respuesta (número)"
          name="respuesta"
          required
          inputMode="numeric"
          defaultValue={respuestaDefault}
          placeholder="4"
        />
      ) : null}

      {tipo === "true_false" ? (
        <label className="block w-full">
          <span className="mb-1.5 block font-titulo text-base font-semibold text-sol">
            Respuesta correcta
          </span>
          <select
            name="respuesta"
            defaultValue={respuestaDefault === "true" ? "true" : "false"}
            className="min-h-12 w-full rounded-2xl border-2 border-sol-claro/55 bg-white px-4 font-cuerpo text-base outline-none transition focus:border-sol focus:shadow-[0_0_0_3px_rgba(216,90,48,0.12)]"
          >
            <option value="true">Verdadero</option>
            <option value="false">Falso</option>
          </select>
        </label>
      ) : null}
    </SuperadminForm>
  );
}
