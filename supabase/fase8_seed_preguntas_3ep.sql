-- =============================================================================
-- Solete — Pack de preguntas 3º de primaria (Excel)
-- =============================================================================
-- NO ejecutar desde el agente: revisa y corre a mano en el SQL Editor de Supabase.
--
-- Requiere antes: supabase/fase8_curso_3_contenido.sql (CHECK curso IN 1,2,3).
-- Sustituye TODAS las asignaturas / temas / preguntas de curso = '3'.
-- No toca el contenido de 1º ni 2º.
--
-- Origen: preguntas 3º.xlsx (Matemáticas + Lengua).
-- Uso: práctica EXTREMA de niños de 2º.
-- =============================================================================

BEGIN;

DELETE FROM public.asignaturas WHERE curso = '3';

-- Asignaturas 3º
INSERT INTO public.asignaturas (id, nombre, icono, curso) VALUES
  ('a3000001-0001-4000-8000-000000000001', 'Matemáticas', '🔢', '3'),
  ('a3000001-0001-4000-8000-000000000002', 'Lengua', '📖', '3');

-- Temas 3º
INSERT INTO public.temas (id, asignatura_id, nombre, orden) VALUES
  ('b3000001-0001-4000-8000-000000000001', 'a3000001-0001-4000-8000-000000000001', 'Números y operaciones', 1),
  ('b3000001-0001-4000-8000-000000000002', 'a3000001-0001-4000-8000-000000000001', 'Divisiones y reparto igualitario', 2),
  ('b3000001-0001-4000-8000-000000000003', 'a3000001-0001-4000-8000-000000000001', 'Medida y geometría', 3),
  ('b3000001-0001-4000-8000-000000000004', 'a3000001-0001-4000-8000-000000000001', 'Resolución de problemas', 4),
  ('b3000001-0001-4000-8000-000000000005', 'a3000001-0001-4000-8000-000000000002', 'Comunicación oral y escrita', 1),
  ('b3000001-0001-4000-8000-000000000006', 'a3000001-0001-4000-8000-000000000002', 'Gramática y vocabulario', 2),
  ('b3000001-0001-4000-8000-000000000007', 'a3000001-0001-4000-8000-000000000002', 'Ortografía', 3);

-- Preguntas

-- Matemáticas / Números y operaciones (125)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número se forma con 4 unidades de millar 2 centenas 8 decenas y 5 unidades?',
  NULL,
  '4285'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cómo se escribe en cifras el número ''siete mil treinta y dos''?',
  NULL,
  '7032'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número va justo antes del 10.000?',
  NULL,
  '9999'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuál es el valor de posición de la cifra 5 en el número 5.621?',
  NULL,
  '5000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuántas centenas completas hay en 3.000 unidades?',
  NULL,
  '30'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número se obtiene al descomponer 8.000 + 900 + 4?',
  NULL,
  '8904'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la suma con llevadas en vertical: 4.528 + 3.745',
  NULL,
  '8273'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la suma con llevadas en vertical: 6.199 + 2.805',
  NULL,
  '9004'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la resta con llevadas en vertical: 5.241 - 1.835',
  NULL,
  '3406'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la resta con llevadas en vertical: 8.000 - 3.450',
  NULL,
  '4550'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 7.409 es menor que el número 7.490.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'En el número 9.352 la cifra 3 ocupa el lugar de las decenas de millar.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'Al redondear el número 4.812 a la centena más cercana obtenemos 4.800.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'Si sumamos 0 a cualquier número de cuatro cifras el resultado cambia.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Cómo se lee el número 6.005?',
  '["Seis mil cinco", "Seis mil cincuenta", "Seiscientos cinco", "Sesenta mil cinco"]'::jsonb,
  '"Seis mil cinco"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Cuál es la descomposición correcta del número 3.450?',
  '["3 UM + 4 C + 5 D", "3 C + 4 D + 5 U", "3 UM + 4 D + 5 U", "30 UM + 45 C"]'::jsonb,
  '"3 UM + 4 C + 5 D"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué número es el posterior a 8.899?',
  '["8.900", "8.890", "8.898", "9.000"]'::jsonb,
  '"8.900"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué cifra ocupa el lugar de las unidades de millar en el número 2.147?',
  '["2", "1", "4", "7"]'::jsonb,
  '"2"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  'Si el minuendo es 5.000 y el sustraendo es 1.200 ¿cuál es la diferencia?',
  '["3.800", "4.200", "6.200", "3.500"]'::jsonb,
  '"3.800"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  'Si aproximas el número 6.780 a la unidad de millar más cercana obtenemos...',
  '["7.000", "6.000", "6.800", "10.000"]'::jsonb,
  '"7.000"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuánto es 3.500 + 2.500?',
  NULL,
  '6000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuánto es 9.400 - 400?',
  NULL,
  '9000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 9.999 es el número de 4 cifras más grande que existe.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'La resta de 4.000 menos 1.500 es igual a 3.500.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué signo falta aquí? 8.102 ___ 8.099',
  '["Mayor que", "Menor que", "Igual que", "Ninguno"]'::jsonb,
  '"Mayor que"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número se forma con 9 unidades de millar 9 centenas 9 decenas y 9 unidades?',
  NULL,
  '9999'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cómo se escribe en cifras el número ''cinco mil cuatrocientos dos''?',
  NULL,
  '5402'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número va justo después del 6.999?',
  NULL,
  '7000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuál es el valor de posición de la cifra 7 en el número 3.745?',
  NULL,
  '700'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuántas unidades de millar completas hay en 8.000 unidades?',
  NULL,
  '8'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número se obtiene al descomponer 3.000 + 40 + 8?',
  NULL,
  '3048'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la suma con llevadas en vertical: 2.789 + 1.435',
  NULL,
  '4224'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la suma con llevadas en vertical: 5.672 + 3.829',
  NULL,
  '9501'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la resta con llevadas en vertical: 4.312 - 2.540',
  NULL,
  '1772'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la resta con llevadas en vertical: 9.002 - 4.135',
  NULL,
  '4867'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 5.032 es mayor que el número 5.302.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'En el número 6.124 la cifra 6 ocupa el lugar de las unidades de millar.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'Al redondear el número 7.689 a la centena más cercana obtenemos 7.700.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'Si restamos 0 a un número de cuatro cifras el número se vuelve cero.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Cómo se lee el número 4.020?',
  '["Cuatro mil veinte", "Cuatro mil dos", "Cuatrocientos veinte", "Cuarenta mil veinte"]'::jsonb,
  '"Cuatro mil veinte"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Cuál es la descomposición correcta del número 9.034?',
  '["9 UM + 3 D + 4 U", "9 C + 3 D + 4 U", "9 UM + 3 C + 4 U", "90 UM + 34 C"]'::jsonb,
  '"9 UM + 3 D + 4 U"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué número es el anterior a 3.100?',
  '["3.099", "3.000", "3.101", "3.090"]'::jsonb,
  '"3.099"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué cifra ocupa el lugar de las centenas en el número 8.529?',
  '["5", "8", "2", "9"]'::jsonb,
  '"5"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  'Si el minuendo es 7.500 y el sustraendo es 2.300 ¿cuál es la diferencia?',
  '["5.200", "5.000", "9.800", "4.200"]'::jsonb,
  '"5.200"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  'Si aproximas el número 2.310 a la unidad de millar más cercana obtenemos...',
  '["2.000", "3.000", "2.300", "1.000"]'::jsonb,
  '"2.000"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuánto es 4.200 + 1.800?',
  NULL,
  '6000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuánto es 8.500 - 500?',
  NULL,
  '8000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 1.000 es el número de 4 cifras más pequeño que existe.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'La suma de 5.000 más 4.500 es igual a 10.000.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué signo falta aquí? 6.740 ___ 6.741',
  '["Menor que", "Mayor que", "Igual que", "Ninguno"]'::jsonb,
  '"Menor que"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número se forma con 9 unidades de millar 0 centenas 5 decenas y 3 unidades?',
  NULL,
  '9053'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cómo se escribe en cifras el número ''cinco mil doscientos uno''?',
  NULL,
  '5201'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número va justo después del 4.999?',
  NULL,
  '5000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuál es el valor de posición de la cifra 7 en el número 2.748?',
  NULL,
  '700'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuántas unidades de millar completas hay en 6.000 unidades?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número se obtiene al descomponer 3.000 + 40 + 8?',
  NULL,
  '3048'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la suma con llevadas en vertical: 5.682 + 2.439',
  NULL,
  '8121'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la suma con llevadas en vertical: 3.754 + 1.256',
  NULL,
  '5010'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la resta con llevadas en vertical: 7.315 - 4.582',
  NULL,
  '2733'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la resta con llevadas en vertical: 6.002 - 2.145',
  NULL,
  '3857'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 9.020 es mayor que el número 9.200.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'En el número 4.781 la cifra 4 ocupa el lugar de las unidades de millar.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'Al redondear el número 2.389 a la centena más cercana obtenemos 2.400.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'La resta de dos números naturales puede dar un resultado mayor que el minuendo.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Cómo se lee el número 8.040?',
  '["Ocho mil cuarenta", "Ocho mil cuatro", "Ocho mil cuatrocientos", "Ochenta mil cuarenta"]'::jsonb,
  '"Ocho mil cuarenta"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Cuál es la descomposición correcta del número 5.062?',
  '["5 UM + 6 D + 2 U", "5 C + 6 D + 2 U", "5 UM + 6 C + 2 D", "50 C + 62 U"]'::jsonb,
  '"5 UM + 6 D + 2 U"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué número es el anterior a 3.100?',
  '["3.099", "3.000", "3.101", "2.999"]'::jsonb,
  '"3.099"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué cifra ocupa el lugar de las centenas en el número 9.514?',
  '["5", "9", "1", "4"]'::jsonb,
  '"5"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  'Si sumas 4.100 y 1.900 ¿cuál es el total?',
  '["6.000", "5.000", "5.900", "6.100"]'::jsonb,
  '"6.000"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  'Si aproximas el número 3.250 a la unidad de millar más cercana obtenemos...',
  '["3.000", "4.000", "3.300", "3.200"]'::jsonb,
  '"3.000"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuánto es 8.200 - 1.200?',
  NULL,
  '7000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuánto nos da juntar 1.500 unidades y 3.500 unidades más?',
  NULL,
  '5000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 1.000 es el primer número de cuatro cifras.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'Si a 7.500 le restas 2.500 el resultado es 4.000.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué signo falta aquí? 5.670 ___ 5.760',
  '["Menor que", "Mayor que", "Igual que", "Ninguno"]'::jsonb,
  '"Menor que"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número se forma con 6 unidades de millar 8 centenas 0 decenas y 2 unidades?',
  NULL,
  '6802'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cómo se escribe en cifras el número ''nueve mil cuatrocientos treinta''?',
  NULL,
  '9430'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número va justo antes del 6.000?',
  NULL,
  '5999'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuál es el valor de posición de la cifra 3 en el número 8.395?',
  NULL,
  '300'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuántas decenas completas hay en 400 unidades sueltas?',
  NULL,
  '40'::jsonb,
  2
);
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número se obtiene al descomponer 2.000 + 700 + 90?',
  NULL,
  '2790'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la suma con llevadas en vertical: 6.471 + 1.859',
  NULL,
  '8330'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la suma con llevadas en vertical: 2.845 + 3.165',
  NULL,
  '6010'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la resta con llevadas en vertical: 8.243 - 3.651',
  NULL,
  '4592'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la resta con llevadas en vertical: 5.001 - 1.432',
  NULL,
  '3569'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 4.050 es menor que el número 4.005.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'En el número 7.814 la cifra 8 ocupa el lugar de las centenas.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'Al redondear el número 8.621 a la centena más cercana obtenemos 8.600.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'Si sumas dos números de cuatro cifras el total puede tener cinco cifras.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Cómo se lee el número 3.080?',
  '["Tres mil ochenta", "Tres mil ocho", "Tres mil ochocientos", "Treinta mil ochenta"]'::jsonb,
  '"Tres mil ochenta"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Cuál es la descomposición correcta del número 9.104?',
  '["9 UM + 1 C + 4 U", "9 C + 1 D + 4 U", "9 UM + 1 D + 4 U", "90 C + 14 U"]'::jsonb,
  '"9 UM + 1 C + 4 U"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué número es el posterior a 5.099?',
  '["5.100", "5.000", "5.098", "6.000"]'::jsonb,
  '"5.100"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué cifra ocupa el lugar de las unidades de millar en el número 6.258?',
  '["6", "2", "5", "8"]'::jsonb,
  '"6"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  'Si sumas 2.300 y 3.700 ¿cuál es el total?',
  '["6.000", "5.000", "5.900", "6.300"]'::jsonb,
  '"6.000"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  'Si aproximas el número 8.910 a la unidad de millar más cercana obtenemos...',
  '["9.000", "8.000", "8.900", "10.000"]'::jsonb,
  '"9.000"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuánto es 7.500 - 2.500?',
  NULL,
  '5000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuánto nos da juntar 4.200 unidades y 1.800 unidades más?',
  NULL,
  '6000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 9.999 es el último número antes del diez mil.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'Si a 5.400 le restas 1.400 el resultado es 3.000.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué signo falta aquí? 7.820 ___ 7.280',
  '["Mayor que", "Menor que", "Igual que", "Ninguno"]'::jsonb,
  '"Mayor que"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número se forma con 7 unidades de millar 9 centenas 4 decenas y 0 unidades?',
  NULL,
  '7940'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cómo se escribe en cifras el número ''ocho mil seiscientos quince''?',
  NULL,
  '8615'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número va justo después del 6.999?',
  NULL,
  '7000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuál es el valor de posición de la cifra 9 en el número 4.192?',
  NULL,
  '90'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuántas centenas completas hay en 8.000 unidades sueltas?',
  NULL,
  '80'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número se obtiene al descomponer 5.000 + 300 + 2?',
  NULL,
  '5302'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la suma con llevadas en vertical: 7.285 + 1.948',
  NULL,
  '9233'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la suma con llevadas en vertical: 4.356 + 2.644',
  NULL,
  '7000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la resta con llevadas en vertical: 9.132 - 4.571',
  NULL,
  '4561'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  'Resuelve la resta con llevadas en vertical: 4.005 - 2.318',
  NULL,
  '1687'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 3.805 es mayor que el número 3.850.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'En el número 6.247 la cifra 6 ocupa el lugar de las unidades de millar.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'Al redondear el número 5.192 a la centena más cercana obtenemos 5.200.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'La diferencia entre dos números es siempre menor o igual que el minuendo.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Cómo se lee el número 4.070?',
  '["Cuatro mil setenta", "Cuatro mil siete", "Cuatro mil setecientos", "Cuarenta mil setenta"]'::jsonb,
  '"Cuatro mil setenta"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Cuál es la descomposición correcta del número 2.308?',
  '["2 UM + 3 C + 8 U", "2 C + 3 D + 8 U", "2 UM + 3 D + 8 U", "20 C + 38 U"]'::jsonb,
  '"2 UM + 3 C + 8 U"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué número es el anterior a 6.000?',
  '["5.999", "5.900", "6.001", "5.000"]'::jsonb,
  '"5.999"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué cifra ocupa el lugar de las decenas en el número 7.843?',
  '["4", "7", "8", "3"]'::jsonb,
  '"4"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  'Si sumas 3.400 y 2.600 ¿cuál es el total?',
  '["6.000", "5.000", "5.800", "6.200"]'::jsonb,
  '"6.000"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  'Si aproximas el número 4.120 a la unidad de millar más cercana obtenemos...',
  '["4.000", "5.000", "4.100", "4.200"]'::jsonb,
  '"4.000"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuánto es 9.500 - 3.500?',
  NULL,
  '6000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuánto nos da juntar 2.800 unidades y 3.200 unidades más?',
  NULL,
  '6000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 9.999 es el número impar de cuatro cifras más grande que existe.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'true_false',
  'Si a 8.200 le restas 3.200 el resultado es 4.500.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué signo falta aquí? 6.340 ___ 6.430',
  '["Menor que", "Mayor que", "Igual que", "Ninguno"]'::jsonb,
  '"Menor que"'::jsonb,
  2
);

