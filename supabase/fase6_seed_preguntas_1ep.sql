-- =============================================================================
-- Solete — Pack de preguntas 1º de primaria (Excel)
-- =============================================================================
-- NO ejecutar desde el agente: revisa y corre a mano en el SQL Editor de Supabase.
--
-- Sustituye TODAS las asignaturas / temas / preguntas de curso = '1'.
-- No toca el contenido de 2º primaria.
--
-- Origen: preguntas 1ºEP.xlsx (~740 filas; se omiten unas pocas corruptas del Excel).
-- English y Natural Science: nombres y temas en inglés.
-- =============================================================================

BEGIN;

DELETE FROM public.asignaturas WHERE curso = '1';

-- Asignaturas 1º
INSERT INTO public.asignaturas (id, nombre, icono, curso) VALUES
  ('a1000001-0001-4000-8000-000000000001', 'Matemáticas', '🔢', '1'),
  ('a1000001-0001-4000-8000-000000000002', 'Lengua', '📖', '1'),
  ('a1000001-0001-4000-8000-000000000003', 'English', '🗣️', '1'),
  ('a1000001-0001-4000-8000-000000000004', 'Natural Science', '🌱', '1');

-- Temas 1º
INSERT INTO public.temas (id, asignatura_id, nombre, orden) VALUES
  ('b1000001-0001-4000-8000-000000000001', 'a1000001-0001-4000-8000-000000000001', 'Números y cantidades', 1),
  ('b1000001-0001-4000-8000-000000000002', 'a1000001-0001-4000-8000-000000000001', 'Operaciones', 2),
  ('b1000001-0001-4000-8000-000000000003', 'a1000001-0001-4000-8000-000000000001', 'Medida y geometría', 3),
  ('b1000001-0001-4000-8000-000000000004', 'a1000001-0001-4000-8000-000000000001', 'Datos y dinero', 4),
  ('b1000001-0001-4000-8000-000000000005', 'a1000001-0001-4000-8000-000000000002', 'Reflexión sobre la lengua', 1),
  ('b1000001-0001-4000-8000-000000000006', 'a1000001-0001-4000-8000-000000000002', 'Lectura y comprensión', 2),
  ('b1000001-0001-4000-8000-000000000007', 'a1000001-0001-4000-8000-000000000002', 'Expresión oral y escrita', 3),
  ('b1000001-0001-4000-8000-000000000008', 'a1000001-0001-4000-8000-000000000003', 'Toys and classroom', 1),
  ('b1000001-0001-4000-8000-000000000009', 'a1000001-0001-4000-8000-000000000003', 'Animals and nature', 2),
  ('b1000001-0001-4000-8000-000000000010', 'a1000001-0001-4000-8000-000000000003', 'Food and town', 3),
  ('b1000001-0001-4000-8000-000000000011', 'a1000001-0001-4000-8000-000000000003', 'I can and clothes', 4),
  ('b1000001-0001-4000-8000-000000000012', 'a1000001-0001-4000-8000-000000000003', 'My day', 5),
  ('b1000001-0001-4000-8000-000000000013', 'a1000001-0001-4000-8000-000000000004', 'My body and health', 1),
  ('b1000001-0001-4000-8000-000000000014', 'a1000001-0001-4000-8000-000000000004', 'Animals', 2),
  ('b1000001-0001-4000-8000-000000000015', 'a1000001-0001-4000-8000-000000000004', 'Plants and care', 3),
  ('b1000001-0001-4000-8000-000000000016', 'a1000001-0001-4000-8000-000000000004', 'Materials', 4),
  ('b1000001-0001-4000-8000-000000000017', 'a1000001-0001-4000-8000-000000000004', 'Environment', 5);

-- Preguntas

