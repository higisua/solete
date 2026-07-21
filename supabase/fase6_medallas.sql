-- =============================================================================
-- Fase 6 — Medallas (logros con diamantes)
-- =============================================================================
-- NO ejecutar desde el agente: revisa y corre a mano en el SQL Editor.
--
-- Decisión de diseño:
--   - Catálogo de medallas (nombre, condición, diamantes) → constante en código
--     (src/lib/juego/medallas-catalogo.ts). Es fijo y versiona con la app.
--   - Tabla medallas_nino → solo el desbloqueo por niño (quién, cuándo, premio).
--
-- Cada medalla se otorga UNA vez (UNIQUE nino_id + medalla_id). Los diamantes
-- del premio se suman a ninos.diamantes desde la app al insertar la fila.
-- =============================================================================

CREATE TABLE IF NOT EXISTS public.medallas_nino (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nino_id UUID NOT NULL REFERENCES public.ninos (id) ON DELETE CASCADE,
  -- Identificador del catálogo en código, p.ej. 'primer_dia', 'semana'
  medalla_id TEXT NOT NULL,
  desbloqueada_en TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  -- Copia del premio en el momento del desbloqueo (auditoría)
  diamantes_otorgados INTEGER NOT NULL DEFAULT 0 CHECK (diamantes_otorgados >= 0),
  CONSTRAINT medallas_nino_unica UNIQUE (nino_id, medalla_id)
);

CREATE INDEX IF NOT EXISTS medallas_nino_nino_id_idx
  ON public.medallas_nino (nino_id);

CREATE INDEX IF NOT EXISTS medallas_nino_medalla_id_idx
  ON public.medallas_nino (medalla_id);

COMMENT ON TABLE public.medallas_nino IS
  'Medallas desbloqueadas por niño. Catálogo fijo en código; una fila = un logro único.';

COMMENT ON COLUMN public.medallas_nino.medalla_id IS
  'Clave del catálogo (primer_dia, tres_dias, semana, …).';

COMMENT ON COLUMN public.medallas_nino.diamantes_otorgados IS
  'Diamantes sumados a ninos.diamantes al desbloquear (no volver a sumar).';

-- -----------------------------------------------------------------------------
-- Permisos + RLS (misma familia que el niño)
-- -----------------------------------------------------------------------------
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.medallas_nino TO authenticated;

ALTER TABLE public.medallas_nino ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "medallas_nino_select_propia_familia" ON public.medallas_nino;
DROP POLICY IF EXISTS "medallas_nino_insert_propia_familia" ON public.medallas_nino;
DROP POLICY IF EXISTS "medallas_nino_update_propia_familia" ON public.medallas_nino;
DROP POLICY IF EXISTS "medallas_nino_delete_propia_familia" ON public.medallas_nino;

CREATE POLICY "medallas_nino_select_propia_familia"
  ON public.medallas_nino FOR SELECT
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id));

CREATE POLICY "medallas_nino_insert_propia_familia"
  ON public.medallas_nino FOR INSERT
  TO authenticated
  WITH CHECK (public.nino_de_mi_familia(nino_id));

CREATE POLICY "medallas_nino_update_propia_familia"
  ON public.medallas_nino FOR UPDATE
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id))
  WITH CHECK (public.nino_de_mi_familia(nino_id));

CREATE POLICY "medallas_nino_delete_propia_familia"
  ON public.medallas_nino FOR DELETE
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id));

-- Lectura superadmin (si existe es_superadmin de fase 5B)
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM pg_proc p
    JOIN pg_namespace n ON n.oid = p.pronamespace
    WHERE p.proname = 'es_superadmin' AND n.nspname = 'public'
  ) THEN
    EXECUTE $pol$
      CREATE POLICY "medallas_nino_select_superadmin"
        ON public.medallas_nino FOR SELECT
        TO authenticated
        USING (public.es_superadmin())
    $pol$;
  END IF;
EXCEPTION
  WHEN duplicate_object THEN NULL;
END $$;