-- Matemáticas / Divisiones y reparto igualitario (125)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si repartes 24 caramelos en partes iguales entre 4 niños ¿cuántos le tocan a cada uno?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuál es el cociente de la división exacta 45 entre 5?',
  NULL,
  '9'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si dividimos 18 pinturas entre 3 botes en partes iguales ¿cuántas pinturas ponemos en cada bote?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuál es el resto de una división exacta?',
  NULL,
  '0'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si repartes 50 céntimos entre 5 hermanos a partes iguales ¿cuántos céntimos le das a cada uno?',
  NULL,
  '10'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuál es el dividendo si el divisor es 6 el cociente es 4 y el resto es 0?',
  NULL,
  '24'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si repartes 32 cromos entre 8 amigos ¿cuántos le corresponden a cada uno?',
  NULL,
  '4'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto da dividir 70 entre 10?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si tienes 15 manzanas y haces 3 grupos iguales ¿cuántas manzanas hay en cada grupo?',
  NULL,
  '5'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si dividimos 42 juguetes entre 6 cajas ¿cuántos juguetes van en cada caja?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'Dividir es lo mismo que repartir una cantidad en partes iguales.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'En una división el resto puede ser mayor o igual que el divisor.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'Si dividimos 21 entre 3 obtenemos como cociente 7.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'Una división es inexacta cuando su resto es igual a cero.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cómo llamamos a la cantidad total que queremos repartir en una división?',
  '["Dividendo", "Divisor", "Cociente", "Resto"]'::jsonb,
  '"Dividendo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cómo llamamos al número de partes entre las que hacemos el reparto?',
  '["Divisor", "Dividendo", "Cociente", "Resto"]'::jsonb,
  '"Divisor"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cómo llamamos al resultado por persona o parte en la división?',
  '["Cociente", "Dividendo", "Divisor", "Resto"]'::jsonb,
  '"Cociente"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cómo llamamos a lo que sobra al final de hacer un reparto igualitario?',
  '["Resto", "Dividendo", "Divisor", "Cociente"]'::jsonb,
  '"Resto"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  'Si repartimos 13 caramelos entre 4 niños ¿cuántos caramelos sobran (resto)?',
  '["1", "2", "3", "0"]'::jsonb,
  '"1"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cuál es la mitad de 18 si hacemos un reparto en 2 partes iguales?',
  '["9", "8", "7", "10"]'::jsonb,
  '"9"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es un tercio de 30 si lo dividimos entre 3?',
  NULL,
  '10'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es un cuarto de 40 si lo dividimos entre 4?',
  NULL,
  '10'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'Si repartimos 0 caramelos entre 5 niños cada uno recibe 0 caramelos.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'La operación inversa a la división es la suma.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  'Si dividimos 35 entre 7 ¿qué número multiplicado por 7 nos da 35?',
  '["5", "6", "4", "7"]'::jsonb,
  '"5"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si repartes 36 globos en partes iguales entre 6 niños ¿cuántos le tocan a cada uno?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuál es el cociente de la división exacta 56 entre 8?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si colocamos 20 libros en 4 estanterías en partes iguales ¿cuántos libros van en cada estantería?',
  NULL,
  '5'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuál es el resto si dividimos 15 caramelos entre 2 niños?',
  NULL,
  '1'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si repartes 80 céntimos entre 8 personas a partes iguales ¿cuántos céntimos recibe cada una?',
  NULL,
  '10'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuál es el dividendo si el divisor es 7 el cociente es 5 y el resto es 0?',
  NULL,
  '35'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si divides 27 canicas entre 3 amigos en partes iguales ¿cuántas canicas le tocan a cada uno?',
  NULL,
  '9'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto da dividir 90 entre 10?',
  NULL,
  '9'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si tienes 16 bombones y haces 4 paquetes iguales ¿cuántos bombones hay en cada paquete?',
  NULL,
  '4'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si divides 48 lápices entre 6 botes ¿cuántos van en cada bote?',
  NULL,
  '8'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'En una división exacta el resto siempre es un número mayor que cero.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'El resto siempre tiene que ser más pequeño que el divisor.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'Si dividimos 30 entre 5 obtenemos como cociente 6.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'Una división es exacta cuando nos sobra una cantidad en el resto.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Qué término de la división indica las partes en las que se divide el total?',
  '["Divisor", "Dividendo", "Cociente", "Resto"]'::jsonb,
  '"Divisor"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Qué término de la división representa el resultado final del reparto?',
  '["Cociente", "Dividendo", "Divisor", "Resto"]'::jsonb,
  '"Cociente"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Qué término representa lo que queda sin poder repartir?',
  '["Resto", "Dividendo", "Divisor", "Cociente"]'::jsonb,
  '"Resto"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Qué término representa la cantidad inicial que vamos a distribuir?',
  '["Dividendo", "Divisor", "Cociente", "Resto"]'::jsonb,
  '"Dividendo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  'Si dividimos 17 pegatinas entre 4 cuadernos ¿cuál es el resto?',
  '["1", "2", "0", "4"]'::jsonb,
  '"1"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cuál es la mitad de 14 si lo dividimos entre 2 partes iguales?',
  '["7", "6", "8", "14"]'::jsonb,
  '"7"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es un tercio de 21 si lo dividimos entre 3?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es un cuarto de 24 si lo dividimos entre 4?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'Si dividimos 40 entre 10 el resultado es 4.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'Para comprobar si una división está bien hecha multiplicamos el divisor por el cociente y sumamos el resto.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  'Si dividimos 12 manzanas entre 4 niños ¿qué número multiplicado por 4 da 12?',
  '["3", "2", "4", "5"]'::jsonb,
  '"3"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si repartes 36 lápices en partes iguales entre 6 botes ¿cuántos lápices pones en cada bote?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuál es el cociente de la división exacta 56 entre 8?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si dividimos 40 cromos entre 5 amigos en partes iguales ¿cuántos le tocan a cada uno?',
  NULL,
  '8'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuál es el resto si repartes 15 globos entre 2 niños a partes iguales?',
  NULL,
  '1'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si divides un billete de 20 euros en 4 partes iguales ¿cuántos euros vale cada parte?',
  NULL,
  '5'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuál es el dividendo si el divisor es 7 el cociente es 5 y el resto es 0?',
  NULL,
  '35'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si repartes 27 juguetes entre 9 cajas a partes iguales ¿cuántos juguetes van en cada caja?',
  NULL,
  '3'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto da dividir 90 entre 10?',
  NULL,
  '9'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si tienes 28 fresas y haces 4 grupos iguales ¿cuántas fresas hay en cada grupo?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si dividimos 48 caramelos entre 6 niños ¿cuántos caramelos recibe cada uno?',
  NULL,
  '8'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'En una división exacta el resto siempre es cero.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'El divisor es la parte que sobra cuando no se puede seguir repartiendo.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'Si dividimos 32 entre 4 obtenemos como cociente 8.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'Si el divisor es 5 el resto de la división puede ser 6.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cómo se llama el término que indica las partes en las que se divide el dividendo?',
  '["Divisor", "Dividendo", "Cociente", "Resto"]'::jsonb,
  '"Divisor"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cómo llamamos a la cantidad que queda sin poder repartir en una división inexacta?',
  '["Resto", "Dividendo", "Divisor", "Cociente"]'::jsonb,
  '"Resto"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cuál es el cociente si dividimos 63 entre 9?',
  '["7", "8", "6", "9"]'::jsonb,
  '"7"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  'Si repartimos 22 libros entre 5 estantes iguales ¿cuántos libros sobran (resto)?',
  '["2", "1", "0", "4"]'::jsonb,
  '"2"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cuál es la mitad de 14 si hacemos un reparto igualitario en 2 partes?',
  '["7", "6", "8", "14"]'::jsonb,
  '"7"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cuánto es un tercio de 24 si lo calculas dividiendo entre 3?',
  '["8", "6", "7", "9"]'::jsonb,
  '"8"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es un cuarto de 20 si lo divides entre 4?',
  NULL,
  '5'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es un quinto de 45 si lo divides entre 5?',
  NULL,
  '9'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'La prueba de la división dice que Dividendo es igual a Divisor por Cociente más Resto.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'Dividir un número entre 1 da como resultado un número diferente.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  'Si dividimos 30 entre 6 ¿qué número de la tabla del 6 nos da 30?',
  '["5", "4", "6", "3"]'::jsonb,
  '"5"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si repartes 42 rotuladores en partes iguales entre 7 botes ¿cuántos pones en cada bote?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuál es el cociente de la división exacta 72 entre 9?',
  NULL,
  '8'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si dividimos 35 canicas entre 5 niños en partes iguales ¿cuántas le tocan a cada uno?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuál es el resto si repartes 19 globos entre 3 niños a partes iguales?',
  NULL,
  '1'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si divides un premio de 50 euros en 10 partes iguales ¿cuántos euros vale cada parte?',
  NULL,
  '5'::jsonb,
  2
);
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuál es el dividendo si el divisor es 8 el cociente es 4 y el resto es 0?',
  NULL,
  '32'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si repartes 54 pegatinas entre 6 páginas a partes iguales ¿cuántas pegatinas van en cada página?',
  NULL,
  '9'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto da dividir 80 entre 10?',
  NULL,
  '8'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si tienes 21 naranjas y haces 3 grupos iguales ¿cuántas naranjas hay en cada grupo?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si dividimos 40 bombones entre 8 abuelos ¿cuántos bombones recibe cada uno?',
  NULL,
  '5'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'En una división inexacta o con resto el residuo final siempre es cero.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'El cociente representa la cantidad que le toca a cada parte en el reparto.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'Si dividimos 45 entre 9 obtenemos como cociente 5.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'El resto de una división puede ser igual al divisor.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cómo se llama la cantidad que sobra al dividir y que ya no se puede repartir?',
  '["Resto", "Divisor", "Dividendo", "Cociente"]'::jsonb,
  '"Resto"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cómo llamamos al número por el cual se divide el dividendo?',
  '["Divisor", "Dividendo", "Cociente", "Resto"]'::jsonb,
  '"Divisor"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cuál es el cociente si dividimos 48 entre 6?',
  '["8", "7", "6", "9"]'::jsonb,
  '"8"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  'Si repartimos 26 lápices entre 4 estuches iguales ¿cuántos lápices sobran (resto)?',
  '["2", "1", "0", "3"]'::jsonb,
  '"2"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cuál es la mitad de 20 si realizas un reparto en 2 partes iguales?',
  '["10", "5", "15", "2"]'::jsonb,
  '"10"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cuánto es un tercio de 27 si lo calculas dividiendo entre 3?',
  '["9", "8", "7", "6"]'::jsonb,
  '"9"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es un cuarto de 36 si lo divides entre 4?',
  NULL,
  '9'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es un quinto de 50 si lo divides entre 5?',
  NULL,
  '10'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'La división es la operación matemática que sirve para calcular el doble de una cantidad.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'Dividir un número entre sí mismo (ej. 7 entre 7) siempre da como cociente 1.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  'Si dividimos 54 entre 9 ¿qué número de la tabla del 9 nos da 54?',
  '["6", "7", "5", "8"]'::jsonb,
  '"6"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si repartes 49 lápices en partes iguales entre 7 botes ¿cuántos lápices pones en cada bote?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuál es el cociente de la división exacta 81 entre 9?',
  NULL,
  '9'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si dividimos 42 cromos entre 6 amigos en partes iguales ¿cuántos le tocan a cada uno?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuál es el resto si repartes 21 globos entre 4 niños a partes iguales?',
  NULL,
  '1'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si divides un premio de 90 euros en 10 partes iguales ¿cuántos euros vale cada parte?',
  NULL,
  '9'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuál es el dividendo si el divisor es 9 el cociente es 3 y el resto es 0?',
  NULL,
  '27'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si repartes 35 pegatinas entre 5 páginas a partes iguales ¿cuántas pegatinas van en cada página?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto da dividir 60 entre 10?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si tienes 24 naranjas y haces 4 grupos iguales ¿cuántas naranjas hay en cada grupo?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  'Si dividimos 45 caramelos entre 5 niños ¿cuántos caramelos recibe cada uno?',
  NULL,
  '9'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'En una división exacta el dividendo siempre es igual al divisor por el cociente.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'El dividendo es el resultado final que le toca a cada persona en el reparto.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'Si dividimos 54 entre 6 obtenemos como cociente 9.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'El resto de una división exacta puede ser cualquier número par diferente de cero.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cómo se llama la cantidad total que se va a dividir o repartir en partes iguales?',
  '["Dividendo", "Divisor", "Cociente", "Resto"]'::jsonb,
  '"Dividendo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cómo llamamos al número que nos indica en cuántas partes iguales dividimos una cantidad?',
  '["Divisor", "Dividendo", "Cociente", "Resto"]'::jsonb,
  '"Divisor"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cuál es el cociente si dividimos 56 entre 7?',
  '["8", "7", "6", "9"]'::jsonb,
  '"8"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  'Si repartimos 31 lápices entre 6 estuches iguales ¿cuántos lápices sobran (resto)?',
  '["1", "2", "0", "5"]'::jsonb,
  '"1"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cuál es la mitad de 40 si realizas un reparto en 2 partes iguales?',
  '["20", "10", "30", "5"]'::jsonb,
  '"20"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cuánto es un tercio de 18 si lo calculas dividiendo entre 3?',
  '["6", "5", "7", "8"]'::jsonb,
  '"6"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es un cuarto de 28 si lo divides entre 4?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es un quinto de 35 si lo divides entre 5?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'La división exacta es aquella en la que no nos sobra nada al terminar el reparto.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'true_false',
  'Dividir un número entre 1 da como resultado el número cero.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000002',
  'multiple_choice',
  'Si dividimos 42 entre 7 ¿qué número de la tabla del 7 nos da 42?',
  '["6", "7", "5", "8"]'::jsonb,
  '"6"'::jsonb,
  2
);