-- English / Animals and nature (39)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'How do you say ''partes del cuerpo'' in English?',
  '["Body parts", "Toys", "Food", "Animals"]'::jsonb,
  '"Body parts"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Which word is an arm or a leg?',
  '["Body part", "Happy", "Big", "Small"]'::jsonb,
  '"Body part"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Translate: ''Yo tengo un coche de juguete.''',
  '["I have got a toy car", "I haven''t got a toy car", "He has got a car", "She has got a car"]'::jsonb,
  '"I have got a toy car"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Translate: ''Yo no tengo una muñeca.''',
  '["I haven''t got a doll", "I have got a doll", "She has got a doll", "He hasn''t got a doll"]'::jsonb,
  '"I haven''t got a doll"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete: He ___ got blue eyes.',
  '["has", "have", "is", "are"]'::jsonb,
  '"has"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete: She ___ got a red pencil.',
  '["has", "have", "is", "am"]'::jsonb,
  '"has"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete: He ___ got a dog (Negative).',
  '["hasn''t", "haven''t", "isn''t", "not"]'::jsonb,
  '"hasn''t"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What word joins two words like ''eyes ___ ears''?',
  '["and", "but", "or", "with"]'::jsonb,
  '"and"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'How do you say ''animales de granja'' in English?',
  '["Farm animals", "Toys", "Classroom objects", "Body parts"]'::jsonb,
  '"Farm animals"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Which of these is a farm animal?',
  '["Goat", "Lion", "Tiger", "Elephant"]'::jsonb,
  '"Goat"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What tense do we use for an action happening now (e.g. ''The cow is eating'')?',
  '["Present continuous", "Past simple", "Future", "Imperative"]'::jsonb,
  '"Present continuous"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete to point at a close animal: ''___ is a goat.''',
  '["This", "That", "They", "These"]'::jsonb,
  '"This"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete to point at a far animal: ''___ is a cow over there.''',
  '["That", "This", "They", "These"]'::jsonb,
  '"That"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Where is the dog? (In the middle of the cat and the pig)',
  '["It''s between them", "It''s behind them", "It''s in front of them", "It''s next to them"]'::jsonb,
  '"It''s between them"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Where is the horse? (At the side of the barn)',
  '["It''s next to the barn", "It''s between the barn", "It''s under the barn", "It''s in the barn"]'::jsonb,
  '"It''s next to the barn"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the question: ''Where ___ the goats?''',
  '["are", "is", "am", "be"]'::jsonb,
  '"are"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the answer: ''Where are the cows?'' - ''___ behind the tree.''',
  '["They''re", "It''s", "I''m", "You''re"]'::jsonb,
  '"They''re"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'true_false',
  '''He has got'' is used for a boy or a man.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'true_false',
  '''She has got'' is used for a boy.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What part of your face do you use to smell things?',
  '["nose", "eyes", "mouth", "ears"]'::jsonb,
  '"nose"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What parts of your body do you use to look and see?',
  '["eyes", "ears", "hands", "feet"]'::jsonb,
  '"eyes"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What part of your face do you use to eat and talk?',
  '["mouth", "nose", "arms", "legs"]'::jsonb,
  '"mouth"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What parts of your head do you use to listen to music?',
  '["ears", "eyes", "face", "hands"]'::jsonb,
  '"ears"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What parts of your body have five fingers to grab toys?',
  '["hands", "feet", "legs", "arms"]'::jsonb,
  '"hands"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What parts of your body do you use to run and jump?',
  '["legs", "arms", "hands", "head"]'::jsonb,
  '"legs"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What do you call a hair color that looks like bright yellow?',
  '["blonde hair", "brown hair", "black hair", "red hair"]'::jsonb,
  '"blonde hair"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What do you call a hair color that is very dark like night?',
  '["black hair", "blonde hair", "red hair", "short hair"]'::jsonb,
  '"black hair"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the sentence: ''I ___ got two hands.''',
  '["have", "has", "am", "is"]'::jsonb,
  '"have"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the sentence: ''He ___ got short hair.''',
  '["has", "have", "am", "are"]'::jsonb,
  '"has"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the sentence for a girl: ''___ has got green eyes.''',
  '["She", "He", "I", "It"]'::jsonb,
  '"She"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the negative sentence: ''I ___ got six eyes.''',
  '["haven''t", "hasn''t", "not", "am not"]'::jsonb,
  '"haven''t"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the negative sentence: ''He ___ got long hair.''',
  '["hasn''t", "haven''t", "isn''t", "not"]'::jsonb,
  '"hasn''t"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'true_false',
  'Human beings have got four feet on their body.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'true_false',
  '''He has got'' is used when we talk about a boy or man.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What farm animal is big, has horns, and says ''moo''?',
  '["cow", "goat", "horse", "sheep"]'::jsonb,
  '"cow"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What farm animal has soft wool and says ''baa''?',
  '["sheep", "chicken", "duck", "bird"]'::jsonb,
  '"sheep"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What farm animal loves to swim in the pond and says ''quack''?',
  '["duck", "pig", "mouse", "cat"]'::jsonb,
  '"duck"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What farm animal can you ride on its back with a saddle?',
  '["horse", "cow", "goat", "dog"]'::jsonb,
  '"horse"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What farm animal is small, pink, and has a curly tail?',
  '["pig", "chicken", "bird", "mouse"]'::jsonb,
  '"pig"'::jsonb,
  1
);

-- English / Food and town (39)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Which of these is a fruit?',
  '["Apple", "Bread", "Cheese", "Chicken"]'::jsonb,
  '"Apple"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Translate: ''No me gusta la leche.''',
  '["I don''t like milk", "I like milk", "Do you like milk?", "No, thank you"]'::jsonb,
  '"I don''t like milk"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'How do you answer: ''Do you like apples?'' (No)',
  '["No, I don''t", "No, thank you", "Yes, I do", "No, it isn''t"]'::jsonb,
  '"No, I don''t"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'How do you answer: ''Do you want some water?'' (Yes, politely)',
  '["Yes, please", "Yes, I do", "No, thank you", "Yes, it is"]'::jsonb,
  '"Yes, please"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'true_false',
  '''I like'' means that you enjoy eating that food.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Which food do we use to make sandwiches?',
  '["Bread", "Apple", "Banana", "Orange"]'::jsonb,
  '"Bread"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'How do you say ''partes de la casa'' in English?',
  '["Parts of the house", "Farm animals", "Classroom objects", "Body parts"]'::jsonb,
  '"Parts of the house"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Where do you sleep in a house?',
  '["Bedroom", "Kitchen", "Bathroom", "Garden"]'::jsonb,
  '"Bedroom"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Complete for one single object: ''___ a book on the desk.''',
  '["There is", "There are", "Are there", "Is there"]'::jsonb,
  '"There is"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Complete for multiple objects: ''___ three apples in the kitchen.''',
  '["There are", "There is", "There isn''t", "Is there"]'::jsonb,
  '"There are"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Complete the question: ''___ houses are there?''',
  '["How many", "What", "Where", "Which"]'::jsonb,
  '"How many"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'How do you say ''No estoy seguro'' if you don''t know if you like a food?',
  '["I''m not sure", "I like", "I don''t like", "Yes, please"]'::jsonb,
  '"I''m not sure"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What fruit is round, orange, and gives juicy juice?',
  '["oranges", "apples", "pears", "bananas"]'::jsonb,
  '"oranges"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What long fruit is yellow and monkeys love to eat?',
  '["bananas", "lemons", "grapes", "tomatoes"]'::jsonb,
  '"bananas"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What fruit is green or red and grows in small sweet bunches?',
  '["grapes", "potatoes", "onions", "carrots"]'::jsonb,
  '"grapes"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What vegetable is long, orange, and grows under the ground?',
  '["carrots", "peas", "beans", "eggs"]'::jsonb,
  '"carrots"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What vegetable makes you cry when you cut it into pieces?',
  '["onions", "potatoes", "tomatoes", "chips"]'::jsonb,
  '"onions"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What food comes from chickens and is round with a shell?',
  '["eggs", "sausages", "burgers", "beans"]'::jsonb,
  '"eggs"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What phrase do you use if you like a food very, very much?',
  '["I love", "I like", "I don''t like", "I haven''t"]'::jsonb,
  '"I love"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What phrase do you use if a food tastes bad to you?',
  '["I don''t like", "I love", "I like", "I have got"]'::jsonb,
  '"I don''t like"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Answer the question: ''Do you like grapes?'' (Positive response)',
  '["Yes, I do", "No, I don''t", "Yes, I can", "No, it isn''t"]'::jsonb,
  '"Yes, I do"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Answer the question: ''Do you like peas?'' (Negative response)',
  '["No, I don''t", "Yes, I do", "No, he don''t", "Yes, please"]'::jsonb,
  '"No, I don''t"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Complete the sentence: ''I like grapes ___ bananas.''',
  '["and", "or", "but", "with"]'::jsonb,
  '"and"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Choose the correct option: ''Do / Does you like chips?''',
  '["Do", "Does", "Is", "Are"]'::jsonb,
  '"Do"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What word is written correctly in plural form?',
  '["oranges", "orangis", "grappes", "egs"]'::jsonb,
  '"oranges"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'true_false',
  '''Burgers'' and ''chips'' are types of healthy green vegetables.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'true_false',
  'We say ''I love pears'' when pears are our favorite fruit.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  '¿Qué mueble tiene estantes para guardar tus libros de cuentos?',
  '["librería", "ducha", "mesa", "cama"]'::jsonb,
  '"librería"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Completa para un elemento: ''___ una ducha en mi casa.''',
  '["Hay", "Hay", "No hay", "¿Hay"]'::jsonb,
  '"Hay"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Completa para varios elementos: ''___ dos camas en el dormitorio.''',
  '["Hay", "Hay", "No hay", "¿Hay"]'::jsonb,
  '"Hay"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Completa la oración negativa: ''Hay ___ una casa aquí.''',
  '["no", "\"no"]'::jsonb,
  '"\"no"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  '¿Qué lugar tiene árboles, césped y columpios para que jueguen los niños?',
  '["parque", "escuela", "zoológico", "tienda"]'::jsonb,
  '"parque"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  '¿Qué lugar visitas para ver animales salvajes como leones y monos?',
  '["zoológico", "escuela", "tienda", "casa"]'::jsonb,
  '"zoológico"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  '¿A qué lugar vas para comprar juguetes, comida o ropa?',
  '["tienda", "parque", "calle", "escuela"]'::jsonb,
  '"tienda"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'multiple_choice',
  '¿Qué palabra está escrita correctamente?',
  '["librería", "bukcase", "cocina", "bet"]'::jsonb,
  '"librería"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'numeric',
  '¿Cuántas mesas hay en la frase ''una mesa''?, Grecia',
  NULL,
  '1'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'numeric',
  '¿Cuántas camas hay en la frase ''cuatro camas''?, Grecia',
  NULL,
  '4'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'true_false',
  '''There are'' se usa cuando hablamos de un solo objeto singular.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000010',
  'true_false',
  'Un jardín es un espacio al aire libre con césped y plantas fuera de la casa.',
  NULL,
  'true'::jsonb,
  1
);

-- English / I can and clothes (41)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'How do you say ''acciones o habilidades'' in English?',
  '["Actions", "Clothes", "Food", "Routines"]'::jsonb,
  '"Actions"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'What word do you use if you know how to swim?',
  '["Can", "Can''t", "Do", "Like"]'::jsonb,
  '"Can"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'What word do you use if you don''t know how to fly?',
  '["Can''t", "Can", "Don''t", "Not"]'::jsonb,
  '"Can''t"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'How do you answer: ''Can you jump?'' (Yes)',
  '["Yes, I can", "Yes, I do", "No, I can''t", "Yes, it is"]'::jsonb,
  '"Yes, I can"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'How do you answer: ''Can you fly?'' (No)',
  '["No, I can''t", "No, I don''t", "Yes, I can", "No, it isn''t"]'::jsonb,
  '"No, I can''t"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'How do you say ''ropa'' in English?',
  '["Clothes", "Toys", "Food", "Actions"]'::jsonb,
  '"Clothes"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Which of these is something you wear on your feet?',
  '["Socks", "T-shirt", "Hat", "Jacket"]'::jsonb,
  '"Socks"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Translate: ''Estoy usando una chaqueta negra.''',
  '["I''m wearing a black jacket", "I''m wearing a blue jacket", "I want a jacket", "This is a jacket"]'::jsonb,
  '"I''m wearing a black jacket"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'What is the action in the sentence: ''I''m painting''.',
  '["Painting", "Wearing", "Jacket", "Black"]'::jsonb,
  '"Painting"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'How do you say politely ''¿Quieres cantar?'' to a friend?',
  '["Do you want to sing?", "I can sing", "I''m wearing a song", "Yes, please"]'::jsonb,
  '"Do you want to sing?"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'true_false',
  'In English adjectives go before the noun (e.g. ''red T-shirt'').',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Which action means ''correr'' in English?',
  '["Run", "Jump", "Swim", "Fly"]'::jsonb,
  '"Run"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Which action means ''saltar'' in English?',
  '["Jump", "Run", "Sing", "Dance"]'::jsonb,
  '"Jump"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'What do you wear on your head when it is sunny?',
  '["Hat", "Shoes", "Trousers", "Skirt"]'::jsonb,
  '"Hat"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'What color is the T-shirt in the phrase ''blue T-shirt''?',
  '["Blue", "Red", "Green", "Black"]'::jsonb,
  '"Blue"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'true_false',
  '''Can''t'' is the short form of ''cannot''.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'true_false',
  '''I''m wearing'' means you have those clothes on your body right now.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  '¿Qué palabra significa ''Yo puedo'' en inglés?',
  '["I can", "I can''t", "I like", "I wear"]'::jsonb,
  '"I can"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  '¿Qué palabra significa ''Yo no puedo'' en inglés?',
  '["I can''t", "I can", "I do", "I don"]'::jsonb,
  '"I can''t"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Completa la pregunta: ''___ andas en bicicleta?''", Grecia',
  '["Puede", "Hacer", "Es", "Son"]'::jsonb,
  '"Puede"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  '¿Cómo respondes a: ''¿Puedes nadar?'' (No)',
  '["No, no puedo", "No, no lo hago", "Sí, puedo", "No, no es"]'::jsonb,
  '"No, no puedo"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  '¿Cómo respondes a: ''¿Puedes bailar?'' (Sí)',
  '["Sí, puedo", "Sí, lo hago", "No, no puedo", "Sí, por favor"]'::jsonb,
  '"Sí, puedo"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  '¿Qué te pones en las piernas cuando hace frío?',
  '["Pantalones", "Camiseta", "Sombrero", "Calcetines"]'::jsonb,
  '"Pantalones"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  '¿Cuál de estos es una prenda de vestir?',
  '["Chaqueta", "Manzana", "Coche", "Muñeca"]'::jsonb,
  '"Chaqueta"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  '¿Qué estás haciendo? (Estoy escribiendo una historia)',
  '["Estoy escribiendo", "Llevo puesto", "Puedo escribir", "Me gusta escribir"]'::jsonb,
  '"Estoy escribiendo"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  '¿Cómo le preguntas a un amigo ''¿Quieres jugar?''?',
  '["¿Quieres jugar?", "Puedo jugar", "Estoy jugando", "¿Te gustaría"]'::jsonb,
  '"¿Quieres jugar?"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  '¿Qué acción significa mover el cuerpo a través del agua usando brazos y piernas?',
  '["nadar", "escalar", "correr", "volar"]'::jsonb,
  '"nadar"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  '¿Qué acción significa subir a un árbol o a una montaña usando manos y pies?',
  '["escalar", "volar", "saltar", "bailar"]'::jsonb,
  '"escalar"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  '¿Qué acción significa moverse muy rápido a pie como en una carrera? coche?',
  '["correr", "nadar", "patinar", "saltar"]'::jsonb,
  '"correr"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  '¿Qué acción significa moverse por el aire con alas como un pájaro?',
  '["volar", "escalar", "saltar", "patear"]'::jsonb,
  '"volar"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'What action means catching a ball with your hands?',
  '["catch", "kick", "throw", "jump"]'::jsonb,
  '"catch"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'What action means pushing a ball hard using your foot?',
  '["kick", "throw", "catch", "hop"]'::jsonb,
  '"kick"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'What action means moving your feet to follow the rhythm of music?',
  '["dance", "run", "skate", "climb"]'::jsonb,
  '"dance"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'What action means moving on the floor using boots with wheels?',
  '["skate", "jump", "run", "hop"]'::jsonb,
  '"skate"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'What action means making music with your voice by saying words with a melody?',
  '["sing", "dance", "skate", "climb"]'::jsonb,
  '"sing"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Complete the sentence: ''Birds ___ fly in the sky.''',
  '["can", "can''t", "do", "are"]'::jsonb,
  '"can"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Complete the sentence: ''Monkeys ___ fly.''',
  '["can''t", "can", "don''t", "isn''t"]'::jsonb,
  '"can''t"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Answer the question: ''Can you jump?'' (Positive response)',
  '["Yes, I can", "No, I can''t", "Yes, I do", "No, I don''t"]'::jsonb,
  '"Yes, I can"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Answer the question: ''Can a dog fly?'' (Negative response)',
  '["No, it can''t", "Yes, it can", "No, he can''t", "Yes, I can"]'::jsonb,
  '"No, it can''t"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'true_false',
  '''Can''t'' is the short way to write ''cannot''.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000011',
  'true_false',
  'A dolphin can walk on the grass using its legs.',
  NULL,
  'false'::jsonb,
  1
);

-- English / My day (9)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b1000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'How do you say ''rutinas diarias'' in English?',
  '["Daily routines", "Farm animals", "Classroom objects", "Body parts"]'::jsonb,
  '"Daily routines"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'Which activity do you do in the morning?',
  '["Wake up", "Go to sleep", "Have dinner", "Watch stars"]'::jsonb,
  '"Wake up"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'Which word connects two choices like: ''Do you like milk ___ juice?''',
  '["or", "and", "but", "with"]'::jsonb,
  '"or"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'How do you answer politely: ''Would you like some water?'' (Yes)',
  '["Yes, please!", "No, thank you", "Yes, I can", "No, I don''t"]'::jsonb,
  '"Yes, please!"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000012',
  'true_false',
  '''Go to bed'' is a daily routine that you do at night.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000012',
  'true_false',
  'Present simple is used to talk about things we do regularly or every day.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'What do you do at school?',
  '["Learn", "Sleep all day", "Shower", "Cook dinner"]'::jsonb,
  '"Learn"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'How do you say ''¿Te gustaría...?'' in English?',
  '["Would you like...?", "Do you want...?", "Can you...?", "Where is...?"]'::jsonb,
  '"Would you like...?"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000012',
  'multiple_choice',
  '¿Cuál es una rutina diaria que haces antes de ir a la escuela?',
  '["Desayunar", "Cenar", "Ir a dormir", "Mirar las estrellas"]'::jsonb,
  '"Desayunar"'::jsonb,
  1
);

-- English / Toys and classroom (44)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'How do you say ''muñeca'' in English?',
  '["Doll", "Ball", "Car", "Train"]'::jsonb,
  '"Doll"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Complete: It is ___ desk.',
  '["a", "an", "is", "are"]'::jsonb,
  '"a"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Complete the question: ''___ is it? - It''s a train.''',
  '["What", "Where", "Who", "How"]'::jsonb,
  '"What"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'How do you answer: ''Is it a car?'' (No)',
  '["No, it isn''t", "Yes, it is", "No, thank you", "Yes, please"]'::jsonb,
  '"No, it isn''t"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'How do you answer: ''Is it a kite?'' (Yes)',
  '["Yes, it is", "No, it isn''t", "Yes, I do", "No, thank you"]'::jsonb,
  '"Yes, it is"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What object do you use to sit on in class?',
  '["Chair", "Desk", "Pencil", "Crayon"]'::jsonb,
  '"Chair"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'If someone is crying, they probably feel...',
  '["Sad", "Happy", "Excited", "Good"]'::jsonb,
  '"Sad"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Where is the book? (On top of the desk)',
  '["It''s on the desk", "It''s in the desk", "It''s under the desk", "It''s next to the desk"]'::jsonb,
  '"It''s on the desk"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Where is the schoolbag? (On the floor, below the chair)',
  '["It''s under the chair", "It''s on the chair", "It''s in the chair", "It''s behind the chair"]'::jsonb,
  '"It''s under the chair"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Complete: You ___ my friend.',
  '["are", "is", "am", "be"]'::jsonb,
  '"are"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Complete: He ___ in the school.',
  '["is", "are", "am", "be"]'::jsonb,
  '"is"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'true_false',
  '''An'' is used before words that start with a vowel sound like ''orange''.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'true_false',
  '''In'' means that an object is inside another one.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Which adjective means ''pequeño''?',
  '["Small", "Big", "New", "Old"]'::jsonb,
  '"Small"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Which toy has four wheels and rolls on the floor?',
  '["Car", "Kite", "Doll", "Teddy"]'::jsonb,
  '"Car"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Complete the question: ''___ is the cat?'' - ''It''s under the bed.''',
  '["Where", "What", "Who", "Is"]'::jsonb,
  '"Where"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'true_false',
  'Feelings in English include happy, sad, and angry.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'How do you say ''enfadado'' in English?',
  '["Angry", "Happy", "Sad", "Scared"]'::jsonb,
  '"Angry"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Complete: It ___ a green pen.',
  '["is", "am", "are", "be"]'::jsonb,
  '"is"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What is a toy that flies with a string in the sky?',
  '["kite", "ball", "robot", "car"]'::jsonb,
  '"kite"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What toy has two wheels and a handlebar to stand on?',
  '["scooter", "doll", "game", "balloon"]'::jsonb,
  '"scooter"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Complete the sentence: ''It is ___ robot.''',
  '["a", "an", "is", "are"]'::jsonb,
  '"a"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Complete the sentence: ''It is ___ alien.''',
  '["an", "a", "not", "it"]'::jsonb,
  '"an"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Answer the question: ''Is it a ball?'' (Negative response), Greece',
  '["No, it isn''t", "Yes, it is", "No, I don''t", "Yes, I can"]'::jsonb,
  '"No, it isn''t"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What adjective means the opposite of ''slow''?',
  '["fast", "big", "old", "small"]'::jsonb,
  '"fast"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What adjective means the opposite of ''new''?',
  '["old", "fast", "slow", "big"]'::jsonb,
  '"old"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What adjective means the opposite of ''small''?',
  '["big", "old", "new", "slow"]'::jsonb,
  '"big"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'true_false',
  'An alien is a toy that has a wheel and a handlebar.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'true_false',
  'We use ''an'' before words that start with a vowel sound like ''alien''.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Where do you put your books and toys to keep them closed?',
  '["cupboard", "ruler", "pencil", "rubber"]'::jsonb,
  '"cupboard"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What object do you use to draw straight lines?',
  '["ruler", "computer", "chair", "desk"]'::jsonb,
  '"ruler"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What object do you sit on in the classroom?',
  '["chair", "desk", "book", "pen"]'::jsonb,
  '"chair"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What object do you write on with a computer?',
  '["desk", "cupboard", "rubber", "crayon"]'::jsonb,
  '"desk"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'If the cat is inside the box, we say it is ___ the box.',
  '["in", "on", "under", "next to"]'::jsonb,
  '"in"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'If the cat is sitting on top of the book, it is ___ the book.',
  '["on", "in", "under", "between"]'::jsonb,
  '"on"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'If the pencil falls down below the chair, it is ___ the chair.',
  '["under", "on", "in", "in front of"]'::jsonb,
  '"under"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'How do you feel if you are yawning and want to sleep?',
  '["sleepy", "happy", "sad", "angry"]'::jsonb,
  '"sleepy"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'How do you feel if you are smiling with a big face?',
  '["happy", "sad", "angry", "scary"]'::jsonb,
  '"happy"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'How do you feel if you have a red face and are shouting?',
  '["angry", "happy", "sleepy", "funny"]'::jsonb,
  '"angry"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'How do you feel if you tell jokes and make people laugh?',
  '["funny", "sad", "scary", "sleepy"]'::jsonb,
  '"funny"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Answer the question: ''Are you happy?'' (Positive response)',
  '["Yes, I am", "No, I''m not", "Yes, it is", "No, it isn''t"]'::jsonb,
  '"Yes, I am"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Answer the question: ''Is she sad?'' (Negative response)',
  '["No, she isn''t", "Yes, she is", "No, he isn''t", "Yes, he is"]'::jsonb,
  '"No, she isn''t"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'true_false',
  'A rubber is used to write text on your schoolbook.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000008',
  'true_false',
  'A computer is a classroom object used to type or look at screens.',
  NULL,
  'true'::jsonb,
  1
);

