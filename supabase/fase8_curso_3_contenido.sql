-- =============================================================================
-- Solete — Permitir contenido de 3º de primaria (solo asignaturas)
-- =============================================================================
-- Los niños siguen siendo curso 1 o 2.
-- La práctica EXTREMA de 2º usa preguntas de asignaturas con curso = '3'.
-- Ejecutar a mano en el SQL Editor de Supabase.
-- =============================================================================

-- Quitar CHECK antiguo e instalar uno que admite '3' en asignaturas.
ALTER TABLE public.asignaturas
  DROP CONSTRAINT IF EXISTS asignaturas_curso_check;

ALTER TABLE public.asignaturas
  ADD CONSTRAINT asignaturas_curso_check
  CHECK (curso IN ('1', '2', '3'));

COMMENT ON COLUMN public.asignaturas.curso IS
  'Curso del contenido: 1, 2 o 3. Los niños solo se matriculan en 1 o 2; el 3 alimenta la práctica extrema de 2º.';

-- Después de este script, carga el pack:
--   supabase/fase8_seed_preguntas_3ep.sql
-- (Matemáticas + Lengua de 3º para práctica EXTREMA de 2º).
