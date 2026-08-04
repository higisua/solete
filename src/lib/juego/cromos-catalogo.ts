/**
 * Economía y catálogo de cromos Solete (arte real en /public/assets/cromos/).
 */

export type RarezaCromo = "comun" | "raro" | "especial";

export type TematicaId =
  | "animales"
  | "ciudades"
  | "comidas"
  | "deportes"
  | "transportes";

export type CromoId = string;

/** Números parametrizables (compra, sobre, devoluciones). */
export const CROMOS_ECONOMIA = {
  precios: {
    comun: 2,
    raro: 5,
    especial: 10,
  },
  /** Sobre clásico: 1 cromo. */
  precioSobre: 3,
  /** Sobre grande: 3 cromos. */
  precioSobreGrande: 10,
  cromosSobreGrande: 3,
  /** Probabilidades acumuladas del sobre (deben sumar 1). */
  probsSobre: {
    comun: 0.65,
    raro: 0.25,
    especial: 0.1,
  },
} as const;

export function precioPorRareza(rareza: RarezaCromo): number {
  return CROMOS_ECONOMIA.precios[rareza];
}

/** Mitad redondeada del precio del cromo (devolución por repetido). */
export function devolucionPorRepetido(rareza: RarezaCromo): number {
  return Math.round(precioPorRareza(rareza) / 2);
}

export type TematicaDef = {
  id: TematicaId;
  nombre: string;
  /** Orden en el álbum. */
  orden: number;
};

export type CromoDef = {
  id: CromoId;
  tematicaId: TematicaId;
  nombre: string;
  rareza: RarezaCromo;
  /** Ruta pública bajo /public, p.ej. /assets/cromos/animales_comun_aguila.png */
  imagenSrc: string;
  /** Orden dentro de la temática. */
  orden: number;
};

export const TEMATICAS_CROMOS: readonly TematicaDef[] = [
  { id: "animales", nombre: "Animales", orden: 1 },
  { id: "ciudades", nombre: "Ciudades", orden: 2 },
  { id: "comidas", nombre: "Comidas", orden: 3 },
  { id: "deportes", nombre: "Deportes", orden: 4 },
  { id: "transportes", nombre: "Transportes", orden: 5 },
] as const;

const img = (archivo: string) => `/assets/cromos/${archivo}`;

/**
 * Catálogo real: 5 categorías × 8 cromos (5 comunes + 2 raros + 1 especial).
 * IDs estables: no renombres al cambiar solo el arte.
 */
