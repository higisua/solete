"use client";

import { useState } from "react";
import {
  actualizarPregunta,
  crearPregunta,
} from "@/app/actions/superadmin";
import { Field, SuperadminForm } from "@/components/zona-padres/SuperadminForm";
import type { Pregunta, TipoPregunta } from "@/types/database";

type Props = {
  modo: "crear" | "editar";
  asignaturaId: string;
  temaId: string;
  pregunta?: Pregunta;
};

export function FormularioPregunta({ modo, asignaturaId, temaId, pregunta }: Props) {
  const [tipo, setTipo] = useState<TipoPregunta>(pregunta?.tipo ?? "numeric");

  const opciones = Array.isArray(pregunta?.opciones) ? pregunta!.opciones! : ["", "", "", ""];
  while (opciones.length < 4) opciones.push("");

  const respuestaDefault =
    pregunta?.tipo === "true_false"
      ? String(Boolean(pregunta.respuesta))
      : pregunta?.respuesta != null
        ? String(pregunta.respuesta)
        : "";

  const action = modo === "crear" ? crearPregunta : actualizarPregunta;

  return (
    <SuperadminForm action={action} submitLabel={modo === "crear" ? "Crear pregunta" : "Guardar"}>
      {modo === "editar" && pregunta ? <input type="hidden" name="id" value={pregunta.id} /> : null}
      <input type="hidden" name="tema_id" value={temaId} />
      <input type="hidden" name="asignatura_id" value={asignaturaId} />
      <input type="hidden" name="tipo" value={tipo} />

      <fieldset>
        <legend className="mb-2 font-titulo text-base text-sol">Tipo</legend>
        <div className="grid grid-cols-1 gap-2">
          {(
            [
              { value: "numeric", label: "Numérica" },
              { value: "true_false", label: "Verdadero / Falso" },
              { value: "multiple_choice", label: "Opción múltiple" },
            ] as const
          ).map((op) => (
            <button
              key={op.value}
              type="button"
              onClick={() => setTipo(op.value)}
              className={`min-h-12 rounded-2xl border-2 px-3 text-left font-titulo ${
                tipo === op.value
                  ? "border-mar bg-mar text-white"
                  : "border-black/10 bg-white text-sol"
              }`}
            >
              {op.label}
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

      <label className="block">
        <span className="mb-1.5 block font-titulo text-base text-sol">Dificultad</span>
        <select
          name="dificultad"
          defaultValue={String(pregunta?.dificultad ?? 1)}
          className="min-h-12 w-full rounded-2xl border-2 border-sol-claro/60 bg-white px-4"
        >
          <option value="1">1 — fácil</option>
          <option value="2">2 — media</option>
          <option value="3">3 — difícil</option>
        </select>
      </label>

      {tipo === "multiple_choice" ? (
        <div className="flex flex-col gap-2">
          <p className="font-titulo text-base text-sol">Opciones</p>
          {[0, 1, 2, 3].map((i) => (
            <Field
              key={i}
              label={`Opción ${i + 1}`}
              name={`opcion_${i + 1}`}
              defaultValue={opciones[i] ?? ""}
              required={i < 2}
            />
          ))}
          <Field
            label="Respuesta correcta (texto exacto de una opción)"
            name="respuesta"
            required
            defaultValue={respuestaDefault}
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
        />
      ) : null}

      {tipo === "true_false" ? (
        <label className="block">
          <span className="mb-1.5 block font-titulo text-base text-sol">Respuesta correcta</span>
          <select
            name="respuesta"
            defaultValue={respuestaDefault === "true" ? "true" : "false"}
            className="min-h-12 w-full rounded-2xl border-2 border-sol-claro/60 bg-white px-4"
          >
            <option value="true">Verdadero</option>
            <option value="false">Falso</option>
          </select>
        </label>
      ) : null}
    </SuperadminForm>
  );
}
