import { redirect } from "next/navigation";
import { Boton, Pantalla } from "@/components/ui";
import { MotorPreguntas } from "@/components/juego/MotorPreguntas";
import { getNinoActivoValidado } from "@/lib/juego";
import { obtenerMisionDiariaDeHoy } from "@/lib/juego/mision-diaria";

/** Misión diaria única (20 preguntas entre asignaturas, Europe/Madrid). */
export default async function MisionDiariaPage() {
  const nino = await getNinoActivoValidado();
  if (!nino) {
    redirect("/entrada");
  }

  const estado = await obtenerMisionDiariaDeHoy(nino.id, nino.curso);

  if (estado.estado === "completada") {
    return (
      <Pantalla centrar className="fondo-halo-sol text-center" sinAtmosfera>
        <h1 className="font-titulo text-3xl font-semibold text-primary">
          ¡Misión de hoy hecha!
        </h1>
        <p className="mt-3 font-cuerpo text-lg text-readable">
          {nino.nombre} ya completó la misión de hoy (
          {estado.mision.aciertos}/{estado.mision.total}, {estado.mision.estrellas}{" "}
          ★). Vuelve mañana para una nueva.
        </p>
        <div className="mt-8">
          <Boton href="/mundo" variant="secundario">
            Volver al mundo
          </Boton>
        </div>
      </Pantalla>
    );
  }

  if (estado.estado === "sin_preguntas") {
    return (
      <Pantalla centrar className="fondo-halo-sol text-center" sinAtmosfera>
        <h1 className="font-titulo text-3xl font-semibold text-primary">
          Aún no hay preguntas
        </h1>
        <p className="mt-3 font-cuerpo text-lg text-readable">
          No hay preguntas activas para la misión de {nino.nombre}. Pide a un
          adulto que active temas.
        </p>
        <div className="mt-8">
          <Boton href="/mundo" variant="secundario">
            Volver al mundo
          </Boton>
        </div>
      </Pantalla>
    );
  }

  return (
    <MotorPreguntas
      ninoId={nino.id}
      ninoNombre={nino.nombre}
      asignaturaId=""
      asignaturaNombre="Misión del día"
      modo="mision"
      preguntasIniciales={estado.preguntas}
      misionCorta={estado.misionCorta}
      misionDiariaId={estado.mision.id || null}
      hrefOtraVez="/mundo"
      hrefCambiar="/mundo"
    />
  );
}
