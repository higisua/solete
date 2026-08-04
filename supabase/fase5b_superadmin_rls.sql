-- =============================================================================
-- Solete — Fase 5B: lectura de administración para superadmin
-- =============================================================================
-- Ejecutar en SQL Editor. NO debilita el RLS de usuarios normales:
-- solo AÑADE políticas para quien ya es superadmin.
--
-- Además, es_superadmin() vive en schema private (fuera de la API REST)
-- como SECURITY DEFINER para evitar recursión RLS al listar familias.
-- =============================================================================

CREATE SCHEMA IF NOT EXISTS private;
REVOKE ALL ON SCHEMA private FROM PUBLIC;
REVOKE ALL ON SCHEMA private FROM anon;
GRANT USAGE ON SCHEMA private TO authenticated;
GRANT USAGE ON SCHEMA private TO service_role;

CREATE OR REPLACE FUNCTION private.es_superadmin()
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = ''
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.familias
    WHERE user_id = auth.uid()
      AND rol = 'superadmin'
  );
$$;

REVOKE ALL ON FUNCTION private.es_superadmin() FROM PUBLIC;
REVOKE ALL ON FUNCTION private.es_superadmin() FROM anon;
GRANT EXECUTE ON FUNCTION private.es_superadmin() TO authenticated;
GRANT EXECUTE ON FUNCTION private.es_superadmin() TO service_role;

-- Por si quedó una versión antigua en public
DROP FUNCTION IF EXISTS public.es_superadmin();

-- Superadmin puede LEER todas las familias (no modificar desde estas políticas)
DROP POLICY IF EXISTS "familias_select_superadmin" ON public.familias;
CREATE POLICY "familias_select_superadmin"
  ON public.familias FOR SELECT
  TO authenticated
  USING (private.es_superadmin());

-- Superadmin puede LEER todos los niños (para contar por familia)
DROP POLICY IF EXISTS "ninos_select_superadmin" ON public.ninos;
CREATE POLICY "ninos_select_superadmin"
  ON public.ninos FOR SELECT
  TO authenticated
  USING (private.es_superadmin());