-- Lengua / Expresión oral y escrita (43)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b1000001-0001-4000-8000-000000000007',
  'true_false',
  'Para saludar a alguien por la mañana decimos ''Adiós''.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Decir cómo es el físico o carácter de alguien es una...',
  '["Descripción de personas", "Descripción de lugares", "Nota", "Poesía"]'::jsonb,
  '"Descripción de personas"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Un texto corto que dejamos a alguien para avisar de algo es una...',
  '["Nota", "Poesía", "Cómic", "Cartel"]'::jsonb,
  '"Nota"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Un formato con viñetas y dibujos que cuenta una historia es un...',
  '["Cómic", "Cartel", "Nota", "Poema"]'::jsonb,
  '"Cómic"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'true_false',
  'Un cartel sirve para anunciar o avisar de un evento de forma visual.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Completar: La palabra que rima con ''gato'' es...',
  '["pato", "sol", "luna", "flor"]'::jsonb,
  '"pato"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál de estos es un saludo?',
  '["Hola", "Gracias", "Por favor", "De nada"]'::jsonb,
  '"Hola"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'true_false',
  'En un poema, las líneas suelen rimar entre sí.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál es el opuesto de una persona ''alta'' en una descripción?',
  '["Baja", "Guapa", "Simpática", "Delgada"]'::jsonb,
  '"Baja"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'true_false',
  'Para despedirse de un amigo podemos decir ''Hasta luego''.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Si explicamos detalladamente cómo es un parque estamos haciendo una...',
  '["Descripción de lugares", "Descripción de personas", "Nota", "Cómic"]'::jsonb,
  '"Descripción de lugares"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Un dibujo grande con letras que invita a una fiesta en el colegio es un...',
  '["Cartel", "Nota", "Poema", "Libro"]'::jsonb,
  '"Cartel"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Las burbujas de texto donde hablan los personajes de un cómic se llaman...',
  '["Bocadillos", "Notas", "Carteles", "Rimas"]'::jsonb,
  '"Bocadillos"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'true_false',
  'Una nota suele ser un texto larguísimo de muchas páginas.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Completar: La palabra que rima con ''luna'' es...',
  '["cuna", "sol", "mar", "flor"]'::jsonb,
  '"cuna"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Cuando conocemos a alguien nuevo lo primero que hacemos es...',
  '["Presentarnos", "Despedirnos", "Escribir una nota", "Hacer un cartel"]'::jsonb,
  '"Presentarnos"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'true_false',
  'Un texto poético suele estar escrito en versos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Cuál es un rasgo físico en la descripción de una persona?',
  '["Tiene el pelo rizado", "Es muy simpática", "Sabe cantar", "Es alegre"]'::jsonb,
  '"Tiene el pelo rizado"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'true_false',
  'Un cuento tradicional es una historia antigua que se transmite de abuelos a niños.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Una narración corta de algo gracioso o curioso que nos ha pasado de verdad es una...',
  '["Anécdota", "Fábula", "Encuesta", "Canción"]'::jsonb,
  '"Anécdota"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Hacer preguntas ordenadas a una persona para conocerla o saber su opinión es una...',
  '["Entrevista", "Fábula", "Canción", "Diario"]'::jsonb,
  '"Entrevista"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Un papel doblado que sirve para dar información turística o de un producto es un...',
  '["Folleto", "Diario", "Cuento", "Poema"]'::jsonb,
  '"Folleto"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Una historia corta donde los animales hablan y nos dan una enseñanza o moraleja es una...',
  '["Fábula", "Anécdota", "Entrevista", "Encuesta"]'::jsonb,
  '"Fábula"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Un cuaderno secreto donde escribimos día a día lo que pensamos y hacemos es un...',
  '["Diario", "Folleto", "Cartel", "Fábula"]'::jsonb,
  '"Diario"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  '¿Qué animal tiene una trompa larga y orejas gigantes en ''Mi animal favorito''?',
  '["El elefante", "El león", "El ratón", "El perro"]'::jsonb,
  '"El elefante"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'true_false',
  'En España se hablan diferentes lenguas además del castellano.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Un juego de palabras que cuesta pronunciar rápido y sin equivocarse es un...',
  '["Trabalenguas", "Chiste", "Adivinanza", "Catálogo"]'::jsonb,
  '"Trabalenguas"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Decir ''Por favor'' o ''Gracias'' son ejemplos de...',
  '["Fórmulas de cortesía", "Instrucciones", "Adivinanzas", "Noticias"]'::jsonb,
  '"Fórmulas de cortesía"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Un texto ordenado con los pasos para hacer una receta de cocina son las...',
  '["Instrucciones", "Catálogo", "Noticia", "Invitación"]'::jsonb,
  '"Instrucciones"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Un folleto o librito que muestra fotos y precios de muchos juguetes es un...',
  '["Catálogo", "Invitación", "Diario", "Fábula"]'::jsonb,
  '"Catálogo"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Una tarjeta que envías a tus amigos para que vayan a tu fiesta de cumpleaños es una...',
  '["Invitación", "Noticia", "Instrucción", "Agenda"]'::jsonb,
  '"Invitación"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Un texto del periódico que cuenta algo importante que ha pasado en la ciudad es una...',
  '["Noticia", "Invitación", "Agenda", "Onomatopeya"]'::jsonb,
  '"Noticia"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Un cuaderno donde apuntamos las tareas de cada día para que no se nos olviden es la...',
  '["Agenda", "Noticia", "Invitación", "Trabalenguas"]'::jsonb,
  '"Agenda"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Una frase graciosa que se cuenta para hacer reír a los demás es un...',
  '["Chiste", "Trabalenguas", "Folleto", "Catálogo"]'::jsonb,
  '"Chiste"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'true_false',
  'El castellano o español es la lengua oficial que se habla en toda España.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Una frase misteriosa que te propone un enigma para que adivines un objeto es una...',
  '["Adivinanza", "Chiste", "Trabalenguas", "Noticia"]'::jsonb,
  '"Adivinanza"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Decir ''Buenos días'' al entrar a un sitio es una fórmula de...',
  '["Cortesía", "Instrucción", "Adivinanza", "Encuesta"]'::jsonb,
  '"Cortesía"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'true_false',
  'Las instrucciones nos indican los pasos prohibidos que nunca debemos hacer.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Un texto impreso o digital que nos cuenta las noticias del día es el...',
  '["Periódico", "Catálogo", "Diccionario", "Calendario"]'::jsonb,
  '"Periódico"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Un documento que mandas para invitar a alguien formalmente a una boda es una...',
  '["Invitación", "Noticia", "Instrucción", "Agenda"]'::jsonb,
  '"Invitación"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'El título grande e importante que va arriba del todo en una noticia se llama...',
  '["Titular", "Instrucción", "Bocadillo", "Rima"]'::jsonb,
  '"Titular"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Hablar por un micrófono transmitiendo música y noticias para los oyentes es un...',
  '["Programa de radio", "Catálogo", "Cómic", "Diario"]'::jsonb,
  '"Programa de radio"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Un acertijo es un problema o enigma que sirve para...',
  '["Pensar y descubrir la solución", "Reír a carcajadas", "Escribir una noticia", "Comprar ropa"]'::jsonb,
  '"Pensar y descubrir la solución"'::jsonb,
  1
);

-- Lengua / Lectura y comprensión (11)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b1000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué sílaba se forma al unir la ''m'' con la ''a''?',
  '["ma", "me", "mi", "mo"]'::jsonb,
  '"ma"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es una sílaba inversa?',
  '["ma", "pa", "am", "sa"]'::jsonb,
  '"am"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es una palabra con una sílaba trabada (con dos consonantes seguidas)?',
  '["pelo", "tren", "casa", "mano"]'::jsonb,
  '"tren"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000006',
  'numeric',
  '¿Cuántas sílabas tiene la palabra ''mariposa''?',
  NULL,
  '4'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Qué sílaba se forma al unir la ''p'' con la ''e''?',
  '["pa", "pe", "pi", "po"]'::jsonb,
  '"pe"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál es una sílaba inversa que empieza por vocal?',
  '["sa", "es", "te", "no"]'::jsonb,
  '"es"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000006',
  'multiple_choice',
  '¿Cuál palabra contiene una sílaba trabada?',
  '["plátano", "mesa", "gato", "nube"]'::jsonb,
  '"plátano"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000006',
  'numeric',
  '¿Cuántas sílabas tiene la palabra ''sol''?',
  NULL,
  '1'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000006',
  'true_false',
  'La lectura comprensiva significa entender perfectamente lo que estamos leyendo.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000006',
  'true_false',
  'La lectura mecánica sirve para leer alto con buena entonación y ritmo.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000006',
  'true_false',
  'La entonación adecuada consiste en leer haciendo las pausas de los puntos y comas.',
  NULL,
  'true'::jsonb,
  1
);

