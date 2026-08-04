-- =============================================================================
-- Fase 6 — Misión diaria + diamantes
-- =============================================================================
-- NO ejecutar desde el agente: revisa y corre esto a mano en el SQL Editor
-- de Supabase cuando te encaje.
--
-- Qué aporta:
--   (a) ninos.diamantes → contador acumulado (solo sube; +1 al completar la
--       misión del día, máx. 1/día).
--   (b) misiones_diarias → una fila por niño y día civil (fecha = día en
--       Europe/Madrid, escrito por la app). Sirve para irrepetibilidad,
--       resultado del día y, más adelante, un calendario.
--
-- La app calcula "hoy" / "ayer" en Europe/Madrid; la columna fecha es DATE
-- sin zona. No uses CURRENT_DATE del servidor (suele ser UTC).
-- =============================================================================

-- -----------------------------------------------------------------------------
-- (a) Diamantes acumulados por niño
-- -----------------------------------------------------------------------------
ALTER TABLE public.ninos
  ADD COLUMN IF NOT EXISTS diamantes INTEGER NOT NULL DEFAULT 0;

ALTER TABLE public.ninos
  DROP CONSTRAINT IF EXISTS ninos_diamantes_check;

ALTER TABLE public.ninos
  ADD CONSTRAINT ninos_diamantes_check CHECK (diamantes >= 0);

COMMENT ON COLUMN public.ninos.diamantes IS
  'Diamantes acumulados. +1 al completar la misión diaria (máx. 1 por día Madrid).';

-- -----------------------------------------------------------------------------
-- (b) Registro de misión diaria (calendario / irrepetible)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.misiones_diarias (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nino_id UUID NOT NULL REFERENCES public.ninos (id) ON DELETE CASCADE,
  -- Día civil Europe/Madrid (YYYY-MM-DD) calculado en la app
  fecha DATE NOT NULL,
  completada BOOLEAN NOT NULL DEFAULT FALSE,
  aciertos INTEGER NOT NULL DEFAULT 0 CHECK (aciertos >= 0),
  total INTEGER NOT NULL DEFAULT 0 CHECK (total >= 0),
  -- Estrellas de ESA misión (0–3). Una misión/día → es la marca del día.
  estrellas INTEGER NOT NULL DEFAULT 0 CHECK (estrellas BETWEEN 0 AND 3),
  diamante_otorgado BOOLEAN NOT NULL DEFAULT FALSE,
  -- Preguntas elegidas al generar la misión (reanudar / auditoría)
  pregunta_ids UUID[] NOT NULL DEFAULT '{}',
  creada_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  completada_en TIMESTAMPTZ,
  CONSTRAINT misiones_diarias_nino_fecha_unique UNIQUE (nino_id, fecha),
  CONSTRAINT misiones_diarias_aciertos_lte_total CHECK (aciertos <= total)
);

CREATE INDEX IF NOT EXISTS misiones_diarias_nino_id_idx
  ON public.misiones_diarias (nino_id);

CREATE INDEX IF NOT EXISTS misiones_diarias_fecha_idx
  ON public.misiones_diarias (fecha);

COMMENT ON TABLE public.misiones_diarias IS
  'Misión diaria por niño. fecha = día Europe/Madrid. Máx. una completada/día.';

COMMENT ON COLUMN public.misiones_diarias.estrellas IS
  'Estrellas obtenidas ese día (umbrales 12–14 / 15–17 / 18–20 o % si corta).';

COMMENT ON COLUMN public.misiones_diarias.diamante_otorgado IS
  'True si esa misión ya sumó el diamante del día.';

-- -----------------------------------------------------------------------------
-- Permisos + RLS (mismo patrón que progreso/sesiones)
-- -----------------------------------------------------------------------------
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.misiones_diarias TO authenticated;

ALTER TABLE public.misiones_diarias ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "misiones_diarias_select_propia_familia" ON public.misiones_diarias;
DROP POLICY IF EXISTS "misiones_diarias_insert_propia_familia" ON public.misiones_diarias;
DROP POLICY IF EXISTS "misiones_diarias_update_propia_familia" ON public.misiones_diarias;
DROP POLICY IF EXISTS "misiones_diarias_delete_propia_familia" ON public.misiones_diarias;

CREATE POLICY "misiones_diarias_select_propia_familia"
  ON public.misiones_diarias FOR SELECT
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id));

CREATE POLICY "misiones_diarias_insert_propia_familia"
  ON public.misiones_diarias FOR INSERT
  TO authenticated
  WITH CHECK (public.nino_de_mi_familia(nino_id));

CREATE POLICY "misiones_diarias_update_propia_familia"
  ON public.misiones_diarias FOR UPDATE
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id))
  WITH CHECK (public.nino_de_mi_familia(nino_id));

CREATE POLICY "misiones_diarias_delete_propia_familia"
  ON public.misiones_diarias FOR DELETE
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id));

-- Lectura superadmin (si ya tienes es_superadmin de fase 5B)
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM pg_proc p
    JOIN pg_namespace n ON n.oid = p.pronamespace
    WHERE p.proname = 'es_superadmin' AND n.nspname = 'private'
  ) THEN
    EXECUTE $pol$
      CREATE POLICY "misiones_diarias_select_superadmin"
        ON public.misiones_diarias FOR SELECT
        TO authenticated
        USING (private.es_superadmin())
    $pol$;
  END IF;
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;