-- Matemáticas / Medida y geometría (125)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos centímetros equivalen a 1 metro de longitud completa?',
  NULL,
  '100'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos gramos hay en 1 kilogramo de masa?',
  NULL,
  '1000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos mililitros se necesitan para llenar una botella de 1 litro de capacidad?',
  NULL,
  '1000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Si juntas dos monedas de 50 céntimos ¿cuántos euros completos formas?',
  NULL,
  '1'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos minutos pasan si la aguja grande del reloj analógico da una vuelta completa?',
  NULL,
  '60'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Calcula el perímetro de un cuadrado si cada uno de sus cuatro lados mide 5 centímetros.',
  NULL,
  '20'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos lados rectos tiene un polígono que es un pentágono?',
  NULL,
  '5'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántas bases circulares planas tiene un cuerpo geométrico que es un cilindro?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Si tienes un billete de 5 euros y tres monedas de 2 euros ¿cuántos euros tienes en total?',
  NULL,
  '11'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Calcula el perímetro de un triángulo si sus tres lados miden 4 centímetros cada uno.',
  NULL,
  '12'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'El perímetro de una figura plana es la suma de las longitudes de todos sus lados.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'Una esfera es un cuerpo geométrico plano que tiene 4 vértices o esquinas.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'En un reloj digital si pone 06:30 significa que son las seis y media.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'El kilogramo (kg) es la unidad principal que usamos para medir el largo de una calle.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué unidad de medida usarías para saber el peso o masa de una manzana?',
  '["Gramos (g)", "Metros (m)", "Litros (l)", "Centímetros (cm)"]'::jsonb,
  '"Gramos (g)"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué unidad de medida se utiliza para medir la cantidad de agua de una piscina?',
  '["Litros (l)", "Kilogramos (kg)", "Metros (m)", "Gramos (g)"]'::jsonb,
  '"Litros (l)"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'Si la aguja pequeña está en el 3 y la grande está en el 12 ¿qué hora es?',
  '["Las 3 en punto", "Las 3 y cuarto", "Las 3 y media", "Las 12 en punto"]'::jsonb,
  '"Las 3 en punto"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué figura geométrica básica tiene 3 lados y 3 vértices?',
  '["Triángulo", "Cuadrado", "Círculo", "Rombo"]'::jsonb,
  '"Triángulo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué cuerpo geométrico en tres dimensiones tiene la forma de un dado de parchís?',
  '["Cubo", "Esfera", "Cilindro", "Cono"]'::jsonb,
  '"Cubo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cuántos céntimos de euro necesitas para igualar un billete de 5 euros?',
  '["500 céntimos", "50 céntimos", "5 céntimos", "100 céntimos"]'::jsonb,
  '"500 céntimos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos lados tiene un hexágono?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Si un rectángulo mide 6 cm de largo y 4 cm de ancho ¿cuál es su perímetro en centímetros?',
  NULL,
  '20'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'Un litro equivale a cuatro cuartos de litro juntos.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'Las monedas de nuestro sistema monetario incluyen las de 1 y 2 euros además de las de céntimos.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'En un reloj digital si marca exactamente 09:15 ¿cómo leemos los minutos?',
  '["Y cuarto", "En punto", "Y media", "Menos cuarto"]'::jsonb,
  '"Y cuarto"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos centímetros mide una regla escolar que tiene una longitud de medio metro?',
  NULL,
  '50'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos medios kilos necesitas juntar para tener 2 kilogramos enteros de arroz?',
  NULL,
  '4'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos medios litros de agua necesitas para rellenar una jarra de 3 litros de capacidad?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Si cambias un billete de 5 euros por monedas de 1 euro ¿cuántas monedas te tienen que dar?',
  NULL,
  '5'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos minutos pasan si la aguja grande del reloj recorre desde el número 12 hasta el número 6?',
  NULL,
  '30'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Calcula el perímetro de un triángulo si sus tres lados miden 6 centímetros cada uno.',
  NULL,
  '18'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos lados rectos tiene un polígono que es un octógono?',
  NULL,
  '8'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos vértices o esquinas tiene un polígono que es un pentágono?',
  NULL,
  '5'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Si tienes dos billetes de 10 euros y una moneda de 2 euros ¿cuántos euros tienes en total?',
  NULL,
  '22'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Calcula el perímetro de un cuadrado si cada uno de sus cuatro lados mide 8 centímetros.',
  NULL,
  '32'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'El perímetro de un rectángulo se calcula sumando el largo y el ancho una sola vez.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'Un prisma es un cuerpo geométrico con volumen que tiene caras planas.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'En un reloj analógico si la aguja pequeña señala el 4 y la grande el 6 son las cuatro y media.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'El litro (l) es la unidad principal que utilizamos para medir la masa o peso de un cuerpo.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué unidad de medida utilizarías para medir la cantidad de jarabe que cabe en una cuchara pequeña?',
  '["Mililitros (ml)", "Litros (l)", "Kilogramos (kg)", "Metros (m)"]'::jsonb,
  '"Mililitros (ml)"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué unidad de medida es la más adecuada para medir el largo de una piscina olímpica?',
  '["Metros (m)", "Centímetros (cm)", "Gramos (g)", "Litros (l)"]'::jsonb,
  '"Metros (m)"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'Si la aguja pequeña está en el 6 y la grande en el 12 ¿qué hora marca el reloj?',
  '["Las 6 en punto", "Las 6 y media", "Las 12 en punto", "Las 12 y media"]'::jsonb,
  '"Las 6 en punto"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué figura geométrica plana tiene 4 lados rectos iguales y 4 vértices?',
  '["Cuadrado", "Triángulo", "Círculo", "Pentágono"]'::jsonb,
  '"Cuadrado"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué cuerpo geométrico redondo tiene una sola base circular y una punta superior?',
  '["Cono", "Cilindro", "Esfera", "Cubo"]'::jsonb,
  '"Cono"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cuántas monedas de 10 céntimos necesitas para juntar un euro completo?',
  '["10 monedas", "5 monedas", "2 monedas", "100 monedas"]'::jsonb,
  '"10 monedas"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos vértices o esquinas tiene un triángulo?',
  NULL,
  '3'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Si un rectángulo mide 10 cm de largo y 5 cm de ancho ¿cuál es su perímetro en centímetros?',
  NULL,
  '30'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'Un kilogramo equivale exactamente a cuatro cuartos de kilo juntos.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'Las monedas de 10, 20 y 50 céntimos tienen un valor menor que la moneda de 1 euro.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'En un reloj digital si marca las 14:00 ¿qué hora en punto de la tarde es?',
  '["Las 2 en punto", "Las 4 en punto", "Las 12 en punto", "Las 7 en punto"]'::jsonb,
  '"Las 2 en punto"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos metros de longitud equivalen a 3 kilómetros completos?',
  NULL,
  '3000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos medios kilos necesitas juntar para tener 2 kilogramos de masa enteros?',
  NULL,
  '4'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos medios litros de agua se necesitan para llenar un cubo de 5 litros de capacidad?',
  NULL,
  '10'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Si juntas cuatro monedas de 20 céntimos y una de 20 céntimos ¿cuántos céntimos tienes?',
  NULL,
  '100'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos minutos pasan si la aguja grande del reloj analógico avanza desde el 12 hasta el 6?',
  NULL,
  '30'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Calcula el perímetro de un triángulo si sus tres lados miden 6 centímetros cada uno.',
  NULL,
  '18'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos vértices o esquinas tiene una figura geométrica que es un hexágono plano?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántas caras planas cuadradas idénticas tiene un cuerpo geométrico que es un cubo?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Si tienes dos billetes de 10 euros y una moneda de 2 euros ¿cuántos euros tienes en total?',
  NULL,
  '22'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Calcula el perímetro de un rectángulo que mide 8 cm de largo y 2 cm de ancho.',
  NULL,
  '20'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'Un prisma es un cuerpo geométrico que tiene dos bases que son polígonos iguales.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'El litro (l) es la unidad principal que utilizamos para medir la masa de los cuerpos duras.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'En un reloj analógico la aguja corta indica las horas y la aguja larga indica los minutos.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'El metro (m) es la unidad que se utiliza para medir el tiempo que dura una clase.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué unidad de medida de masa es más pequeña que el kilogramo y sirve para pesar cosas ligeras?',
  '["Gramo (g)", "Litro (l)", "Metro (m)", "Kilómetro (Km)"]'::jsonb,
  '"Gramo (g)"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué instrumento de medida utilizamos para saber los minutos exactos que tardamos en correr?',
  '["El reloj", "La regla", "La báscula", "El vaso medidor"]'::jsonb,
  '"El reloj"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'Si la aguja pequeña está en el 6 y la grande está en el 6 ¿qué hora indica el reloj analógico?',
  '["Las seis y media", "Las seis en punto", "Las seis y cuarto", "Las siete menos cuarto"]'::jsonb,
  '"Las seis y media"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué figura geométrica plana tiene 4 lados rectos iguales y 4 vértices rectos?',
  '["Cuadrado", "Triángulo", "Círculo", "Pentágono"]'::jsonb,
  '"Cuadrado"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué cuerpo geométrico redondo tiene la forma perfecta de un cono de helado o gorro de fiesta?',
  '["Cono", "Cubo", "Cilindro", "Esfera"]'::jsonb,
  '"Cono"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cuántos céntimos le faltan a una moneda de 80 céntimos para completar 1 euro entero?',
  '["20 céntimos", "10 céntimos", "50 céntimos", "5 céntimos"]'::jsonb,
  '"20 céntimos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos lados tiene un octógono plano?',
  NULL,
  '8'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Si un triángulo equilátero tiene un perímetro de 15 cm ¿cuántos centímetros mide cada uno de sus tres lados?',
  NULL,
  '5'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'Un kilogramo equivale exactamente a cuatro cuartos de kilo juntos.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'Las caras de un cubo son todas triángulos equiláteros perfectos.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'En un reloj digital si marca las 14:00 horas significa que en horario de tarde son..., wilderness',
  '["Las 2 en punto", "Las 4 en punto", "Las 12 en punto", "Las 7 en punto"]'::jsonb,
  '"Las 2 en punto"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos metros de longitud equivalen a 5 kilómetros completos?',
  NULL,
  '5000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos medios kilos necesitas juntar para tener 3 kilogramos de masa enteros?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos medios litros de leche se necesitan para rellenar un recipiente de 4 litros de capacidad?',
  NULL,
  '8'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Si juntas cinco monedas de 20 céntimos ¿cuántos euros completos formas?',
  NULL,
  '1'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos minutos pasan si la aguja grande del reloj analógico avanza desde el 12 hasta el 3?',
  NULL,
  '15'::jsonb,
  2
);
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Calcula el perímetro de un cuadrado si cada uno de sus cuatro lados mide 6 centímetros.',
  NULL,
  '24'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos vértices o esquinas tiene una figura geométrica plana que es un pentágono?',
  NULL,
  '5'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántas caras planas tiene un cuerpo geométrico que es una pirámide de base cuadrada?',
  NULL,
  '5'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Si tienes un billete de 10 euros y cuatro monedas de 2 euros ¿cuántos euros tienes en total?',
  NULL,
  '18'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Calcula el perímetro de un rectángulo que mide 7 cm de largo y 3 cm de ancho.',
  NULL,
  '20'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'Una pirámide es un cuerpo geométrico que termina en una punta llamada vértice común.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'El metro (m) es la unidad que utilizamos para pesar de forma exacta los alimentos pesados.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'En un reloj analógico si la aguja grande marca el número 6 significa que han pasado treinta minutos.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'El litro (l) es la unidad que mide la distancia entre tu casa y el colegio.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué unidad de medida de masa es perfecta para medir el peso de un camión grande?',
  '["Kilogramo (kg)", "Gramo (g)", "Metro (m)", "Litro (l)"]'::jsonb,
  '"Kilogramo (kg)"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué instrumento manual usamos en clase para medir el largo de un folio en centímetros?',
  '["La regla", "El reloj", "La báscula", "El termómetro"]'::jsonb,
  '"La regla"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'Si la aguja pequeña está en el 9 y la grande está en el 12 ¿qué hora indica el reloj analógico?',
  '["Las 9 en punto", "Las 9 y cuarto", "Las 9 y media", "Las 12 en punto"]'::jsonb,
  '"Las 9 en punto"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué figura geométrica plana tiene 4 lados rectos (2 largos y 2 cortos) y 4 vértices?',
  '["Rectángulo", "Triángulo", "Círculo", "Hexágono"]'::jsonb,
  '"Rectángulo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué cuerpo geométrico perfectamente redondo tiene la forma tridimensional de una canica?',
  '["Esfera", "Cubo", "Cilindro", "Cono"]'::jsonb,
  '"Esfera"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cuántos céntimos le faltan a una moneda de 50 céntimos para completar 1 euro entero?',
  '["50 céntimos", "10 céntimos", "20 céntimos", "90 céntimos"]'::jsonb,
  '"50 céntimos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos lados tiene un heptágono plano?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Si un cuadrado tiene un perímetro de 16 cm ¿cuántos centímetros mide cada uno de sus cuatro lados?',
  NULL,
  '4'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'Un litro equivale a dos medios litros exactamente.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'Un círculo y una circunferencia son cuerpos geométricos en tres dimensiones que ocupan volumen.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'En un reloj digital si marca las 18:30 horas significa que en horario de tarde son...',
  '["Las 6 y media", "Las 8 y media", "Las 5 y media", "Las 12 en punto"]'::jsonb,
  '"Las 6 y media"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos metros de longitud equivalen a 8 kilómetros completos?',
  NULL,
  '8000'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos medios kilos necesitas juntar para tener 4 kilogramos de masa enteros?',
  NULL,
  '8'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos medios litros de leche se necesitan para rellenar un bote de 3 litros de capacidad?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Si juntas tres monedas de 20 céntimos y cuatro de 10 céntimos ¿cuántos céntimos tienes?',
  NULL,
  '100'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos minutos pasan si la aguja grande del reloj analógico avanza desde el 12 hasta el 9?',
  NULL,
  '45'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Calcula el perímetro de un cuadrado si cada uno de sus cuatro lados mide 7 centímetros.',
  NULL,
  '28'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos vértices o esquinas tiene una figura geométrica plana que es un octógono plano?',
  NULL,
  '8'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántas caras planas rectangulares u opuestas tiene un cuerpo geométrico que es un prisma rectangular?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Si tienes dos billetes de 5 euros y tres monedas de 2 euros ¿cuántos euros tienes en total?',
  NULL,
  '16'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Calcula el perímetro de un rectángulo que mide 9 cm de largo y 1 cm de ancho.',
  NULL,
  '20'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'Un cilindro es un cuerpo geométrico que rueda porque tiene superficies curvas y dos bases circulares.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'El gramo (g) es la unidad principal que utilizamos para medir la longitud de un campo de fútbol.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'En un reloj analógico si la aguja grande marca exactamente el número 3 significa que han pasado quince minutos.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'El kilogramo (kg) es la unidad que mide el agua que cabe dentro de una botella grande.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué unidad de medida de masa es más pequeña que el kilogramo y sirve para pesar cartas ligeras?',
  '["Gramo (g)", "Litro (l)", "Metro (m)", "Kilómetro (Km)"]'::jsonb,
  '"Gramo (g)"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué instrumento manual de medición usamos para saber los centímetros exactos de una libreta?',
  '["La regla", "El reloj", "La báscula", "El termómetro"]'::jsonb,
  '"La regla"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'Si la aguja pequeña está en el 10 y la grande está en el 12 ¿qué hora indica el reloj analógico?',
  '["Las 10 en punto", "Las 10 y cuarto", "Las 10 y media", "Las 12 en punto"]'::jsonb,
  '"Las 10 en punto"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué figura geométrica plana circular no tiene lados rectos ni vértices?',
  '["Círculo", "Triángulo", "Cuadrado", "Rectángulo"]'::jsonb,
  '"Círculo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué cuerpo geométrico alargado en tres dimensiones tiene la forma de un bote de conservas o lata de refresco?',
  '["Cilindro", "Cubo", "Esfera", "Cono"]'::jsonb,
  '"Cilindro"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cuántos céntimos le faltan a una moneda de 20 céntimos para completar 1 euro entero?',
  '["80 céntimos", "10 céntimos", "50 céntimos", "70 céntimos"]'::jsonb,
  '"80 céntimos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos lados rectos tiene un pentágono plano?',
  NULL,
  '5'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'numeric',
  'Si un triángulo equilátero tiene un perímetro de 24 cm ¿cuántos centímetros mide cada uno de sus tres lados?',
  NULL,
  '8'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'Un litro equivale a cuatro cuartos de litro de capacidad exacta.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'true_false',
  'Un cubo tiene un total de ocho caras planas y triangulares idénticas.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'En un reloj digital si marca las 20:00 horas significa que en horario de noche son...',
  '["Las 8 en punto", "Las 10 en punto", "Las 6 en punto", "Las 12 en punto"]'::jsonb,
  '"Las 8 en punto"'::jsonb,
  2
);

