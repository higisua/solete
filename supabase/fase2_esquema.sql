-- =============================================================================
-- Solete — Fase 2: esquema de base de datos + Row Level Security (RLS)
-- =============================================================================
-- Cómo usar: pega este archivo completo en el SQL Editor de Supabase y ejecútalo.
-- NO incluye datos de ejemplo (seed); eso irá en un segundo paso.
-- =============================================================================

-- Extensión para generar UUIDs (habitualmente ya activa en Supabase)
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- -----------------------------------------------------------------------------
-- 1. TABLAS DE CUENTA Y PERFILES
-- -----------------------------------------------------------------------------

-- Familia = cuenta del adulto (1 fila por usuario de Auth)
CREATE TABLE public.familias (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE REFERENCES auth.users (id) ON DELETE CASCADE,
  nombre TEXT NOT NULL,
  pin_hash TEXT, -- PIN de 4 dígitos cifrado (se rellena más adelante)
  rol TEXT NOT NULL DEFAULT 'user' CHECK (rol IN ('user', 'superadmin')),
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMENT ON TABLE public.familias IS 'Cuenta familiar vinculada a un usuario de Supabase Auth';
COMMENT ON COLUMN public.familias.pin_hash IS 'Hash del PIN de la zona padres; no guardar el PIN en claro';
COMMENT ON COLUMN public.familias.rol IS 'user = familia normal; superadmin = puede editar contenido';

-- Niños = perfiles dentro de una familia (sin login propio)
CREATE TABLE public.ninos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  familia_id UUID NOT NULL REFERENCES public.familias (id) ON DELETE CASCADE,
  nombre TEXT NOT NULL,
  curso TEXT NOT NULL CHECK (curso IN ('1', '2')),
  avatar TEXT NOT NULL, -- nombre del archivo/avatar elegido (ej. solete_avatar_leon)
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX ninos_familia_id_idx ON public.ninos (familia_id);

COMMENT ON TABLE public.ninos IS 'Perfiles de niños; pertenecen a una familia';

-- -----------------------------------------------------------------------------
-- 2. CONTENIDO COMÚN (igual para todas las familias)
-- -----------------------------------------------------------------------------

CREATE TABLE public.asignaturas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre TEXT NOT NULL,
  icono TEXT NOT NULL,
  curso TEXT NOT NULL CHECK (curso IN ('1', '2')),
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMENT ON TABLE public.asignaturas IS 'Asignaturas por curso (contenido global)';

CREATE TABLE public.temas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  asignatura_id UUID NOT NULL REFERENCES public.asignaturas (id) ON DELETE CASCADE,
  nombre TEXT NOT NULL,
  orden INTEGER NOT NULL DEFAULT 0,
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX temas_asignatura_id_idx ON public.temas (asignatura_id);

COMMENT ON TABLE public.temas IS 'Temas dentro de una asignatura';

CREATE TABLE public.preguntas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tema_id UUID NOT NULL REFERENCES public.temas (id) ON DELETE CASCADE,
  tipo TEXT NOT NULL CHECK (tipo IN ('numeric', 'true_false', 'multiple_choice')),
  enunciado TEXT NOT NULL,
  opciones JSONB, -- solo multiple_choice; null en el resto
  respuesta JSONB NOT NULL, -- formato flexible según el tipo
  dificultad INTEGER NOT NULL CHECK (dificultad BETWEEN 1 AND 3),
  creado_en TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX preguntas_tema_id_idx ON public.preguntas (tema_id);

COMMENT ON TABLE public.preguntas IS 'Preguntas de un tema; opciones/respuesta en JSONB';

-- -----------------------------------------------------------------------------
-- 3. DATOS POR NIÑO (progreso y juego)
-- -----------------------------------------------------------------------------

-- Temas que el adulto ha activado para un niño
CREATE TABLE public.temas_activos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nino_id UUID NOT NULL REFERENCES public.ninos (id) ON DELETE CASCADE,
  tema_id UUID NOT NULL REFERENCES public.temas (id) ON DELETE CASCADE,
  activo BOOLEAN NOT NULL DEFAULT true,
  UNIQUE (nino_id, tema_id)
);

CREATE INDEX temas_activos_nino_id_idx ON public.temas_activos (nino_id);

