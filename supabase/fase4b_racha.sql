-- =============================================================================
-- Solete — Fase 4B: racha diaria en ninos
-- =============================================================================
-- Ejecuta esto en el SQL Editor de Supabase ANTES de probar misiones.
-- NO lo ejecuto yo desde el código; es un cambio de esquema a tu cargo.
-- =============================================================================

ALTER TABLE public.ninos
  ADD COLUMN IF NOT EXISTS racha_dias INTEGER NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS ultima_mision_fecha DATE;

COMMENT ON COLUMN public.ninos.racha_dias IS
  'Días consecutivos con al menos una misión completada';
COMMENT ON COLUMN public.ninos.ultima_mision_fecha IS
  'Fecha (día calendario) de la última misión que sumó a la racha';
