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
  getAsignaturaContenidoExtremo,
  getTemasContenidoExtremo,
  cursoContenidoExtremo,
} from "@/lib/juego/preguntas";

export { obtenerMisionDiariaDeHoy, getResumenMisionHoy } from "@/lib/juego/mision-diaria";
export { mesActualMadrid, parseMesParam } from "@/lib/juego/calendario";
export { getMisionesCompletadasDelMes } from "@/lib/juego/calendario-datos";
export {
  CATALOGO_MEDALLAS,
  type MedallaId,
  type MedallaDef,
} from "@/lib/juego/medallas-catalogo";
export {
  evaluarMedallasTrasMision,
  evaluarMedallasTrasPractica,
  evaluarMedallasTrasCromo,
  otorgarMedallaBienvenida,
  type MedallaDesbloqueada,
} from "@/lib/juego/medallas";
export {
  DIAMANTES_MISION_DIARIA,
  DIAMANTES_PRACTICA_DIARIA,
  DIAMANTES_CATEGORIA_COMPLETA,
  DIAMANTES_PRACTICA_EXTREMA_LOTE,
  PRACTICA_PREGUNTAS_PARA_DIAMANTE,
  PRACTICA_EXTREMA_ACIERTOS_POR_LOTE,
  esNivelPractica,
  type NivelPractica,
} from "@/lib/juego/economia";
export {
  registrarPracticaDelDia,
  otorgarDiamantesPracticaExtrema,
  diamantesPracticaExtrema,
  totalPreguntasPractica,
  preguntasPracticaHoy,
} from "@/lib/juego/practica-diaria";
export {
  getMedallasVista,
  type MedallaVistaItem,
  type MedallasVistaData,
} from "@/lib/juego/medallas-vista";
export {
  CROMOS_ECONOMIA,
  CATALOGO_CROMOS,
  TEMATICAS_CROMOS,
  precioPorRareza,
  devolucionPorRepetido,
  cromoPorId,
  esRarezaVisible,
  RAREZAS_VISIBLES,
  type RarezaCromo,
  type RarezaVisible,
  type TematicaId,
  type CromoDef,
  type TematicaDef,
} from "@/lib/juego/cromos-catalogo";
export {
  CATALOGO_LEGENDARIOS,
  legendarioPorId,
  esIdLegendario,
  imagenLegendario,
  type LegendaryDef,
  type LegendaryUnlockType,
  type LegendaryId,
} from "@/lib/juego/legendaries";
export {
  evaluarLegendarios,
  getLegendariosVista,
  type LegendarioDesbloqueado,
  type LegendariosVista,
  type LegendarioProgresoItem,
} from "@/lib/juego/legendarios-eval";
export {
  comprarCromo,
  abrirSobre,
  abrirSobreGrande,
  getColeccionVista,
  type CromoObtenido,
  type ResultadoCompraCromo,
  type ResultadoSobre,
  type ResultadoSobreGrande,
  type ItemSobre,
  type ColeccionVista,
  type TematicaAlbum,
  type CromoAlbumItem,
} from "@/lib/juego/cromos";

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

export {
  MISSION_STAGES,
  planificarEtapas,
  posicionEnEtapa,
  type MissionStageDef,
  type EtapaPlan,
} from "@/lib/juego/mission-stages";
