import { createClient } from "@/lib/supabase/server";
import { getNinoDeMiFamilia } from "@/lib/juego/nino";
import {
  CATALOGO_CROMOS,
  CROMOS_ECONOMIA,
  TEMATICAS_CROMOS,
  cromoPorId,
  cromosPorRareza,
  devolucionPorRepetido,
  precioPorRareza,
  type CromoDef,
  type CromoId,
  type RarezaCromo,
  type TematicaId,
} from "@/lib/juego/cromos-catalogo";

export type ViaCromo = "compra" | "sobre";

export type CromoObtenido = {
  id: CromoId;
  nombre: string;
  rareza: RarezaCromo;
  tematicaId: TematicaId;
  imagenSrc: string;
  diamantes: number;
};

export type ResultadoCompraCromo =
  | {
      ok: true;
      cromo: CromoObtenido;
      diamantesGastados: number;
      diamantesTotales: number;
    }
  | { ok: false; error: string };

export type ResultadoSobre =
  | {
      ok: true;
      cromo: CromoObtenido;
      repetido: boolean;
      diamantesGastados: number;
      diamantesDevueltos: number;
      diamantesTotales: number;
    }
  | { ok: false; error: string };

export type CromoAlbumItem = CromoDef & {
  loTiene: boolean;
  obtenidoEn: string | null;
};

export type TematicaAlbum = {
  id: TematicaId;
  nombre: string;
  orden: number;
  cromos: CromoAlbumItem[];
  conseguidos: number;
  total: number;
};

export type ColeccionVista = {
  tematicas: TematicaAlbum[];
  conseguidos: number;
  total: number;
  diamantes: number;
};

function aPublico(def: CromoDef): CromoObtenido {
  return {
    id: def.id,
    nombre: def.nombre,
    rareza: def.rareza,
    tematicaId: def.tematicaId,
    imagenSrc: def.imagenSrc,
    diamantes: precioPorRareza(def.rareza),
  };
}

/** Entero uniforme en [0, maxExclusive). */
function randomInt(maxExclusive: number): number {
  if (maxExclusive <= 0) return 0;
  const buf = new Uint32Array(1);
  crypto.getRandomValues(buf);
  return buf[0]! % maxExclusive;
}

/** Float [0, 1). */
function randomUnit(): number {
  const buf = new Uint32Array(1);
  crypto.getRandomValues(buf);
  return buf[0]! / 2 ** 32;
}

function elegirRarezaSobre(): RarezaCromo {
  const r = randomUnit();
  const { comun, raro } = CROMOS_ECONOMIA.probsSobre;
  if (r < comun) return "comun";
  if (r < comun + raro) return "raro";
  return "especial";
}

function elegirCromoDeRareza(rareza: RarezaCromo): CromoDef {
  const pool = cromosPorRareza(rareza);
  if (pool.length === 0) {
    // Fallback defensivo: cualquier cromo del catálogo
    return CATALOGO_CROMOS[randomInt(CATALOGO_CROMOS.length)]!;
  }
  return pool[randomInt(pool.length)]!;
}

async function idsPoseidos(ninoId: string): Promise<Set<string>> {
  const supabase = await createClient();
  const { data, error } = await supabase
    .from("cromos_nino")
    .select("cromo_id")
    .eq("nino_id", ninoId);

  if (error) {
    console.warn("[cromos] lectura:", error.message);
    return new Set();
  }
  return new Set((data ?? []).map((r) => String(r.cromo_id)));
}

/**
 * Gasta diamantes de forma atómica (RPC).
 * @returns nuevo saldo o null si fallo (saldo / permiso / SQL no aplicado).
 */
async function gastarDiamantes(
  ninoId: string,
  cantidad: number,
): Promise<{ ok: true; saldo: number } | { ok: false; error: string }> {
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("gastar_diamantes", {
    p_nino_id: ninoId,
    p_cantidad: cantidad,
  });

  if (error) {
    const msg = error.message ?? "";
    if (msg.includes("saldo_insuficiente")) {
      return { ok: false, error: "No tienes diamantes suficientes." };
    }
    if (msg.includes("sin_permiso")) {
      return { ok: false, error: "No puedes gastar diamantes de este perfil." };
    }
    console.warn("[cromos] gastar_diamantes:", msg);
    return {
      ok: false,
      error:
        "No se pudieron gastar diamantes. ¿Ejecutaste fase6_cromos.sql?",
    };
  }

  return { ok: true, saldo: Number(data) };
}

async function devolverDiamantes(
  ninoId: string,
  cantidad: number,
): Promise<number | null> {
  if (cantidad <= 0) return null;
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("devolver_diamantes", {
    p_nino_id: ninoId,
    p_cantidad: cantidad,
  });
  if (error) {
    console.warn("[cromos] devolver_diamantes:", error.message);
    return null;
  }
  return Number(data);
}

async function leerSaldo(ninoId: string): Promise<number> {
  const supabase = await createClient();
  const { data } = await supabase
    .from("ninos")
    .select("diamantes")
    .eq("id", ninoId)
    .maybeSingle();
  return data?.diamantes ?? 0;
}

/**
 * Compra directa: precio exacto por rareza. No permite recomprar.
 */