-- Lengua / Reflexión sobre la lengua (71)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el nexo que une las palabras ''perro ___ gato''?',
  '["o", "y", "con", "de"]'::jsonb,
  '"y"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuántas vocales existen en español?',
  '["3", "4", "5", "6"]'::jsonb,
  '"5"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letra falta para completar la palabra ''_una'' (objeto del cielo)?',
  '["l", "p", "s", "t"]'::jsonb,
  '"l"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'true_false',
  'La letra ''h'' en español no tiene sonido (es muda).',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra se escribe con ''ch''?',
  '["Sapo", "Chocolate", "Gato", "Perro"]'::jsonb,
  '"Chocolate"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál palabra lleva la letra ''ñ''?',
  '["Niño", "Nube", "Luna", "Sol"]'::jsonb,
  '"Niño"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letra tiene el sonido fuerte en ''perro''?',
  '["r", "rr", "p", "o"]'::jsonb,
  '"rr"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'true_false',
  'Las palabras ''sol'' y ''sal'' empiezan por la misma grafía.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letra usamos para escribir ''queso''?',
  '["c", "q", "k", "g"]'::jsonb,
  '"q"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'numeric',
  '¿Cuántas letras ''s'' hay en la palabra ''sapo''?',
  NULL,
  '1'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'true_false',
  'La grafía ''v'' y la ''b'' suenan muy parecido en español.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué grafía falta en la palabra ''za_ato''?',
  '["p", "m", "t", "b"]'::jsonb,
  '"p"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el nexo en la frase: ''papá ___ mamá''?',
  '["y", "o", "de", "con"]'::jsonb,
  '"y"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál de estas letras no es una vocal?',
  '["a", "e", "t", "o"]'::jsonb,
  '"t"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letra falta para completar la palabra ''_ato'' (animal)?',
  '["g", "h", "k", "x"]'::jsonb,
  '"g"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'true_false',
  'La grafía ''rr'' se utiliza únicamente en mitad de las palabras.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra lleva la grafía ''ll''?',
  '["Llama", "Luna", "Lápiz", "Limón"]'::jsonb,
  '"Llama"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál palabra se escribe correctamente con la grafía ''z''?',
  '["Zapa", "Zapato", "Suela", "Cielo"]'::jsonb,
  '"Zapato"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letra suena suave en la palabra ''pera''?',
  '["p", "r", "e", "a"]'::jsonb,
  '"r"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'true_false',
  'Las palabras ''bota'' y ''vota'' se pronuncian igual pero significan cosas distintas.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letras juntas usamos para escribir la palabra ''co_e'' (vehículo)?',
  '["ch", "ll", "rr", "qu"]'::jsonb,
  '"ch"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'numeric',
  '¿Cuántas letras ''m'' hay en la palabra ''mamá''?',
  NULL,
  '2'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'true_false',
  'La grafía ''q'' siempre va acompañada de la letra ''u'' antes de la vocal.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letra falta en la palabra ''ni_o''?',
  '["ñ", "n", "m", "l"]'::jsonb,
  '"ñ"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué grafía compuesta falta para escribir la palabra ''_anco'' (color)?',
  '["bl", "br", "pl", "pr"]'::jsonb,
  '"bl"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué grafía compuesta falta para escribir la palabra ''_uta'' (platano o manzana)?',
  '["fr", "fl", "tr", "dr"]'::jsonb,
  '"fr"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué conjunto de palabras forman una familia de palabras?',
  '["Pan, panadero, panadería", "Sol, luna, estrella", "Casa, coche, perro", "Lápiz, goma, mesa"]'::jsonb,
  '"Pan, panadero, panadería"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'true_false',
  'Al empezar una frase o escribir un nombre propio siempre usamos letra mayúscula.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué signo ponemos al final de una frase que termina y no es una pregunta?',
  '["Un punto", "Una coma", "Signo de interrogación", "Signo de exclamación"]'::jsonb,
  '"Un punto"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué signos usamos para escribir la frase: ''¿Cómo te llamas?''?',
  '["Signos de interrogación", "Signos de exclamación", "Puntos suspensivos", "Comillas"]'::jsonb,
  '"Signos de interrogación"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué signos usamos cuando expresamos alegría o sorpresa como ''¡Qué bien!''?',
  '["Signos de exclamación", "Signos de interrogación", "Dos puntos", "Punto y coma"]'::jsonb,
  '"Signos de exclamación"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el diminutivo de la palabra ''perro''?',
  '["Perrito", "Perrazo", "Perro", "Perrera"]'::jsonb,
  '"Perrito"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el aumentativo de la palabra ''casa''?',
  '["Casaza", "Casita", "Casucha", "Caserío"]'::jsonb,
  '"Casaza"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de palabra es ''mesa'' o ''sofá''?',
  '["Un nombre (sustantivo)", "Un adjetivo", "Un artículo", "Un verbo"]'::jsonb,
  '"Un nombre (sustantivo)"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de palabra nos dice cómo es un objeto (ej. ''grande'', ''azul'')?',
  '["Un adjetivo", "Un nombre", "Un artículo", "Un nexo"]'::jsonb,
  '"Un adjetivo"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuáles son los artículos que acompañan a los nombres?',
  '["El, la, los, las", "Yo, tú, él", "Y, o, con", "Grande, pequeño"]'::jsonb,
  '"El, la, los, las"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos a las palabras que tienen varios significados como ''banco''?',
  '["Palabras polisémicas", "Sinónimos", "Aumentativos", "Diminutivos"]'::jsonb,
  '"Palabras polisémicas"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra significa lo mismo (es sinónimo) que ''guapo''?',
  '["Hermoso", "Feo", "Grande", "Rápido"]'::jsonb,
  '"Hermoso"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo se llama la imitación de un sonido como ''¡miau!'' o ''¡pum!''?',
  '["Onomatopeya", "Sinónimo", "Diminutivo", "Adjetivo"]'::jsonb,
  '"Onomatopeya"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'numeric',
  '¿Cuántas sílabas tiene la palabra ''plátano''?',
  NULL,
  '3'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra contiene la grafía compuesta ''tr''?',
  '["Tractor", "Plato", "Blusa", "Fresa"]'::jsonb,
  '"Tractor"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letras faltan para escribir correctamente la palabra ''gu_tarra''?',
  '["gui", "gue", "ga", "go"]'::jsonb,
  '"gui"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra lleva los dos puntitos llamados diéresis (gü)?',
  '["Cigüeña", "Gato", "Girasol", "Guiso"]'::jsonb,
  '"Cigüeña"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letra va siempre antes de la ''p'' en palabras como ''ca_po''?',
  '["m", "n", "b", "s"]'::jsonb,
  '"m"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letra va siempre antes de la ''b'' en palabras como ''o_bligo''?',
  '["m", "n", "p", "v"]'::jsonb,
  '"m"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál de estas es una palabra compuesta (hecha de dos palabras)?',
  '["Lavaminitas", "Paraguas", "Gato", "Sol"]'::jsonb,
  '"Paraguas"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el antónimo (lo contrario) de la palabra ''lindo''?',
  '["Feo", "Hermoso", "Bonito", "Grande"]'::jsonb,
  '"Feo"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra rima o concuerda en género y número con ''las mesas''?',
  '["altas", "alto", "bajos", "nueva"]'::jsonb,
  '"altas"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué conjunto de palabras forman el campo semántico de los ''colores''?',
  '["Rojo, verde, azul", "Mesa, silla, sofá", "Lápiz, goma, papel", "Perro, gato, león"]'::jsonb,
  '"Rojo, verde, azul"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de palabra nos dice una acción (ej. ''correr'', ''saltar'')?',
  '["Un verbo", "Un nombre", "Un adjetivo", "Un artículo"]'::jsonb,
  '"Un verbo"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo se llama la lista ordenada de todas las letras desde la A hasta la Z?',
  '["El abecedario", "La agenda", "El catálogo", "La noticia"]'::jsonb,
  '"El abecedario"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué signo usamos en medio de una frase para hacer una pequeña pausa al separar cosas?',
  '["La coma", "El punto", "La exclamación", "La interrogación"]'::jsonb,
  '"La coma"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000005',
  'numeric',
  '¿Cuántas letras tiene el abecedario español (sin contar dígrafos como ch o ll)?',
  NULL,
  '27'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000005',
  'true_false',
  'Los nombres propios como ''María'' o ''Madrid'' se escriben con mayúscula inicial.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el sinónimo (significa lo mismo) de la palabra ''terminar''?',
  '["Acabar", "Empezar", "Jugar", "Correr"]'::jsonb,
  '"Acabar"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra es un verbo?',
  '["Saltar", "Mesa", "Grande", "El"]'::jsonb,
  '"Saltar"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letras faltan para escribir correctamente la palabra ''ma_era'' (fuego)?',
  '["guer", "gari", "gue", "ga"]'::jsonb,
  '"gue"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra se escribe con la sílaba ''gui''?',
  '["Guisante", "Gato", "Goma", "Guerra"]'::jsonb,
  '"Guisante"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letra va siempre antes de la ''p'' en la palabra ''to_ba''?',
  '["m", "n", "r", "s"]'::jsonb,
  '"m"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letra va siempre antes de la ''b'' en la palabra ''bo_ba''?',
  '["m", "n", "p", "l"]'::jsonb,
  '"m"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál de estas es una palabra compuesta hecha por dos palabras juntas?',
  '["Sacamuelas", "Dentista", "Muela", "Limpieza"]'::jsonb,
  '"Sacamuelas"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el antónimo (lo contrario) de la palabra ''cerrar''?',
  '["Abrir", "Terminar", "Guardar", "Romper"]'::jsonb,
  '"Abrir"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra concuerda bien en género y número con ''el perro''?',
  '["bueno", "buena", "buenos", "buenas"]'::jsonb,
  '"bueno"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué conjunto de palabras forman el campo semántico de los ''animales''?',
  '["León, jirafa, oso", "Mesa, silla, cama", "Lunes, martes, mayo", "Lápiz, goma, tiza"]'::jsonb,
  '"León, jirafa, oso"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de palabra es ''escribir'' o ''pintar''?',
  '["Un verbo", "Un nombre", "Un adjetivo", "Un artículo"]'::jsonb,
  '"Un verbo"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es la primera letra de nuestro abecedario?',
  '["La letra A", "La letra B", "La letra Z", "La letra M"]'::jsonb,
  '"La letra A"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es la última letra de nuestro abecedario?',
  '["La letra Z", "La letra A", "La letra Y", "La letra X"]'::jsonb,
  '"La letra Z"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'numeric',
  '¿Cuántas comas hay en la frase ''Compré manzanas, peras y limones''?',
  NULL,
  '1'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'true_false',
  'La primera palabra con la que se empieza a escribir un texto va en mayúscula.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el sinónimo (significa lo mismo) de la palabra ''rápido''?',
  '["Veloz", "Lento", "Grande", "Alto"]'::jsonb,
  '"Veloz"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra es un nombre o sustantivo de persona?',
  '["Médico", "Cantar", "Feliz", "Ellos"]'::jsonb,
  '"Médico"'::jsonb,
  1
);

-- Matemáticas / Datos y dinero (10)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b1000001-0001-4000-8000-000000000004',
  'multiple_choice',
  '¿Cuál es el billete de menor valor en euros de estos tres?',
  '["5 euros", "10 euros", "20 euros", "50 euros"]'::jsonb,
  '"5 euros"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000004',
  'numeric',
  'Si tengo una moneda de 1 euro y otra de 2 euros ¿cuántos euros tengo?',
  NULL,
  '3'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000004',
  'true_false',
  'Un pictograma es un gráfico que utiliza dibujos para mostrar datos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000004',
  'multiple_choice',
  '¿Cómo llamamos al gráfico que usa rectángulos altos para contar datos?',
  '["Gráfico de barras", "Pictograma", "Reloj", "Calendario"]'::jsonb,
  '"Gráfico de barras"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000004',
  'numeric',
  '¿Cuántos céntimos se necesitan para tener una moneda de 10 céntimos?',
  NULL,
  '10'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000004',
  'multiple_choice',
  '¿Cuál es el billete de mayor valor en euros de estos tres?',
  '["20 euros", "10 euros", "5 euros", "2 euros"]'::jsonb,
  '"20 euros"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000004',
  'numeric',
  'Si tengo un billete de 5 euros y otro de 10 euros ¿cuántos euros tengo en total?',
  NULL,
  '15'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000004',
  'true_false',
  'Un gráfico de barras utiliza columnas para que podamos comparar cantidades fácilmente.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Si en un pictograma cada dibujo de un coche vale por 1 coche ¿cuánto valen 4 dibujos?',
  '["4 coches", "1 coche", "2 coches", "40 coches"]'::jsonb,
  '"4 coches"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000004',
  'numeric',
  '¿Cuántas monedas de 1 euro necesito para igualar a un billete de 5 euros?',
  NULL,
  '5'::jsonb,
  2
);