export const CATALOGO_CROMOS: readonly CromoDef[] = [
  // —— Animales
  { id: "animales_aguila", tematicaId: "animales", nombre: "Águila", rareza: "comun", imagenSrc: img("animales_comun_aguila.png"), orden: 1 },
  { id: "animales_ardilla", tematicaId: "animales", nombre: "Ardilla", rareza: "comun", imagenSrc: img("animales_comun_ardilla.png"), orden: 2 },
  { id: "animales_camaleon", tematicaId: "animales", nombre: "Camaleón", rareza: "comun", imagenSrc: img("animales_comun_camaleon.png"), orden: 3 },
  { id: "animales_hormiga", tematicaId: "animales", nombre: "Hormiga", rareza: "comun", imagenSrc: img("animales_comun_hormiga.png"), orden: 4 },
  { id: "animales_rinoceronte", tematicaId: "animales", nombre: "Rinoceronte", rareza: "comun", imagenSrc: img("animales_comun_rinoceronte.png"), orden: 5 },
  { id: "animales_caballito_de_mar", tematicaId: "animales", nombre: "Caballito de mar", rareza: "raro", imagenSrc: img("animales_raro_caballito-de-mar.png"), orden: 6 },
  { id: "animales_pavo_real", tematicaId: "animales", nombre: "Pavo real", rareza: "raro", imagenSrc: img("animales_raro_pavo-real.png"), orden: 7 },
  { id: "animales_koala", tematicaId: "animales", nombre: "Koala", rareza: "especial", imagenSrc: img("animales_especial_koala.png"), orden: 8 },

  // —— Ciudades
  { id: "ciudades_bruselas", tematicaId: "ciudades", nombre: "Bruselas", rareza: "comun", imagenSrc: img("ciudades_comun_bruselas.png"), orden: 1 },
  { id: "ciudades_lisboa", tematicaId: "ciudades", nombre: "Lisboa", rareza: "comun", imagenSrc: img("ciudades_comun_lisboa.png"), orden: 2 },
  { id: "ciudades_londres", tematicaId: "ciudades", nombre: "Londres", rareza: "comun", imagenSrc: img("ciudades_comun_londres.png"), orden: 3 },
  { id: "ciudades_paris", tematicaId: "ciudades", nombre: "París", rareza: "comun", imagenSrc: img("ciudades_comun_paris.png"), orden: 4 },
  { id: "ciudades_roma", tematicaId: "ciudades", nombre: "Roma", rareza: "comun", imagenSrc: img("ciudades_comun_roma.png"), orden: 5 },
  { id: "ciudades_amsterdam", tematicaId: "ciudades", nombre: "Ámsterdam", rareza: "raro", imagenSrc: img("ciudades_raro_amsterdam.png"), orden: 6 },
  { id: "ciudades_berlin", tematicaId: "ciudades", nombre: "Berlín", rareza: "raro", imagenSrc: img("ciudades_raro_berlin.png"), orden: 7 },
  { id: "ciudades_madrid", tematicaId: "ciudades", nombre: "Madrid", rareza: "especial", imagenSrc: img("ciudades_especial_madrid.png"), orden: 8 },

  // —— Comidas
  { id: "comidas_hamburguesa", tematicaId: "comidas", nombre: "Hamburguesa", rareza: "comun", imagenSrc: img("comidas_comun_hamburguesa.png"), orden: 1 },
  { id: "comidas_helado", tematicaId: "comidas", nombre: "Helado", rareza: "comun", imagenSrc: img("comidas_comun_helado.png"), orden: 2 },
  { id: "comidas_perrito", tematicaId: "comidas", nombre: "Perrito", rareza: "comun", imagenSrc: img("comidas_comun_perrito.png"), orden: 3 },
  { id: "comidas_pizza", tematicaId: "comidas", nombre: "Pizza", rareza: "comun", imagenSrc: img("comidas_comun_pizza.png"), orden: 4 },
  { id: "comidas_pollo", tematicaId: "comidas", nombre: "Pollo", rareza: "comun", imagenSrc: img("comidas_comun_pollo.png"), orden: 5 },
  { id: "comidas_galleta", tematicaId: "comidas", nombre: "Galleta", rareza: "raro", imagenSrc: img("comidas_raro_galleta.png"), orden: 6 },
  { id: "comidas_pescado", tematicaId: "comidas", nombre: "Pescado", rareza: "raro", imagenSrc: img("comidas_raro_pescado.png"), orden: 7 },
  { id: "comidas_paella", tematicaId: "comidas", nombre: "Paella", rareza: "especial", imagenSrc: img("comidas_especial_paella.png"), orden: 8 },

  // —— Deportes
  { id: "deportes_atletismo", tematicaId: "deportes", nombre: "Atletismo", rareza: "comun", imagenSrc: img("deportes_comun_atletismo.png"), orden: 1 },
  { id: "deportes_baloncesto", tematicaId: "deportes", nombre: "Baloncesto", rareza: "comun", imagenSrc: img("deportes_comun_baloncesto.png"), orden: 2 },
  { id: "deportes_balonmano", tematicaId: "deportes", nombre: "Balonmano", rareza: "comun", imagenSrc: img("deportes_comun_balonmano.png"), orden: 3 },
  { id: "deportes_futbol", tematicaId: "deportes", nombre: "Fútbol", rareza: "comun", imagenSrc: img("deportes_comun_futbol.png"), orden: 4 },
  { id: "deportes_tenis", tematicaId: "deportes", nombre: "Tenis", rareza: "comun", imagenSrc: img("deportes_comun_tenis.png"), orden: 5 },
  { id: "deportes_ciclismo", tematicaId: "deportes", nombre: "Ciclismo", rareza: "raro", imagenSrc: img("deportes_raro_ciclismo.png"), orden: 6 },
  { id: "deportes_gimnasia", tematicaId: "deportes", nombre: "Gimnasia", rareza: "raro", imagenSrc: img("deportes_raro_gimnasia.png"), orden: 7 },
  { id: "deportes_escalada", tematicaId: "deportes", nombre: "Escalada", rareza: "especial", imagenSrc: img("deportes_especial_escalada.png"), orden: 8 },

  // —— Transportes
  { id: "transportes_autobus", tematicaId: "transportes", nombre: "Autobús", rareza: "comun", imagenSrc: img("transportes_comun_autobus.png"), orden: 1 },
  { id: "transportes_coche", tematicaId: "transportes", nombre: "Coche", rareza: "comun", imagenSrc: img("transportes_comun_coche.png"), orden: 2 },
  { id: "transportes_moto", tematicaId: "transportes", nombre: "Moto", rareza: "comun", imagenSrc: img("transportes_comun_moto.png"), orden: 3 },
  { id: "transportes_taxi", tematicaId: "transportes", nombre: "Taxi", rareza: "comun", imagenSrc: img("transportes_comun_taxi.png"), orden: 4 },
  { id: "transportes_tren", tematicaId: "transportes", nombre: "Tren", rareza: "comun", imagenSrc: img("transportes_comun_tren.png"), orden: 5 },
  { id: "transportes_avion", tematicaId: "transportes", nombre: "Avión", rareza: "raro", imagenSrc: img("transportes_raro_avion.png"), orden: 6 },
  { id: "transportes_barco", tematicaId: "transportes", nombre: "Barco", rareza: "raro", imagenSrc: img("transportes_raro_barco.png"), orden: 7 },
  { id: "transportes_glovo", tematicaId: "transportes", nombre: "Glovo", rareza: "especial", imagenSrc: img("transportes_especial_glovo.png"), orden: 8 },
] as const;

export function cromoPorId(id: CromoId): CromoDef | undefined {
  return CATALOGO_CROMOS.find((c) => c.id === id);
}

export function tematicaPorId(id: TematicaId): TematicaDef | undefined {
  return TEMATICAS_CROMOS.find((t) => t.id === id);
}

export function cromosPorRareza(rareza: RarezaCromo): CromoDef[] {
  return CATALOGO_CROMOS.filter((c) => c.rareza === rareza);
}

export function cromosDeTematica(tematicaId: TematicaId): CromoDef[] {
  return CATALOGO_CROMOS.filter((c) => c.tematicaId === tematicaId).sort(
    (a, b) => a.orden - b.orden,
  );
}