-- Matemáticas / Resolución de problemas (125)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'María tiene 150 cromos. Su tío le regala 45 más y luego pierde 20 en el patio. ¿Cuántos tiene ahora?',
  NULL,
  '175'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En un autobús viajan 40 personas. En la primera parada se bajan 12 y suben 8. ¿Cuántas personas quedan dentro?',
  NULL,
  '36'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Un pastelero hace 4 bandejas con 10 pasteles cada una. Si vende 15 pasteles ¿cuántos le quedan?',
  NULL,
  '25'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Carlos compra un libro de 12 euros y un estuche de 6 euros. Si paga con un billete de 20 euros ¿cuántos euros le devuelven?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En un huerto hay 6 filas de tomates y en cada fila hay 5 plantas. Si se secan 4 plantas ¿cuántas quedan sanas?',
  NULL,
  '26'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Sofía quiere repartir 30 lápices en partes iguales entre sus 3 hermanos. ¿Cuántos lápices le dará a cada uno?',
  NULL,
  '10'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Un granjero recoge 85 huevos por la mañana y 40 por la tarde. Si se le rompen 15 huevos ¿cuántos le quedan enteros?',
  NULL,
  '110'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Tengo 3 cajas rojas con 5 juguetes cada una y 2 cajas azules con 10 juguetes cada una. ¿Cuántos juguetes tengo en total?',
  NULL,
  '35'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En una tienda hay 80 bicicletas. Si venden la mitad de las bicicletas ¿cuántas quedan por vender?',
  NULL,
  '40'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Un tren lleva 240 pasajeros. En la estación se bajan 100 y suben 60. ¿Cuántos pasajeros continúan el viaje?',
  NULL,
  '200'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Para saber cuántos elementos quedan después de perder o romper algunos debemos hacer una suma.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Si un problema te pide juntar o añadir cantidades la operación que debes plantear es una adición.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Si un problema te pide repartir una cantidad en partes idénticas planteamos una división.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Un problema matemático siempre se resuelve haciendo una única operación.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Compro 4 entradas de cine a 5 euros cada una. ¿Qué operación hago para saber el precio total?',
  '["Multiplicar 4 por 5", "Restar 5 de 4", "Sumar 4 más 4", "Dividir 5 entre 4"]'::jsonb,
  '"Multiplicar 4 por 5"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Tenía 50 euros. Gasté 20 euros en ropa y 10 euros en un libro. ¿Qué operaciones describen este problema?',
  '["Restar 20 y luego restar 10", "Sumar 20 y sumar 10", "Multiplicar 50 por 20", "Dividir 50 entre 10"]'::jsonb,
  '"Restar 20 y luego restar 10"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Tengo 12 caramelos y los reparto a partes iguales entre mis 2 bolsillos. ¿Qué pregunta plantea este problema?',
  '["¿Cuántos caramelos van en cada bolsillo?", "¿Cuántos bolsillos tengo?", "¿Cuántos caramelos pierdo?", "¿Cuánto dinero cuesta cada caramelo?"]'::jsonb,
  '"¿Cuántos caramelos van en cada bolsillo?"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'En una carrera participan 3 equipos de 6 corredores cada uno. Si se retiran 2 corredores ¿cuántos quedan?',
  '["16 corredores", "18 corredores", "20 corredores", "10 corredores"]'::jsonb,
  '"16 corredores"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  '¿Cuál es el primer paso indispensable para resolver cualquier situación cotidiana de matemáticas?',
  '["Leer bien el enunciado para entender los datos", "Hacer una suma rápido", "Escribir la solución", "Inventar los números"]'::jsonb,
  '"Leer bien el enunciado para entender los datos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Si una caja de galletas cuesta 3 euros ¿cuántas cajas puedes comprar exactamente con un billete de 15 euros?',
  '["5 cajas", "3 cajas", "15 cajas", "2 cajas"]'::jsonb,
  '"5 cajas"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Tengo un álbum con capacidad para 200 cromos. Si ya he pegado 130 ¿cuántos cromos me faltan para completarlo?',
  NULL,
  '70'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En mi fiesta hay 12 sándwiches de jamón y 18 de queso. Si nos comemos 20 sándwiches ¿cuántos quedan en la bandeja?',
  NULL,
  '10'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Si un paquete de chicles vale 2 euros con 10 euros puedo comprar exactamente 5 paquetes.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Si reparto 15 bombones entre 5 personas y me sobran 3 bombones significa que hice un reparto igualitario y exacto.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Lucas lee 5 páginas por la mañana y 5 por la tarde. ¿Cuántas páginas lee en 4 días?',
  '["40 páginas", "10 páginas", "20 páginas", "50 páginas"]'::jsonb,
  '"40 páginas"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Tengo 200 euros en mi hucha. Compro unas zapatillas de 60 euros y una camiseta de 15 euros. ¿Cuántos euros me quedan?',
  NULL,
  '125'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En un cine hay 120 personas. En el descanso salen 30 personas y entran 15 nuevas. ¿Cuántas personas hay ahora en el cine?',
  NULL,
  '105'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Un agricultor recoge 5 cajas con 10 melocotones cada una. Si tira 8 melocotones porque estaban pochos ¿cuántos le quedan?',
  NULL,
  '42'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Pedro compra un juego de 25 euros y un libro de 12 euros. Si paga con un billete de 50 euros ¿cuánto dinero le devuelven?',
  NULL,
  '13'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En una tienda hay 8 filas de bombones y en cada fila hay 5 bombones. Si se venden 12 bombones ¿cuántos quedan en la tienda?',
  NULL,
  '28'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Laura quiere repartir 40 caramelos en partes iguales en 4 bolsas. ¿Cuántos caramelos pondrá en cada bolsa?',
  NULL,
  '10'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Un panadero hace 90 cruasanes por la mañana y 30 por la tarde. Si vende 100 cruasanes ¿cuántos le quedan al final del día?',
  NULL,
  '20'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Tengo 4 estuches con 6 lápices cada uno y un cajón con 20 lápices sueltos. ¿Cuántos lápices tengo en total?',
  NULL,
  '44'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En un colegio hay 60 balones de deporte. Si la mitad son balones de fútbol ¿cuántos balones de fútbol hay?',
  NULL,
  '30'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Un barco lleva 350 pasajeros. En el primer puerto se bajan 150 pasajeros y se suben 80. ¿Cuántos pasajeros quedan en el barco?',
  NULL,
  '280'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Para calcular el dinero que te devuelven al comprar algo debes hacer una suma con los datos.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Si un problema te pregunta por el total de elementos al juntar grupos iguales puedes usar una multiplicación.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Si un enunciado indica que una cantidad disminuye porque se pierde o vende planteamos una resta.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Un problema de matemáticas nunca puede resolverse usando dos restas seguidas.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Compro 3 paquetes de cromos a 2 euros cada uno. ¿Qué operación hago para saber cuánto gasto en total?',
  '["Multiplicar 3 por 2", "Sumar 3 más 3", "Restar 2 de 3", "Dividir 3 entre 2"]'::jsonb,
  '"Multiplicar 3 por 2"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Tenía 40 rotuladores. Regalé 10 a mi hermano y perdí 5 en clase. ¿Qué operaciones resuelven este problema?',
  '["Restar 10 y luego restar 5", "Sumar 10 y luego sumar 5", "Multiplicar 40 por 10", "Dividir 40 entre 5"]'::jsonb,
  '"Restar 10 y luego restar 5"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Reparto 20 tizas a partes iguales entre las 4 pizarras del colegio. ¿Qué pregunta resuelve este problema?',
  '["¿Cuántas tizas se colocan en cada pizarra?", "¿Cuántas pizarras hay en total?", "¿Cuántas tizas se rompen?", "¿Cuánto cuesta cada tiza?"]'::jsonb,
  '"¿Cuántas tizas se colocan en cada pizarra?"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'En un restaurante hay 5 mesas con 4 sillas cada una. Si quitan 3 sillas para arreglarlas ¿cuántas sillas quedan libres?',
  '["17 sillas", "20 sillas", "23 sillas", "12 sillas"]'::jsonb,
  '"17 sillas"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  '¿Qué es lo primero que debes hacer al enfrentarte a un problema matemático en un examen?',
  '["Leer el enunciado con atención para comprender la situación", "Escribir números al azar", "Hacer una suma corriendo", "Preguntar la solución"]'::jsonb,
  '"Leer el enunciado con atención para comprender la situación"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Si una libreta cuesta 2 euros ¿cuántas libretas iguales puedes comprar exactamente con un billete de 20 euros?',
  '["10 libretas", "2 libretas", "20 libretas", "5 libretas"]'::jsonb,
  '"10 libretas"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Quiero completar un puzle de 500 piezas. Si ya he colocado 350 piezas ¿cuántas piezas me faltan por poner?',
  NULL,
  '150'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En una bandeja hay 24 pasteles de crema y 16 de chocolate. Si nos comemos 15 pasteles ¿cuántos quedan en la bandeja?',
  NULL,
  '25'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Si una entrada infantil para el parque vale 5 euros con un billete de 20 euros puedo comprar exactamente 4 entradas.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Si reparto 12 caramelos entre 3 amigos y me sobran 2 caramelos significa que hice el reparto de forma correcta.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Un escritor escribe 4 páginas por la mañana y 4 por la tarde. ¿Cuántas páginas escribe en un total de 5 días?',
  '["40 páginas", "20 páginas", "8 páginas", "45 páginas"]'::jsonb,
  '"40 páginas"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Un granjero tiene 200 huevos. Vende 120 en el mercado y luego recoge 50 más. ¿Cuántos huevos tiene ahora?',
  NULL,
  '130'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En una tienda hay 45 balones. Compran 3 cajas nuevas con 10 balones cada una. ¿Cuántos balones hay en total?',
  NULL,
  '75'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Lucas tiene 3 billetes de 5 euros. Si se gasta 6 euros en un libro ¿cuántos euros le quedan?',
  NULL,
  '9'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Un tren sale con 180 pasajeros. En la primera estación bajan 40 y en la segunda bajan 20. ¿Cuántos pasajeros quedan?',
  NULL,
  '120'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En un cine hay 8 filas de asientos y en cada fila hay 10 butacas. Si hay 30 asientos vacíos ¿cuántos están ocupados?',
  NULL,
  '50'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Queremos repartir 40 caramelos en partes iguales entre 5 bolsas. ¿Cuántos caramelos pondremos en cada bolsa?',
  NULL,
  '8'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Sofía compra un juego de 25 euros y una muñeca de 15 euros. Si paga con un billete de 50 euros ¿cuántos euros le devuelven?',
  NULL,
  '10'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Tengo 4 cajas de pinturas con 6 ceras cada una. Si pierdo 5 ceras ¿cuántas ceras me quedan en total?',
  NULL,
  '19'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En un almacén hay 90 cajas de fruta. Si se llevan la tercera parte de las cajas ¿cuántas cajas se llevan?',
  NULL,
  '30'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Un camión transporta 500 botellas de agua. Si descarga 250 en un supermercado y 150 en una tienda ¿cuántas quedan?',
  NULL,
  '100'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Para calcular el precio de varios objetos iguales podemos multiplicar el precio de uno por el total de objetos.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Si un problema dice que una cantidad disminuye o se pierde se debe resolver planteando una suma.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'La pregunta de un problema matemático siempre nos indica los datos que debemos inventar.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Si repartimos caramelos de forma equitativa significa que a todos los niños les toca la misma cantidad.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Tengo 5 paquetes de cromos y cada uno trae 6 cromos. ¿Qué operación hago para saber cuántos cromos tengo?',
  '["Multiplicar 5 por 6", "Sumar 5 más 6", "Restar 5 de 6", "Dividir 6 entre 5"]'::jsonb,
  '"Multiplicar 5 por 6"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Tenía 30 rotuladores gasté 10 y mi hermana me regaló 5. ¿Qué operaciones resuelven este problema?',
  '["Restar 10 y luego sumar 5", "Sumar 10 y luego restar 5", "Multiplicar 30 por 10", "Dividir 30 entre 5"]'::jsonb,
  '"Restar 10 y luego sumar 5"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Un profesor reparte 18 folios entre 6 alumnos a partes iguales. ¿Qué pregunta responde este problema?',
  '["¿Cuántos folios recibe cada alumno?", "¿Cuántos alumnos hay en clase?", "¿Cuántos folios se han roto?", "¿Cuánto cuesta cada folio?"]'::jsonb,
  '"¿Cuántos folios recibe cada alumno?"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'En una pastelería hacen 4 tartas de fresa y 6 de chocolate. Si venden 5 tartas ¿cuántas quedan?',
  '["5 tartas", "10 tartas", "15 tartas", "2 tartas"]'::jsonb,
  '"5 tartas"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  '¿Qué es lo primero que debes escribir de forma ordenada al resolver un problema en el cuaderno?',
  '["Los datos del enunciado", "La operación final", "La respuesta completa", "El dibujo del problema"]'::jsonb,
  '"Los datos del enunciado"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Si un bolígrafo cuesta 2 euros ¿cuántos bolígrafos puedes comprar exactamente con un billete de 20 euros?',
  '["10 bolígrafos", "5 bolígrafos", "20 bolígrafos", "2 bolígrafos"]'::jsonb,
  '"10 bolígrafos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Un libro tiene 120 páginas. Si ayer leí 40 páginas y hoy he leído 50 ¿cuántas páginas me quedan por leer?',
  NULL,
  '30'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En un jardín hay 35 rosas rojas y 25 rosas blancas. Si se marchitan 10 rosas ¿cuántas quedan sanas?',
  NULL,
  '50'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Si compro un juguete de 14 euros y pago con un billete de 20 euros me tienen que devolver 6 euros.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Si un problema dice que triplicamos una cantidad de dinero significa que tenemos que dividir entre 3.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Un panadero vende 8 barras de pan por la mañana y 12 por la tarde a 1 euro cada una. ¿Cuánto dinero recauda?',
  '["20 euros", "8 euros", "12 euros", "4 euros"]'::jsonb,
  '"20 euros"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Lucas tiene 300 canicas. Regala 140 a su hermano y luego compra 80 más. ¿Cuántas tiene ahora?',
  NULL,
  '240'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En un huerto hay 50 lechugas. Se plantan 4 filas nuevas con 10 lechugas cada una. ¿Cuántas lechugas hay en total?',
  NULL,
  '90'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Sofía tiene 5 billetes de 5 euros. Si se compra una mochila que cuesta 18 euros ¿cuántos euros le quedan?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Un barco sale con 250 pasajeros. En el primer puerto bajan 60 y en el segundo bajan 40. ¿Cuántos pasajeros quedan?',
  NULL,
  '150'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En una biblioteca hay 9 filas de libros y en cada fila hay 10 libros. Si se prestan 40 libros ¿cuántos quedan?',
  NULL,
  '50'::jsonb,
  2
);
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Queremos repartir 48 bombones en partes iguales entre 6 cajas de regalo. ¿Cuántos bombones pondremos en cada caja?',
  NULL,
  '8'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Carlos compra una pelota de 18 euros y unos guantes de 12 euros. Si paga con un billete de 50 euros ¿cuántos euros le devuelven?',
  NULL,
  '20'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Tengo 5 cajas de pinturas con 6 ceras cada una. Si se me rompen 8 ceras ¿cuántas ceras me quedan útiles?',
  NULL,
  '22'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En una fábrica hay 120 botellas de zumo. Si se vende la tercera parte de las botellas ¿cuántas botellas se venden?',
  NULL,
  '40'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Un camión lleva 600 cajas de leche. Si descarga 300 en un almacén y 200 en otro ¿cuántas cajas quedan en el camión?',
  NULL,
  '100'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Para calcular cuántos elementos quedan después de quitar o consumir algunos usamos la operación de restar.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Si un problema te pide calcular el total de tres colecciones juntas se debe resolver planteando una resta.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Al resolver un problema cotidiano es obligatorio pensar primero en qué nos están preguntando.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Un reparto equitativo significa que unas personas reciben más objetos que otras.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Tengo 6 estuches de lápices y cada uno contiene 6 lápices. ¿Qué operación hago para saber cuántos lápices tengo?',
  '["Multiplicar 6 por 6", "Sumar 6 más 6", "Restar 6 de 6", "Dividir 6 entre 6"]'::jsonb,
  '"Multiplicar 6 por 6"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Tenía 40 cromos perdí 15 en el recreo y luego mi amigo me dio 10. ¿Qué operaciones resuelven este problema?',
  '["Restar 15 y luego sumar 10", "Sumar 15 y luego restar 10", "Multiplicar 40 por 15", "Dividir 40 entre 10"]'::jsonb,
  '"Restar 15 y luego sumar 10"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Un pastor reparte 45 ovejas a partes iguales entre 5 cercados. ¿Qué pregunta responde esta situación?',
  '["¿Cuántas ovejas van en cada cercado?", "¿Cuántos cercados hay en total?", "¿Cuántas ovejas son blancas?", "¿Cuánto cuesta cada oveja?"]'::jsonb,
  '"¿Cuántas ovejas van en cada cercado?"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'En una panadería hacen 10 tartas de manzana y 10 de piña. Si venden 7 tartas ¿cuántas quedan en la vitrina?',
  '["13 tartas", "20 tartas", "7 tartas", "3 tartas"]'::jsonb,
  '"13 tartas"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  '¿Cuál es la sección de un problema donde organizamos los números clave que nos da el enunciado?',
  '["Los datos", "La operación", "La solución", "El dibujo"]'::jsonb,
  '"Los datos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Si un cuaderno cuesta 3 euros ¿cuántos cuadernos puedes comprar exactamente con un billete de 30 euros?',
  '["10 cuadernos", "3 cuadernos", "30 cuadernos", "9 cuadernos"]'::jsonb,
  '"10 cuadernos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Un rompecabezas tiene 150 piezas. Si ayer coloqué 50 piezas y hoy he colocado 60 ¿cuántas piezas quedan por colocar?',
  NULL,
  '40'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En una tienda hay 40 bicicletas rojas y 30 azules. Si se venden 20 bicicletas ¿cuántas quedan en la tienda?',
  NULL,
  '50'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Si compro un libro de 16 euros y pago con un billete de 20 euros me tienen que devolver 4 euros.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Calcular la mitad de un grupo de manzanas es exactamente lo mismo que multiplicar la cantidad por dos.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Un frutero vende 10 kilos de naranjas por la mañana y 5 por la tarde a 2 euros el kilo. ¿Cuánto dinero recauda?',
  '["30 euros", "15 euros", "20 euros", "10 euros"]'::jsonb,
  '"30 euros"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Lucas tiene 400 cromos. Regala 150 a su amigo y luego compra 60 más. ¿Cuántos tiene ahora?',
  NULL,
  '310'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En una cafetería hay 30 sillas. Compran 5 mesas nuevas con 4 sillas cada una. ¿Cuántas sillas hay en total?',
  NULL,
  '50'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Sofía tiene 6 billetes de 5 euros. Si se compra un estuche que cuesta 12 euros ¿cuántos euros le quedan?',
  NULL,
  '18'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Un autobús sale con 90 pasajeros. En la primera parada bajan 30 y en la segunda bajan 15. ¿Cuántos pasajeros quedan?',
  NULL,
  '45'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En una tienda hay 7 filas de cajas y en cada fila hay 10 cajas. Si se venden 25 cajas ¿cuántas quedan?',
  NULL,
  '45'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Queremos repartir 35 bombones en partes iguales entre 7 bolsas de dulces. ¿Cuántos bombones pondremos en cada bolsa?',
  NULL,
  '5'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Carlos compra un libro de 22 euros y un bloc de 8 euros. Si paga con un billete de 50 euros ¿cuántos euros le devuelven?',
  NULL,
  '20'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Tengo 6 cajas de pinturas con 6 ceras cada una. Si se me rompen 10 ceras ¿cuántas ceras me quedan útiles?',
  NULL,
  '26'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En un almacén hay 150 botellas de agua. Si se vende la tercera parte de las botellas ¿cuántas botellas se venden?',
  NULL,
  '50'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Un camión lleva 800 cajas de leche. Si descarga 400 en un supermercado y 200 en otro ¿cuántas cajas quedan?',
  NULL,
  '200'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Para calcular el precio total de varios artículos iguales sumamos el precio al número de artículos.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Si un enunciado nos pide quitar restar o disminuir una cantidad la operación adecuada es la sustracción.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Los datos numéricos de un problema son opcionales y podemos resolverlo sin mirarlos.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Un reparto equitativo significa dar a cada grupo exactamente el mismo número de cosas.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Tengo 8 paquetes de chicles y cada uno contiene 5 chicles. ¿Qué operación hago para saber cuántos chicles tengo?',
  '["Multiplicar 8 por 5", "Sumar 8 más 5", "Restar 5 de 8", "Dividir 8 entre 5"]'::jsonb,
  '"Multiplicar 8 por 5"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Tenía 50 euros perdí 20 en la calle y luego mi padre me dio 15. ¿Qué operaciones resuelven este problema?',
  '["Restar 20 y luego sumar 15", "Sumar 20 y luego restar 15", "Multiplicar 50 por 20", "Dividir 50 entre 15"]'::jsonb,
  '"Restar 20 y luego sumar 15"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Un granjero reparte 54 huevos a partes iguales entre 6 cajas. ¿Qué pregunta responde esta situación?',
  '["¿Cuántos huevos van en cada caja?", "¿Cuántas cajas hay en total?", "¿Cuántos huevos son blancos?", "¿Cuánto cuesta cada huevo?"]'::jsonb,
  '"¿Cuántos huevos van en cada caja?"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'En una pastelería hacen 15 bollos de crema y 15 de chocolate. Si venden 12 bollos ¿cuántos quedan en la tienda?',
  '["18 bollos", "30 bollos", "12 bollos", "5 bollos"]'::jsonb,
  '"18 bollos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  '¿Qué es la solución en el proceso de resolución de un problema matemático escolar?',
  '["La respuesta escrita que contesta a la pregunta", "Los números sueltos", "El signo de la operación", "El título"]'::jsonb,
  '"La respuesta escrita que contesta a la pregunta"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Si un bolígrafo cuesta 3 euros ¿cuántos bolígrafos puedes comprar exactamente con un billete de 15 euros?',
  '["5 bolígrafos", "3 bolígrafos", "15 bolígrafos", "2 bolígrafos"]'::jsonb,
  '"5 bolígrafos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'Un libro tiene 200 páginas. Si ayer leí 60 páginas y hoy he leído 40 ¿cuántas páginas me quedan por leer?',
  NULL,
  '100'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'numeric',
  'En una cesta hay 40 manzanas rojas y 20 verdes. Si nos comemos 15 manzanas ¿cuántas quedan en la cesta?',
  NULL,
  '45'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Si compro un juguete de 35 euros y pago con un billete de 50 euros me tienen que devolver 15 euros.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'true_false',
  'Calcular un tercio de un grupo de pinturas es equivalente a multiplicar la cantidad por tres.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Un frutero vende 8 kilos de manzanas por la mañana y 4 por la tarde a 2 euros el kilo. ¿Cuánto dinero recauda?',
  '["24 euros", "12 euros", "16 euros", "8 euros"]'::jsonb,
  '"24 euros"'::jsonb,
  2
);