-- Matemáticas / Medida y geometría (32)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cómo es una jirafa comparada con un ratón?',
  '["Alto", "Bajo", "Estrecho", "Corto"]'::jsonb,
  '"Alto"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué objeto suele ser más largo?',
  '["Un lápiz nuevo", "Una goma de borrar", "Un clip", "Un botón"]'::jsonb,
  '"Un lápiz nuevo"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cuál signo usamos si 5 es más que 3?',
  '["Mayor que", "Menor que", "Igual que", "Ninguno"]'::jsonb,
  '"Mayor que"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'true_false',
  'Un elefante pesa menos que una hormiga.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Dónde cabe más agua?',
  '["En una piscina", "En un vaso", "En una cuchara", "En una taza"]'::jsonb,
  '"En una piscina"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'Si el gato está debajo de la mesa, el plato sobre la mesa está...',
  '["Encima", "Debajo", "Lejos", "Dentro"]'::jsonb,
  '"Encima"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cuál de estas es una figura plana?',
  '["Círculo", "Cubo", "Esfera", "Pirámide"]'::jsonb,
  '"Círculo"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'Con la mano que la mayoría escribe y come se llama mano...',
  '["Derecha", "Izquierda", "Abajo", "Arriba"]'::jsonb,
  '"Derecha"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cómo es un lápiz usado comparado con uno nuevo?',
  '["Largo", "Corto", "Ancho", "Alto"]'::jsonb,
  '"Corto"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué objeto suele ser más estrecho?',
  '["Una carretera", "Un pasillo de casa", "Una regla para medir", "Una puerta"]'::jsonb,
  '"Una regla para medir"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cuál signo usamos si 10 es igual a 10?',
  '["Mayor que", "Menor que", "Igual que", "Ninguno"]'::jsonb,
  '"Igual que"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'true_false',
  'Un libro cerrado pesa más que una sola hoja de papel.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Dónde cabe menos líquido?',
  '["En una bañera", "En una botella de agua", "En un dedal", "En un cubo"]'::jsonb,
  '"En un dedal"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'Si tus juguetes están guardados dentro del baúl, la tapa está...',
  '["Encima", "Debajo", "Detrás", "Cerca"]'::jsonb,
  '"Encima"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cuál de estas figuras no tiene esquinas ni lados rectos?',
  '["Cuadrado", "Triángulo", "Círculo", "Rectángulo"]'::jsonb,
  '"Círculo"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'Al mirar un mapa de frente el lado contrario a la derecha es...',
  '["Arriba", "Abajo", "Izquierda", "Delante"]'::jsonb,
  '"Izquierda"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué unidad no convencional usamos si medimos usando la palma de la mano abierta?',
  '["El palmo", "El pie", "El paso", "La regla"]'::jsonb,
  '"El palmo"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué medida usarías para medir el largo del patio dando zancadas ordinarias?',
  '["El paso", "El palmo", "El dedo", "El lápiz"]'::jsonb,
  '"El paso"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'true_false',
  'Si pasamos agua de una botella grande a un vaso pequeño decimos que estamos haciendo un trasvase.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Dónde cabe menos cantidad de zumo?',
  '["En un dedal", "En una jarra", "En una taza", "En un vaso"]'::jsonb,
  '"En un dedal"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cómo se llama la línea recta que va de arriba a abajo bien derecha?',
  '["Vertical", "Horizontal", "Curva", "Espiral"]'::jsonb,
  '"Vertical"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cómo se llama la línea que imita el horizonte del mar en calma?',
  '["Horizontal", "Vertical", "Cruzada", "Inclinada"]'::jsonb,
  '"Horizontal"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos lados rectos tiene un cuadrado?',
  NULL,
  '4'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos lados tiene un triángulo?',
  NULL,
  '3'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué mes va justo después de enero?',
  '["Febrero", "Marzo", "Diciembre", "Mayo"]'::jsonb,
  '"Febrero"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos días tiene una semana completa?',
  NULL,
  '7'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'Si la aguja pequeña está en el 3 y la grande en el 12 ¿qué hora es?',
  '["Las 3 en punto", "Las 3 y media", "Las 12 en punto", "Las 12 y media"]'::jsonb,
  '"Las 3 en punto"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'En un reloj digital si pone 04:30 significa que son...',
  '["Las cuatro y media", "Las cuatro en punto", "Las tres en punto", "Las cinco y media"]'::jsonb,
  '"Las cuatro y media"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué mes va justo antes de diciembre?',
  '["Noviembre", "Enero", "Octubre", "Agosto"]'::jsonb,
  '"Noviembre"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos meses tiene un año completo?',
  NULL,
  '12'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'Si la aguja pequeña está en el 6 y la grande en el 6 ¿qué hora es?',
  '["Las 6 y media", "Las 6 en punto", "Las 12 en punto", "Las 12 y media"]'::jsonb,
  '"Las 6 y media"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'En un reloj digital si marca exactamente 12:00 significa que son...',
  '["Las doce en punto", "Las doce y media", "La una en punto", "Las once y media"]'::jsonb,
  '"Las doce en punto"'::jsonb,
  1
);

-- Matemáticas / Números y cantidades (53)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número sigue en la serie: 1, 2, 3, 4...?',
  NULL,
  '5'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número sigue en la serie: 10, 9, 8, 7...?',
  NULL,
  '6'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  'Si contamos de 2 en 2: 2, 4, 6... ¿cuál viene después?',
  NULL,
  '8'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  'Si contamos hacia atrás de 2 en 2: 10, 8, 6... ¿cuál sigue?',
  NULL,
  '4'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número sigue al 19?',
  NULL,
  '20'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número va justo antes del 15?',
  NULL,
  '14'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  'Si tengo 1 decena de lápices, ¿cuántos lápices tengo?',
  NULL,
  '10'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  'Si tengo 2 decenas de caramelos, ¿cuántos tengo?',
  NULL,
  '20'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 12 es igual al número 21.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 10 es posterior al número 9.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'true_false',
  'Si 4 + 2 = 6, entonces 6 - 2 = 4.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número sigue en la serie: 5, 6, 7, 8...?',
  NULL,
  '9'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número sigue en la serie: 20, 19, 18, 17...?',
  NULL,
  '16'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  'Si contamos de 2 en 2: 12, 14, 16... ¿cuál viene después?',
  NULL,
  '18'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  'Si contamos hacia atrás de 2 en 2: 20, 18, 16... ¿cuál sigue?',
  NULL,
  '14'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número va justo después del 28?',
  NULL,
  '29'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número va justo antes del 10?',
  NULL,
  '9'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  'Si tengo 1 decena y 5 unidades ¿qué número formo?',
  NULL,
  '15'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  'Si tengo 2 decenas y 9 unidades ¿qué número formo?',
  NULL,
  '29'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 25 es menor que el número 15.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 19 es el anterior al número 20.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'true_false',
  'Si restar es quitar, entonces sumar es juntar o añadir.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número sigue en la serie: 5, 10, 15, 20...?',
  NULL,
  '25'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número sigue en la serie: 50, 45, 40, 35...?',
  NULL,
  '30'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  'Si cuentas de 2 en 2: 70, 72, 74... ¿cuál viene después?',
  NULL,
  '76'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número va justo antes del 79 en la tabla numérica?',
  NULL,
  '78'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuántas decenas tiene el número 64?',
  NULL,
  '6'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuántas unidades sueltas tiene el número 53?',
  NULL,
  '3'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  'Si tengo 4 decenas y 7 unidades ¿qué número formo?',
  NULL,
  '47'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  'Si tengo 7 decenas y 0 unidades ¿qué número formo?',
  NULL,
  '70'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 68 es menor que el número 65.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 40 es el posterior al número 39.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué signo falta entre estos números? 72 ___ 79',
  '["Mayor que", "Menor que", "Igual que", "Ninguno"]'::jsonb,
  '"Menor que"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número sigue en la serie: 10, 20, 30, 40...?',
  NULL,
  '50'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número va justo antes del 90 en la tabla numérica?',
  NULL,
  '89'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Cómo se escribe en número ordinal ''el tercero''?',
  '["3º", "3", "2º", "4º"]'::jsonb,
  '"3º"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué posición es el 10º en los números ordinales?',
  '["Décimo", "Primero", "Quinto", "Segundo"]'::jsonb,
  '"Décimo"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuántas decenas tiene el número 95?',
  NULL,
  '9'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuántas unidades tiene el número 87?',
  NULL,
  '7'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  'Si tengo 9 decenas y 9 unidades ¿qué número formo?',
  NULL,
  '99'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 99 es mayor que el número 89.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 76 es el anterior al número 75.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  'Si contamos hacia atrás de 10 en 10: 50, 40, 30... ¿cuál sigue?',
  NULL,
  '20'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número sigue en la serie hacia atrás: 90, 80, 70...?, Greece',
  NULL,
  '60'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número va justo después del 98 en la tabla numérica?',
  NULL,
  '99'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Cómo se escribe en número ordinal ''el primero''?',
  '["1º", "1", "2º", "3º"]'::jsonb,
  '"1º"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿Qué posición es el 5º en los números ordinales?',
  '["Quinto", "Primero", "Décimo", "Cuarto"]'::jsonb,
  '"Quinto"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuántas decenas tiene el número 82?',
  NULL,
  '8'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuántas unidades sueltas tiene el número 91?',
  NULL,
  '1'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  'Si tengo 8 decenas y 5 unidades ¿qué número formo?',
  NULL,
  '85'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 79 es igual al número 97.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 90 es el posterior al número 89.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000001',
  'numeric',
  'Si sumamos de 5 en 5: 75, 80, 85... ¿qué número viene después?',
  NULL,
  '90'::jsonb,
  1
);

