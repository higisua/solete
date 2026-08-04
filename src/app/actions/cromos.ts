"use server";

import {
  abrirSobre,
  abrirSobreGrande,
  comprarCromo,
  getColeccionVista,
  type ColeccionVista,
  type ResultadoCompraCromo,
  type ResultadoSobre,
  type ResultadoSobreGrande,
} from "@/lib/juego/cromos";
import { getNinoActivoValidado } from "@/lib/juego/nino";

/**
 * Compra directa del cromo indicado para el niño activo.
 */
export async function comprarCromoAction(
  cromoId: string,
): Promise<ResultadoCompraCromo> {
  const nino = await getNinoActivoValidado();
  if (!nino) {
    return { ok: false, error: "No hay un perfil activo." };
  }
  return comprarCromo(nino.id, cromoId);
}

/**
 * Abre un sobre sorpresa (1 cromo) para el niño activo.
 */
export async function abrirSobreAction(): Promise<ResultadoSobre> {
  const nino = await getNinoActivoValidado();
  if (!nino) {
    return { ok: false, error: "No hay un perfil activo." };
  }
  return abrirSobre(nino.id);
}

/**
 * Abre un sobre grande (3 cromos) para el niño activo.
 */
export async function abrirSobreGrandeAction(): Promise<ResultadoSobreGrande> {
  const nino = await getNinoActivoValidado();
  if (!nino) {
    return { ok: false, error: "No hay un perfil activo." };
  }
  return abrirSobreGrande(nino.id);
}

/**
 * Colección del niño activo (para el álbum).
 */
export async function getColeccionActiva(): Promise<ColeccionVista | null> {
  const nino = await getNinoActivoValidado();
  if (!nino) return null;
  return getColeccionVista(nino.id);
}
