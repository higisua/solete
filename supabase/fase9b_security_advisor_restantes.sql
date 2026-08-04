-- =============================================================================
-- Solete — Fase 9B: cerrar los 4 warnings restantes del Security Advisor
-- =============================================================================
-- NO ejecutar desde el agente: revisa y corre a mano en el SQL Editor.
--
-- Tras fase9 suelen quedar:
--   1–2) public.es_superadmin  → SECURITY DEFINER expuesto en API (public)
--   3–4) public.rls_auto_enable → DEFINER con EXECUTE a PUBLIC/anon
--
-- Solución:
--   • Mover es_superadmin a schema private (fuera de la API REST)
--   • Revocar EXECUTE de rls_auto_enable a roles de API + fijar search_path
-- =============================================================================

BEGIN;

-- -----------------------------------------------------------------------------
-- 0) Diagnóstico (opcional: descomenta para ver estado antes)
-- -----------------------------------------------------------------------------
-- SELECT n.nspname, p.proname, p.prosecdef,
--        p.proconfig,
--        has_function_privilege('anon', p.oid, 'EXECUTE') AS anon_exec,
--        has_function_privilege('authenticated', p.oid, 'EXECUTE') AS auth_exec,
--        has_function_privilege('public', p.oid, 'EXECUTE') AS public_exec
-- FROM pg_proc p
-- JOIN pg_namespace n ON n.oid = p.pronamespace
-- WHERE n.nspname IN ('public', 'private')
--   AND p.proname IN (
--     'es_superadmin','nino_de_mi_familia','proteger_rol_familia',
--     'gastar_diamantes','devolver_diamantes','sumar_practica_diaria',
--     'marcar_diamante_practica_diaria','rls_auto_enable'
--   )
-- ORDER BY 1, 2;

-- -----------------------------------------------------------------------------
-- 1) Schema private (NO está en Exposed schemas de la API)
-- -----------------------------------------------------------------------------
CREATE SCHEMA IF NOT EXISTS private;

REVOKE ALL ON SCHEMA private FROM PUBLIC;
REVOKE ALL ON SCHEMA private FROM anon;
GRANT USAGE ON SCHEMA private TO authenticated;
GRANT USAGE ON SCHEMA private TO service_role;

COMMENT ON SCHEMA private IS
  'Helpers internos (RLS). No exponer en Settings → API → Exposed schemas.';

-- -----------------------------------------------------------------------------
-- 2) es_superadmin en private (SECURITY DEFINER + search_path vacío)
-- -----------------------------------------------------------------------------
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

-- -----------------------------------------------------------------------------
-- 3) Reapuntar políticas que usaban public.es_superadmin()
-- -----------------------------------------------------------------------------

-- familias / ninos (fase5b)
DROP POLICY IF EXISTS "familias_select_superadmin" ON public.familias;
CREATE POLICY "familias_select_superadmin"
  ON public.familias FOR SELECT
  TO authenticated
  USING (private.es_superadmin());

DROP POLICY IF EXISTS "ninos_select_superadmin" ON public.ninos;
CREATE POLICY "ninos_select_superadmin"
  ON public.ninos FOR SELECT
  TO authenticated
  USING (private.es_superadmin());

-- contenido (fase2)
DROP POLICY IF EXISTS "asignaturas_write_superadmin" ON public.asignaturas;
CREATE POLICY "asignaturas_write_superadmin"
  ON public.asignaturas FOR ALL
  TO authenticated
  USING (private.es_superadmin())
  WITH CHECK (private.es_superadmin());

DROP POLICY IF EXISTS "temas_write_superadmin" ON public.temas;
CREATE POLICY "temas_write_superadmin"
  ON public.temas FOR ALL
  TO authenticated
  USING (private.es_superadmin())
  WITH CHECK (private.es_superadmin());

DROP POLICY IF EXISTS "preguntas_write_superadmin" ON public.preguntas;
CREATE POLICY "preguntas_write_superadmin"
  ON public.preguntas FOR ALL
  TO authenticated
  USING (private.es_superadmin())
  WITH CHECK (private.es_superadmin());

-- tablas fase6 (si existen)
DO $$
BEGIN
  IF to_regclass('public.medallas_nino') IS NOT NULL THEN
    EXECUTE 'DROP POLICY IF EXISTS "medallas_nino_select_superadmin" ON public.medallas_nino';
    EXECUTE $pol$
      CREATE POLICY "medallas_nino_select_superadmin"
        ON public.medallas_nino FOR SELECT
        TO authenticated
        USING (private.es_superadmin())
    $pol$;
  END IF;

  IF to_regclass('public.cromos_nino') IS NOT NULL THEN
    EXECUTE 'DROP POLICY IF EXISTS "cromos_nino_select_superadmin" ON public.cromos_nino';
    EXECUTE $pol$
      CREATE POLICY "cromos_nino_select_superadmin"
        ON public.cromos_nino FOR SELECT
        TO authenticated
        USING (private.es_superadmin())
    $pol$;
  END IF;

  IF to_regclass('public.misiones_diarias') IS NOT NULL THEN
    EXECUTE 'DROP POLICY IF EXISTS "misiones_diarias_select_superadmin" ON public.misiones_diarias';
    EXECUTE $pol$
      CREATE POLICY "misiones_diarias_select_superadmin"
        ON public.misiones_diarias FOR SELECT
        TO authenticated
        USING (private.es_superadmin())
    $pol$;
  END IF;

  IF to_regclass('public.practica_diaria') IS NOT NULL THEN
    EXECUTE 'DROP POLICY IF EXISTS "practica_diaria_select_superadmin" ON public.practica_diaria';
    EXECUTE $pol$
      CREATE POLICY "practica_diaria_select_superadmin"
        ON public.practica_diaria FOR SELECT
        TO authenticated
        USING (private.es_superadmin())
    $pol$;
  END IF;