-- Matemáticas / Operaciones (130)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 + 3?',
  NULL,
  '8'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 9 - 4?',
  NULL,
  '5'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 12 + 5?',
  NULL,
  '17'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 25 - 3?',
  NULL,
  '22'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'María tiene 4 manzanas y le regalan 3 más. ¿Cuántas tiene ahora?',
  NULL,
  '7'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Carlos tiene 8 canicas y pierde 2. ¿Cuántas le quedan?',
  NULL,
  '6'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 7 + 2?',
  NULL,
  '9'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 8 - 5?',
  NULL,
  '3'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 14 + 3?',
  NULL,
  '17'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 29 - 6?',
  NULL,
  '23'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Lucas tiene 10 cromos y compra 5 más. ¿Cuántos tiene ahora?',
  NULL,
  '15'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Sofía tiene 15 caramelos y reparte 4. ¿Cuántos le quedan?',
  NULL,
  '11'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 32 + 14?',
  NULL,
  '46'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 57 - 23?',
  NULL,
  '34'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es la suma con llevada de 15 + 16?',
  NULL,
  '31'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es la suma de tres números: 3 + 4 + 2?',
  NULL,
  '9'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'En un árbol hay 12 pájaros y llegan 9 más. ¿Cuántos hay en total?',
  NULL,
  '21'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Tenía 45 canicas y regalé 12. ¿Cuántas canicas me quedan ahora?',
  NULL,
  '33'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 45 + 23?',
  NULL,
  '68'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 89 - 34?',
  NULL,
  '55'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es la suma con llevada de 48 + 15?',
  NULL,
  '63'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es la suma de tres sumandos: 5 + 5 + 4?',
  NULL,
  '14'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Tengo 20 cromos y me dan 15 más. ¿Cuántos tengo ahora?',
  NULL,
  '35'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'En una cesta hay 12 manzanas y nos comemos 4. ¿Cuántas quedan?',
  NULL,
  '8'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es la suma en vertical de 54 + 21?',
  NULL,
  '75'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es la resta en vertical de 96 - 42?',
  NULL,
  '54'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es la suma con llevada de 37 + 25?',
  NULL,
  '62'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es la suma de tres sumandos: 6 + 4 + 5?',
  NULL,
  '15'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Tenía 35 euros y gasté 12 en un juguete. ¿Cuántos euros me quedan?',
  NULL,
  '23'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'En un autobús viajan 15 personas y se bajan 5. ¿Cuántas personas quedan dentro?',
  NULL,
  '10'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 + 3?',
  NULL,
  '7'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 + 2?',
  NULL,
  '8'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 + 5?',
  NULL,
  '10'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 7 + 1?',
  NULL,
  '8'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 8 + 0?',
  NULL,
  '8'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 9 + 3?',
  NULL,
  '12'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 - 2?',
  NULL,
  '3'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 8 - 4?',
  NULL,
  '4'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 9 - 6?',
  NULL,
  '3'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 7 - 3?',
  NULL,
  '4'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 10 - 5?',
  NULL,
  '5'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 - 0?',
  NULL,
  '6'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 12 + 4?',
  NULL,
  '16'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 15 + 3?',
  NULL,
  '18'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 11 + 7?',
  NULL,
  '18'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 14 - 2?',
  NULL,
  '12'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 18 - 5?',
  NULL,
  '13'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 19 - 4?',
  NULL,
  '15'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 20 + 5?',
  NULL,
  '25'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 25 - 5?',
  NULL,
  '20'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma vertical sin llevada: 12 + 13',
  NULL,
  '25'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma vertical sin llevada: 21 + 14',
  NULL,
  '35'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma vertical sin llevada: 30 + 15',
  NULL,
  '45'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma vertical sin llevada: 42 + 23',
  NULL,
  '65'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma vertical sin llevada: 54 + 12',
  NULL,
  '66'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma vertical sin llevada: 63 + 11',
  NULL,
  '74'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma vertical sin llevada: 71 + 25',
  NULL,
  '96'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma vertical sin llevada: 10 + 40',
  NULL,
  '50'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma vertical sin llevada: 33 + 33',
  NULL,
  '66'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma vertical sin llevada: 50 + 29',
  NULL,
  '79'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta vertical sin llevada: 25 - 12',
  NULL,
  '13'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta vertical sin llevada: 34 - 21',
  NULL,
  '13'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta vertical sin llevada: 48 - 15',
  NULL,
  '33'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta vertical sin llevada: 59 - 34',
  NULL,
  '25'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta vertical sin llevada: 67 - 23',
  NULL,
  '44'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta vertical sin llevada: 76 - 41',
  NULL,
  '35'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta vertical sin llevada: 85 - 52',
  NULL,
  '33'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta vertical sin llevada: 99 - 14',
  NULL,
  '85'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta vertical sin llevada: 45 - 20',
  NULL,
  '25'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta vertical sin llevada: 78 - 36',
  NULL,
  '42'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada en vertical: 15 + 16',
  NULL,
  '31'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada en vertical: 27 + 14',
  NULL,
  '41'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada en vertical: 38 + 15',
  NULL,
  '53'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada en vertical: 49 + 23',
  NULL,
  '72'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada en vertical: 56 + 18',
  NULL,
  '74'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada en vertical: 64 + 27',
  NULL,
  '91'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada en vertical: 75 + 15',
  NULL,
  '90'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada en vertical: 29 + 13',
  NULL,
  '42'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada en vertical: 47 + 35',
  NULL,
  '82'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada en vertical: 68 + 14',
  NULL,
  '82'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Suma estos tres números: 2 + 3 + 4',
  NULL,
  '9'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Suma estos tres números: 5 + 1 + 3',
  NULL,
  '9'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Suma estos tres números: 4 + 4 + 2',
  NULL,
  '10'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Suma estos tres números: 6 + 2 + 5',
  NULL,
  '13'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Suma estos tres números: 7 + 3 + 1',
  NULL,
  '11'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Suma estos tres números: 1 + 8 + 2',
  NULL,
  '11'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Suma estos tres números: 3 + 3 + 3',
  NULL,
  '9'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Suma estos tres números: 5 + 5 + 5',
  NULL,
  '15'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Suma estos tres números: 9 + 1 + 4',
  NULL,
  '14'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Suma estos tres números: 2 + 7 + 3',
  NULL,
  '12'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Si tienes 12 caramelos y tu hermana te regala 5 ¿cuántos tienes ahora?',
  NULL,
  '17'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'En una cesta había 18 huevos y se han roto 4 ¿cuántos quedan enteros?',
  NULL,
  '14'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Tengo 24 cromos de fútbol y compro un paquete con 5 más ¿cuántos tengo?',
  NULL,
  '29'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Un autobús lleva 35 pasajeros y en la parada se bajan 12 ¿cuántos quedan?',
  NULL,
  '23'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'En un árbol hay 14 pájaros y llegan volando otros 14 ¿cuántos hay en total?',
  NULL,
  '28'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Carlos tenía 47 céntimos y gasta 25 en una goma ¿cuántos céntimos le quedan?',
  NULL,
  '22'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'En mi fiesta de cumpleaños hay 15 globos azules y 16 globos rojos ¿cuántos hay en total?',
  NULL,
  '31'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Lucas plantó 22 semillas y su abuelo plantó otras 35 ¿cuántas plantaron entre los dos?',
  NULL,
  '57'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Una caja tiene 68 tizas y la profesora gasta 15 tizas ¿cuántas tizas quedan?',
  NULL,
  '53'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Tengo 3 lápices en mi estuche 4 en la mochila y 2 sobre la mesa ¿cuántos tengo en total?',
  NULL,
  '9'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Calcula mentalmente: 10 + 10',
  NULL,
  '20'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Calcula mentalmente: 30 - 10',
  NULL,
  '20'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Calcula mentalmente: 50 + 5',
  NULL,
  '55'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Calcula mentalmente: 40 - 1',
  NULL,
  '39'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Calcula mentalmente: 15 + 5',
  NULL,
  '20'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto nos da juntar 40 unidades y 20 unidades más?',
  NULL,
  '60'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto nos queda si a 90 unidades le quitamos 30 unidades?',
  NULL,
  '60'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Si sumamos 13 + 13 ¿cuál es el resultado?',
  NULL,
  '26'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Si restamos 28 - 14 ¿cuál es el resultado?',
  NULL,
  '14'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Tengo 8 canicas pierdo 3 en el recreo y luego gano 2 ¿cuántas tengo al final?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma: 31 + 42',
  NULL,
  '73'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma: 25 + 54',
  NULL,
  '79'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma: 62 + 26',
  NULL,
  '88'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma: 17 + 81',
  NULL,
  '98'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta: 84 - 31',
  NULL,
  '53'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta: 75 - 54',
  NULL,
  '21'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta: 69 - 18',
  NULL,
  '51'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta: 93 - 72',
  NULL,
  '21'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es la suma de 52 y 37?',
  NULL,
  '89'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto nos da restar 86 menos 45?',
  NULL,
  '41'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada: 45 + 17',
  NULL,
  '62'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada: 58 + 24',
  NULL,
  '82'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada: 69 + 15',
  NULL,
  '84'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada: 36 + 26',
  NULL,
  '62'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada: 73 + 19',
  NULL,
  '92'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Si tienes 3 cajas con 10 bombones cada una ¿cuántos bombones tienes en total?',
  NULL,
  '30'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'En una libreta hay 50 hojas limpias y ya he usado 20 ¿cuántas quedan vacías?',
  NULL,
  '30'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'María compró un cuento por 8 euros y un lápiz por 2 euros ¿cuántos euros gastó?',
  NULL,
  '10'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Un pastor tiene 45 ovejas y nacen 15 corderitos nuevos ¿cuántos animales tiene ahora?',
  NULL,
  '60'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000002',
  'numeric',
  'Si a la suma de 5 + 5 le sumas otros 5 ¿cuánto da?',
  NULL,
  '15'::jsonb,
  1
);

-- Natural Science / Animals (43)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b1000001-0001-4000-8000-000000000014',
  'true_false',
  'El ciclo de la vida de los seres humanos incluye nacer, crecer, reproducirse y morir.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'true_false',
  'Los seres humanos nacen directamente siendo adultos.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Qué etapa viene justo después de ser un bebé?',
  '["La infancia (ser niño)", "La vejez", "Ser abuelo", "Morir"]'::jsonb,
  '"La infancia (ser niño)"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Cómo llamamos al lugar natural donde vive un animal o planta y encuentra su comida?',
  '["Hábitat", "Colegio", "Nido", "Parque"]'::jsonb,
  '"Hábitat"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000014',
  'true_false',
  'Los osos polares tienen un pelaje grueso para adaptarse al frío de su hábitat.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'true_false',
  'Los animales se diferencian de las plantas porque los animales pueden desplazarse.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Cómo llamamos a los animales que comen carne de otros animales?',
  '["Carnívoros", "Herbívoros", "Omnívoros", "Plantas"]'::jsonb,
  '"Carnívoros"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Cómo llamamos a los animales que comen tanto plantas como carne?',
  '["Omnívoros", "Carnívoros", "Herbívoros", "Inertes"]'::jsonb,
  '"Omnívoros"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Cómo llamamos a los animales que solo comen hierba, hojas y plantas?',
  '["Herbívoros", "Carnívoros", "Omnívoros", "Rocas"]'::jsonb,
  '"Herbívoros"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Cuál de estos animales es un animal doméstico que puede vivir con personas?',
  '["El perro", "El león", "El tiburón", "El lobo"]'::jsonb,
  '"El perro"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Cuál de estos animales es un animal salvaje que vive libre en la naturaleza?',
  '["El tigre", "El gato", "La vaca", "El hámster"]'::jsonb,
  '"El tigre"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Cómo se clasifican los animales que vuelan y pasan mucho tiempo en el aire?',
  '["Aéreos", "Acuáticos", "Terrestres", "Inertes"]'::jsonb,
  '"Aéreos"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Cómo se clasifican los animales que viven y nadan bajo el agua?',
  '["Acuáticos", "Terrestres", "Aéreos", "Plantas"]'::jsonb,
  '"Acuáticos"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Cómo se clasifican los animales que caminan y corren sobre la tierra?',
  '["Terrestres", "Acuáticos", "Aéreos", "Peces"]'::jsonb,
  '"Terrestres"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Qué tipo de animal es una vaca según su alimentación?',
  '["Herbívoros", "Carnívoros", "Omnívoros", "Cazadores"]'::jsonb,
  '"Herbívoros"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Qué tipo de animal es un león según su alimentación?',
  '["Carnívoros", "Herbívoros", "Omnívoros", "Inertes"]'::jsonb,
  '"Carnívoros"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Qué tipo de animal es el ser humano o el oso que come de todo?',
  '["Omnívoros", "Carnívoros", "Herbívoros", "Verdes"]'::jsonb,
  '"Omnívoros"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'true_false',
  'Un pez es un animal acuático.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'true_false',
  'Un águila es un animal terrestre.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What do we call animals that only eat other animals?',
  '["carnivores", "herbivores", "omnivores", "plants"]'::jsonb,
  '"carnivores"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What do we call animals that only eat plants?',
  '["herbivores", "carnivores", "omnivores", "rocks"]'::jsonb,
  '"herbivores"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What do we call animals that eat both plants and other animals?',
  '["omnivores", "carnivores", "herbivores", "water"]'::jsonb,
  '"omnivores"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What type of food does a carnivore animal need to eat?',
  '["meat", "grass", "leaves", "flowers"]'::jsonb,
  '"meat"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What type of food does a herbivore animal need to eat?',
  '["plants", "meat", "fish", "other animals"]'::jsonb,
  '"plants"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'Where do wild animals like lions and bears live?',
  '["in the wild", "with people", "at school", "in a house"]'::jsonb,
  '"in the wild"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'Where do domestic animals like dogs and cats live?',
  '["with people", "in the wild", "in the jungle", "in the ocean"]'::jsonb,
  '"with people"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'Where do fish and dolphins live?',
  '["in water", "on land", "in the sky", "with people"]'::jsonb,
  '"in water"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'Where do horses and elephants live?',
  '["on land", "in water", "in the air", "in the sea"]'::jsonb,
  '"on land"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'true_false',
  'Animals are non-living things because they cannot talk.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'true_false',
  'Animals need air, food and water to live.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'How do birds and eagles move through the air?',
  '["fly", "swim", "crawl", "hop"]'::jsonb,
  '"fly"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'How do fish and sharks move through the water?',
  '["swim", "fly", "walk", "climb"]'::jsonb,
  '"swim"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'How do snakes move on the ground without legs?',
  '["crawl", "walk", "hop", "fly"]'::jsonb,
  '"crawl"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'How do frogs and kangaroos move on the ground?',
  '["hop", "swim", "crawl", "fly"]'::jsonb,
  '"hop"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'How do monkeys and koalas move up into the trees?',
  '["climb", "swim", "fly", "hop"]'::jsonb,
  '"climb"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What body part do birds have to fly in the air?',
  '["wings", "fins", "scales", "fur"]'::jsonb,
  '"wings"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What covers the body of a bird to keep it warm?',
  '["feathers", "fur", "scales", "skin"]'::jsonb,
  '"feathers"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What covers the body of a horse or a dog?',
  '["fur", "feathers", "scales", "fins"]'::jsonb,
  '"fur"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What covers the body of a fish to protect it in water?',
  '["scales", "fur", "feathers", "hair"]'::jsonb,
  '"scales"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What body part do fish use to swim and steer in water?',
  '["fins", "wings", "beaks", "feathers"]'::jsonb,
  '"fins"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What hard part do birds use to peck and eat food instead of teeth?',
  '["beak", "tail", "fin", "scales"]'::jsonb,
  '"beak"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'true_false',
  'A frog has got scales all over its body.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000014',
  'true_false',
  'An eagle has got feathers on its wings.',
  NULL,
  'true'::jsonb,
  1
);

