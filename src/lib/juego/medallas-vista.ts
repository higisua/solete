import { createClient } from "@/lib/supabase/server";
import { hoyMadridISO } from "@/lib/fecha-madrid";
import { finMesISO, inicioMesISO } from "@/lib/juego/calendario";
import {
  CATALOGO_CROMOS,
  TEMATICAS_CROMOS,
  type TematicaId,
} from "@/lib/juego/cromos-catalogo";
import {
  CATALOGO_MEDALLAS,
  type MedallaId,
} from "@/lib/juego/medallas-catalogo";
import {
  MEDALLA_POR_TEMATICA,
  MEDALLAS_CON_PROGRESO,
} from "@/lib/juego/medallas-iconos";
import {
  preguntasPracticaHoy,
  totalPreguntasPractica,
} from "@/lib/juego/practica-diaria";

export type ProgresoMedalla = {
  actual: number;
  meta: number;
};

export type MedallaVistaItem = {
  id: MedallaId;
  nombre: string;
  descripcion: string;
  diamantes: number;
  conseguida: boolean;
  desbloqueadaEn: string | null;
  /** Solo para pendientes acumulativas; null = hito único sin barra. */
  progreso: ProgresoMedalla | null;
};

export type MedallasVistaData = {
  items: MedallaVistaItem[];
  conseguidas: number;
  total: number;
};

type Stats = {
  rachaDias: number;
  aciertosTotales: number;
  conTresEstrellas: number;
  totalMisiones: number;
  diasMesActual: number;
  diasEnMes: number;
  practicaHoy: number;
  practicaTotal: number;
  cromos: number;
  porTema: Record<TematicaId, { actual: number; meta: number }>;
};

async function cargarStats(ninoId: string): Promise<Stats> {
  const supabase = await createClient();

  const [
    { data: nino },
    { data: misiones },
    { data: progreso },
    { data: cromosFilas },
    practicaHoy,
    practicaTotal,
  ] = await Promise.all([
    supabase
      .from("ninos")
      .select("racha_dias")
      .eq("id", ninoId)
      .maybeSingle(),
    supabase
      .from("misiones_diarias")
      .select("fecha, estrellas, completada")
      .eq("nino_id", ninoId)
      .eq("completada", true),
    supabase.from("progreso").select("aciertos").eq("nino_id", ninoId),
    supabase.from("cromos_nino").select("cromo_id").eq("nino_id", ninoId),
    preguntasPracticaHoy(ninoId),
    totalPreguntasPractica(ninoId),
  ]);

  const rachaDias = nino?.racha_dias ?? 0;
  const aciertosTotales = (progreso ?? []).reduce(
    (s, r) => s + (r.aciertos ?? 0),
    0,
  );
  const lista = misiones ?? [];
  const conTresEstrellas = lista.filter((m) => (m.estrellas ?? 0) >= 3).length;

  const hoy = hoyMadridISO();
  const [y, m] = hoy.split("-").map(Number);
  const mes = { year: y, month: m };
  const desde = inicioMesISO(mes);
  const hasta = finMesISO(mes);
  const diasEnMes = Number(hasta.slice(8, 10));
  const diasMesActual = new Set(
    lista
      .map((r) => String(r.fecha).slice(0, 10))
      .filter((f) => f >= desde && f <= hasta),
  ).size;

  const poseidos = new Set((cromosFilas ?? []).map((r) => String(r.cromo_id)));
  const porTema = {} as Record<TematicaId, { actual: number; meta: number }>;
  for (const tema of TEMATICAS_CROMOS) {
    const delTema = CATALOGO_CROMOS.filter((c) => c.tematicaId === tema.id);
    porTema[tema.id] = {
      actual: delTema.filter((c) => poseidos.has(c.id)).length,
      meta: delTema.length,
    };
  }

  return {
    rachaDias,
    aciertosTotales,
    conTresEstrellas,
    totalMisiones: lista.length,
    diasMesActual,
    diasEnMes,
    practicaHoy,
    practicaTotal,
    cromos: poseidos.size,
    porTema,
  };
}