COMMENT ON TABLE public.temas_activos IS 'Temas activados por niño desde la zona padres';

-- Progreso acumulado por niño y tema
CREATE TABLE public.progreso (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nino_id UUID NOT NULL REFERENCES public.ninos (id) ON DELETE CASCADE,
  tema_id UUID NOT NULL REFERENCES public.temas (id) ON DELETE CASCADE,
  puntos INTEGER NOT NULL DEFAULT 0,
  estrellas INTEGER NOT NULL DEFAULT 0,
  aciertos INTEGER NOT NULL DEFAULT 0,
  intentos INTEGER NOT NULL DEFAULT 0,
  UNIQUE (nino_id, tema_id)
);

CREATE INDEX progreso_nino_id_idx ON public.progreso (nino_id);

COMMENT ON TABLE public.progreso IS 'Progreso acumulado de un niño en un tema';

-- Historial de partidas
CREATE TABLE public.sesiones (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nino_id UUID NOT NULL REFERENCES public.ninos (id) ON DELETE CASCADE,
  tema_id UUID NOT NULL REFERENCES public.temas (id) ON DELETE CASCADE,
  modo TEXT NOT NULL CHECK (modo IN ('mision', 'libre')),
  aciertos INTEGER NOT NULL DEFAULT 0,
  total INTEGER NOT NULL DEFAULT 0,
  fecha TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX sesiones_nino_id_idx ON public.sesiones (nino_id);
CREATE INDEX sesiones_fecha_idx ON public.sesiones (fecha DESC);

COMMENT ON TABLE public.sesiones IS 'Sesiones de juego (misión o libre)';

-- -----------------------------------------------------------------------------
-- 4. HELPERS PARA RLS
-- -----------------------------------------------------------------------------
-- Funciones STABLE usadas en políticas para no repetir subconsultas.
-- SECURITY INVOKER (por defecto): respetan RLS de las tablas que consultan.

-- Schema private: helpers RLS fuera de la API REST (no exponer en Settings → API).
CREATE SCHEMA IF NOT EXISTS private;
REVOKE ALL ON SCHEMA private FROM PUBLIC;
REVOKE ALL ON SCHEMA private FROM anon;
GRANT USAGE ON SCHEMA private TO authenticated;
GRANT USAGE ON SCHEMA private TO service_role;

-- ¿La familia del usuario autenticado es superadmin?
-- SECURITY DEFINER evita recursión RLS; vive en private (no RPC público).
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

-- ¿Este niño pertenece a la familia del usuario autenticado?
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

-- -----------------------------------------------------------------------------
-- 5. ROW LEVEL SECURITY
-- -----------------------------------------------------------------------------

ALTER TABLE public.familias ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ninos ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.asignaturas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.temas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.preguntas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.temas_activos ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.progreso ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sesiones ENABLE ROW LEVEL SECURITY;

-- ========== familias ==========
-- Cada usuario solo ve/edita SU fila (user_id = auth.uid()).

CREATE POLICY "familias_select_propia"
  ON public.familias FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

CREATE POLICY "familias_insert_propia"
  ON public.familias FOR INSERT
  TO authenticated
  WITH CHECK (user_id = auth.uid() AND rol = 'user');
  -- El rol superadmin se asigna a mano desde el dashboard (service role),
  -- no desde el cliente.

CREATE POLICY "familias_update_propia"
  ON public.familias FOR UPDATE
  TO authenticated
  USING (user_id = auth.uid())
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "familias_delete_propia"
  ON public.familias FOR DELETE
  TO authenticated
  USING (user_id = auth.uid());

-- Impide auto-ascender a superadmin desde el cliente (el dashboard/service role sí puede).
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

CREATE TRIGGER trg_proteger_rol_familia
  BEFORE UPDATE OF rol ON public.familias
  FOR EACH ROW
  EXECUTE FUNCTION public.proteger_rol_familia();

-- ========== ninos ==========
-- Solo los niños de tu familia.

CREATE POLICY "ninos_select_propia_familia"
  ON public.ninos FOR SELECT
  TO authenticated
  USING (
    familia_id IN (SELECT id FROM public.familias WHERE user_id = auth.uid())
  );

CREATE POLICY "ninos_insert_propia_familia"
  ON public.ninos FOR INSERT
  TO authenticated
  WITH CHECK (
    familia_id IN (SELECT id FROM public.familias WHERE user_id = auth.uid())
  );

CREATE POLICY "ninos_update_propia_familia"
  ON public.ninos FOR UPDATE
  TO authenticated
  USING (
    familia_id IN (SELECT id FROM public.familias WHERE user_id = auth.uid())
  )
  WITH CHECK (
    familia_id IN (SELECT id FROM public.familias WHERE user_id = auth.uid())
  );

CREATE POLICY "ninos_delete_propia_familia"
  ON public.ninos FOR DELETE
  TO authenticated
  USING (
    familia_id IN (SELECT id FROM public.familias WHERE user_id = auth.uid())
  );

-- ========== asignaturas / temas / preguntas ==========
-- Lectura: cualquier usuario autenticado (contenido común).
-- Escritura: solo superadmin.

CREATE POLICY "asignaturas_select_autenticados"
  ON public.asignaturas FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "asignaturas_write_superadmin"
  ON public.asignaturas FOR ALL
  TO authenticated
  USING (private.es_superadmin())
  WITH CHECK (private.es_superadmin());

CREATE POLICY "temas_select_autenticados"
  ON public.temas FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "temas_write_superadmin"
  ON public.temas FOR ALL
  TO authenticated
  USING (private.es_superadmin())
  WITH CHECK (private.es_superadmin());

CREATE POLICY "preguntas_select_autenticados"
  ON public.preguntas FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "preguntas_write_superadmin"
  ON public.preguntas FOR ALL
  TO authenticated
  USING (private.es_superadmin())
  WITH CHECK (private.es_superadmin());

-- Nota: en asignaturas/temas/preguntas coexisten una política SELECT (todos)
-- y una FOR ALL (superadmin). PostgreSQL aplica OR entre políticas del mismo
-- comando: los users normales leen; el superadmin lee y escribe.

-- ========== temas_activos / progreso / sesiones ==========
-- Solo datos de niños de tu familia.

CREATE POLICY "temas_activos_select_propia_familia"
  ON public.temas_activos FOR SELECT
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id));