-- Lengua / Comunicación oral y escrita (132)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo se llama el texto periodístico que nos cuenta un hecho real y reciente de interés general?',
  '["Noticia", "Poema", "Cuento", "Receta"]'::jsonb,
  '"Noticia"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué parte de la noticia va arriba del todo con letras grandes para llamar la atención?',
  '["Titular", "Cuerpo", "Fecha", "Firma"]'::jsonb,
  '"Titular"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  'Si explicamos detalladamente cómo es un objeto, un animal o un paisaje estamos haciendo una...',
  '["Descripción", "Narración", "Noticia", "Entrevista"]'::jsonb,
  '"Descripción"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos al texto que cuenta una historia imaginaria con un inicio, nudo y desenlace?',
  '["Narración o cuento", "Descripción", "Noticia", "Folleto"]'::jsonb,
  '"Narración o cuento"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué parte de una narración presenta a los personajes y el lugar del relato?',
  '["Inicio", "Nudo", "Desenlace", "Titular"]'::jsonb,
  '"Inicio"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué parte de una narración cuenta el problema principal o la aventura más importante?',
  '["Nudo", "Inicio", "Desenlace", "Copete"]'::jsonb,
  '"Nudo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué parte de una narración explica cómo se resuelve el problema de la historia?',
  '["Desenlace", "Inicio", "Nudo", "Titular"]'::jsonb,
  '"Desenlace"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo se llama la persona real o imaginaria que participa en los hechos de un cuento?',
  '["Personaje", "Narrador", "Lector", "Escritor"]'::jsonb,
  '"Personaje"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos a la persona que cuenta la historia dentro de una narración?',
  '["Narrador", "Personaje", "Protagonista", "Autor"]'::jsonb,
  '"Narrador"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  'Para describir cómo es el carácter de una persona, ¿qué adjetivo podemos usar?',
  '["Simpática", "Alta", "Rubia", "Delgada"]'::jsonb,
  '"Simpática"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  'Para describir el aspecto físico de una persona, ¿qué rasgo podemos destacar?',
  '["Tiene el pelo rizado", "Es inteligente", "Es muy alegre", "Es trabajadora"]'::jsonb,
  '"Tiene el pelo rizado"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto oral o escrito se utiliza para hacernos reír contando algo gracioso?',
  '["Chiste", "Noticia", "Descripción", "Instrucción"]'::jsonb,
  '"Chiste"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  'Un texto con rimas que expresa sentimientos y se divide en estrofas es una...',
  '["Poesía", "Noticia", "Fábula", "Entrevista"]'::jsonb,
  '"Poesía"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto nos da los pasos ordenados para armar un mueble o jugar un juego?',
  '["Texto instructivo", "Noticia", "Poema", "Descripción"]'::jsonb,
  '"Texto instructivo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  'Al hablar con los demás, ¿qué fórmula de cortesía usamos para pedir las cosas de buen modo?',
  '["Por favor", "Adiós", "Hola", "¿Qué tal?"]'::jsonb,
  '"Por favor"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  'Al escuchar un texto oral, ¿qué debemos hacer para comprenderlo perfectamente?',
  '["Prestar mucha atención", "Hablar alto", "Dibujar", "Interrumpir"]'::jsonb,
  '"Prestar mucha atención"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Una noticia debe contar cosas imaginarias inventadas por el escritor.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Las descripciones nos ayudan a imaginar cómo son las cosas sin verlas.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'El nudo es la parte final donde termina el cuento.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'En una descripción de un pueblo se suele explicar su paisaje y sus edificios.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Los diálogos son textos donde dos o más personas hablan entre sí.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Las recetas de cocina son un ejemplo de texto narrativo.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'numeric',
  '¿Cuántas viñetas suele tener un cómic corto de tres escenas?',
  NULL,
  '3'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'numeric',
  'Si una poesía tiene 3 estrofas de 4 versos cada una, ¿cuántos versos tiene en total?',
  NULL,
  '12'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'La comprensión lectora consiste en entender el mensaje del texto que leemos.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué elemento de comunicación oral nos sirve para presentarnos ante los demás saludando?',
  '["Presentación", "Despedida", "Noticia", "Descripción"]'::jsonb,
  '"Presentación"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Una entrevista es un diálogo donde una persona hace preguntas a otra para conocer sus respuestas.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto breve se escribe para felicitar a un amigo en su cumpleaños?',
  '["Tarjeta de felicitación", "Noticia", "Diccionario", "Instrucción"]'::jsonb,
  '"Tarjeta de felicitación"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'El cuerpo de la noticia es la parte escrita donde se cuenta todo el suceso al detalle.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra rima con la palabra ''canción''?',
  '["Avión", "Mesa", "Gato", "Luna"]'::jsonb,
  '"Avión"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Los cuentos populares son narraciones antiguas que se transmiten de padres a hijos.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto indica los ingredientes ordenados para preparar un postre?',
  '["Receta", "Noticia", "Poema", "Descripción"]'::jsonb,
  '"Receta"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos al dibujo grande con letras que anuncia un evento escolar en el colegio?',
  '["Cartel o póster", "Noticia", "Cuento", "Diccionario"]'::jsonb,
  '"Cartel o póster"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto breve se escribe para invitar a tus amigos a tu fiesta de cumpleaños?',
  '["Invitación", "Noticia", "Poema", "Diccionario"]'::jsonb,
  '"Invitación"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos a la breve frase que se incluye debajo de la foto de una noticia para explicarla?',
  '["Pie de foto", "Titular", "Cuerpo", "Firma"]'::jsonb,
  '"Pie de foto"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de narración breve tiene como personajes a animales que hablan y nos deja una moraleja o enseñanza?',
  '["Fábula", "Noticia", "Novela", "Descripción"]'::jsonb,
  '"Fábula"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo se llama la lista ordenada de platos, postres y bebidas que podemos elegir en un restaurante?',
  '["Menú", "Receta", "Cuento", "Noticia"]'::jsonb,
  '"Menú"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  'Si explicamos paso a paso las reglas y cómo se juega a un juego de mesa, estamos haciendo un texto...',
  '["Instructivo", "Descriptivo", "Narrativo", "Poético"]'::jsonb,
  '"Instructivo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos a la línea de texto que escribe un personaje cuando habla en un cómic o teatro?',
  '["Diálogo o intervención", "Narración", "Titular", "Moraleja"]'::jsonb,
  '"Diálogo o intervención"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto nos informa de los datos, fecha, hora y lugar de un evento en un folleto?',
  '["Cartel informativo", "Poesía", "Cuento popular", "Chiste"]'::jsonb,
  '"Cartel informativo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué adjetivo expresa una cualidad física ideal para describir a una jirafa?',
  '["Alta", "Simpática", "Inteligente", "Alegre"]'::jsonb,
  '"Alta"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué elemento de un libro nos indica las páginas donde empieza cada tema o capítulo?',
  '["Índice", "Portada", "Contraportada", "Título"]'::jsonb,
  '"Índice"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos al texto breve que dejamos sobre la mesa para avisar a mamá de que hemos ido al parque?',
  '["Nota", "Noticia", "Poema", "Fábula"]'::jsonb,
  '"Nota"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'El desenlace de un cuento narra el momento de mayor misterio o problema de la historia.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Una noticia debe responder siempre a las preguntas de qué ocurrió, dónde y cuándo.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Las descripciones detalladas sirven para que el lector conozca el aspecto de un lugar.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Un folleto turístico sirve para describir y promocionar las actividades de una ciudad.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Las onomatopeyas se usan mucho en los cómics para representar sonidos mediante letras.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál de estos textos se organiza habitualmente en versos y estrofas?',
  '["Un poema", "Una noticia", "Una receta", "Una carta"]'::jsonb,
  '"Un poema"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué recurso usamos en una descripción para comparar un elemento con otro (ej. ''blanco como la nieve'')?',
  '["Comparación", "Titular", "Moraleja", "Rima"]'::jsonb,
  '"Comparación"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Para realizar una exposición oral en clase es de gran ayuda preparar un guion ordenado.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'numeric',
  'Si un cuento se divide en introducción, nudo y desenlace, ¿en cuántas partes estructurales se divide?',
  NULL,
  '3'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'numeric',
  'Si una estrofa tiene cuatro líneas o versos, ¿cuántos versos componen esa estrofa?',
  NULL,
  '4'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Una fábula siempre termina con un titular llamativo escrito en el periódico.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Los diccionarios organizan las palabras en estricto orden alfabético.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto envía Oliver a su abuela metido en un sobre cerrado con un sello?',
  '["Una carta", "Una noticia", "Un eslogan", "Un cartel"]'::jsonb,
  '"Una carta"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué nombre recibe la frase corta y pegadiza que se usa para anunciar un producto en publicidad?',
  '["Eslogan", "Moraleja", "Titular", "Verso"]'::jsonb,
  '"Eslogan"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Los trabalenguas son juegos de palabras difíciles de pronunciar que sirven para practicar la dicción.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué texto periodístico relata la información verídica respondiendo a qué, quién, cómo, cuándo y dónde?',
  '["La noticia", "El poema", "La fábula", "El chiste"]'::jsonb,
  '"La noticia"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Un cómic cuenta una historia divertida utilizando viñetas con dibujos animados.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto breve se cuelga en el tablón de anuncios del colegio para vender un libro viejo?',
  '["Un anuncio", "Una noticia", "Un poema", "Un cuento"]'::jsonb,
  '"Un anuncio"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'La moraleja de una fábula es el titular en mayúsculas que aparece arriba del todo.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra consigue hacer una rima perfecta con la palabra ''melón''?',
  '["Limón", "Mesa", "Silla", "Perro"]'::jsonb,
  '"Limón"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Una descripción de personas puede incluir tanto sus rasgos físicos como su carácter.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto detalla los pasos obligatorios para programar un videojuego escolar?',
  '["Instrucciones", "Noticia", "Poema", "Descripción"]'::jsonb,
  '"Instrucciones"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos al folleto informativo plegado que reparte publicidad de un museo infantil?',
  '["Tríptico o folleto", "Noticia", "Diccionario", "Novela"]'::jsonb,
  '"Tríptico o folleto"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué parte de una carta contiene el saludo inicial al destinatario?',
  '["El saludo", "El cuerpo", "La despedida", "La firma"]'::jsonb,
  '"El saludo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué parte de una carta contiene el mensaje principal que queremos contar?',
  '["El cuerpo", "El saludo", "La despedida", "La firma"]'::jsonb,
  '"El cuerpo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué parte de una carta sirve para decir adiós de forma cariñosa?',
  '["La despedida", "El saludo", "El cuerpo", "La fecha"]'::jsonb,
  '"La despedida"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos al nombre de la persona que escribe y envía una carta?',
  '["El remitente", "El destinatario", "El narrador", "El personaje"]'::jsonb,
  '"El remitente"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos a la persona que recibe una carta metida en un sobre?',
  '["El destinatario", "El remitente", "El autor", "El mensajero"]'::jsonb,
  '"El destinatario"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto de los periódicos sirve para dar la opinión sobre un libro o película?',
  '["La crítica o reseña", "La noticia", "La receta", "El poema"]'::jsonb,
  '"La crítica o reseña"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo se llama el texto breve que se coloca en un museo al lado de un cuadro para explicarlo?',
  '["Cartela informativa", "Noticia", "Cuento", "Fábula"]'::jsonb,
  '"Cartela informativa"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué adjetivo expresa un rasgo de carácter perfecto para describir a un científico?',
  '["Trabajador o curioso", "Alto", "Rubio", "Azul"]'::jsonb,
  '"Trabajador o curioso"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos a las palabras que imitan los sonidos que hacen los animales (ej. ''¡guau!'')?',
  '["Onomatopeyas", "Sinónimos", "Antónimos", "Rimas"]'::jsonb,
  '"Onomatopeyas"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto oral se utiliza para debatir las normas de convivencia en clase de forma respetuosa?',
  '["Asamblea o debate", "Cuento", "Noticia", "Receta"]'::jsonb,
  '"Asamblea o debate"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'El inicio de una narración presenta la solución al problema de los personajes.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Una descripción objetiva cuenta cómo son las cosas de forma real sin dar opiniones personales.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Los folletos informativos suelen llevar imágenes para apoyar el texto escrito.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Un texto teatral está escrito para que unos actores representen los diálogos ante el público.',
  NULL,
  'true'::jsonb,
  2
);
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Los chistes son narraciones larguísimas de muchas páginas que sirven para asustar.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué elemento de un cuento popular nos indica el momento del tiempo en que ocurre (ej. ''Hace muchos años'')?',
  '["El tiempo de la narración", "El nudo", "La moraleja", "El titular"]'::jsonb,
  '"El tiempo de la narración"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué recurso literario consiste en dar cualidades humanas a los animales en las fábulas?',
  '["Personificación", "Comparación", "Rima", "Titular"]'::jsonb,
  '"Personificación"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Para comprender una noticia oral en la radio es necesario escuchar con atención y no hacer ruido.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'numeric',
  'Si una noticia responde a qué pasó, quién, cuándo, dónde y por qué, ¿a cuántas preguntas básicas responde?',
  NULL,
  '5'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'numeric',
  'Si un poema tiene dos estrofas de cuatro versos cada una, ¿cuántos versos tiene en total?',
  NULL,
  '8'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Las instrucciones de una receta de cocina se pueden ordenar usando números (1, 2, 3...).',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'El eslogan publicitario debe ser una frase larguísima y difícil de entender.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto breve y pegadizo sirve para anunciar un evento en los muros del colegio?',
  '["Un cartel publicitario", "Una carta", "Una noticia", "Un diccionario"]'::jsonb,
  '"Un cartel publicitario"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué sección de una revista infantil contiene juegos de ingenio y pasatiempos?',
  '["Pasatiempos", "Editoria", "Titular", "Cuerpo"]'::jsonb,
  '"Pasatiempos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Las adivinanzas son textos breves que plantean un acertijo para descubrir un objeto oculto.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto breve y llamativo sirve para convencer a la gente de cuidar los parques?',
  '["Un anuncio publicitario", "Una receta", "Un cuento", "Un diccionario"]'::jsonb,
  '"Un anuncio publicitario"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Una noticia real debe incluir opiniones inventadas y mentiras para ser divertida.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto recoge la biografía ordenada de un personaje de la historia?',
  '["Texto biográfico", "Noticia", "Fábula", "Receta"]'::jsonb,
  '"Texto biográfico"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'La introducción de un cuento presenta a los personajes y sitúa el espacio del relato.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra consigue hacer una rima consonante con la palabra ''gato''?',
  '["Pato", "Perro", "Casa", "Ratón"]'::jsonb,
  '"Pato"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Las descripciones de paisajes detallan los elementos de la naturaleza de forma ordenada.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto nos da las reglas paso a paso para jugar de forma limpia al fútbol?',
  '["Reglamento o instrucciones", "Noticia", "Poema", "Fábula"]'::jsonb,
  '"Reglamento o instrucciones"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos a la hoja impresa que te da el menú y los precios de una heladería?',
  '["Carta de precios o menú", "Noticia", "Diccionario", "Novela"]'::jsonb,
  '"Carta de precios o menú"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué datos obligatorios deben ir arriba en una carta formal antes del texto?',
  '["La fecha y el lugar", "La firma", "La moraleja", "El eslogan"]'::jsonb,
  '"La fecha y el lugar"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué elemento se escribe al final de todo en una carta para asegurar quién la envió?',
  '["La firma", "El saludo", "El titular", "El índice"]'::jsonb,
  '"La firma"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos a la pequeña aclaración que se añade al final de la carta si olvidamos algo?',
  '["Posdata (P.D.)", "Saludo", "Pie de foto", "Titular"]'::jsonb,
  '"Posdata (P.D.)"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto breve resume de qué trata un libro en su contraportada trasera?',
  '["Sinopsis o resumen", "Noticia", "Fábula", "Eslogan"]'::jsonb,
  '"Sinopsis o resumen"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo se llama el texto estructurado que te dice las normas de uso de la piscina del colegio?',
  '["Reglamento o normas", "Noticia", "Cuento", "Poesía"]'::jsonb,
  '"Reglamento o normas"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto periodístico se basa en hacer preguntas y respuestas a un deportista famoso?',
  '["Entrevista", "Crítica", "Receta", "Poema"]'::jsonb,
  '"Entrevista"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos al texto que describe de forma ordenada los pasos para hacer un experimento científico?',
  '["Instrucciones de experimento", "Cuento", "Fábula", "Eslogan"]'::jsonb,
  '"Instrucciones de experimento"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué adjetivo expresa un rasgo físico ideal para describir a un oso polar?',
  '["Peludo o blanco", "Simpático", "Alegre", "Rápido"]'::jsonb,
  '"Peludo o blanco"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué parte de una revista de cocina te indica en qué página está la receta de la tarta?',
  '["El índice", "La portada", "La firma", "El titular"]'::jsonb,
  '"El índice"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos al texto oral rápido que transmite un locutor para anunciar un producto en la radio?',
  '["Cuña publicitaria", "Noticia", "Poema", "Fábula"]'::jsonb,
  '"Cuña publicitaria"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'El inicio de una fábula sirve para explicar la moraleja y la enseñanza final al lector.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Una descripción subjetiva incluye los sentimientos y opiniones de la persona que describe.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Los folletos informativos se doblan para que la información se lea de forma organizada.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Un guion de teatro contiene los nombres de los personajes antes de cada frase que deben decir.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Los chistes infantiles siempre deben redactarse con un titular serio de periódico.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué elemento de una narración representa el espacio donde se mueven los personajes (ej. un bosque)?',
  '["El lugar o escenario", "El nudo", "La moraleja", "El titular"]'::jsonb,
  '"El lugar o escenario"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué recurso usamos al describir para exagerar una cualidad (ej. ''más rápido que un cohete'')?',
  '["Exageración o hipérbole", "Rima", "Pie de foto", "Índice"]'::jsonb,
  '"Exageración o hipérbole"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'En una exposición oral en clase es correcto hablar bajo, rápido y mirando hacia el suelo.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'numeric',
  'Si un poema tiene tres estrofas de tres versos cada una, ¿cuántos versos tiene en total?',
  NULL,
  '9'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'numeric',
  'Si un folleto publicitario se dobla exactamente en tres partes, ¿cómo se llama por su número de caras?',
  NULL,
  '3'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Las recetas de cocina omiten siempre el nombre de los ingredientes necesarios.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Un eslogan publicitario debe ser corto, llamativo y fácil de recordar por la gente.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto breve sirve para avisar a tus compañeros de que se ha perdido un estuche verde?',
  '["Un cartel de aviso", "Una carta", "Una receta", "Un poema"]'::jsonb,
  '"Un cartel de aviso"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué sección de un periódico digital relata los resultados de los partidos de fútbol y baloncesto?',
  '["Deportes", "Opinión", "Pasatiempos", "Titular"]'::jsonb,
  '"Deportes"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Los acertijos de las adivinanzas nos dan pistas ocultas para que usemos la lógica.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué texto periodístico narra un acontecimiento verídico respondiendo a las preguntas básicas?',
  '["La noticia", "El poema", "La fábula", "El chiste"]'::jsonb,
  '"La noticia"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Un folleto publicitario sirve para dar instrucciones de cómo reparar un motor complejo.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto recoge los acontecimientos de la vida de una persona real ordenados en el tiempo?',
  '["La biografía", "La noticia", "La fábula", "La receta"]'::jsonb,
  '"La biografía"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'El nudo de un cuento narra las consecuencias finales después de que se resolviera el problema.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra consigue hacer una rima consonante con la palabra ''luna''?',
  '["Cuna", "Perro", "Casa", "Sol"]'::jsonb,
  '"Cuna"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'true_false',
  'Las descripciones de objetos sirven para detallar su forma, tamaño, color y utilidad.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de texto detalla los pasos obligatorios para jugar de forma limpia al escondite?',
  '["Instrucciones", "Noticia", "Poema", "Fábula"]'::jsonb,
  '"Instrucciones"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos a la hoja impresa que te da la lista de helados y precios en una heladería?',
  '["Menú o carta", "Noticia", "Diccionario", "Novela"]'::jsonb,
  '"Menú o carta"'::jsonb,
  2
);

