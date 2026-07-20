-- =============================================================================
-- Solete — Fase 5B: lectura de administración para superadmin
-- =============================================================================
-- Ejecutar en SQL Editor. NO debilita el RLS de usuarios normales:
-- solo AÑADE políticas para quien ya es superadmin.
--
-- Además, es_superadmin() pasa a SECURITY DEFINER para evitar recursión RLS
-- al listar todas las familias.
-- =============================================================================

CREATE OR REPLACE FUNCTION public.es_superadmin()
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.familias
    WHERE user_id = auth.uid()
      AND rol = 'superadmin'
  );
$$;

REVOKE ALL ON FUNCTION public.es_superadmin() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.es_superadmin() TO authenticated;

-- Superadmin puede LEER todas las familias (no modificar desde estas políticas)
DROP POLICY IF EXISTS "familias_select_superadmin" ON public.familias;
CREATE POLICY "familias_select_superadmin"
  ON public.familias FOR SELECT
  TO authenticated
  USING (public.es_superadmin());

-- Superadmin puede LEER todos los niños (para contar por familia)
DROP POLICY IF EXISTS "ninos_select_superadmin" ON public.ninos;
CREATE POLICY "ninos_select_superadmin"
  ON public.ninos FOR SELECT
  TO authenticated
  USING (public.es_superadmin());
