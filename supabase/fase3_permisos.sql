-- =============================================================================
-- Solete — Parche Fase 3: permisos para roles authenticated/anon
-- =============================================================================
-- Ejecutar en SQL Editor si el registro crea el usuario Auth pero falla al
-- guardar la fila en "familias" (error de permisos / RLS).
-- =============================================================================

GRANT USAGE ON SCHEMA public TO anon, authenticated;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.familias TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.ninos TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.temas_activos TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.progreso TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.sesiones TO authenticated;

GRANT SELECT ON TABLE public.asignaturas TO authenticated;
GRANT SELECT ON TABLE public.temas TO authenticated;
GRANT SELECT ON TABLE public.preguntas TO authenticated;

-- Escritura de contenido: solo vía políticas de superadmin (ya definidas).
GRANT INSERT, UPDATE, DELETE ON TABLE public.asignaturas TO authenticated;
GRANT INSERT, UPDATE, DELETE ON TABLE public.temas TO authenticated;
GRANT INSERT, UPDATE, DELETE ON TABLE public.preguntas TO authenticated;

-- Asegura que la política de insert de familias está correcta
DROP POLICY IF EXISTS "familias_insert_propia" ON public.familias;
CREATE POLICY "familias_insert_propia"
  ON public.familias FOR INSERT
  TO authenticated
  WITH CHECK (user_id = auth.uid() AND rol = 'user');
