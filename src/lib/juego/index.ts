export {
  getNinoDeMiFamilia,
  getNinoActivoValidado,
  getAsignaturasPorCurso,
  getTotalesProgreso,
} from "@/lib/juego/nino";

export {
  getTemasActivosDeAsignatura,
  getPreguntasParaPartida,
  getPreguntasParaPractica,
  getPreguntasParaMisionDiaria,
} from "@/lib/juego/preguntas";

export { obtenerMisionDiariaDeHoy } from "@/lib/juego/mision-diaria";

export {
  MISION_OBJETIVO,
  PUNTOS_POR_ACIERTO,
  calcularEstrellas,
  puntosPorAciertos,
  esRespuestaCorrecta,
  mensajeAnimo,
  formatearRespuestaCorrecta,
  temaPredominante,
  repartirCupos,
} from "@/lib/juego/reglas";
