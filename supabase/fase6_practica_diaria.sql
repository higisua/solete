-- =============================================================================
-- Fase 6 — Práctica diaria (conteo + diamante topado)
-- =============================================================================
-- NO ejecutar desde el agente: revisa y corre a mano en el SQL Editor.
--
-- Por qué una tabla nueva (recomendado) y no solo `sesiones`:
--   - Necesitamos un contador del día civil Europe/Madrid (fecha DATE escrita
--     por la app) y un flag `diamante_otorgado` para no dar 1💎 dos veces.
--   - Sumar `sesiones` (TIMESTAMPTZ) obliga a convertir zona en cada consulta;
--     sin flag, dos partidas concurrentes podrían doble-otorgar el diamante.
--   - Pros tabla: atómica, clara, espejo de misiones_diarias.
--   - Contras tabla: migración extra; histórico previo a este SQL no rellena
--     practica_diaria (el total acumulado de medallas usa `sesiones` modo libre).
--
-- Alternativa sin BD nueva: SUM(sesiones.total) WHERE modo='libre' y fecha
--   convertida a Madrid; otorgar si antes < 10 y después >= 10.
--   Pros: cero migración. Contras: frágil con concurrencia; sin auditoría limpia
--   de “ya cobré hoy”; borde DST/filtros más feos.
-- =============================================================================

CREATE TABLE IF NOT EXISTS public.practica_diaria (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nino_id UUID NOT NULL REFERENCES public.ninos (id) ON DELETE CASCADE,
  -- Día civil Europe/Madrid (YYYY-MM-DD) calculado en la app
  fecha DATE NOT NULL,
  -- Preguntas de práctica respondidas ese día (suma de partidas)
  preguntas INTEGER NOT NULL DEFAULT 0 CHECK (preguntas >= 0),
  -- True si ya se sumó el +1 💎 del día por llegar a 10 preguntas
  diamante_otorgado BOOLEAN NOT NULL DEFAULT FALSE,
  actualizado_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT practica_diaria_nino_fecha_unique UNIQUE (nino_id, fecha)
);

CREATE INDEX IF NOT EXISTS practica_diaria_nino_id_idx
  ON public.practica_diaria (nino_id);

CREATE INDEX IF NOT EXISTS practica_diaria_fecha_idx
  ON public.practica_diaria (fecha);

COMMENT ON TABLE public.practica_diaria IS
  'Conteo de práctica por niño y día Madrid. +1💎 al llegar a 10 preguntas (máx. 1/día).';

COMMENT ON COLUMN public.practica_diaria.fecha IS
  'Día civil Europe/Madrid escrito por la app (no CURRENT_DATE del servidor).';

COMMENT ON COLUMN public.practica_diaria.diamante_otorgado IS
  'True si ese día ya otorgó el diamante de práctica.';

-- -----------------------------------------------------------------------------
-- Incremento atómico del contador del día
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.sumar_practica_diaria(
  p_nino_id UUID,
  p_fecha DATE,
  p_preguntas INTEGER
)
RETURNS public.practica_diaria
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = ''
AS $$
DECLARE
  v_fila public.practica_diaria;
BEGIN
  IF p_preguntas IS NULL OR p_preguntas <= 0 THEN
    RAISE EXCEPTION 'preguntas_invalidas';
  END IF;

  IF NOT public.nino_de_mi_familia(p_nino_id) THEN
    RAISE EXCEPTION 'sin_permiso';
  END IF;

  INSERT INTO public.practica_diaria (nino_id, fecha, preguntas, actualizado_en)
  VALUES (p_nino_id, p_fecha, p_preguntas, NOW())
  ON CONFLICT (nino_id, fecha) DO UPDATE
    SET preguntas = public.practica_diaria.preguntas + EXCLUDED.preguntas,
        actualizado_en = NOW()
  RETURNING * INTO v_fila;

  RETURN v_fila;
END;
$$;

-- Marca el diamante del día solo una vez (idempotente).
CREATE OR REPLACE FUNCTION public.marcar_diamante_practica_diaria(
  p_nino_id UUID,
  p_fecha DATE
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = ''
AS $$
DECLARE
  v_updated INTEGER;
BEGIN
  IF NOT public.nino_de_mi_familia(p_nino_id) THEN
    RAISE EXCEPTION 'sin_permiso';
  END IF;

  UPDATE public.practica_diaria
  SET diamante_otorgado = TRUE,
      actualizado_en = NOW()
  WHERE nino_id = p_nino_id
    AND fecha = p_fecha
    AND diamante_otorgado = FALSE
    AND preguntas >= 10;

  GET DIAGNOSTICS v_updated = ROW_COUNT;
  RETURN v_updated > 0;
END;
$$;

REVOKE ALL ON FUNCTION public.sumar_practica_diaria(UUID, DATE, INTEGER) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.sumar_practica_diaria(UUID, DATE, INTEGER) FROM anon;
REVOKE ALL ON FUNCTION public.marcar_diamante_practica_diaria(UUID, DATE) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.marcar_diamante_practica_diaria(UUID, DATE) FROM anon;
GRANT EXECUTE ON FUNCTION public.sumar_practica_diaria(UUID, DATE, INTEGER) TO authenticated;
GRANT EXECUTE ON FUNCTION public.marcar_diamante_practica_diaria(UUID, DATE) TO authenticated;

-- -----------------------------------------------------------------------------
-- Permisos + RLS
-- -----------------------------------------------------------------------------
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.practica_diaria TO authenticated;

ALTER TABLE public.practica_diaria ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "practica_diaria_select_propia_familia" ON public.practica_diaria;
DROP POLICY IF EXISTS "practica_diaria_insert_propia_familia" ON public.practica_diaria;
DROP POLICY IF EXISTS "practica_diaria_update_propia_familia" ON public.practica_diaria;
DROP POLICY IF EXISTS "practica_diaria_delete_propia_familia" ON public.practica_diaria;

CREATE POLICY "practica_diaria_select_propia_familia"
  ON public.practica_diaria FOR SELECT
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id));

CREATE POLICY "practica_diaria_insert_propia_familia"
  ON public.practica_diaria FOR INSERT
  TO authenticated
  WITH CHECK (public.nino_de_mi_familia(nino_id));

CREATE POLICY "practica_diaria_update_propia_familia"
  ON public.practica_diaria FOR UPDATE
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id))
  WITH CHECK (public.nino_de_mi_familia(nino_id));

CREATE POLICY "practica_diaria_delete_propia_familia"
  ON public.practica_diaria FOR DELETE
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
      CREATE POLICY "practica_diaria_select_superadmin"
        ON public.practica_diaria FOR SELECT
        TO authenticated
        USING (private.es_superadmin())
    $pol$;
  END IF;
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;
