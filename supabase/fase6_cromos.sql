-- =============================================================================
-- Fase 6 — Cromos (colección / gasto de diamantes)
-- =============================================================================
-- NO ejecutar desde el agente: revisa y corre a mano en el SQL Editor.
--
-- Decisión de diseño:
--   - Catálogo (temáticas, rarezas, precios) → constante en código
--     (src/lib/juego/cromos-catalogo.ts).
--   - Tabla cromos_nino → solo posesión (tiene / no tiene). UNIQUE evita
--     duplicar el mismo cromo. Los repetidos del sobre NO se guardan:
--     se devuelve la mitad (redondeada) del precio de esa rareza en la app.
--   - RPCs gastar_diamantes / devolver_diamantes → descuento y abono
--     atómicos (UPDATE … WHERE diamantes >= …) para no poder gastar de más
--     con peticiones concurrentes.
-- =============================================================================

CREATE TABLE IF NOT EXISTS public.cromos_nino (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nino_id UUID NOT NULL REFERENCES public.ninos (id) ON DELETE CASCADE,
  -- Identificador del catálogo en código, p.ej. 'mar_delfin'
  cromo_id TEXT NOT NULL,
  obtenido_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  -- Cómo lo consiguió (auditoría / UI futura)
  via TEXT NOT NULL DEFAULT 'compra'
    CHECK (via IN ('compra', 'sobre')),
  -- Diamantes netos gastados en esta adquisición (sobre repetido: 0 o negativo
  -- no aplica; el repetido no inserta fila). En compra = precio; en sobre nuevo = precioSobre.
  diamantes_gastados INTEGER NOT NULL DEFAULT 0 CHECK (diamantes_gastados >= 0),
  CONSTRAINT cromos_nino_unica UNIQUE (nino_id, cromo_id)
);

CREATE INDEX IF NOT EXISTS cromos_nino_nino_id_idx
  ON public.cromos_nino (nino_id);

CREATE INDEX IF NOT EXISTS cromos_nino_cromo_id_idx
  ON public.cromos_nino (cromo_id);

COMMENT ON TABLE public.cromos_nino IS
  'Cromos poseídos por niño. Catálogo en código; una fila = un cromo único (sin copias).';

COMMENT ON COLUMN public.cromos_nino.cromo_id IS
  'Clave del catálogo (mar_delfin, cole_profe, …).';

COMMENT ON COLUMN public.cromos_nino.via IS
  'compra = compra directa; sobre = resultado de un sobre sorpresa (nuevo).';

-- -----------------------------------------------------------------------------
-- Diamantes atómicos (evita saldos negativos por concurrencia)
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.gastar_diamantes(
  p_nino_id UUID,
  p_cantidad INTEGER
)
RETURNS INTEGER
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = ''
AS $$
DECLARE
  v_nuevo INTEGER;
BEGIN
  IF p_cantidad IS NULL OR p_cantidad <= 0 THEN
    RAISE EXCEPTION 'cantidad_invalida';
  END IF;

  IF NOT public.nino_de_mi_familia(p_nino_id) THEN
    RAISE EXCEPTION 'sin_permiso';
  END IF;

  UPDATE public.ninos
  SET diamantes = diamantes - p_cantidad
  WHERE id = p_nino_id
    AND diamantes >= p_cantidad
  RETURNING diamantes INTO v_nuevo;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'saldo_insuficiente';
  END IF;

  RETURN v_nuevo;
END;
$$;

CREATE OR REPLACE FUNCTION public.devolver_diamantes(
  p_nino_id UUID,
  p_cantidad INTEGER
)
RETURNS INTEGER
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = ''
AS $$
DECLARE
  v_nuevo INTEGER;
BEGIN
  IF p_cantidad IS NULL OR p_cantidad <= 0 THEN
    RAISE EXCEPTION 'cantidad_invalida';
  END IF;

  IF NOT public.nino_de_mi_familia(p_nino_id) THEN
    RAISE EXCEPTION 'sin_permiso';
  END IF;

  UPDATE public.ninos
  SET diamantes = diamantes + p_cantidad
  WHERE id = p_nino_id
  RETURNING diamantes INTO v_nuevo;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'nino_no_encontrado';
  END IF;

  RETURN v_nuevo;
END;
$$;

REVOKE ALL ON FUNCTION public.gastar_diamantes(UUID, INTEGER) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.gastar_diamantes(UUID, INTEGER) FROM anon;
REVOKE ALL ON FUNCTION public.devolver_diamantes(UUID, INTEGER) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.devolver_diamantes(UUID, INTEGER) FROM anon;
GRANT EXECUTE ON FUNCTION public.gastar_diamantes(UUID, INTEGER) TO authenticated;
GRANT EXECUTE ON FUNCTION public.devolver_diamantes(UUID, INTEGER) TO authenticated;

COMMENT ON FUNCTION public.gastar_diamantes(UUID, INTEGER) IS
  'Resta diamantes de forma atómica si hay saldo; exige nino_de_mi_familia.';

COMMENT ON FUNCTION public.devolver_diamantes(UUID, INTEGER) IS
  'Suma diamantes (p.ej. devolución por repetido o rollback de compra fallida).';

-- -----------------------------------------------------------------------------
-- Permisos + RLS
-- -----------------------------------------------------------------------------
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.cromos_nino TO authenticated;

ALTER TABLE public.cromos_nino ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "cromos_nino_select_propia_familia" ON public.cromos_nino;
DROP POLICY IF EXISTS "cromos_nino_insert_propia_familia" ON public.cromos_nino;
DROP POLICY IF EXISTS "cromos_nino_update_propia_familia" ON public.cromos_nino;
DROP POLICY IF EXISTS "cromos_nino_delete_propia_familia" ON public.cromos_nino;

CREATE POLICY "cromos_nino_select_propia_familia"
  ON public.cromos_nino FOR SELECT
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id));

CREATE POLICY "cromos_nino_insert_propia_familia"
  ON public.cromos_nino FOR INSERT
  TO authenticated
  WITH CHECK (public.nino_de_mi_familia(nino_id));

CREATE POLICY "cromos_nino_update_propia_familia"
  ON public.cromos_nino FOR UPDATE
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id))
  WITH CHECK (public.nino_de_mi_familia(nino_id));

CREATE POLICY "cromos_nino_delete_propia_familia"
  ON public.cromos_nino FOR DELETE
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id));

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM pg_proc p
    JOIN pg_namespace n ON n.oid = p.pronamespace
    WHERE p.proname = 'es_superadmin' AND n.nspname = 'private'
  ) THEN
    EXECUTE $pol$
      CREATE POLICY "cromos_nino_select_superadmin"
        ON public.cromos_nino FOR SELECT
        TO authenticated
        USING (private.es_superadmin())
    $pol$;
  END IF;
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;
