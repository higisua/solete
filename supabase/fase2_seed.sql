-- =============================================================================
-- Solete — Fase 2: datos de ejemplo (seed)
-- =============================================================================
-- Cómo usar: pega este archivo en el SQL Editor de Supabase y ejecútalo
-- DESPUÉS de haber corrido fase2_esquema.sql.
--
-- Incluye solo contenido común: asignaturas → temas → preguntas.
-- NO crea familias ni niños (necesitan un user_id real de Auth).
--
-- Idempotencia suave: borra el contenido previo de estas 3 tablas antes de
-- insertar, para poder re-ejecutar el seed sin duplicar filas.
-- =============================================================================

-- Limpieza del contenido de ejemplo (cascada: preguntas ← temas ← asignaturas)
TRUNCATE TABLE public.preguntas, public.temas, public.asignaturas RESTART IDENTITY CASCADE;

-- -----------------------------------------------------------------------------
-- ASIGNATURAS (curso 1º y 2º de primaria)
-- -----------------------------------------------------------------------------

INSERT INTO public.asignaturas (id, nombre, icono, curso) VALUES
  ('a1111111-1111-1111-1111-111111111101', 'Matemáticas', 'calculadora', '1'),
  ('a1111111-1111-1111-1111-111111111102', 'Lengua', 'libro', '1'),
  ('a1111111-1111-1111-1111-111111111201', 'Matemáticas', 'calculadora', '2'),
  ('a1111111-1111-1111-1111-111111111202', 'Lengua', 'libro', '2');

-- -----------------------------------------------------------------------------
-- TEMAS
-- -----------------------------------------------------------------------------

INSERT INTO public.temas (id, asignatura_id, nombre, orden) VALUES
  -- Matemáticas 1º
  ('b2222222-2222-2222-2222-222222222101', 'a1111111-1111-1111-1111-111111111101', 'Sumas hasta 10', 1),
  ('b2222222-2222-2222-2222-222222222102', 'a1111111-1111-1111-1111-111111111101', 'Restas hasta 10', 2),
  -- Lengua 1º
  ('b2222222-2222-2222-2222-222222222111', 'a1111111-1111-1111-1111-111111111102', 'Vocales y consonantes', 1),
  ('b2222222-2222-2222-2222-222222222112', 'a1111111-1111-1111-1111-111111111102', 'Palabras sencillas', 2),
  -- Matemáticas 2º
  ('b2222222-2222-2222-2222-222222222201', 'a1111111-1111-1111-1111-111111111201', 'Sumas con llevadas', 1),
  ('b2222222-2222-2222-2222-222222222202', 'a1111111-1111-1111-1111-111111111201', 'Tablas del 2 y del 5', 2),
  -- Lengua 2º
  ('b2222222-2222-2222-2222-222222222211', 'a1111111-1111-1111-1111-111111111202', 'Sinónimos', 1),
  ('b2222222-2222-2222-2222-222222222212', 'a1111111-1111-1111-1111-111111111202', 'Mayúsculas', 2);

-- -----------------------------------------------------------------------------
-- PREGUNTAS
-- tipos: numeric | true_false | multiple_choice
-- respuesta / opciones en JSONB
-- -----------------------------------------------------------------------------

INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES

-- ===== Matemáticas 1º — Sumas hasta 10 =====
(
  'b2222222-2222-2222-2222-222222222101',
  'numeric',
  '¿Cuánto es 3 + 4?',
  NULL,
  '7'::jsonb,
  1
),
(
  'b2222222-2222-2222-2222-222222222101',
  'numeric',
  '¿Cuánto es 5 + 5?',
  NULL,
  '10'::jsonb,
  1
),
(
  'b2222222-2222-2222-2222-222222222101',
  'multiple_choice',
  '¿Cuál es el resultado de 2 + 6?',
  '["6", "7", "8", "9"]'::jsonb,
  '"8"'::jsonb,
  2
),
(
  'b2222222-2222-2222-2222-222222222101',
  'true_false',
  '2 + 7 = 9',
  NULL,
  'true'::jsonb,
  1
),

-- ===== Matemáticas 1º — Restas hasta 10 =====
(
  'b2222222-2222-2222-2222-222222222102',
  'numeric',
  '¿Cuánto es 9 - 4?',
  NULL,
  '5'::jsonb,
  1
),
(
  'b2222222-2222-2222-2222-222222222102',
  'numeric',
  '¿Cuánto es 10 - 3?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b2222222-2222-2222-2222-222222222102',
  'true_false',
  '8 - 2 = 5',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2222222-2222-2222-2222-222222222102',
  'multiple_choice',
  '¿Cuál es el resultado de 7 - 3?',
  '["3", "4", "5", "6"]'::jsonb,
  '"4"'::jsonb,
  1
),

-- ===== Lengua 1º — Vocales y consonantes =====
(
  'b2222222-2222-2222-2222-222222222111',
  'true_false',
  'La letra A es una vocal',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2222222-2222-2222-2222-222222222111',
  'true_false',
  'La letra M es una vocal',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2222222-2222-2222-2222-222222222111',
  'multiple_choice',
  '¿Cuál de estas letras es una vocal?',
  '["B", "C", "E", "T"]'::jsonb,
  '"E"'::jsonb,
  1
),
(
  'b2222222-2222-2222-2222-222222222111',
  'multiple_choice',
  '¿Cuántas vocales hay en español?',
  '["3", "4", "5", "6"]'::jsonb,
  '"5"'::jsonb,
  2
),