-- Natural Science / Environment (20)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b1000001-0001-4000-8000-000000000017',
  'true_false',
  'Una roca del campo es un ser vivo porque se mueve si la empujas.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'multiple_choice',
  '¿Cuál de estos elementos es un ser vivo?',
  '["Un pájaro", "Una mesa", "Un coche", "Una piedra"]'::jsonb,
  '"Un pájaro"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'true_false',
  'Las plantas son seres inertes porque no hablan ni caminan.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'multiple_choice',
  '¿Cuál de estos elementos es un ser inerte construido por el ser humano?',
  '["Un lápiz", "Una hormiga", "Un árbol", "Un ratón"]'::jsonb,
  '"Un lápiz"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'multiple_choice',
  '¿Cómo se llama la regla que nos enseña a Reducir Reutilizar y Reciclar?',
  '["La regla de las tres R", "El ciclo de la vida", "Las funciones vitales", "La regla del agua"]'::jsonb,
  '"La regla de las tres R"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'multiple_choice',
  '¿En qué contenedor debemos tirar las botellas de plástico y los envases?',
  '["Contenedor amarillo", "Contenedor azul", "Contenedor verde", "Contenedor gris"]'::jsonb,
  '"Contenedor amarillo"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'multiple_choice',
  '¿En qué contenedor debemos reciclar el papel y las cajas de cartón?',
  '["Contenedor azul", "Contenedor amarillo", "Contenedor verde", "Contenedor orgánico"]'::jsonb,
  '"Contenedor azul"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'multiple_choice',
  '¿En qué contenedor se reciclan los tarros y botellas de vidrio?',
  '["Contenedor verde", "Contenedor azul", "Contenedor amarillo", "Contenedor rojo"]'::jsonb,
  '"Contenedor verde"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'true_false',
  'Reutilizar significa volver a usar una botella de plástico vacía como maceta.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'true_false',
  'Reducir significa intentar usar menos bolsas de plástico cuando compramos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'true_false',
  'Reciclar consiste en transformar la basura vieja en objetos nuevos y útiles.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'true_false',
  'Cuidar el entorno significa mantener limpios los parques y las playas.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'multiple_choice',
  '¿Qué palabra de las tres R significa usar menos cosas para generar menos basura?',
  '["Reducir", "Reutilizar", "Reciclar", "Romper"]'::jsonb,
  '"Reducir"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'multiple_choice',
  '¿Qué palabra de las tres R significa dar un segundo uso a un objeto viejo?',
  '["Reutilizar", "Reducir", "Reciclar", "Recoger"]'::jsonb,
  '"Reutilizar"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'multiple_choice',
  '¿Qué palabra de las tres R significa procesar los materiales para hacer otros nuevos?',
  '["Reciclar", "Reducir", "Reutilizar", "Repetir"]'::jsonb,
  '"Reciclar"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000017',
  'true_false',
  'El plástico tarda muchísimos años en desaparecer de la naturaleza si lo tiramos al suelo.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'true_false',
  'Cerrar el grifo mientras nos cepillamos los dientes ayuda a reducir el gasto de agua.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'true_false',
  'Apagar las luces cuando salimos de una habitación nos ayuda a ahorrar energía.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'true_false',
  'Tirar plásticos al mar daña a los peces y tortugas acuáticas.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000017',
  'true_false',
  'Reciclar papel evita que se tengan que cortar tantos árboles en el bosque.',
  NULL,
  'true'::jsonb,
  1
);

-- Natural Science / Materials (35)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿De qué material suele estar hecho un vaso que se rompe fácilmente al caer?',
  '["Vidrio (cristal)", "Madera", "Metal", "Plástico"]'::jsonb,
  '"Vidrio (cristal)"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Qué propiedad tiene una goma elástica que se estira y vuelve a su forma?',
  '["Elasticidad", "Dureza", "Transparencia", "Fragilidad"]'::jsonb,
  '"Elasticidad"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Qué propiedad tiene un material duro que no se dobla ni se rompe fácil?',
  '["Resistencia", "Fragilidad", "Transparencia", "Flexibilidad"]'::jsonb,
  '"Resistencia"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'true_false',
  'El papel es un material completamente impermeable que no deja pasar el agua.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿De qué material se fabrican los clavos y las llaves para que sean muy resistentes?',
  '["Metal", "Plástico", "Papel", "Plastilina"]'::jsonb,
  '"Metal"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Qué propiedad describe a un cristal a través del cual podemos ver perfectamente?',
  '["Transparente", "Opaco", "Elástico", "Blando"]'::jsonb,
  '"Transparente"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000016',
  'true_false',
  'La madera procede de los troncos de los árboles.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Cuál de estos materiales es blando y podemos modelar con nuestras manos?',
  '["Plastilina", "Hierro", "Piedra", "Madera"]'::jsonb,
  '"Plastilina"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Qué objeto está hecho principalmente de plástico?',
  '["Una botella de agua desechable", "Una mesa de comedor dura", "Un libro escolar", "Una ventana de cristal"]'::jsonb,
  '"Una botella de agua desechable"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Qué material se usa para hacer los folios y cuadernos?',
  '["Papel", "Metal", "Vidrio", "Piedra"]'::jsonb,
  '"Papel"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'true_false',
  'Los metales son materiales que suelen brillar y conducir el calor.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿De qué material flexible y suave suele estar hecha nuestra ropa de vestir?',
  '["Tejido (tela)", "Metal", "Vidrio", "Piedra"]'::jsonb,
  '"Tejido (tela)"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Qué propiedad tiene un objeto de metal que cuesta mucho rayar o romper?',
  '["Dureza", "Fragilidad", "Transparencia", "Elasticidad"]'::jsonb,
  '"Dureza"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Qué propiedad tiene un papel que podemos doblar fácilmente sin romperlo?',
  '["Flexibilidad", "Dureza", "Transparencia", "Fragilidad"]'::jsonb,
  '"Flexibilidad"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'true_false',
  'Un material transparente es aquel que no deja pasar la luz ni ver a través.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿De qué material resistente se construyen los coches y las bicicletas?',
  '["Metal", "Papel", "Plastilina", "Vidrio"]'::jsonb,
  '"Metal"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Qué propiedad describe a una ventana a través de la cual entra el sol?',
  '["Transparente", "Opaca", "Elástica", "Blanda"]'::jsonb,
  '"Transparente"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'true_false',
  'El plástico es un material de origen natural que se extrae de las plantas.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Cuál de estos materiales se rompe en mil pedazos si se golpea contra el suelo?',
  '["El vidrio", "La madera", "El plástico", "El metal"]'::jsonb,
  '"El vidrio"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Qué material se obtiene a partir de la arena derretida a alta temperatura?',
  '["El vidrio", "El plástico", "La madera", "El papel"]'::jsonb,
  '"El vidrio"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Qué material blando usamos en clase para hacer figuritas moldeables?',
  '["La plastilina", "El hierro", "El cristal", "La piedra"]'::jsonb,
  '"La plastilina"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'true_false',
  'Los objetos impermeables son los que no dejan pasar el agua dentro.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'What do we call materials that come directly from nature?',
  '["Natural materials", "Manufactured materials", "Plastic materials", "Glass materials"]'::jsonb,
  '"Natural materials"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'What do we call materials that are made by people using other materials?',
  '["Manufactured materials", "Natural materials", "Wood materials", "Wool materials"]'::jsonb,
  '"Manufactured materials"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'Which of these is a completely NATURAL material?',
  '["wood", "glass", "plastic", "paper"]'::jsonb,
  '"wood"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'Which of these is a MANUFACTURED material made by people?',
  '["plastic", "metal", "wood", "wool"]'::jsonb,
  '"plastic"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'What property describes a material that can bend easily without breaking?',
  '["flexible", "rigid", "hard", "opaque"]'::jsonb,
  '"flexible"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'What property describes a material that is stiff and cannot bend?',
  '["rigid", "flexible", "soft", "transparent"]'::jsonb,
  '"rigid"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'What property describes a window through which you can see clearly?',
  '["transparent", "opaque", "rigid", "soft"]'::jsonb,
  '"transparent"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'What property describes a wooden door through which you cannot see?',
  '["opaque", "transparent", "flexible", "soft"]'::jsonb,
  '"opaque"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'What action changes the shape of a material by making it longer?',
  '["stretch", "bend", "squeeze", "rigid"]'::jsonb,
  '"stretch"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'What action changes the shape of a straw into a curved line?',
  '["bend", "stretch", "squeeze", "opaque"]'::jsonb,
  '"bend"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'What action changes the shape of a soft sponge or balloon by pressing it hard?',
  '["squeeze", "stretch", "bend", "transparent"]'::jsonb,
  '"squeeze"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'true_false',
  'A glass cup is transparent and hard.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000016',
  'true_false',
  'Paper and fabric are completely rigid materials that cannot bend.',
  NULL,
  'false'::jsonb,
  1
);