function progresoDe(id: MedallaId, stats: Stats): ProgresoMedalla | null {
  if (!MEDALLAS_CON_PROGRESO.has(id)) return null;

  switch (id) {
    case "tres_dias":
      return { actual: Math.min(stats.rachaDias, 3), meta: 3 };
    case "semana":
      return { actual: Math.min(stats.rachaDias, 7), meta: 7 };
    case "quince_dias":
      return { actual: Math.min(stats.rachaDias, 15), meta: 15 };
    case "estrella_fija":
      return { actual: Math.min(stats.conTresEstrellas, 5), meta: 5 };
    case "diez_perfectos":
      return { actual: Math.min(stats.conTresEstrellas, 10), meta: 10 };
    case "aprendiz":
      return { actual: Math.min(stats.aciertosTotales, 100), meta: 100 };
    case "aciertos_250":
      return { actual: Math.min(stats.aciertosTotales, 250), meta: 250 };
    case "sabelotodo":
      return { actual: Math.min(stats.aciertosTotales, 500), meta: 500 };
    case "misiones_10":
      return { actual: Math.min(stats.totalMisiones, 10), meta: 10 };
    case "misiones_25":
      return { actual: Math.min(stats.totalMisiones, 25), meta: 25 };
    case "mes_completo":
      return {
        actual: Math.min(stats.diasMesActual, stats.diasEnMes),
        meta: stats.diasEnMes,
      };
    case "practica_10":
      return { actual: Math.min(stats.practicaHoy, 10), meta: 10 };
    case "practica_dia_25":
      return { actual: Math.min(stats.practicaHoy, 25), meta: 25 };
    case "practica_50":
      return { actual: Math.min(stats.practicaTotal, 50), meta: 50 };
    case "practica_100":
      return { actual: Math.min(stats.practicaTotal, 100), meta: 100 };
    case "primer_cromo":
      return { actual: Math.min(stats.cromos, 1), meta: 1 };
    case "coleccion_10":
      return { actual: Math.min(stats.cromos, 10), meta: 10 };
    case "album_animales":
    case "album_ciudades":
    case "album_comidas":
    case "album_deportes":
    case "album_transportes": {
      const temaId = (
        Object.entries(MEDALLA_POR_TEMATICA) as [TematicaId, MedallaId][]
      ).find(([, mid]) => mid === id)?.[0];
      if (!temaId) return null;
      const t = stats.porTema[temaId];
      return { actual: t.actual, meta: t.meta };
    }
    default:
      return null;
  }
}

/**
 * Vista de lectura: catálogo + desbloqueos + progreso acumulativo.
 * No otorga medallas.
 */
export async function getMedallasVista(
  ninoId: string,
): Promise<MedallasVistaData> {
  const supabase = await createClient();
  const [{ data: filas }, stats] = await Promise.all([
    supabase
      .from("medallas_nino")
      .select("medalla_id, desbloqueada_en, diamantes_otorgados")
      .eq("nino_id", ninoId),
    cargarStats(ninoId),
  ]);

  const mapa = new Map(
    (filas ?? []).map((f) => [
      String(f.medalla_id),
      {
        desbloqueadaEn: f.desbloqueada_en
          ? String(f.desbloqueada_en)
          : null,
        diamantes: f.diamantes_otorgados ?? 0,
      },
    ]),
  );

  const items: MedallaVistaItem[] = CATALOGO_MEDALLAS.map((def) => {
    const row = mapa.get(def.id);
    const conseguida = Boolean(row);
    return {
      id: def.id,
      nombre: def.nombre,
      descripcion: def.descripcion,
      diamantes: conseguida && row ? row.diamantes : def.diamantes,
      conseguida,
      desbloqueadaEn: row?.desbloqueadaEn ?? null,
      progreso: conseguida ? null : progresoDe(def.id, stats),
    };
  });

  items.sort((a, b) => {
    if (a.conseguida !== b.conseguida) return a.conseguida ? -1 : 1;
    return 0;
  });

  const conseguidas = items.filter((i) => i.conseguida).length;

  return {
    items,
    conseguidas,
    total: CATALOGO_MEDALLAS.length,
  };
}