END $$;

-- Quitar la versión pública (deja de aparecer en /rest/v1/rpc)
DROP FUNCTION IF EXISTS public.es_superadmin();

-- -----------------------------------------------------------------------------
-- 4) rls_auto_enable — no es RPC de la app; revocar API + fijar search_path
-- -----------------------------------------------------------------------------
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM pg_proc p
    JOIN pg_namespace n ON n.oid = p.pronamespace
    WHERE n.nspname = 'public' AND p.proname = 'rls_auto_enable'
  ) THEN
    EXECUTE 'ALTER FUNCTION public.rls_auto_enable() SET search_path = pg_catalog';
    EXECUTE 'REVOKE ALL ON FUNCTION public.rls_auto_enable() FROM PUBLIC';
    EXECUTE 'REVOKE ALL ON FUNCTION public.rls_auto_enable() FROM anon';
    EXECUTE 'REVOKE ALL ON FUNCTION public.rls_auto_enable() FROM authenticated';
  END IF;
END $$;

-- -----------------------------------------------------------------------------
-- 5) Reafirmar economía INVOKER + sin EXECUTE a anon/public
--    (por si fase9 no se aplicó del todo)
-- -----------------------------------------------------------------------------
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM pg_proc p
    JOIN pg_namespace n ON n.oid = p.pronamespace
    WHERE n.nspname = 'public' AND p.proname = 'gastar_diamantes'
  ) THEN
    EXECUTE 'REVOKE ALL ON FUNCTION public.gastar_diamantes(UUID, INTEGER) FROM PUBLIC';
    EXECUTE 'REVOKE ALL ON FUNCTION public.gastar_diamantes(UUID, INTEGER) FROM anon';
    EXECUTE 'GRANT EXECUTE ON FUNCTION public.gastar_diamantes(UUID, INTEGER) TO authenticated';
  END IF;

  IF EXISTS (
    SELECT 1 FROM pg_proc p
    JOIN pg_namespace n ON n.oid = p.pronamespace
    WHERE n.nspname = 'public' AND p.proname = 'devolver_diamantes'
  ) THEN
    EXECUTE 'REVOKE ALL ON FUNCTION public.devolver_diamantes(UUID, INTEGER) FROM PUBLIC';
    EXECUTE 'REVOKE ALL ON FUNCTION public.devolver_diamantes(UUID, INTEGER) FROM anon';
    EXECUTE 'GRANT EXECUTE ON FUNCTION public.devolver_diamantes(UUID, INTEGER) TO authenticated';
  END IF;

  IF EXISTS (
    SELECT 1 FROM pg_proc p
    JOIN pg_namespace n ON n.oid = p.pronamespace
    WHERE n.nspname = 'public' AND p.proname = 'sumar_practica_diaria'
  ) THEN
    EXECUTE 'REVOKE ALL ON FUNCTION public.sumar_practica_diaria(UUID, DATE, INTEGER) FROM PUBLIC';
    EXECUTE 'REVOKE ALL ON FUNCTION public.sumar_practica_diaria(UUID, DATE, INTEGER) FROM anon';
    EXECUTE 'GRANT EXECUTE ON FUNCTION public.sumar_practica_diaria(UUID, DATE, INTEGER) TO authenticated';
  END IF;

  IF EXISTS (
    SELECT 1 FROM pg_proc p
    JOIN pg_namespace n ON n.oid = p.pronamespace
    WHERE n.nspname = 'public' AND p.proname = 'marcar_diamante_practica_diaria'
  ) THEN
    EXECUTE 'REVOKE ALL ON FUNCTION public.marcar_diamante_practica_diaria(UUID, DATE) FROM PUBLIC';
    EXECUTE 'REVOKE ALL ON FUNCTION public.marcar_diamante_practica_diaria(UUID, DATE) FROM anon';
    EXECUTE 'GRANT EXECUTE ON FUNCTION public.marcar_diamante_practica_diaria(UUID, DATE) TO authenticated';
  END IF;
END $$;

COMMIT;

-- Tras ejecutar:
--   1) Settings → API → Exposed schemas: NO añadas "private"
--   2) Advisors → Security → Refresh
-- Si queda algún aviso, pega aquí el nombre de la función.