-- Natural Science / My body and health (73)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Qué órgano usamos para pensar?',
  '["El corazón", "El cerebro", "Los pulmones", "El estómago"]'::jsonb,
  '"El cerebro"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Cuál es la función por la que tenemos hijos?',
  '["Nutrición", "Relación", "Reproducción", "Digestión"]'::jsonb,
  '"Reproducción"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Cuál de las siguientes es una de las tres funciones vitales?',
  '["Nutrición", "Cantar", "Bailar", "Dormir"]'::jsonb,
  '"Nutrición"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Qué sentido usamos para ver los colores?',
  '["La vista", "El oído", "El olfato", "El gusto"]'::jsonb,
  '"La vista"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Qué parte del cuerpo une la cabeza con el tronco?',
  '["El cuello", "El brazo", "La pierna", "El pie"]'::jsonb,
  '"El cuello"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'Los pulmones sirven para bombear la sangre por todo el cuerpo.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Cuál es un hábito saludable para cuidar nuestros dientes?',
  '["Comer caramelos", "Cepillarse los dientes", "No lavarse la boca", "Beber refrescos"]'::jsonb,
  '"Cepillarse los dientes"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'Si un amigo está triste, ¿qué debemos hacer?',
  '["Reírnos", "Respetar su emoción y apoyarle", "Ignorarle", "Enfadarnos"]'::jsonb,
  '"Respetar su emoción y apoyarle"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'Dormir pocas horas es buenísimo para la salud.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Qué órgano se llena de aire cuando respiramos?',
  '["Los pulmones", "El estómago", "El corazón", "Los huesos"]'::jsonb,
  '"Los pulmones"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Con qué parte del cuerpo podemos caminar y correr?',
  '["Los brazos", "Las piernas", "Las manos", "La cabeza"]'::jsonb,
  '"Las piernas"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'Identificar y expresar nuestras propias emociones es un hábito saludable.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Qué función nos permite reaccionar cuando vemos un peligro?',
  '["Nutrición", "Relación", "Reproducción", "Respiración"]'::jsonb,
  '"Relación"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Cuál es una comida saludable para el almuerzo?',
  '["Una manzana", "Una bolsa de patatas", "Un bombón", "Una piruleta"]'::jsonb,
  '"Una manzana"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'Hacer ejercicio físico ayuda a mantener fuertes nuestros músculos y huesos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Qué parte del cuerpo usamos para aplaudir?',
  '["Los pies", "Las orejas", "Las manos", "Los ojos"]'::jsonb,
  '"Las manos"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'Cuando estamos muy contentos, ¿qué emoción sentimos?',
  '["Alegría", "Tristeza", "Miedo", "Enfado"]'::jsonb,
  '"Alegría"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Qué parte del cuerpo protege a nuestro cerebro?',
  '["El cráneo", "Las costillas", "Las manos", "Los pies"]'::jsonb,
  '"El cráneo"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Qué función realizamos al comer alimentos todos los días?',
  '["Nutrición", "Relación", "Reproducción", "Dormir"]'::jsonb,
  '"Nutrición"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Qué función nos permite escuchar cuando nuestra madre nos llama?',
  '["Relación", "Nutrición", "Reproducción", "Respiración"]'::jsonb,
  '"Relación"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Qué sentido usamos para saborear un helado?',
  '["El gusto", "El olfato", "La vista", "El tacto"]'::jsonb,
  '"El gusto"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Cómo se llaman las extremidades superiores del cuerpo?',
  '["Los brazos", "Las piernas", "Los pies", "La cabeza"]'::jsonb,
  '"Los brazos"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'El estómago ayuda a digerir la comida que tomamos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Cuál es un hábito de higiene diario muy importante?',
  '["Ducharse o bañarse", "Jugar con barro", "No peinarse", "Mancharse la ropa"]'::jsonb,
  '"Ducharse o bañarse"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'Si vemos que alguien está enfadado ¿qué debemos hacer?',
  '["Respetar su espacio y hablar con calma", "Gritar más fuerte", "Molestarle", "Ponernos a llorar"]'::jsonb,
  '"Respetar su espacio y hablar con calma"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'Hacer deporte al aire libre es malo para el cuerpo.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Qué cubre y protege todo nuestro cuerpo por fuera?',
  '["La piel", "Los músculos", "Los huesos", "La sangre"]'::jsonb,
  '"La piel"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Con qué parte de la cara podemos oler una flor?',
  '["La nariz", "La boca", "Los ojos", "Las orejas"]'::jsonb,
  '"La nariz"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'Comer frutas y verduras nos ayuda a crecer sanos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Gracias a qué función los seres vivos evitan extinguirse y tienen crías o hijos?',
  '["Reproducción", "Nutrición", "Relación", "Digestión"]'::jsonb,
  '"Reproducción"'::jsonb,
  2
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Cuál de estas bebidas es la más saludable para hidratarse?',
  '["El agua", "El refresco de cola", "El zumo con mucho azúcar", "La batida industrial"]'::jsonb,
  '"El agua"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'Ver las pantallas de la tablet o tele justo antes de dormir ayuda a descansar.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'Cuando algo nos asusta mucho, ¿qué emoción sentimos?',
  '["Miedo", "Alegría", "Tristeza", "Sorpresa"]'::jsonb,
  '"Miedo"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'Los ojos son los órganos del sentido del oído.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Qué sentido nos permite notar si algo está suave o rasposo?',
  '["El tacto", "La vista", "El gusto", "El olfato"]'::jsonb,
  '"El tacto"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'Cruzar la calle mirando a ambos lados es un hábito para proteger nuestra vida.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Qué parte del cuerpo nos permite doblar el brazo?',
  '["El codo", "La rodilla", "El tobillo", "El cuello"]'::jsonb,
  '"El codo"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'La función de relación nos conecta con lo que pasa a nuestro alrededor.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Cómo se llaman las extremidades inferiores del cuerpo?',
  '["Las piernas", "Los brazos", "Las manos", "Los hombros"]'::jsonb,
  '"Las piernas"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What part of your head is hair attached to?',
  '["head", "arm", "leg", "foot"]'::jsonb,
  '"head"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'How many toes have human beings got on each foot?',
  '["five", "two", "ten", "four"]'::jsonb,
  '"five"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What parts of your face are located just above your eyes?',
  '["eyebrows", "fingers", "toes", "arms"]'::jsonb,
  '"eyebrows"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What part inside your mouth do you use to taste food?',
  '["tongue", "nose", "ear", "hair"]'::jsonb,
  '"tongue"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'Which of these parts belongs to your HEAD?',
  '["mouth", "arms", "feet", "hands"]'::jsonb,
  '"mouth"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'Which of these parts belongs to your BODY and not your head?',
  '["fingers", "ears", "tongue", "nose"]'::jsonb,
  '"fingers"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'Human beings have got ten fingers on their hands.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'Our tongue is naturally blue.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'Which of the five senses do you use with your eyes?',
  '["sight", "smell", "hearing", "taste"]'::jsonb,
  '"sight"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'Which of the five senses do you use with your nose?',
  '["smell", "touch", "taste", "hearing"]'::jsonb,
  '"smell"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'Which of the five senses do you use with your tongue?',
  '["taste", "sight", "smell", "touch"]'::jsonb,
  '"taste"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'Which of the five senses do you use with your ears?',
  '["hearing", "sight", "taste", "touch"]'::jsonb,
  '"hearing"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'Which of the five senses do you use with your hands and skin?',
  '["touch", "smell", "hearing", "sight"]'::jsonb,
  '"touch"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'Complete the sentence: ''With my eyes I can ___.''',
  '["see", "hear", "smell", "taste"]'::jsonb,
  '"see"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'Complete the sentence: ''With my ears I can ___.''',
  '["hear", "taste", "see", "smell"]'::jsonb,
  '"hear"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'Complete the sentence: ''With my nose I can ___.''',
  '["smell", "taste", "touch", "see"]'::jsonb,
  '"smell"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'Complete the sentence: ''With my tongue I can ___.''',
  '["taste", "see", "smell", "touch"]'::jsonb,
  '"taste"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'How do you feel if you are crying because you lost a toy?',
  '["sad", "happy", "angry", "worried"]'::jsonb,
  '"sad"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'How do you feel if you are smiling and laughing with friends?',
  '["happy", "sad", "angry", "scared"]'::jsonb,
  '"happy"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'How do you feel if you see a big scary monster in a dream?',
  '["scared", "happy", "angry", "worried"]'::jsonb,
  '"scared"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'How do you feel if someone breaks your favorite pencil?',
  '["angry", "happy", "sad", "scared"]'::jsonb,
  '"angry"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'How do you feel if you are thinking about a difficult test?',
  '["worried", "happy", "sad", "scared"]'::jsonb,
  '"worried"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What healthy habit should you do after eating food?',
  '["Brush your teeth", "Eat candy", "Play video games", "Sleep"]'::jsonb,
  '"Brush your teeth"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What should you do with your hands before eating?',
  '["Wash your hands", "Cover your coughs", "Do yoga", "Run"]'::jsonb,
  '"Wash your hands"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'How many hours should children sleep every night to rest well?',
  '["ten hours", "one hour", "five hours", "twenty hours"]'::jsonb,
  '"ten hours"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What should you do when you cough or sneeze?',
  '["Cover your coughs", "Drink water", "Wash hands", "Do exercise"]'::jsonb,
  '"Cover your coughs"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What is the healthiest drink for your body?',
  '["water", "soda", "juice with sugar", "milkshake"]'::jsonb,
  '"water"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'Vegetables are an unhealthy food.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'Fish and eggs are healthy foods.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'Chocolate and cakes are healthy foods to eat every single hour.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'Brushing your teeth once a week is a very good habit.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'true_false',
  'Having a shower every day helps keep your body clean.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'Which of these is a healthy physical action?',
  '["Do exercise", "Eat chocolate", "Watch TV all day", "Drink soda"]'::jsonb,
  '"Do exercise"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What healthy exercise involves sitting cross-legged and breathing calmly?',
  '["Do yoga", "Run", "Skate", "Play"]'::jsonb,
  '"Do yoga"'::jsonb,
  1
);

-- Natural Science / Plants and care (44)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Cuál de las siguientes es una necesidad básica de las plantas para vivir?',
  '["Agua y luz del sol", "Carne y leche", "Zumo y galletas", "Sombras y juguetes"]'::jsonb,
  '"Agua y luz del sol"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Cómo se llaman las plantas grandes que tienen un tronco duro de madera?',
  '["Árboles", "Arbustos", "Hierbas", "Flores"]'::jsonb,
  '"Árboles"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Cómo llamamos a las plantas más bajas que los árboles con ramas desde el suelo?',
  '["Arbustos", "Árboles", "Hierbas", "Algas"]'::jsonb,
  '"Arbustos"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Cómo se llama la planta fina, blanda y verde que cubre los campos (césped)?',
  '["Hierba", "Árbol", "Arbusto", "Pino"]'::jsonb,
  '"Hierba"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'true_false',
  'Las plantas fabrican su propio alimento gracias a la luz del sol.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'true_false',
  'Arrancar las hojas de las plantas del parque es una forma de cuidarlas.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Qué debemos dar a un perro todos los días para cuidar de él?',
  '["Agua y comida adecuada", "Caramelos y refrescos", "Piedras y juguetes rotos", "Nada"]'::jsonb,
  '"Agua y comida adecuada"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Cuál es una acción correcta para cuidar el medio ambiente del colegio?',
  '["Tirar los papeles a la papelera", "Dejar las luces encendidas", "Gastar mucho papel", "Tirar basura al suelo"]'::jsonb,
  '"Tirar los papeles a la papelera"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'true_false',
  'Los animales de una granja necesitan revisiones del veterinario para estar sanos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'true_false',
  'Las plantas necesitan que les quitemos la luz del sol para crecer mejor.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Qué necesita una planta en su maceta además de tierra y agua?',
  '["Luz del sol", "Caramelos", "Leche", "Sombra total"]'::jsonb,
  '"Luz del sol"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'true_false',
  'Poner agua limpia y fresca a nuestra mascota es parte de su cuidado diario.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Qué les ocurre a las plantas de una maceta si nunca las regamos con agua?',
  '["Se secan y mueren", "Crecen gigantes", "Dan muchas flores", "Se vuelven árboles"]'::jsonb,
  '"Se secan y mueren"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Qué profesional cuida de la salud de los animales cuando se ponen enfermos?',
  '["El veterinario", "El médico", "El bombero", "El profesor"]'::jsonb,
  '"El veterinario"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'true_false',
  'Sacar a pasear a un perro es necesario para que haga ejercicio y esté sano.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'true_false',
  'Quitar las malas hierbas secas ayuda a que las plantas crezcan mejor.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'Which of the following is a living thing?',
  '["A plant", "A robot", "A clock", "A pencil"]'::jsonb,
  '"A plant"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'Which of the following is a non-living thing?',
  '["A toy doll", "A human being", "A rabbit", "A tree"]'::jsonb,
  '"A toy doll"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'true_false',
  'Living things are born, grow, reproduce and die.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'true_false',
  'Non-living things need water and sunlight to live.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What do plants need from the soil to grow strong?',
  '["nutrients", "toys", "candy", "pencils"]'::jsonb,
  '"nutrients"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What do plants need from the sun?',
  '["sunlight", "water", "air", "soil"]'::jsonb,
  '"sunlight"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What do plants need that comes with the wind?',
  '["air", "nutrients", "sunlight", "candy"]'::jsonb,
  '"air"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What type of plant is very green and covers the ground like a carpet?',
  '["grass", "bush", "tree", "flower"]'::jsonb,
  '"grass"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What type of plant is medium-sized and has many low branches?',
  '["bush", "tree", "grass", "seed"]'::jsonb,
  '"bush"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What type of plant is very tall and has a hard wooden trunk?',
  '["tree", "bush", "grass", "flower"]'::jsonb,
  '"tree"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What part of the plant grows under the ground and absorbs water?',
  '["roots", "stem", "leaves", "flowers"]'::jsonb,
  '"roots"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What part of the plant holds it up right and carries water to the leaves?',
  '["stem", "roots", "seed", "flowers"]'::jsonb,
  '"stem"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What green parts of the plant grow out from the stem?',
  '["leaves", "roots", "seed", "trunk"]'::jsonb,
  '"leaves"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What beautiful colored part of the plant helps it reproduce?',
  '["flowers", "roots", "stem", "soil"]'::jsonb,
  '"flowers"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What part of a carrot plant do human beings eat?',
  '["roots", "stems", "leaves", "flowers"]'::jsonb,
  '"roots"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What part of an asparagus plant do human beings eat?',
  '["stems", "roots", "leaves", "flowers"]'::jsonb,
  '"stems"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What part of a lettuce plant do human beings eat?',
  '["leaves", "roots", "stems", "flowers"]'::jsonb,
  '"leaves"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'true_false',
  'All plants have got beautiful red flowers.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What should you do with your trash when you have a picnic in nature?',
  '["Pick up your rubbish", "Throw it on land", "Throw it in water", "Leave it"]'::jsonb,
  '"Pick up your rubbish"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'true_false',
  'It is a good idea to pick or step on the flowers in a park.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'true_false',
  'We should stay far away and not feed wild animals.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What do cars, planes and factories cause in the air?',
  '["air pollution", "water pollution", "soil pollution", "clean air"]'::jsonb,
  '"air pollution"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What do plastic bottles thrown from ships cause in the sea?',
  '["water pollution", "air pollution", "soil pollution", "clean water"]'::jsonb,
  '"water pollution"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What does throwing rubbish on the ground cause?',
  '["soil pollution", "water pollution", "air pollution", "clean soil"]'::jsonb,
  '"soil pollution"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What habit helps use water responsibly when brushing your teeth?',
  '["Turn off the tap", "Play with water", "Take long showers", "Leave tap open"]'::jsonb,
  '"Turn off the tap"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What type of shower helps save water every day?',
  '["short showers", "long showers", "tall showers", "dirty showers"]'::jsonb,
  '"short showers"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What are the three words of the ''3 R'' rule to protect our planet?',
  '["Reduce, Reuse, Recycle", "Run, Read, Rest", "Roots, Stems, Leaves", "Red, Rice, Rock"]'::jsonb,
  '"Reduce, Reuse, Recycle"'::jsonb,
  1
),
(
  'b1000001-0001-4000-8000-000000000015',
  'true_false',
  'Plants can grow very well if the air is clean.',
  NULL,
  'true'::jsonb,
  1
);

COMMIT;

-- Resumen: 737 preguntas · 4 asignaturas · 17 temas