-- Lengua / Gramática y vocabulario (136)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cómo llamamos a las palabras que sirven para nombrar personas, animales, plantas u objetos?',
  '["Sustantivos o nombres", "Adjetivos", "Verbos", "Artículos"]'::jsonb,
  '"Sustantivos o nombres"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué tipo de sustantivo nombra a una persona o lugar distinguiéndolo de los demás (ej. ''Lucas'', ''Madrid'')?',
  '["Nombre propio", "Nombre común", "Nombre colectivo", "Nombre abstracto"]'::jsonb,
  '"Nombre propio"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué tipo de sustantivo nombra en singular a un conjunto de seres (ej. ''rebaño'')?',
  '["Nombre colectivo", "Nombre individual", "Nombre propio", "Nombre abstracto"]'::jsonb,
  '"Nombre colectivo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué tipo de sustantivo nombra a un solo ser u objeto en singular (ej. ''oveja'')?',
  '["Nombre individual", "Nombre colectivo", "Nombre propio", "Artículos"]'::jsonb,
  '"Nombre individual"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabras nos indican las acciones que realizan las personas (ej. ''correr'', ''saltar'')?',
  '["Verbos", "Sustantivos", "Adjetivos", "Pronombres"]'::jsonb,
  '"Verbos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cómo se llaman las palabras que significan lo mismo o algo muy parecido (ej. ''rápido'' y ''veloz'')?',
  '["Sinónimos", "Antónimos", "Polisémicas", "Derivadas"]'::jsonb,
  '"Sinónimos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cómo se llaman las palabras que significan lo contrario (ej. ''grande'' y ''pequeño'')?',
  '["Antónimos", "Sinónimos", "Polisémicas", "Compuestas"]'::jsonb,
  '"Antónimos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cómo llamamos a las palabras que se han formado añadiendo una terminación a otra palabra (ej. ''panadero'' de ''pan'')?',
  '["Palabras derivadas", "Palabras primitivas", "Sinónimos", "Antónimos"]'::jsonb,
  '"Palabras derivadas"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cómo llamamos al conjunto de palabras que comparten la misma palabra primitiva (ej. ''pan, panadero, panadería'')?',
  '["Familia de palabras", "Campo semántico", "Sinónimos", "Palabras polisémicas"]'::jsonb,
  '"Familia de palabras"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cómo llamamos a las palabras que se escriben igual pero tienen varios significados (ej. ''banco'')?',
  '["Palabras polisémicas", "Sinónimos", "Antónimos", "Derivadas"]'::jsonb,
  '"Palabras polisémicas"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el sinónimo de la palabra ''feliz''?',
  '["Contento", "Triste", "Enfadado", "Rápido"]'::jsonb,
  '"Contento"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el antónimo de la palabra ''abrir''?',
  '["Cerrar", "Subir", "Destapar", "Comenzar"]'::jsonb,
  '"Cerrar"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra pertenece a la familia de palabras de ''fruta''?',
  '["Frutería", "Flor", "Verdura", "Comida"]'::jsonb,
  '"Frutería"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es un verbo en infinitivo?',
  '["Dormir", "Cama", "Blando", "Ellos"]'::jsonb,
  '"Dormir"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el nombre colectivo para referirse a un conjunto de árboles?',
  '["Bosque", "Árbol", "Rebaño", "Manada"]'::jsonb,
  '"Bosque"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Los verbos pueden estar en pasado, presente o futuro.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Las palabras ''alto'' y ''bajo'' son palabras sinónimas.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'La palabra ''marinero'' es una palabra derivada de ''mar''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Un nombre común sirve para nombrar a cualquier animal o cosa de una misma clase.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'La palabra ''hoja'' es polisémica porque tiene el significado de hoja de árbol y hoja de papel.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'numeric',
  '¿Cuántos verbos hay en la frase: ''El perro corre y salta por el campo''?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'numeric',
  '¿Cuántos sustantivos comunes hay en la frase: ''La niña lee un libro escolar''?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Los nombres propios se escriben siempre obligatoriamente con letra inicial minúscula.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'El antónimo de ''subir'' es ''bajar''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es un sustantivo propio?',
  '["Oliver", "niño", "perro", "colegio"]'::jsonb,
  '"Oliver"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es el antónimo de ''encender''?',
  '["Apagar", "Iluminar", "Quemar", "Subir"]'::jsonb,
  '"Apagar"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es el sinónimo de ''terminar''?',
  '["Acabar", "Empezar", "Jugar", "Saltar"]'::jsonb,
  '"Acabar"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'La palabra ''zapatería'' forma parte de la familia de palabras de ''zapato''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'numeric',
  '¿Cuántos sustantivos propios hay en la oración: ''María viaja a Madrid en avión''?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué tipo de palabra es ''correr''?',
  '["Un verbo", "Un sustantivo", "Un adjetivo", "Un artículo"]'::jsonb,
  '"Un verbo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el nombre colectivo para referirse a un grupo de perros o lobos?',
  '["Jauría o manada", "Oveja", "Bosque", "Bandada"]'::jsonb,
  '"Jauría o manada"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'La palabra ''gato'' es un sustantivo común de género masculino.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es el antónimo de ''lleno''?',
  '["Vacío", "Cargado", "Grande", "Alto"]'::jsonb,
  '"Vacío"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Los verbos en presente indican acciones que están ocurriendo justo ahora.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cómo se clasifican los sustantivos que nombran a seres de forma general (ej. ''río'', ''perro'')?',
  '["Sustantivos comunes", "Sustantivos propios", "Sustantivos colectivos", "Sustantivos abstractos"]'::jsonb,
  '"Sustantivos comunes"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué clase de palabra acompaña al sustantivo concordando en género y número (ej. ''el'', ''la'', ''los'')?',
  '["Artículos o determinantes", "Verbos", "Pronombres", "Adjetivos"]'::jsonb,
  '"Artículos o determinantes"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué pronombre personal en singular usamos para referirnos a la persona que habla?',
  '["Yo", "Tú", "Él", "Nosotros"]'::jsonb,
  '"Yo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué pronombre personal en singular usamos para referirnos a la persona que escucha?',
  '["Tú", "Yo", "Ella", "Vosotros"]'::jsonb,
  '"Tú"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿En qué tiempo verbal se encuentra una acción que ya ocurrió ayer (ej. ''Sofía cantó'')?',
  '["Pasado", "Presente", "Futuro", "Infinitivo"]'::jsonb,
  '"Pasado"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿En qué tiempo verbal se encuentra una acción que ocurrirá mañana (ej. ''Lucas correrá'')?',
  '["Futuro", "Presente", "Pasado", "Infinitivo"]'::jsonb,
  '"Futuro"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el sinónimo de la palabra ''comenzar''?',
  '["Empezar", "Terminar", "Acabar", "Saltar"]'::jsonb,
  '"Empezar"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el antónimo de la palabra ''comprar''?',
  '["Vender", "Pagar", "Gastar", "Guardar"]'::jsonb,
  '"Vender"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es la palabra primitiva de la que proceden ''panadero'' y ''panadería''?',
  '["Pan", "Harina", "Trigo", "Horno"]'::jsonb,
  '"Pan"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es una palabra derivada de la palabra primitiva ''mar''?',
  '["Marea", "Agua", "Pez", "Barco"]'::jsonb,
  '"Marea"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es polisémica porque significa un órgano del cuerpo y una parte de una planta?',
  '["Lengua", "Raíz", "Planta", "Brazo"]'::jsonb,
  '"Planta"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el sinónimo de la palabra ''rápido''?',
  '["Veloz", "Lento", "Bajo", "Triste"]'::jsonb,
  '"Veloz"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el antónimo de la palabra ''encima''?',
  '["Debajo", "Arriba", "Lejos", "Dentro"]'::jsonb,
  '"Debajo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra no pertenece a la familia de palabras de ''casa''?',
  '["Coche", "Casita", "Casoplón", "Caserío"]'::jsonb,
  '"Coche"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el infinitivo correcto del verbo en la frase ''El niño duerme''?',
  '["Dormir", "Duerme", "Dormía", "Dormirá"]'::jsonb,
  '"Dormir"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Los pronombres personales sirven para sustituir a los nombres de las personas en una oración.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Las palabras ''alegre'' y ''triste'' son palabras sinónimas porque significan lo mismo.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'La palabra ''librería'' es una palabra derivada que proviene de ''libro''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Un sustantivo colectivo expresa un conjunto de elementos estando escrito en singular.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'La palabra ''muñeca'' es polisémica porque significa un juguete y una articulación del cuerpo.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'numeric',
  '¿Cuántos sustantivos comunes hay en la frase: ''El gato bebe leche en un plato''?',
  NULL,
  '3'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'numeric',
  '¿Cuántos pronombres personales hay en la frase: ''Él y yo jugamos juntos''?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Los verbos en infinitivo terminan siempre en las terminaciones ''-ar'', ''-er'' o ''-ir''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'El antónimo de ''limpio'' es ''sucio''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué pronombre personal completa la frase: ''___ vas al colegio cada mañana''?',
  '["Tú", "Yo", "Él", "Nosotros"]'::jsonb,
  '"Tú"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es el antónimo de ''subir''?',
  '["Bajar", "Escalar", "Elevar", "Saltar"]'::jsonb,
  '"Bajar"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es el sinónimo de ''bonito''?',
  '["Hermoso", "Feo", "Grande", "Rápido"]'::jsonb,
  '"Hermoso"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'La palabra ''frutería'' forma parte de la familia de palabras de ''fruta''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'numeric',
  '¿Cuántos verbos hay en la oración: ''Oliver canta, Sofía baila y Lucas ríe''?',
  NULL,
  '3'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué clase de palabra es ''correr'' en la frase ''Me gusta correr''?',
  '["Un verbo", "Un nombre", "Un adjetivo", "Un artículo"]'::jsonb,
  '"Un verbo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el sustantivo colectivo que define a un conjunto de abejas?',
  '["Enjambre", "Oveja", "Bosque", "Jauría"]'::jsonb,
  '"Enjambre"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Los sustantivos propios sirven para identificar a un animal concreto diferenciándolo de su clase.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es el antónimo de ''ganar''?',
  '["Perder", "Triunfar", "Lograr", "Subir"]'::jsonb,
  '"Perder"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Los verbos en futuro indican acciones que se realizarán con total seguridad mañana.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cómo llamamos a los sustantivos que se refieren a personas o lugares específicos (ej. ''Oliver'', ''Madrid'')?',
  '["Sustantivos propios", "Sustantivos comunes", "Sustantivos colectivos", "Sustantivos abstractos"]'::jsonb,
  '"Sustantivos propios"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué clase de palabra nos indica cómo son o cómo están los sustantivos (ej. ''casa grande'')?',
  '["Adjetivos", "Verbos", "Artículos", "Pronombres"]'::jsonb,
  '"Adjetivos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué pronombre personal en plural usamos para referirnos al grupo que incluye a la persona que habla?',
  '["Nosotros", "Ellos", "Vosotros", "Yo"]'::jsonb,
  '"Nosotros"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué pronombre personal en plural usamos para referirnos al grupo de personas que escuchan?',
  '["Vosotros", "Nosotros", "Ellos", "Tú"]'::jsonb,
  '"Vosotros"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿En qué tiempo verbal se encuentra una acción que se realiza en este mismo instante (ej. ''Sofía escribe'')?',
  '["Presente", "Pasado", "Futuro", "Infinitivo"]'::jsonb,
  '"Presente"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cómo llamamos a las palabras que expresan significados totalmente opuestos (ej. ''blanco'' y ''negro'')?',
  '["Antónimos", "Sinónimos", "Polisémicas", "Derivadas"]'::jsonb,
  '"Antónimos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el sinónimo de la palabra ''elegir''?',
  '["Escoger", "Dejar", "Romper", "Terminar"]'::jsonb,
  '"Escoger"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el antónimo de la palabra ''reír''?',
  '["Llorar", "Cantar", "Bailar", "Saltar"]'::jsonb,
  '"Llorar"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es la palabra primitiva de la que proceden ''frutero'' y ''frutería''?',
  '["Fruta", "Árbol", "Comida", "Tienda"]'::jsonb,
  '"Fruta"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es una palabra derivada de la palabra primitiva ''flor''?',
  '["Florero", "Planta", "Hoja", "Jardín"]'::jsonb,
  '"Florero"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es polisémica porque significa un animal volador y un objeto para jugar al béisbol?',
  '["Bate", "Pelota", "Guante", "Red"]'::jsonb,
  '"Bate"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el sinónimo de la palabra ''escuchar''?',
  '["Oír", "Hablar", "Mirar", "Escribir"]'::jsonb,
  '"Oír"'::jsonb,
  2
);
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el antónimo de la palabra ''despierto''?',
  '["Dormido", "Alerta", "Activo", "Atento"]'::jsonb,
  '"Dormido"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra pertenece a la familia de palabras de ''mar''?',
  '["Marino", "Pez", "Arena", "Agua"]'::jsonb,
  '"Marino"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el infinitivo correcto del verbo en la frase ''Los niños corren''?',
  '["Correr", "Corren", "Corría", "Correrán"]'::jsonb,
  '"Correr"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Los sustantivos abstractos nombran cosas que se pueden ver y tocar (ej. una mesa).',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Las palabras ''rápido'' y ''lento'' son palabras antónimas.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'La palabra ''panadería'' es una palabra derivada que proviene de ''pan''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Un sustantivo individual se refiere a un solo objeto o ser en singular.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'La palabra ''banco'' es polisémica porque significa un asiento de parque y un lugar para guardar dinero.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'numeric',
  '¿Cuántos adjetivos calificativos hay en la frase: ''El perro negro es muy inteligente''?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'numeric',
  '¿Cuántos sustantivos comunes hay en la frase: ''El niño lee un libro en la biblioteca''?',
  NULL,
  '3'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Los pronombres personales de tercera persona en plural son ''ellos'' y ''ellas''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'El sinónimo de ''difícil'' es ''complicado''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué pronombre personal completa la frase: ''___ somos buenos amigos del colegio''?',
  '["Nosotros", "Yo", "Tú", "Ellos"]'::jsonb,
  '"Nosotros"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es el antónimo de ''entrar''?',
  '["Salir", "Subir", "Bajar", "Correr"]'::jsonb,
  '"Salir"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es el sinónimo de ''delgado''?',
  '["Flaco", "Gordo", "Alto", "Simpático"]'::jsonb,
  '"Flaco"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'La palabra ''pescador'' forma parte de la familia de palabras de ''pescado''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'numeric',
  '¿Cuántos verbos en pasado hay en la oración: ''Oliver cantó y Sofía bailó ayer''?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué clase de palabra es ''salta'' en la frase ''El conejo salta''?',
  '["Un verbo", "Un nombre", "Un adjetivo", "Un artículo"]'::jsonb,
  '"Un verbo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el sustantivo colectivo que define a un conjunto de ovejas?',
  '["Rebaño", "Bosque", "Jauría", "Enjambre"]'::jsonb,
  '"Rebaño"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Los sustantivos comunes sirven para nombrar a los seres de la misma clase sin distinguirlos.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es el antónimo de ''bajar''?',
  '["Subir", "Caer", "Correr", "Saltar"]'::jsonb,
  '"Subir"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Los verbos en infinitivo nos indican el nombre de la acción sin expresar el tiempo.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cómo llamamos a los sustantivos que nombran cosas que no podemos ver ni tocar (ej. ''alegría'')?',
  '["Sustantivos abstractos", "Sustantivos concretos", "Sustantivos propios", "Sustantivos colectivos"]'::jsonb,
  '"Sustantivos abstractos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué clase de palabra describe cualidades o estados de los sustantivos (ej. ''perro rápido'')?',
  '["Adjetivos", "Verbos", "Artículos", "Pronombres"]'::jsonb,
  '"Adjetivos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué pronombre personal en plural usamos para referirnos a un grupo de chicos que no nos incluye?',
  '["Ellos", "Nosotros", "Vosotros", "Yo"]'::jsonb,
  '"Ellos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué pronombre personal en plural usamos para referirnos a un grupo de chicas que no nos incluye?',
  '["Ellas", "Nosotros", "Vosotros", "Tú"]'::jsonb,
  '"Ellas"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿En qué tiempo verbal se encuentra una acción que ocurrirá el próximo verano (ej. ''viajaremos'')?',
  '["Futuro", "Presente", "Pasado", "Infinitivo"]'::jsonb,
  '"Futuro"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cómo llamamos a las palabras que significan exactamente lo mismo (ej. ''andar'' y ''caminar'')?',
  '["Sinónimos", "Antónimos", "Polisémicas", "Derivadas"]'::jsonb,
  '"Sinónimos"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el sinónimo de la palabra ''escoger''?',
  '["Elegir", "Dejar", "Romper", "Terminar"]'::jsonb,
  '"Elegir"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el antónimo de la palabra ''llorar''?',
  '["Reír", "Cantar", "Bailar", "Saltar"]'::jsonb,
  '"Reír"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es la palabra primitiva de la que proceden ''pescador'' y ''pesadería''?',
  '["Pescado", "Agua", "Red", "Barco"]'::jsonb,
  '"Pescado"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es una palabra derivada de la palabra primitiva ''zapato''?',
  '["Zapatería", "Pie", "Calcetín", "Suela"]'::jsonb,
  '"Zapatería"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es polisémica porque significa un órgano de la boca y una parte de una zapatilla?',
  '["Lengua", "Raíz", "Diente", "Brazo"]'::jsonb,
  '"Lengua"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el sinónimo de la palabra ''rápido''?',
  '["Veloz", "Lento", "Bajo", "Triste"]'::jsonb,
  '"Veloz"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el antónimo de la palabra ''dentro''?',
  '["Fuera", "Arriba", "Lejos", "Encima"]'::jsonb,
  '"Fuera"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra no pertenece a la familia de palabras de ''mar''?',
  '["Barco", "Marino", "Marea", "Marítimo"]'::jsonb,
  '"Barco"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el infinitivo correcto del verbo en la frase ''Los conejos saltan''?',
  '["Saltar", "Saltan", "Saltaba", "Saltarán"]'::jsonb,
  '"Saltar"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Los sustantivos concretos nombran seres u objetos reales que podemos percibir por los sentidos.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Las palabras ''encender'' y ''apagar'' son palabras sinónimas.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'La palabra ''librero'' es una palabra derivada que proviene de ''libro''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Un sustantivo colectivo nombra en plural a un solo objeto individual.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'La palabra ''carta'' es polisémica porque significa un mensaje escrito y un elemento de la baraja de juego.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'numeric',
  '¿Cuántos adjetivos calificativos hay en la frase: ''El coche rojo es muy rápido''?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'numeric',
  '¿Cuántos sustantivos comunes hay en la frase: ''El profesor explica la lección en la pizarra''?',
  NULL,
  '3'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Los pronombres personales sirven para acompañar al sustantivo aportando cualidades.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'El antónimo de ''malo'' es ''bueno''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué pronombre personal completa la frase: ''___ vais al parque de atracciones hoy''?',
  '["Vosotros", "Yo", "Tú", "Ellos"]'::jsonb,
  '"Vosotros"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es el antónimo de ''subir''?',
  '["Bajar", "Escalar", "Elevar", "Saltar"]'::jsonb,
  '"Bajar"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es el sinónimo de ''alegre''?',
  '["Contento", "Triste", "Grande", "Rápido"]'::jsonb,
  '"Contento"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'La palabra ''carnicería'' forma parte de la familia de palabras de ''carne''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'numeric',
  '¿Cuántos verbos en futuro hay en la oración: ''Oliver cantará y Sofía bailará mañana''?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué clase de palabra es ''escribe'' en la frase ''El niño escribe''?',
  '["Un verbo", "Un nombre", "Un adjetivo", "Un artículo"]'::jsonb,
  '"Un verbo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es el sustantivo colectivo que define a un conjunto de aves que vuelan juntas?',
  '["Bandada", "Oveja", "Bosque", "Jauría"]'::jsonb,
  '"Bandada"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Los sustantivos colectivos se escriben en plural para nombrar a un conjunto de elementos.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué palabra es el antónimo de ''perder''?',
  '["Ganar", "Fracasar", "Bajar", "Saltar"]'::jsonb,
  '"Ganar"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000006',
  'true_false',
  'Los verbos en infinitivo nos indican si la acción la realiza una sola persona o un grupo.',
  NULL,
  'false'::jsonb,
  2
);