CREATE POLICY "temas_activos_insert_propia_familia"
  ON public.temas_activos FOR INSERT
  TO authenticated
  WITH CHECK (public.nino_de_mi_familia(nino_id));

CREATE POLICY "temas_activos_update_propia_familia"
  ON public.temas_activos FOR UPDATE
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id))
  WITH CHECK (public.nino_de_mi_familia(nino_id));

CREATE POLICY "temas_activos_delete_propia_familia"
  ON public.temas_activos FOR DELETE
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id));

CREATE POLICY "progreso_select_propia_familia"
  ON public.progreso FOR SELECT
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id));

CREATE POLICY "progreso_insert_propia_familia"
  ON public.progreso FOR INSERT
  TO authenticated
  WITH CHECK (public.nino_de_mi_familia(nino_id));

CREATE POLICY "progreso_update_propia_familia"
  ON public.progreso FOR UPDATE
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id))
  WITH CHECK (public.nino_de_mi_familia(nino_id));

CREATE POLICY "progreso_delete_propia_familia"
  ON public.progreso FOR DELETE
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id));

CREATE POLICY "sesiones_select_propia_familia"
  ON public.sesiones FOR SELECT
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id));

CREATE POLICY "sesiones_insert_propia_familia"
  ON public.sesiones FOR INSERT
  TO authenticated
  WITH CHECK (public.nino_de_mi_familia(nino_id));

CREATE POLICY "sesiones_update_propia_familia"
  ON public.sesiones FOR UPDATE
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id))
  WITH CHECK (public.nino_de_mi_familia(nino_id));

CREATE POLICY "sesiones_delete_propia_familia"
  ON public.sesiones FOR DELETE
  TO authenticated
  USING (public.nino_de_mi_familia(nino_id));

-- =============================================================================
-- Fin del esquema Fase 2
-- =============================================================================
-- Tras ejecutarlo, en Table Editor deberías ver las 8 tablas.
-- Para asignarte superadmin (contenido): Table Editor → familias → edita rol
-- (como service role / desde el dashboard se bypasea RLS).
-- =============================================================================