-- ===== Lengua 1º — Palabras sencillas =====
(
  'b2222222-2222-2222-2222-222222222112',
  'multiple_choice',
  '¿Qué palabra nombra a un animal?',
  '["mesa", "gato", "rojo", "correr"]'::jsonb,
  '"gato"'::jsonb,
  1
),
(
  'b2222222-2222-2222-2222-222222222112',
  'multiple_choice',
  '¿Cuál es el plural de "sol"?',
  '["soles", "sols", "solas", "sol"]'::jsonb,
  '"soles"'::jsonb,
  2
),
(
  'b2222222-2222-2222-2222-222222222112',
  'true_false',
  'La palabra "casa" tiene 4 letras',
  NULL,
  'true'::jsonb,
  1
),

-- ===== Matemáticas 2º — Sumas con llevadas =====
(
  'b2222222-2222-2222-2222-222222222201',
  'numeric',
  '¿Cuánto es 18 + 7?',
  NULL,
  '25'::jsonb,
  2
),
(
  'b2222222-2222-2222-2222-222222222201',
  'numeric',
  '¿Cuánto es 29 + 14?',
  NULL,
  '43'::jsonb,
  3
),
(
  'b2222222-2222-2222-2222-222222222201',
  'multiple_choice',
  '¿Cuál es el resultado de 15 + 16?',
  '["29", "30", "31", "32"]'::jsonb,
  '"31"'::jsonb,
  2
),
(
  'b2222222-2222-2222-2222-222222222201',
  'true_false',
  '24 + 8 = 32',
  NULL,
  'true'::jsonb,
  2
),

-- ===== Matemáticas 2º — Tablas del 2 y del 5 =====
(
  'b2222222-2222-2222-2222-222222222202',
  'numeric',
  '¿Cuánto es 2 × 6?',
  NULL,
  '12'::jsonb,
  1
),
(
  'b2222222-2222-2222-2222-222222222202',
  'numeric',
  '¿Cuánto es 5 × 4?',
  NULL,
  '20'::jsonb,
  1
),
(
  'b2222222-2222-2222-2222-222222222202',
  'multiple_choice',
  '¿Cuál es el resultado de 2 × 8?',
  '["14", "16", "18", "20"]'::jsonb,
  '"16"'::jsonb,
  2
),
(
  'b2222222-2222-2222-2222-222222222202',
  'true_false',
  '5 × 7 = 35',
  NULL,
  'true'::jsonb,
  2
),

-- ===== Lengua 2º — Sinónimos =====
(
  'b2222222-2222-2222-2222-222222222211',
  'multiple_choice',
  '¿Cuál es un sinónimo de "bonito"?',
  '["feo", "alto", "hermoso", "rápido"]'::jsonb,
  '"hermoso"'::jsonb,
  1
),
(
  'b2222222-2222-2222-2222-222222222211',
  'multiple_choice',
  '¿Cuál es un sinónimo de "contento"?',
  '["triste", "alegre", "cansado", "serio"]'::jsonb,
  '"alegre"'::jsonb,
  1
),
(
  'b2222222-2222-2222-2222-222222222211',
  'true_false',
  '"Grande" y "enorme" son sinónimos',
  NULL,
  'true'::jsonb,
  2
),

-- ===== Lengua 2º — Mayúsculas =====
(
  'b2222222-2222-2222-2222-222222222212',
  'true_false',
  'Los nombres propios se escriben con mayúscula',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2222222-2222-2222-2222-222222222212',
  'multiple_choice',
  '¿Cuál está bien escrito?',
  '["madrid", "Madrid", "MADRID", "MaDrId"]'::jsonb,
  '"Madrid"'::jsonb,
  1
),
(
  'b2222222-2222-2222-2222-222222222212',
  'true_false',
  'Después de un punto debemos escribir mayúscula',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2222222-2222-2222-2222-222222222212',
  'multiple_choice',
  '¿Qué palabra debe ir con mayúscula?',
  '["mesa", "perro", "españa", "azul"]'::jsonb,
  '"españa"'::jsonb,
  2
);

-- -----------------------------------------------------------------------------
-- Comprobación rápida (opcional): descomenta para ver contadores
-- -----------------------------------------------------------------------------
-- SELECT 'asignaturas' AS tabla, count(*) FROM public.asignaturas
-- UNION ALL SELECT 'temas', count(*) FROM public.temas
-- UNION ALL SELECT 'preguntas', count(*) FROM public.preguntas;

-- =============================================================================
-- Resumen del seed
-- =============================================================================
-- 4 asignaturas (Matemáticas y Lengua × cursos 1 y 2)
-- 8 temas (2 por asignatura)
-- 30 preguntas (numeric, true_false y multiple_choice mezcladas)
--
-- Nota: familias, ninos, temas_activos, progreso y sesiones se crearán
-- desde la app cuando haya usuarios reales de Auth.
-- =============================================================================
