-- =============================================================================
-- Solete — Fase 9: endurecer funciones (Security Advisor)
-- =============================================================================
-- NO ejecutar desde el agente: revisa y corre a mano en el SQL Editor.
--
-- Cierra warnings:
--   • Function Search Path Mutable
--   • Public Can Execute SECURITY DEFINER Function
--   • Signed-In Users Can Execute SECURITY DEFINER Function (RPCs de economía)
--
-- NO toca public.rls_auto_enable() (función interna de Supabase).
-- =============================================================================

BEGIN;

-- -----------------------------------------------------------------------------
-- 1) Helpers RLS / trigger — search_path fijo
--    Nota: es_superadmin se mueve a private en fase9b (fuera de la API).
-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.nino_de_mi_familia(p_nino_id UUID)
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY INVOKER
SET search_path = ''
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.ninos n
    JOIN public.familias f ON f.id = n.familia_id
    WHERE n.id = p_nino_id
      AND f.user_id = auth.uid()
  );
$$;

CREATE OR REPLACE FUNCTION public.proteger_rol_familia()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = ''
AS $$
BEGIN
  IF NEW.rol IS DISTINCT FROM OLD.rol AND OLD.rol IS DISTINCT FROM 'superadmin' THEN
    RAISE EXCEPTION 'El rol solo puede cambiarse desde el panel de Supabase';
  END IF;
  RETURN NEW;
END;
$$;

REVOKE ALL ON FUNCTION public.nino_de_mi_familia(UUID) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.nino_de_mi_familia(UUID) FROM anon;
GRANT EXECUTE ON FUNCTION public.nino_de_mi_familia(UUID) TO authenticated;

REVOKE ALL ON FUNCTION public.proteger_rol_familia() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.proteger_rol_familia() FROM anon;
-- Trigger: lo ejecuta el owner de la tabla; authenticated no necesita EXECUTE.

-- -----------------------------------------------------------------------------
-- 2) Economía / práctica — SECURITY INVOKER (RLS aplica) + search_path ''
--    Antes: siguen exigiendo nino_de_mi_familia; authenticated puede
--    UPDATE ninos / practica_diaria de su familia vía políticas existentes.
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

REVOKE ALL ON FUNCTION public.gastar_diamantes(UUID, INTEGER) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.gastar_diamantes(UUID, INTEGER) FROM anon;
GRANT EXECUTE ON FUNCTION public.gastar_diamantes(UUID, INTEGER) TO authenticated;

REVOKE ALL ON FUNCTION public.devolver_diamantes(UUID, INTEGER) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.devolver_diamantes(UUID, INTEGER) FROM anon;
GRANT EXECUTE ON FUNCTION public.devolver_diamantes(UUID, INTEGER) TO authenticated;

REVOKE ALL ON FUNCTION public.sumar_practica_diaria(UUID, DATE, INTEGER) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.sumar_practica_diaria(UUID, DATE, INTEGER) FROM anon;
GRANT EXECUTE ON FUNCTION public.sumar_practica_diaria(UUID, DATE, INTEGER) TO authenticated;

REVOKE ALL ON FUNCTION public.marcar_diamante_practica_diaria(UUID, DATE) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.marcar_diamante_practica_diaria(UUID, DATE) FROM anon;
GRANT EXECUTE ON FUNCTION public.marcar_diamante_practica_diaria(UUID, DATE) TO authenticated;

-- Evitar que funciones nuevas hereden EXECUTE a anon/public
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  REVOKE EXECUTE ON FUNCTIONS FROM PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  REVOKE EXECUTE ON FUNCTIONS FROM anon;

COMMIT;

-- Tras ejecutar: Database → Advisors → Security → refrescar.
-- Si quedan avisos de es_superadmin o rls_auto_enable → ejecuta fase9b.