-- Lengua / Ortografía (132)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas sílabas tónicas existen en una sola palabra?',
  NULL,
  '1'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas sílabas tiene la palabra ''teléfono''?',
  NULL,
  '4'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas letras tiene el abecedario español completo?',
  NULL,
  '27'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'La sílaba tónica es la que se pronuncia con más fuerza en una palabra.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Las sílabas átonas son las que no tienen la fuerza de voz en la palabra.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Las palabras agudas llevan la fuerza de voz en la última sílaba.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Las palabras llanas llevan la fuerza de voz en la antepenúltima sílaba.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Todas las palabras esdrújulas se escriben obligatoriamente con tilde.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Los nombres de los días de la semana se escriben siempre con mayúscula inicial.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Antes de las letras ''p'' y ''b'' se escribe siempre la letra ''m''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál de las siguientes palabras es aguda?',
  '["Ratón", "Mesa", "Pájaro", "Estuche Rose"]'::jsonb,
  '"Ratón"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál de las siguientes palabras es llana?',
  '["Árbol", "Compás", "Plátano", "Sofá"]'::jsonb,
  '"Árbol"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál de las siguientes palabras es esdrújula?',
  '["Médico", "Papel", "Camión", "Libreta"]'::jsonb,
  '"Médico"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra está escrita correctamente siguiendo la regla de la ''m'' ante la ''p''?',
  '["Campana", "Canpana", "Canbana", "Cambana"]'::jsonb,
  '"Campana"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra está escrita correctamente siguiendo la regla de la ''m'' ante la ''b''?',
  '["Sombra", "Sonbra", "Sompra", "Sonpra"]'::jsonb,
  '"Sombra"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra termina en ''-y'' en singular de forma correcta?',
  '["Rey", "Rei", "Reis", "Reyes"]'::jsonb,
  '"Rey"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿En cuál de estos casos es obligatorio usar letra mayúscula inicial?',
  '["Después de un punto", "En los nombres de los meses", "En las estaciones", "En los adjetivos comunes"]'::jsonb,
  '"Después de un punto"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra se escribe con mayúscula porque es un nombre propio de lugar?',
  '["España", "País", "Ciudad", "Río"]'::jsonb,
  '"España"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál es la sílaba tónica en la palabra ''camiseta''?',
  '["se", "ca", "mi", "ta"]'::jsonb,
  '"se"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál es la sílaba tónica en la palabra ''balón''?',
  '["lón", "ba", "ba-lón", "ninguna"]'::jsonb,
  '"lón"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Las palabras agudas llevan tilde si terminan en vocal, en ''n'' o en ''s''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Las palabras llanas llevan tilde si terminan en vocal.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra lleva tilde correctamente por ser esdrújula?',
  '["Brújula", "Brujula", "Brujulá", "Brújula-S"]'::jsonb,
  '"Brújula"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'La primera palabra de un texto escrito debe empezar siempre con mayúscula.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra termina en ''-y'' de forma correcta en español?',
  '["Hoy", "Hoi", "Hoys", "Hois"]'::jsonb,
  '"Hoy"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra es llana y no lleva tilde porque termina en vocal?',
  '["Casa", "Árbol", "Lápiz", "Ratón"]'::jsonb,
  '"Casa"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra es aguda y lleva tilde porque termina en la letra ''s''?',
  '["Compás", "Papel", "Cantar", "Mesa"]'::jsonb,
  '"Compás"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Las sílabas de una palabra se pueden separar usando guiones (ej. ca-sa).',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas sílabas átonas tiene la palabra esdrújula ''pájaro''?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Los nombres de personas como ''Sofía'' o ''Carlos'' llevan mayúscula inicial.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál es la sílaba tónica en la palabra ''esdrújula''?',
  '["drú", "es", "ju", "la"]'::jsonb,
  '"drú"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'La palabra ''tambor'' cumple con la regla de la ''m'' antes de la ''b''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas tildes faltan en la oración: ''El pajaro cantó en el arbol''?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas sílabas tiene la palabra ''ordenador''?',
  NULL,
  '4'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas letras forman la sílaba tónica de la palabra ''papel''?',
  NULL,
  '3'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas palabras esdrújulas llevan tilde de forma obligatoria según la regla?',
  NULL,
  '1'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Todas las palabras agudas llevan tilde sin importar en qué letra terminen.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Las palabras llanas llevan la fuerza de voz en la penúltima sílaba.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'La palabra ''estómago'' es esdrújula porque su sílaba tónica es la antepenúltima.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Los nombres de los países como ''Francia'' se escriben con minúscula inicial.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Al separar la palabra ''acción'' en sílabas se escribe como ac-ción.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'El plural de las palabras que terminan en ''-z'' en singular se escribe con ''-ces'' (ej. pez y peces).',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Detrás de un signo de interrogación de cierre jamás se coloca un punto final.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál de las siguientes palabras es aguda porque la fuerza de voz recae en la última sílaba?',
  '["Caracol", "Libreta", "Música", "Lápiz"]'::jsonb,
  '"Caracol"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál de las siguientes palabras es llana porque su sílaba tónica es la penúltima?',
  '["Mesa", "Camión", "Plátano", "Cantar"]'::jsonb,
  '"Mesa"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál de las siguientes palabras es esdrújula?',
  '["Sábado", "Sofá", "Estuche", "Papel"]'::jsonb,
  '"Sábado"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra está escrita correctamente respetando el uso de la ''m'' antes de la ''p''?',
  '["Trampolín", "Tranpolín", "Tranbolín", "Trambolín"]'::jsonb,
  '"Trampolín"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra está escrita correctamente respetando el uso de la ''m'' antes de la ''b''?',
  '["Sombrilla", "Sonbrilla", "Somprilla", "Sonprilla"]'::jsonb,
  '"Sombrilla"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál es el plural correcto de la palabra singular ''buey''?',
  '["Bueyes", "Bueis", "Bueys", "Bueyeis"]'::jsonb,
  '"Bueyes"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué signo ortográfico compuesto se coloca al principio y al final de una pregunta?',
  '["Signos de interrogación", "Signos de exclamación", "Puntos suspensivos", "Comas"]'::jsonb,
  '"Signos de interrogación"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué signo ortográfico compuesto se utiliza para expresar sorpresa, miedo o emoción en una frase?',
  '["Signos de exclamación", "Signos de interrogación", "Dos puntos", "Guiones"]'::jsonb,
  '"Signos de exclamación"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál es la sílaba tónica en la palabra ''pantalón''?',
  '["lón", "pan", "ta", "panta"]'::jsonb,
  '"lón"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál es la sílaba tónica en la palabra ''ventana''?',
  '["ta", "ven", "na", "ventana"]'::jsonb,
  '"ta"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Las palabras llanas llevan tilde cuando terminan en una consonante que no sea ''n'' o ''s''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Las palabras agudas llevan tilde si terminan en vocal.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra lleva tilde de forma correcta siguiendo las reglas de acentuación?',
  '["Árbol", "Arbol", "Arból", "Árbol-S"]'::jsonb,
  '"Árbol"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Los nombres de personas y apellidos deben empezar siempre obligatoriamente con mayúscula.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra termina correctamente en ''-y'' en singular en castellano?',
  '["Muy", "Mui", "Muys", "Muis"]'::jsonb,
  '"Muy"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra es llana porque su fuerza de voz recae en la penúltima sílaba?',
  '["Lápiz", "Ratón", "Música", "Papel"]'::jsonb,
  '"Lápiz"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra es aguda y lleva tilde porque termina en la consonante ''n''?',
  '["Camión", "Árbol", "Mesa", "Cantar"]'::jsonb,
  '"Camión"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Las palabras monosílabas son aquellas que están compuestas por una única sílaba.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas sílabas átonas componen la palabra llana ''ventana''?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Los nombres geográficos de ríos y montañas como ''Ebro'' se escriben con mayúscula inicial.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál es la sílaba tónica en la palabra esdrújula ''brújula''?',
  '["brú", "ju", "la", "ninguna"]'::jsonb,
  '"brú"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'La palabra ''campo'' cumple perfectamente con la regla de escribir ''m'' antes de ''p''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas letras mayúsculas obligatorias faltan en el texto: ''me llamo óliver. vivo en madrid.''?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas sílabas tiene la palabra ''mariposa''?',
  NULL,
  '4'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas letras forman la sílaba tónica de la palabra ''sol''?',
  NULL,
  '3'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas sílabas tónicas tiene una palabra esdrújula?',
  NULL,
  '1'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Las palabras llanas llevan la fuerza de voz en la última sílaba.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Las palabras agudas llevan tilde si terminan en vocal, en ''n'' o en ''s''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'La palabra ''música'' es esdrújula porque su sílaba tónica es la antepenúltima.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Los nombres propios de las mascotas (ej. ''Toby'') se escriben con minúscula inicial.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Al separar la palabra ''mariposa'' en sílabas se escribe como ma-ri-po-sa.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Las palabras llanas llevan tilde cuando terminan en una consonante que no sea ''n'' o ''s''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Se escribe la letra ''m'' antes de la ''p'' y de la ''b'' de forma obligatoria.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál de las siguientes palabras es aguda porque la fuerza de voz recae en la última sílaba?',
  '["Reloj", "Ventana", "Plátano", "Árbol"]'::jsonb,
  '"Reloj"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál de las siguientes palabras es llana porque su sílaba tónica es la penúltima?',
  '["Libreta", "Sofá", "Brújula", "Camión"]'::jsonb,
  '"Libreta"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál de las siguientes palabras es esdrújula porque su sílaba tónica es la antepenúltima?',
  '["Plátano", "Papel", "Mesa", "Reloj"]'::jsonb,
  '"Plátano"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra está escrita correctamente respetando la regla de la ''m'' antes de la ''p''?',
  '["Trompa", "Tronpa", "Tronba", "Tromba"]'::jsonb,
  '"Trompa"'::jsonb,
  2
);
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra está escrita correctamente respetando la regla de la ''m'' antes de la ''b''?',
  '["Bombo", "Bonbo", "Bompo", "Bonpo"]'::jsonb,
  '"Bombo"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál es el plural correcto de la palabra singular ''ley''?',
  '["Leyes", "Leis", "Leys", "Leyeis"]'::jsonb,
  '"Leyes"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué signo ortográfico se coloca al final de una oración completa que ha terminado?',
  '["Un punto", "Una coma", "Un guion", "Dos puntos"]'::jsonb,
  '"Un punto"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué signo ortográfico sirve para separar los elementos de una enumeración en una lista?',
  '["La coma", "El punto", "El guion", "Los dos puntos"]'::jsonb,
  '"La coma"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál es la sílaba tónica en la palabra ''computadora''?',
  '["do", "com", "pu", "ra"]'::jsonb,
  '"do"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál es la sílaba tónica en la palabra ''lápiz''?',
  '["lá", "piz", "la-piz", "ninguna"]'::jsonb,
  '"lá"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Todas las palabras esdrújulas llevan tilde obligatoriamente en español.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'La palabra ''reloj'' lleva tilde porque es aguda y termina en consonante ''j''.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra lleva tilde de forma correcta según las reglas de las palabras llanas?',
  '["Césped", "Cesped", "Césped-S"]'::jsonb,
  '"Césped"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'La primera palabra de una frase que va después de un punto se escribe con mayúscula.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra termina correctamente en ''-y'' en singular en castellano?',
  '["Paraguay", "Paraguai", "Paraguays", "Paraguais"]'::jsonb,
  '"Paraguay"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra es llana porque su fuerza de voz recae en la penúltima sílaba?',
  '["Árbol", "Sofá", "Pájaro", "Papel"]'::jsonb,
  '"Árbol"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra es aguda y lleva tilde porque termina en vocal?',
  '["Sofá", "Reloj", "Mesa", "Cantar"]'::jsonb,
  '"Sofá"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Las palabras de dos sílabas se llaman palabras bisílabas (ej. go-ma).',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas sílabas átonas componen la palabra esdrújula ''médico''?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Los nombres de los planetas como ''Marte'' se escriben con mayúscula inicial.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál es la sílaba tónica en la palabra esdrújula ''plátano''?',
  '["plá", "ta", "no", "ninguna"]'::jsonb,
  '"plá"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'La palabra ''sombrero'' cumple perfectamente con la regla de escribir ''m'' antes de ''b''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas letras mayúsculas iniciales faltan en la frase: ''lucas vive en sevilla.''?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas sílabas tiene la palabra ''temperatura''?',
  NULL,
  '5'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas letras forman la sílaba tónica de la palabra ''sol''?',
  NULL,
  '3'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas sílabas tónicas puede tener una palabra llana?',
  NULL,
  '1'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Las palabras agudas llevan la fuerza de voz en la penúltima sílaba.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Las palabras llanas llevan tilde si no terminan en vocal, en ''n'' o en ''s''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'La palabra ''lámpara'' es esdrújula porque su sílaba tónica es la antepenúltima.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Los nombres de los planetas del Sistema Solar como ''Júpiter'' se escriben con minúscula.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Al separar la palabra ''paraguas'' en sílabas se escribe como pa-ra-guas.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'El plural de las palabras que terminan en ''-y'' se forma añadiendo ''-es'' (ej. rey y reyes).',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Antes de la consonante ''p'' se escribe siempre la consonante ''m'' (ej. campo).',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál de las siguientes palabras es aguda porque su sílaba tónica es la última?',
  '["Pared", "Libreta", "Pájaro", "Mesa"]'::jsonb,
  '"Pared"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál de las siguientes palabras es llana porque su sílaba tónica es la penúltima?',
  '["Estuche", "Sofá", "Cantar", "Esdrújula"]'::jsonb,
  '"Estuche"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál de las siguientes palabras es esdrújula porque su sílaba tónica es la antepenúltima?',
  '["Pájaro", "Papel", "Mesa", "Reloj"]'::jsonb,
  '"Pájaro"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra está escrita correctamente respetando la regla de la ''m'' antes de la ''p''?',
  '["Smapo", "Sanpo", "Champú", "Chanpú"]'::jsonb,
  '"Champú"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra está escrita correctamente respetando la regla de la ''m'' antes de la ''b''?',
  '["Alfombra", "Alfonbra", "Alfonpra", "Alfompra"]'::jsonb,
  '"Alfombra"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál es el plural correcto de la palabra singular ''buey''?',
  '["Bueyes", "Bueis", "Bueys", "Bueyeis"]'::jsonb,
  '"Bueyes"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué signo ortográfico se coloca al principio de una frase exclamativa de sorpresa?',
  '["¡", "!", "¿", "?"]'::jsonb,
  '"¡"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué signo ortográfico se utiliza para encerrar las palabras exactas que dice un personaje?',
  '["Las comillas", "El punto", "La coma", "El guion"]'::jsonb,
  '"Las comillas"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál es la sílaba tónica en la palabra ''computador''?',
  '["dor", "com", "pu", "ta"]'::jsonb,
  '"dor"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál es la sílaba tónica en la palabra ''árbol''?',
  '["ár", "bol", "ar-bol", "ninguna"]'::jsonb,
  '"ár"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Todas las palabras agudas que terminan en la letra ''r'' llevan tilde de forma obligatoria.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'La palabra ''canguro'' es una palabra llana que no lleva tilde porque termina en vocal.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra es esdrújula y lleva tilde correctamente en su sílaba tónica?',
  '["Plátano", "Platano", "Platanó", "Plátano-S"]'::jsonb,
  '"Plátano"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'La palabra que va justo detrás de un signo de exclamación de cierre debe empezar con mayúscula.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra termina correctamente en ''-y'' en singular en español?',
  '["Uruguay", "Uruguai", "Uruguays", "Uruguais"]'::jsonb,
  '"Uruguay"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra es llana porque su fuerza de voz recae en la penúltima sílaba?',
  '["Mesa", "Sofá", "Pájaro", "Papel"]'::jsonb,
  '"Mesa"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué palabra es aguda y lleva tilde porque termina en la consonante ''s''?',
  '["Compás", "Reloj", "Mesa", "Cantar"]'::jsonb,
  '"Compás"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Las palabras formadas por tres sílabas exactas reciben el nombre de trisílabas (ej. pla-ta-no).',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas sílabas átonas componen la palabra esdrújula ''brújula''?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'Los nombres de los meses del año en español como ''mayo'' se deben escribir con mayúscula inicial.',
  NULL,
  'false'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál es la sílaba tónica en la palabra esdrújula ''médico''?',
  '["mé", "di", "co", "ninguna"]'::jsonb,
  '"mé"'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'true_false',
  'La palabra ''enjambre'' cumple perfectamente con la regla de escribir ''m'' antes de ''b''.',
  NULL,
  'true'::jsonb,
  2
),
(
  'b3000001-0001-4000-8000-000000000007',
  'numeric',
  '¿Cuántas letras mayúsculas iniciales faltan en la frase: ''sofía vive en burgos.''?',
  NULL,
  '2'::jsonb,
  2
);

COMMIT;

-- Resumen: 900 preguntas · 2 asignaturas · 7 temas