export async function comprarCromo(
  ninoId: string,
  cromoId: CromoId,
): Promise<ResultadoCompraCromo> {
  const nino = await getNinoDeMiFamilia(ninoId);
  if (!nino) {
    return { ok: false, error: "Perfil no válido." };
  }

  const def = cromoPorId(cromoId);
  if (!def) {
    return { ok: false, error: "Ese cromo no existe." };
  }

  const precio = precioPorRareza(def.rareza);
  const poseidos = await idsPoseidos(ninoId);
  if (poseidos.has(def.id)) {
    return { ok: false, error: "Ya tienes este cromo." };
  }

  const gasto = await gastarDiamantes(ninoId, precio);
  if (!gasto.ok) return gasto;

  const supabase = await createClient();
  const { error: insErr } = await supabase.from("cromos_nino").insert({
    nino_id: ninoId,
    cromo_id: def.id,
    via: "compra" satisfies ViaCromo,
    diamantes_gastados: precio,
  });

  if (insErr) {
    // Carrera: otro proceso lo insertó → devolver diamantes
    await devolverDiamantes(ninoId, precio);
    if (insErr.code === "23505") {
      return { ok: false, error: "Ya tienes este cromo." };
    }
    console.warn("[cromos] insert compra:", insErr.message);
    return { ok: false, error: "No se pudo guardar el cromo." };
  }

  return {
    ok: true,
    cromo: aPublico(def),
    diamantesGastados: precio,
    diamantesTotales: gasto.saldo,
  };
}

/**
 * Sobre sorpresa: gasta precioSobre, elige rareza+cromo al azar.
 * Si es repetido: no inserta; devuelve mitad redondeada del precio de esa rareza.
 */
export async function abrirSobre(ninoId: string): Promise<ResultadoSobre> {
  const nino = await getNinoDeMiFamilia(ninoId);
  if (!nino) {
    return { ok: false, error: "Perfil no válido." };
  }

  const precioSobre = CROMOS_ECONOMIA.precioSobre;
  const gasto = await gastarDiamantes(ninoId, precioSobre);
  if (!gasto.ok) return gasto;

  const rareza = elegirRarezaSobre();
  const def = elegirCromoDeRareza(rareza);
  const poseidos = await idsPoseidos(ninoId);
  const repetido = poseidos.has(def.id);

  if (repetido) {
    const devolucion = devolucionPorRepetido(def.rareza);
    const saldoTras =
      (await devolverDiamantes(ninoId, devolucion)) ??
      gasto.saldo + devolucion;

    return {
      ok: true,
      cromo: aPublico(def),
      repetido: true,
      diamantesGastados: precioSobre,
      diamantesDevueltos: devolucion,
      diamantesTotales: saldoTras,
    };
  }

  const supabase = await createClient();
  const { error: insErr } = await supabase.from("cromos_nino").insert({
    nino_id: ninoId,
    cromo_id: def.id,
    via: "sobre" satisfies ViaCromo,
    diamantes_gastados: precioSobre,
  });

  if (insErr) {
    // Carrera rara: se insertó entre el select y el insert → tratar como repetido
    if (insErr.code === "23505") {
      const devolucion = devolucionPorRepetido(def.rareza);
      const saldoTras =
        (await devolverDiamantes(ninoId, devolucion)) ??
        gasto.saldo + devolucion;
      return {
        ok: true,
        cromo: aPublico(def),
        repetido: true,
        diamantesGastados: precioSobre,
        diamantesDevueltos: devolucion,
        diamantesTotales: saldoTras,
      };
    }
    // Fallo de insert: devolver el coste del sobre
    await devolverDiamantes(ninoId, precioSobre);
    console.warn("[cromos] insert sobre:", insErr.message);
    return { ok: false, error: "No se pudo guardar el cromo del sobre." };
  }

  return {
    ok: true,
    cromo: aPublico(def),
    repetido: false,
    diamantesGastados: precioSobre,
    diamantesDevueltos: 0,
    diamantesTotales: gasto.saldo,
  };
}

/**
 * Álbum de lectura: todas las temáticas + posesión + saldo.
 */
export async function getColeccionVista(
  ninoId: string,
): Promise<ColeccionVista | null> {
  const nino = await getNinoDeMiFamilia(ninoId);
  if (!nino) return null;

  const supabase = await createClient();
  const [{ data: filas }, diamantes] = await Promise.all([
    supabase
      .from("cromos_nino")
      .select("cromo_id, obtenido_en")
      .eq("nino_id", ninoId),
    leerSaldo(ninoId),
  ]);

  const mapa = new Map(
    (filas ?? []).map((f) => [
      String(f.cromo_id),
      f.obtenido_en ? String(f.obtenido_en) : null,
    ]),
  );

  const tematicas: TematicaAlbum[] = [...TEMATICAS_CROMOS]
    .sort((a, b) => a.orden - b.orden)
    .map((t) => {
      const cromos: CromoAlbumItem[] = CATALOGO_CROMOS.filter(
        (c) => c.tematicaId === t.id,
      )
        .sort((a, b) => a.orden - b.orden)
        .map((c) => ({
          ...c,
          loTiene: mapa.has(c.id),
          obtenidoEn: mapa.get(c.id) ?? null,
        }));
      const conseguidos = cromos.filter((c) => c.loTiene).length;
      return {
        id: t.id,
        nombre: t.nombre,
        orden: t.orden,
        cromos,
        conseguidos,
        total: cromos.length,
      };
    });

  const conseguidos = tematicas.reduce((s, t) => s + t.conseguidos, 0);

  return {
    tematicas,
    conseguidos,
    total: CATALOGO_CROMOS.length,
    diamantes,
  };
}
