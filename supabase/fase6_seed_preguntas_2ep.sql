-- =============================================================================
-- Solete — Pack de preguntas 2º de primaria (Excel)
-- =============================================================================
-- NO ejecutar desde el agente: revisa y corre a mano en el SQL Editor de Supabase.
--
-- Sustituye TODAS las asignaturas / temas / preguntas de curso = '2'.
-- No toca el contenido de 1º primaria.
--
-- Origen: preguntas 2ªEP.xlsx (sin la asignatura Ciencias Sociales).
-- English / Natural Science: nombres y temas en inglés.
-- =============================================================================

BEGIN;

DELETE FROM public.asignaturas WHERE curso = '2';

-- Asignaturas 2º
INSERT INTO public.asignaturas (id, nombre, icono, curso) VALUES
  ('a2000001-0001-4000-8000-000000000001', 'Matemáticas', '🔢', '2'),
  ('a2000001-0001-4000-8000-000000000002', 'Lengua', '📖', '2'),
  ('a2000001-0001-4000-8000-000000000003', 'English', '🗣️', '2'),
  ('a2000001-0001-4000-8000-000000000004', 'Natural Science', '🌱', '2');

-- Temas 2º
INSERT INTO public.temas (id, asignatura_id, nombre, orden) VALUES
  ('b2000001-0001-4000-8000-000000000001', 'a2000001-0001-4000-8000-000000000001', 'Números', 1),
  ('b2000001-0001-4000-8000-000000000002', 'a2000001-0001-4000-8000-000000000001', 'Operaciones', 2),
  ('b2000001-0001-4000-8000-000000000003', 'a2000001-0001-4000-8000-000000000001', 'Medida y geometría', 3),
  ('b2000001-0001-4000-8000-000000000004', 'a2000001-0001-4000-8000-000000000001', 'Datos y dinero', 4),
  ('b2000001-0001-4000-8000-000000000005', 'a2000001-0001-4000-8000-000000000002', 'Reflexión sobre la lengua', 1),
  ('b2000001-0001-4000-8000-000000000006', 'a2000001-0001-4000-8000-000000000002', 'Expresión oral y escrita', 2),
  ('b2000001-0001-4000-8000-000000000007', 'a2000001-0001-4000-8000-000000000003', 'Sport and weather', 1),
  ('b2000001-0001-4000-8000-000000000008', 'a2000001-0001-4000-8000-000000000003', 'Animals and our world', 2),
  ('b2000001-0001-4000-8000-000000000009', 'a2000001-0001-4000-8000-000000000003', 'Fun and tropical', 3),
  ('b2000001-0001-4000-8000-000000000010', 'a2000001-0001-4000-8000-000000000003', 'Getting around', 4),
  ('b2000001-0001-4000-8000-000000000011', 'a2000001-0001-4000-8000-000000000003', 'City life', 5),
  ('b2000001-0001-4000-8000-000000000012', 'a2000001-0001-4000-8000-000000000004', 'Animals', 1),
  ('b2000001-0001-4000-8000-000000000013', 'a2000001-0001-4000-8000-000000000004', 'Plants', 2),
  ('b2000001-0001-4000-8000-000000000014', 'a2000001-0001-4000-8000-000000000004', 'Light and sound', 3),
  ('b2000001-0001-4000-8000-000000000015', 'a2000001-0001-4000-8000-000000000004', 'Machines and technology', 4),
  ('b2000001-0001-4000-8000-000000000016', 'a2000001-0001-4000-8000-000000000004', 'Materials and structures', 5);

-- Preguntas

-- English / Animals and our world (71)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What wild animal has got a very long neck to eat leaves from tall trees?',
  '["giraffe", "elephant", "monkey", "lion"]'::jsonb,
  '"giraffe"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What body part does a bird or a fish use to change direction or fly/swim?',
  '["tail", "beak", "fur", "legs"]'::jsonb,
  '"tail"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What is the correct order of adjectives in English?',
  '["size before colour", "colour before size", "noun before size", "verb before colour"]'::jsonb,
  '"size before colour"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Choose the correct description for a big animal with dark eyes:',
  '["big brown eyes", "brown big eyes", "eyes big brown", "brown eyes big"]'::jsonb,
  '"big brown eyes"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Complete the description for an elephant: ''It ___ got big ears.''',
  '["''s", "hasn''t", "is", "are"]'::jsonb,
  '"''s"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Complete the negative sentence for a snake: ''It ___ got legs.''',
  '["hasn''t", "haven''t", "isn''t", "not"]'::jsonb,
  '"hasn''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Complete the question: ''___ it got a long tail?''',
  '["Has", "Have", "Is", "Does"]'::jsonb,
  '"Has"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Answer the question about a monkey: ''Has it got a tail?'' (Positive response)',
  '["Yes, it has", "No, it hasn''t", "Yes, it is", "No, it doesn''t"]'::jsonb,
  '"Yes, it has"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Answer the question about a frog: ''Has it got fur?'' (Negative response)',
  '["No, it hasn''t", "Yes, it has", "No, it isn''t", "Yes, it does"]'::jsonb,
  '"No, it hasn''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What big grey animal has got a long trunk and two tusks?',
  '["elephant", "giraffe", "monkey", "crocodile"]'::jsonb,
  '"elephant"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What body part does a dog or a cat wag when it is happy?',
  '["tail", "beak", "wings", "fins"]'::jsonb,
  '"tail"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What is the correct adjective structure in English for size and colour?',
  '["size before colour", "colour before size", "noun before size", "verb before colour"]'::jsonb,
  '"size before colour"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Choose the correct description for a small bird with yellow feathers:',
  '["small yellow feathers", "yellow small feathers", "feathers small yellow", "small feathers yellow"]'::jsonb,
  '"small yellow feathers"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Complete the description for a bird: ''It ___ got a yellow beak.''',
  '["''s", "hasn''t", "is", "are"]'::jsonb,
  '"''s"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Complete the negative sentence for a frog: ''It ___ got hair or fur.''',
  '["hasn''t", "haven''t", "isn''t", "not"]'::jsonb,
  '"hasn''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Complete the question: ''___ it got sharp teeth?''',
  '["Has", "Have", "Is", "Does"]'::jsonb,
  '"Has"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Answer the question about a giraffe: ''Has it got a long neck?'' (Positive response)',
  '["Yes, it has", "No, it hasn''t", "Yes, it is", "No, it does"]'::jsonb,
  '"Yes, it has"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Answer the question about a snake: ''Has it got arms?'' (Negative response)',
  '["No, it hasn''t", "Yes, it has", "No, it isn''t", "Yes, it does"]'::jsonb,
  '"No, it hasn''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What tropical fruit is brown on the outside and has got white sweet meat inside?',
  '["coconuts", "apples", "bananas", "oranges"]'::jsonb,
  '"coconuts"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What possessive adjective is used for a girl (e.g. ''___ national sport'')?',
  '["Her", "His", "Our", "Their"]'::jsonb,
  '"Her"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What possessive adjective is used for a boy (e.g. ''___ favorite fruit'')?',
  '["His", "Her", "Our", "Their"]'::jsonb,
  '"His"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What possessive adjective means that something belongs to us?',
  '["Our", "Their", "His", "Her"]'::jsonb,
  '"Our"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What do you say when you ask about objects that are close to you?',
  '["What are these?", "What are those?", "What is this?", "What is that?"]'::jsonb,
  '"What are these?"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What do you say when you ask about objects that are far away from you?',
  '["What are those?", "What are these?", "What is that?", "What is this?"]'::jsonb,
  '"What are those?"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Answer the question ''What are those?'' pointing at mangoes:',
  '["They''re mangoes", "This is a mango", "Those is mangoes", "It''s a mango"]'::jsonb,
  '"They''re mangoes"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What sweet tropical fruit is big, green or yellow, and has got a bright yellow meat?',
  '["mangoes", "apples", "coconuts", "pears"]'::jsonb,
  '"mangoes"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What possessive adjective means that something belongs to a group of people (not us)?',
  '["Their", "Our", "His", "Her"]'::jsonb,
  '"Their"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What possessive adjective means that a football belongs to a boy?',
  '["His", "Her", "Our", "Their"]'::jsonb,
  '"His"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What possessive adjective means that a classroom belongs to a girl?',
  '["Her", "His", "Our", "Their"]'::jsonb,
  '"Her"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What wild animal has got a very long neck to eat leaves from tall trees?',
  '["giraffe", "elephant", "monkey", "lion"]'::jsonb,
  '"giraffe"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What big grey animal has got a long trunk and two tusks?',
  '["elephant", "giraffe", "monkey", "crocodile"]'::jsonb,
  '"elephant"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What jungle animal has got a long tail and loves climbing trees?',
  '["monkey", "elephant", "giraffe", "snake"]'::jsonb,
  '"monkey"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What reptile has got sharp teeth and lives in rivers?',
  '["crocodile", "giraffe", "monkey", "bird"]'::jsonb,
  '"crocodile"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What body part does a bird or a fish use to change direction when moving?',
  '["tail", "beak", "fur", "legs"]'::jsonb,
  '"tail"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What body part is the hard mouth of a bird used to peck food?',
  '["beak", "tail", "wings", "fins"]'::jsonb,
  '"beak"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What body part do fish use to swim and steer under water?',
  '["fins", "wings", "beaks", "feathers"]'::jsonb,
  '"fins"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What covers the body of a dog or a cat to keep it warm?',
  '["fur", "feathers", "scales", "beaks"]'::jsonb,
  '"fur"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What is the correct order of adjectives in English?',
  '["size before colour", "colour before size", "noun before size", "verb before colour"]'::jsonb,
  '"size before colour"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Choose the correct description for an elephant''s ears:',
  '["big brown ears", "brown big ears", "ears big brown", "brown ears big"]'::jsonb,
  '"big brown ears"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Choose the correct description for a small yellow bird:',
  '["small yellow bird", "yellow small bird", "bird small yellow", "small bird yellow"]'::jsonb,
  '"small yellow bird"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Complete the description for a monkey: ''It ___ got a long tail.''',
  '["''s", "hasn''t", "is", "are"]'::jsonb,
  '"''s"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Complete the negative sentence for a snake: ''It ___ got legs.''',
  '["hasn''t", "haven''t", "isn''t", "not"]'::jsonb,
  '"hasn''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Complete the question: ''___ it got sharp teeth?''',
  '["Has", "Have", "Is", "Does"]'::jsonb,
  '"Has"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Answer the question about a giraffe: ''Has it got a long neck?'' (Positive response)',
  '["Yes, it has", "No, it hasn''t", "Yes, it is", "No, it does"]'::jsonb,
  '"Yes, it has"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Answer the question about a frog: ''Has it got fur?'' (Negative response)',
  '["No, it hasn''t", "Yes, it has", "No, it isn''t", "Yes, it does"]'::jsonb,
  '"No, it hasn''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'true_false',
  'In English description rules ''size before colour'' means we say ''big green eyes''.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'true_false',
  '''It''s got'' is the short form of ''It has got''.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Which country is famous for its ancient pyramids like Chichen Itza?',
  '["Mexico", "Spain", "The UK", "China"]'::jsonb,
  '"Mexico"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Which country has got the Taj Mahal monument?',
  '["India", "Brazil", "Canada", "Poland"]'::jsonb,
  '"India"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Which cold North American country is home to polar bears?',
  '["Canada", "Mexico", "Spain", "India"]'::jsonb,
  '"Canada"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'In which European country do people live in Madrid or Barcelona?',
  '["Spain", "Brazil", "The UK", "China"]'::jsonb,
  '"Spain"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Which South American country is famous for the Amazon rainforest and toucans?',
  '["Brazil", "Canada", "Poland", "New Zealand"]'::jsonb,
  '"Brazil"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Which big island country is famous for rugby and kiwi birds?',
  '["New Zealand", "The USA", "The UK", "China"]'::jsonb,
  '"New Zealand"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Which country is famous for baseball and the Statue of Liberty?',
  '["the USA", "Poland", "India", "Brazil"]'::jsonb,
  '"the USA"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Which Asian country has got the Great Wall?',
  '["China", "The UK", "Canada", "Mexico"]'::jsonb,
  '"China"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Which country has got the famous red telephone boxes in London?',
  '["The UK", "Spain", "Brazil", "Poland"]'::jsonb,
  '"The UK"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What tropical fruit is small, fuzzy brown outside and green inside?',
  '["kiwis", "mangoes", "watermelons", "limes"]'::jsonb,
  '"kiwis"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What tropical fruit is very big, green outside and red inside with seeds?',
  '["watermelons", "coconuts", "pineapples", "limes"]'::jsonb,
  '"watermelons"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What tropical fruit is yellow, rough outside and very sweet inside?',
  '["pineapples", "mangoes", "kiwis", "coconuts"]'::jsonb,
  '"pineapples"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What tropical fruit is brown, hard outside and white inside?',
  '["coconuts", "limes", "mangoes", "watermelons"]'::jsonb,
  '"coconuts"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What small green citrus fruit is very sour?',
  '["limes", "mangoes", "kiwis", "pineapples"]'::jsonb,
  '"limes"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What possessive adjective is used for a girl (e.g. ''It is ___ dog'')?',
  '["her", "his", "our", "their"]'::jsonb,
  '"her"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What possessive adjective is used for a boy (e.g. ''It is ___ dog'')?',
  '["his", "her", "our", "their"]'::jsonb,
  '"his"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What possessive adjective means that something belongs to us?',
  '["our", "their", "his", "her"]'::jsonb,
  '"our"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What possessive adjective means that something belongs to a group of people?',
  '["their", "our", "his", "her"]'::jsonb,
  '"their"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What do you say when you ask about plural objects that are close to you?',
  '["What are these?", "What are those?", "What is this?", "What is that?"]'::jsonb,
  '"What are these?"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'What do you say when you ask about plural objects that are far away from you?',
  '["What are those?", "What are these?", "What is that?", "What is this?"]'::jsonb,
  '"What are those?"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Answer the question ''What are these?'' pointing at close coconuts:',
  '["They are coconuts.", "Those are coconuts.", "This is a coconut.", "It''s a coconut."]'::jsonb,
  '"They are coconuts."'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'multiple_choice',
  'Answer the question ''What are those?'' pointing at far mangoes:',
  '["They are mangoes.", "These are mangoes.", "That is a mango.", "It is a mango."]'::jsonb,
  '"They are mangoes."'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'true_false',
  'We use ''his'' for a boy and ''her'' for a girl to show possession.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000008',
  'true_false',
  '''These'' is used for far objects and ''those'' is used for close objects.',
  NULL,
  'false'::jsonb,
  1
);

-- English / City life (37)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Where do you go in the city centre if you need to save or take out your money?',
  '["bank", "hospital", "market", "park"]'::jsonb,
  '"bank"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Where do you go in the city if you are sick and need a doctor?',
  '["hospital", "bank", "market", "cinema"]'::jsonb,
  '"hospital"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Complete the past sentence for a boy: ''He ___ at the hospital yesterday.''',
  '["was", "were", "is", "are"]'::jsonb,
  '"was"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Complete the negative past sentence: ''She ___ at the bank last night.''',
  '["wasn''t", "weren''t", "isn''t", "not"]'::jsonb,
  '"wasn''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Complete the question about past location: ''Where ___ you yesterday?''',
  '["were", "was", "are", "did"]'::jsonb,
  '"were"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Answer the question ''Where was Uncle Drew yesterday?'' point to the bank:',
  '["He was at the bank", "I was at the bank", "He is at the bank", "She was at the bank"]'::jsonb,
  '"He was at the bank"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Where do you go in the city centre if you want to buy fresh fruits and vegetables?',
  '["market", "bank", "hospital", "cinema"]'::jsonb,
  '"market"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Where was she yesterday if she was visiting a family member at the doctor''s building?',
  '["She was at the hospital", "She was at the bank", "She was at the market", "She was at the park"]'::jsonb,
  '"She was at the hospital"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Complete the past sentence: ''I ___ at the market last weekend.''',
  '["was", "were", "is", "am"]'::jsonb,
  '"was"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Complete the negative past sentence: ''He ___ at the bank last night.''',
  '["wasn''t", "weren''t", "isn''t", "not"]'::jsonb,
  '"wasn''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Complete the question: ''Where ___ Uncle Drew last weekend?''',
  '["was", "were", "is", "did"]'::jsonb,
  '"was"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Answer the question ''Where were you yesterday?'' pointing to the market:',
  '["I was at the market", "He was at the market", "You were at the market", "We were at the bank"]'::jsonb,
  '"I was at the market"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Where do you go if you are sick and need a doctor?',
  '["hospital", "bank", "library", "car park"]'::jsonb,
  '"hospital"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Where do you go to borrow storybooks and read quietly?',
  '["library", "supermarket", "bus station", "cinema"]'::jsonb,
  '"library"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Where do you park your family car in the town?',
  '["car park", "market", "train station", "hospital"]'::jsonb,
  '"car park"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Where do you go to buy food and fresh vegetables outdoors?',
  '["market", "library", "shopping centre", "bank"]'::jsonb,
  '"market"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Where do you go to save or take out your money?',
  '["bank", "hospital", "bus station", "café"]'::jsonb,
  '"bank"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Where do you go to catch a big bus to another town?',
  '["bus station", "train station", "car park", "restaurant"]'::jsonb,
  '"bus station"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Where do you go to catch a fast train on tracks?',
  '["train station", "bus station", "shopping centre", "market"]'::jsonb,
  '"train station"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Where do you find many shops inside one single big building?',
  '["shopping centre", "library", "bank", "hospital"]'::jsonb,
  '"shopping centre"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Where do you go to buy your daily food at the big indoor shop?',
  '["supermarket", "car park", "bus station", "train station"]'::jsonb,
  '"supermarket"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Complete the sentence: ''Yesterday I ___ at the market.''',
  '["was", "were", "is", "am"]'::jsonb,
  '"was"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Complete the negative sentence: ''Yesterday I ___ at the bank.''',
  '["wasn''t", "weren''t", "isn''t", "not"]'::jsonb,
  '"wasn''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Complete the sentence for a boy: ''He ___ at the hospital yesterday.''',
  '["was", "were", "is", "are"]'::jsonb,
  '"was"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Complete the negative sentence: ''He ___ at the shopping centre.''',
  '["wasn''t", "weren''t", "isn''t", "not"]'::jsonb,
  '"wasn''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Complete the question: ''Where ___ you yesterday?''',
  '["were", "was", "are", "did"]'::jsonb,
  '"were"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Complete the past question: ''Where ___ your uncle yesterday?''',
  '["was", "were", "is", "does"]'::jsonb,
  '"was"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'How do you answer: ''Where were you yesterday?'' (At the market)',
  '["I was at the market.", "He was at the market.", "I am at the market.", "You were at the market."]'::jsonb,
  '"I was at the market."'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'How do you answer: ''Where was your uncle yesterday?'' (At the bank)',
  '["He was at the bank.", "I was at the bank.", "She was at the bank.", "He is at the bank."]'::jsonb,
  '"He was at the bank."'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Which word means the family member who is your father''s brother?',
  '["uncle", "aunt", "cousins", "dad"]'::jsonb,
  '"uncle"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Which word means the family member who is your mother''s sister?',
  '["aunt", "uncle", "mum", "cousins"]'::jsonb,
  '"aunt"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'Which word means the children of your aunt and uncle?',
  '["cousins", "brother", "sister", "me"]'::jsonb,
  '"cousins"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'What do you say if you talk about the Saturday and Sunday that just passed?',
  '["last weekend", "yesterday", "last night", "today"]'::jsonb,
  '"last weekend"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'multiple_choice',
  'What do you say if you talk about the darkness or sleeping time of the day before?',
  '["last night", "yesterday", "last weekend", "today"]'::jsonb,
  '"last night"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000011',
  'true_false',
  'In the past tense we use ''I was'' and ''He was''.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'true_false',
  '''Yesterday I wasn''t'' means that I went to that place.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000011',
  'true_false',
  'A hospital is a place where you go to catch a train.',
  NULL,
  'false'::jsonb,
  1
);

-- English / Fun and tropical (70)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What place do you visit to watch films and eat popcorn?',
  '["cinema", "park", "school", "zoo"]'::jsonb,
  '"cinema"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the sentence in 3rd person: ''He ___ to the park on Saturdays.''',
  '["goes", "go", "going", "went"]'::jsonb,
  '"goes"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the sentence: ''She ___ basketball on Tuesdays.''',
  '["plays", "play", "playing", "played"]'::jsonb,
  '"plays"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the negative sentence in 3rd person: ''He ___ like scary films.''',
  '["doesn''t", "don''t", "not", "no"]'::jsonb,
  '"doesn''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What fun place has got animals from all over the world to visit?',
  '["zoo", "cinema", "park", "school"]'::jsonb,
  '"zoo"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the sentence: ''She ___ fun activities on Sundays.''',
  '["does", "do", "doing", "did"]'::jsonb,
  '"does"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the sentence: ''He ___ to the cinema on Fridays.''',
  '["goes", "go", "going", "went"]'::jsonb,
  '"goes"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the negative sentence in 3rd person: ''She ___ play video games.''',
  '["doesn''t", "don''t", "not", "no"]'::jsonb,
  '"doesn''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'true_false',
  'In the present simple 3rd person (he/she/it), we usually add an ''-s'' or ''-es'' to the verb.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'true_false',
  'We use commas to separate items in a list in English sentences.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What are you doing when you look for pretty seashells on the beach?',
  '["We''re collecting shells", "We''re swimming", "We''re flying a kite", "We''re sleeping"]'::jsonb,
  '"We''re collecting shells"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the sentence for some objects: ''There are ___ insects in the jungle.''',
  '["some", "any", "is", "not"]'::jsonb,
  '"some"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the negative sentence: ''There aren''t ___ sandals on the sand.''',
  '["any", "some", "a", "an"]'::jsonb,
  '"any"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the question: ''___ you drawing in the sand?''',
  '["Are", "Is", "Do", "Does"]'::jsonb,
  '"Are"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Answer the question: ''Are you swimming in the sea?'' (Positive response)',
  '["Yes, we are", "No, we aren''t", "Yes, I am", "No, I''m not"]'::jsonb,
  '"Yes, we are"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Answer the question: ''Are you collecting shells?'' (Negative response)',
  '["No, we aren''t", "Yes, we are", "No, he isn''t", "Yes, it is"]'::jsonb,
  '"No, we aren''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What word connects two different or opposite ideas like ''I like the beach, ___ I don''t like the sun''?, Greece',
  '["but", "and", "or", "because"]'::jsonb,
  '"but"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000009',
  'true_false',
  'We use ''and'' to connect two list items or similar ideas in a sentence.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What are you doing when you look for hidden animals among the trees in the jungle?',
  '["We''re looking for insects", "We''re collecting shells", "We''re swimming", "We''re driving a car"]'::jsonb,
  '"We''re looking for insects"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the sentence: ''There are ___ beautiful shells on the beach sand.''',
  '["some", "any", "is", "aren''t"]'::jsonb,
  '"some"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the negative sentence: ''There aren''t ___ spiders in our tent.''',
  '["any", "some", "a", "an"]'::jsonb,
  '"any"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the question: ''___ you collecting shells on the beach right now?''',
  '["Are", "Is", "Do", "Does"]'::jsonb,
  '"Are"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Answer the question: ''Are you drawing in the sand?'' (Positive response)',
  '["Yes, we are", "No, we aren''t", "Yes, I am", "No, I''m not"]'::jsonb,
  '"Yes, we are"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Answer the question: ''Are you looking for insects?'' (Negative response)',
  '["No, we aren''t", "Yes, we are", "No, he isn''t", "Yes, she is"]'::jsonb,
  '"No, we aren''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What word connects two matching ideas like ''I like swimming, ___ I like collecting shells''?, Greece',
  '["and", "but", "or", "because"]'::jsonb,
  '"and"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000009',
  'true_false',
  'We use the word ''but'' to link two contrasting or opposite elements in a sentence.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What wild animal is very big, dark, and lives in the tropical jungle?',
  '["gorilla", "insect", "fish", "duck"]'::jsonb,
  '"gorilla"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What do we call a small little creature like an ant or a beetle?',
  '["insect", "gorilla", "plant", "leaf"]'::jsonb,
  '"insect"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What green element grows on the branches of plants and trees?',
  '["leaf / leaves", "sandals", "cap", "waves"]'::jsonb,
  '"leaf / leaves"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What do you wear on your feet to walk on the hot beach sand?',
  '["sandals", "cap", "leaves", "plant"]'::jsonb,
  '"sandals"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What item do you wear on your head to protect your eyes from the sun?',
  '["cap", "sandals", "ice lolly", "waves"]'::jsonb,
  '"cap"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What do we call the moving water lines that crash on the shore?',
  '["waves", "sand", "beach", "jungle"]'::jsonb,
  '"waves"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What cold sweet food do you eat on the beach when it is hot?',
  '["ice lolly / lollies", "sandals", "cap", "leaves"]'::jsonb,
  '"ice lolly / lollies"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the sentence for positive items: ''There are ___ insects.''',
  '["some", "any", "is", "not"]'::jsonb,
  '"some"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the negative sentence: ''There aren''t ___ insects.''',
  '["any", "some", "are", "no"]'::jsonb,
  '"any"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What beach activity means gathering pretty shells from the sand?',
  '["collect shells", "draw in the sand", "play volleyball", "look for fish"]'::jsonb,
  '"collect shells"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What beach activity means using your finger to make a picture in the sand?',
  '["draw in the sand", "make a sandcastle", "swim in the sea", "collect shells"]'::jsonb,
  '"draw in the sand"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What beach activity means playing a sport with a net and a ball?',
  '["play volleyball", "swim in the sea", "look for fish", "make a sandcastle"]'::jsonb,
  '"play volleyball"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What beach activity means building a small house out of wet sand?',
  '["make a sandcastle", "draw in the sand", "collect shells", "swim in the sea"]'::jsonb,
  '"make a sandcastle"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What beach activity means moving through the salt water with your body?',
  '["swim in the sea", "look for fish", "play volleyball", "draw in the sand"]'::jsonb,
  '"swim in the sea"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What beach activity means using a net to find small animals in the water?',
  '["look for fish", "swim in the sea", "collect shells", "make a sandcastle"]'::jsonb,
  '"look for fish"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the question: ''What ___ you doing?''',
  '["are", "is", "am", "do"]'::jsonb,
  '"are"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the answer: ''We''re ___ in the sea.''',
  '["swimming", "swim", "swims", "swammed"]'::jsonb,
  '"swimming"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the beach question: ''___ you collecting shells?''',
  '["Are", "Is", "Do", "Does"]'::jsonb,
  '"Are"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'How do you answer: ''Are you collecting shells?'' (Positive response)',
  '["Yes, we are", "No, we aren''t", "Yes, I am", "No, I don''t"]'::jsonb,
  '"Yes, we are"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'How do you answer: ''Are you drawing in the sand?'' (Negative response)',
  '["No, we aren''t", "Yes, we are", "No, he isn''t", "Yes, it is"]'::jsonb,
  '"No, we aren''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What word joins two similar ideas together?',
  '["and", "but", "or", "because"]'::jsonb,
  '"and"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What word joins two opposite or different ideas together?',
  '["but", "and", "or", "so"]'::jsonb,
  '"but"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'true_false',
  'We use ''some'' in negative sentences and ''any'' in positive sentences.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'true_false',
  'Gorillas naturally live in the tropical jungle ecosystem.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What place in town do you visit to have a warm drink or a snack?',
  '["café", "cinema", "sports centre", "mountain"]'::jsonb,
  '"café"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What place in town do you visit to have lunch or dinner at tables?',
  '["restaurant", "swimming pool", "lake", "forest"]'::jsonb,
  '"restaurant"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What place in town do you go to watch a movie on a big screen?',
  '["cinema", "café", "sports centre", "river"]'::jsonb,
  '"cinema"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What place in town do you visit to play sports like indoor tennis?',
  '["sports centre", "restaurant", "mountain", "lake"]'::jsonb,
  '"sports centre"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What place has got a big hole with water to dive and swim in town?',
  '["swimming pool", "cinema", "café", "countryside"]'::jsonb,
  '"swimming pool"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What action means taking your puppy for a walk on a leash?',
  '["walk the dog", "read a comic", "do a puzzle", "climb a tree"]'::jsonb,
  '"walk the dog"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What action means looking at a book with stories and drawings?',
  '["read a comic", "play a board game", "go to the playground", "do a puzzle"]'::jsonb,
  '"read a comic"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What action means fitting small cardboard pieces together to make a picture?',
  '["do a puzzle", "walk the dog", "climb a tree", "play a board game"]'::jsonb,
  '"do a puzzle"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What action means playing with dice and tokens on a table (ej. chess)?',
  '["play a board game", "read a comic", "go to the playground", "walk the dog"]'::jsonb,
  '"play a board game"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What action means going to the outdoor park zone with swings and slides?',
  '["go to the playground", "do a puzzle", "climb a tree", "read a comic"]'::jsonb,
  '"go to the playground"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'What action means using your hands and feet to go up a wooden trunk?',
  '["climb a tree", "walk the dog", "play a board game", "do a puzzle"]'::jsonb,
  '"climb a tree"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete for a 3rd person singular sentence: ''He ___ to the cinema.''',
  '["goes", "go", "going", "went"]'::jsonb,
  '"goes"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the sentence: ''She ___ a board game at home.''',
  '["plays", "play", "playing", "played"]'::jsonb,
  '"plays"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the negative sentence: ''He ___ play board games.''',
  '["doesn''t", "don''t", "not", "no"]'::jsonb,
  '"doesn''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Complete the 3rd person question: ''___ he walk the dog?''',
  '["Does", "Do", "Is", "Are"]'::jsonb,
  '"Does"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Answer the question: ''Does he do a puzzle?'' (Positive response)',
  '["Yes, he does", "No, he doesn''t", "Yes, he do", "No, he don''t"]'::jsonb,
  '"Yes, he does"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'multiple_choice',
  'Answer the question: ''Does she climb a tree?'' (Negative response)',
  '["No, she doesn''t", "Yes, she does", "No, she don''t", "Yes, she do"]'::jsonb,
  '"No, she doesn''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'true_false',
  'In the present simple for ''he, she, it'' we add an ''-s'' or ''-es'' to the verb.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'true_false',
  '''He doesn''t play'' is the correct negative form for a boy.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000009',
  'true_false',
  'A cinema is a place where we eat pasta and salad.',
  NULL,
  'false'::jsonb,
  1
);

-- English / Getting around (72)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What transport moves on tracks and carries many people between cities?',
  '["train", "car", "bike", "boat"]'::jsonb,
  '"train"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What is she doing if she is controlling a car with a steering wheel?',
  '["She''s driving", "She''s riding", "She''s flying", "She''s walking"]'::jsonb,
  '"She''s driving"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Complete the question: ''___ she riding a bike?''',
  '["Is", "Are", "Does", "Do"]'::jsonb,
  '"Is"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Answer the question: ''Is she driving a bus?'' (Negative response)',
  '["No, she isn''t", "Yes, she is", "No, he isn''t", "Yes, I am"]'::jsonb,
  '"No, she isn''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'true_false',
  'Vial education teaches us to cross the street safely at the zebra crossing.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What question do you ask to know the owner of a singular object (e.g. a schoolbag)?',
  '["Whose bag is this?", "Whose glasses are these?", "What is this?", "Where is the bag?"]'::jsonb,
  '"Whose bag is this?"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What question do you ask to know the owners of plural objects (e.g. glasses)?',
  '["Whose glasses are these?", "Whose bag is this?", "What are those?", "Where are the glasses?"]'::jsonb,
  '"Whose glasses are these?"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What possessive pronoun means that an object belongs to me?',
  '["mine", "yours", "his", "hers"]'::jsonb,
  '"mine"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What possessive pronoun means that a toy belongs to a girl?',
  '["hers", "his", "mine", "yours"]'::jsonb,
  '"hers"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What possessive pronoun means that a ball belongs to a boy?',
  '["his", "hers", "yours", "theirs"]'::jsonb,
  '"his"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Using the Saxon genitive: How do you say ''la casa de Mery'' in English?',
  '["Mery''s house", "The house of Mery", "Mery house", "House Mery''s"]'::jsonb,
  '"Mery''s house"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What question do you ask to find the owner of these sunglasses?',
  '["Whose glasses are these?", "Whose bag is this?", "What is that?", "Where is the beach?"]'::jsonb,
  '"Whose glasses are these?"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What question do you ask to find the owner of this keys?',
  '["Whose keys are these?", "Whose bag is this?", "What is this?", "Where are the keys?"]'::jsonb,
  '"Whose keys are these?"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What possessive pronoun means that an object belongs to you?',
  '["yours", "mine", "his", "hers"]'::jsonb,
  '"yours"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What possessive pronoun means that an object belongs to them?',
  '["theirs", "ours", "yours", "mine"]'::jsonb,
  '"theirs"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What possessive pronoun means that a house belongs to us?',
  '["ours", "theirs", "yours", "his"]'::jsonb,
  '"ours"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Using the Saxon genitive: How do you answer if the house belongs to Emma?',
  '["It''s Emma''s house", "It''s house Emma", "It''s the house of Emma", "It''s Emmas house"]'::jsonb,
  '"It''s Emma''s house"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What object do you wear on your wrist to see what time it is?',
  '["watch", "mirror", "headphones", "glasses"]'::jsonb,
  '"watch"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What object do you look at to see your own face?',
  '["mirror", "picture", "mat", "bag"]'::jsonb,
  '"mirror"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What object do you put over your ears to listen to music?',
  '["headphones", "glasses", "watch", "phone"]'::jsonb,
  '"headphones"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What object do you use to call your mum or play mobile games?',
  '["phone", "tablet", "camera", "mirror"]'::jsonb,
  '"phone"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What object do you wear over your eyes to see better?',
  '["glasses", "headphones", "watch", "mat"]'::jsonb,
  '"glasses"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What object is a flat piece of fabric on the floor to step on?',
  '["mat", "picture", "bag", "tablet"]'::jsonb,
  '"mat"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What object has got a frame and you hang it on the wall to look at a drawing?',
  '["picture", "mirror", "camera", "watch"]'::jsonb,
  '"picture"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What object do you use to carry your schoolbooks on your back?',
  '["bag", "tablet", "camera", "mat"]'::jsonb,
  '"bag"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What big screen object do you use to watch videos or play games?',
  '["tablet", "phone", "watch", "mirror"]'::jsonb,
  '"tablet"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What object do you use to take a photo of your friends?',
  '["camera", "phone", "picture", "headphones"]'::jsonb,
  '"camera"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What question do you ask to know the owner of a singular watch?',
  '["Whose watch is this?", "Whose glasses are these?", "What is this?", "Where is the watch?"]'::jsonb,
  '"Whose watch is this?"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What question do you ask to know the owner of plural glasses?',
  '["Whose glasses are these?", "Whose watch is this?", "What are those?", "Where are the glasses?"]'::jsonb,
  '"Whose glasses are these?"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What pronoun means that the book belongs to me?',
  '["It''s mine", "It''s yours", "It''s hers", "It''s his"]'::jsonb,
  '"It''s mine"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What pronoun means that the book belongs to you (the person I talk to)?',
  '["It''s yours", "It''s mine", "It''s his", "It''s ours"]'::jsonb,
  '"It''s yours"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What pronoun means that the book belongs to a girl?',
  '["It''s hers", "It''s his", "It''s mine", "It''s theirs"]'::jsonb,
  '"It''s hers"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What pronoun means that the book belongs to a boy?',
  '["It''s his", "It''s hers", "It''s ours", "It''s yours"]'::jsonb,
  '"It''s his"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What pronoun means that the book belongs to us?',
  '["It''s ours", "It''s theirs", "It''s mine", "It''s yours"]'::jsonb,
  '"It''s ours"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What pronoun means that the book belongs to them?',
  '["It''s theirs", "It''s ours", "It''s his", "It''s hers"]'::jsonb,
  '"It''s theirs"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Complete the sentence for a singular item: ''Whose watch is this? ___ mine.''',
  '["It''s", "They''re", "Are", "Is"]'::jsonb,
  '"It''s"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Complete the sentence for plural items: ''Whose glasses are these? ___ hers.''',
  '["They''re", "It''s", "Is", "Am"]'::jsonb,
  '"They''re"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Using the Saxon genitive: How do you say that the picture belongs to Sue?',
  '["It''s Sue''s picture.", "It''s the picture of Sue.", "It''s Sue picture.", "It''s picture Sue."]'::jsonb,
  '"It''s Sue''s picture."'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'How do you answer: ''Is it Emma''s house?'' (Negative response)',
  '["No, it isn''t.", "Yes, it is.", "No, they aren''t.", "Yes, I am."]'::jsonb,
  '"No, it isn''t."'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What part of a house do you use to walk between different floors?',
  '["stairs", "lift", "door", "roof"]'::jsonb,
  '"stairs"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What machine moves up and down inside a building to carry people?',
  '["lift", "stairs", "window", "balcony"]'::jsonb,
  '"lift"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What part of a house covers the top part outside to protect from rain?',
  '["roof", "door", "window", "balcony"]'::jsonb,
  '"roof"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What part of a house is a small outdoor platform with a railing upstairs?',
  '["balcony", "door", "stairs", "lift"]'::jsonb,
  '"balcony"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What part of a house do you open to walk into a room?',
  '["door", "window", "roof", "stairs"]'::jsonb,
  '"door"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What glass part of a house can you look through to see outside?',
  '["window", "door", "roof", "lift"]'::jsonb,
  '"window"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'true_false',
  'We use ''They''re'' when answering about a single watch.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'true_false',
  'The Saxon genitive uses an apostrophe and an ''s'' to show ownership (e.g. Emma''s house).',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What transport moves on tracks and carries many people?',
  '["train", "bus", "lorry", "boat"]'::jsonb,
  '"train"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What big road vehicle is used to carry heavy things and products?',
  '["lorry", "car", "bike", "helicopter"]'::jsonb,
  '"lorry"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What road transport has got two wheels and a powerful motor?',
  '["motorbike", "bike", "bus", "plane"]'::jsonb,
  '"motorbike"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What transport has got two wheels and you push pedals with your feet?',
  '["bike", "motorbike", "lorry", "train"]'::jsonb,
  '"bike"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What transport flies high in the sky and has got big fixed wings?',
  '["plane", "helicopter", "boat", "bus"]'::jsonb,
  '"plane"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What air transport has got spinning blades on top to fly?',
  '["helicopter", "plane", "train", "car"]'::jsonb,
  '"helicopter"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What transport moves over water using sails or a motor?',
  '["boat", "lorry", "bus", "motorbike"]'::jsonb,
  '"boat"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What action verb is used for controlling a car, bus or lorry?',
  '["drive", "fly", "ride", "sail"]'::jsonb,
  '"drive"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What action verb is used for controlling a plane or helicopter in the air?',
  '["fly", "drive", "ride", "sail"]'::jsonb,
  '"fly"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What action verb is used for moving a bike, motorbike or horse?',
  '["ride", "drive", "fly", "sail"]'::jsonb,
  '"ride"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What action verb is used for controlling a boat on the water?',
  '["sail", "drive", "fly", "ride"]'::jsonb,
  '"sail"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What is she doing if she is controlling a bus?',
  '["She is driving.", "She is riding.", "She is flying.", "She is sailing."]'::jsonb,
  '"She is driving."'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What is he doing if he is controlling a boat?',
  '["He is sailing.", "He is driving.", "He is riding.", "He is flying."]'::jsonb,
  '"He is sailing."'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Complete the question: ''___ she driving a lorry?''',
  '["Is", "Are", "Does", "Do"]'::jsonb,
  '"Is"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Answer the question: ''Is she driving a car?'' (Positive response)',
  '["Yes, she is.", "No, she isn''t.", "Yes, he is.", "No, he isn''t."]'::jsonb,
  '"Yes, she is."'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Answer the question: ''Is he sailing a boat?'' (Negative response)',
  '["No, he isn''t.", "Yes, he is.", "No, she isn''t.", "Yes, she is."]'::jsonb,
  '"No, he isn''t."'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What security rule teaches us to be safe inside a car?',
  '["Wear the seat belt!", "Walk on the pavement!", "Don''t run on a crossing!", "Look at the traffic lights!"]'::jsonb,
  '"Wear the seat belt!"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'Where must pedestrians walk safely on the side of the street?',
  '["pavement", "crossing", "traffic lights", "sign"]'::jsonb,
  '"pavement"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What road zone with white lines is used to cross the street?',
  '["crossing", "pavement", "traffic", "sign"]'::jsonb,
  '"crossing"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What security instruction tells us what to do at a pedestrian crossing?',
  '["Cross at the crossing!", "Wear the seat belt!", "Don''t play next to traffic!", "Stop at a red traffic light!"]'::jsonb,
  '"Cross at the crossing!"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What important security advice tells us how to move when crossing?',
  '["Don''t run on a crossing!", "Wear the seat belt!", "Walk on the pavement!", "Look at the traffic lights!"]'::jsonb,
  '"Don''t run on a crossing!"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What electronic lights change colour to organize vehicles and people?',
  '["traffic lights", "sign", "pavement", "crossing"]'::jsonb,
  '"traffic lights"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'multiple_choice',
  'What instruction tells us how to use our eyes before crossing the street?',
  '["Look before you cross!", "Wear a seat belt!", "Walk on the pavement!", "Don''t play next to traffic!"]'::jsonb,
  '"Look before you cross!"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'true_false',
  'Vial education teaches us to walk on the road and run on the crossing.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000010',
  'true_false',
  'We use ''drive'' for cars and ''ride'' for bicycles.',
  NULL,
  'true'::jsonb,
  1
);

-- English / Sport and weather (71)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Which sport is played with a big orange ball and a high basket?',
  '["basketball", "tennis", "swimming", "football"]'::jsonb,
  '"basketball"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What equipment do you use to hit the ball in tennis?',
  '["racket", "basket", "bike", "goggles"]'::jsonb,
  '"racket"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the sentence: ''I ___ football with my friends on Mondays.''',
  '["play", "go", "do", "swim"]'::jsonb,
  '"play"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the sentence: ''I ___ swimming in the pool at weekends.''',
  '["go", "play", "do", "ride"]'::jsonb,
  '"go"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the negative sentence: ''I ___ play basketball.''',
  '["don''t", "doesn''t", "not", "no"]'::jsonb,
  '"don''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the negative sentence: ''I don''t ___ rollerblading.''',
  '["go", "play", "do", "skate"]'::jsonb,
  '"go"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the question: ''___ you play tennis?''',
  '["Do", "Does", "Is", "Are"]'::jsonb,
  '"Do"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Answer the question: ''Do you go swimming?'' (Positive response)',
  '["Yes, I do", "No, I don''t", "Yes, I have", "No, I haven''t"]'::jsonb,
  '"Yes, I do"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Answer the question: ''Do you play football?'' (Negative response)',
  '["No, I don''t", "Yes, I do", "No, it isn''t", "Yes, I can"]'::jsonb,
  '"No, I don''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the question: ''___ you got a tennis racket?''',
  '["Have", "Has", "Do", "Are"]'::jsonb,
  '"Have"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Answer the question: ''Have you got a football?'' (Positive response)',
  '["Yes, I have", "No, I haven''t", "Yes, I do", "No, I don''t"]'::jsonb,
  '"Yes, I have"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Answer the question: ''Have you got a bike?'' (Negative response)',
  '["No, I haven''t", "Yes, I have", "No, I don''t", "Yes, I do"]'::jsonb,
  '"No, I haven''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'true_false',
  'In English, days of the week like ''Monday'' must always start with a capital letter.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Which sport is played on a grass pitch where players kick a round ball into a net?',
  '["football", "basketball", "tennis", "swimming"]'::jsonb,
  '"football"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What equipment do you wear over your eyes to see under water when swimming?',
  '["goggles", "racket", "bike", "helmet"]'::jsonb,
  '"goggles"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the sentence: ''On Fridays, I ___ rollerblading in the park.''',
  '["go", "play", "do", "ride"]'::jsonb,
  '"go"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the sentence: ''He ___ tennis at the school sports center.''',
  '["plays", "play", "go", "goes"]'::jsonb,
  '"plays"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the negative sentence: ''I ___ go swimming on Tuesdays.''',
  '["don''t", "doesn''t", "not", "no"]'::jsonb,
  '"don''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the question: ''___ you play basketball on Wednesdays?''',
  '["Do", "Does", "Is", "Are"]'::jsonb,
  '"Do"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Answer the question: ''Do you play tennis?'' (Positive response)',
  '["Yes, I do", "No, I don''t", "Yes, I have", "No, I haven''t"]'::jsonb,
  '"Yes, I do"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the question: ''___ you got a bicycle helmet?''',
  '["Have", "Has", "Do", "Are"]'::jsonb,
  '"Have"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Answer the question: ''Have you got a tennis racket?'' (Negative response)',
  '["No, I haven''t", "Yes, I have", "No, I don''t", "Yes, I do"]'::jsonb,
  '"No, I haven''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'true_false',
  'Days of the week like ''Tuesday'' or ''Friday'' do not need a capital letter.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What''s the weather like when there are no clouds and the sun shines bright?',
  '["It''s sunny", "It''s rainy", "It''s snowy", "It''s windy"]'::jsonb,
  '"It''s sunny"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What''s the weather like when white flakes fall down and it''s very cold?',
  '["It''s snowy", "It''s sunny", "It''s cloudy", "It''s rainy"]'::jsonb,
  '"It''s snowy"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What are you doing when the wind blows and you hold a string with a toy in the sky?',
  '["I''m flying a kite", "I''m planting flowers", "I''m making a snowman", "I''m swimming"]'::jsonb,
  '"I''m flying a kite"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the sentence: ''I don''t like ___ flowers in winter.''',
  '["planting", "plant", "planted", "plants"]'::jsonb,
  '"planting"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the question: ''___ you like making a snowman?''',
  '["Do", "Does", "Is", "Are"]'::jsonb,
  '"Do"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Answer the question: ''Do you like jumping in puddles?'' (Positive response)',
  '["Yes, I do", "No, I don''t", "Yes, I am", "No, I''m not"]'::jsonb,
  '"Yes, I do"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'true_false',
  'In English, months like ''January'' or ''May'' must start with a capital letter.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What''s the weather like when drops of water fall from the clouds?',
  '["It''s rainy", "It''s sunny", "It''s snowy", "It''s hot"]'::jsonb,
  '"It''s rainy"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What''s the weather like when the wind blows hard and leaves fly away?',
  '["It''s windy", "It''s sunny", "It''s rainy", "It''s calm"]'::jsonb,
  '"It''s windy"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What are you doing when it''s very cold and you put a carrot carrot as a nose on a big snow figure?',
  '["I''m making a snowman", "I''m flying a kite", "I''m planting flowers", "I''m swimming"]'::jsonb,
  '"I''m making a snowman"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the sentence: ''I like ___ a kite when it''s windy.''',
  '["flying", "fly", "flied", "flies"]'::jsonb,
  '"flying"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the question: ''___ she like planting flowers in spring?''',
  '["Does", "Do", "Is", "Are"]'::jsonb,
  '"Does"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Answer the question: ''Do you like flying a kite?'' (Negative response)',
  '["No, I don''t", "Yes, I do", "No, I''m not", "Yes, I am"]'::jsonb,
  '"No, I don''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'true_false',
  'Months of the year like ''September'' or ''December'' must start with a capital letter in English.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Which sport is played with a orange ball and a high basket?',
  '["basketball", "tennis", "swimming", "football"]'::jsonb,
  '"basketball"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What equipment do you use to hit the ball in tennis?',
  '["racket", "basket", "bike", "goggles"]'::jsonb,
  '"racket"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What do you wear over your eyes to see under water when swimming?',
  '["goggles", "racket", "bike", "helmet"]'::jsonb,
  '"goggles"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What do you wear on your head to protect yourself when riding a bike?',
  '["helmet", "goggles", "racket", "basket"]'::jsonb,
  '"helmet"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the sentence: ''I ___ basketball with my friends on Mondays.''',
  '["play", "go", "do", "swim"]'::jsonb,
  '"play"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the sentence: ''I ___ swimming in the pool at weekends.''',
  '["go", "play", "do", "ride"]'::jsonb,
  '"go"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the sentence: ''On Fridays I ___ rollerblading in the park.''',
  '["go", "play", "do", "ride"]'::jsonb,
  '"go"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the negative sentence: ''I ___ play basketball.''',
  '["don''t", "doesn''t", "not", "no"]'::jsonb,
  '"don''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the negative sentence: ''I don''t ___ swimming on Tuesdays.''',
  '["go", "play", "do", "skate"]'::jsonb,
  '"go"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the question: ''___ you play tennis?''',
  '["Do", "Does", "Is", "Are"]'::jsonb,
  '"Do"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Answer the question: ''Do you go swimming?'' (Positive response)',
  '["Yes, I do", "No, I don''t", "Yes, I have", "No, I haven''t"]'::jsonb,
  '"Yes, I do"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Answer the question: ''Do you play football?'' (Negative response)',
  '["No, I don''t", "Yes, I do", "No, it isn''t", "Yes, I can"]'::jsonb,
  '"No, I don''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the question: ''___ you got a tennis racket?''',
  '["Have", "Has", "Do", "Are"]'::jsonb,
  '"Have"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Answer the question: ''Have you got a football?'' (Positive response)',
  '["Yes, I have", "No, I haven''t", "Yes, I do", "No, I don''t"]'::jsonb,
  '"Yes, I have"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Answer the question: ''Have you got a bike?'' (Negative response)',
  '["No, I haven''t", "Yes, I have", "No, I don''t", "Yes, I do"]'::jsonb,
  '"No, I haven''t"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'true_false',
  'In English days of the week like ''Monday'' must always start with a capital letter.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'true_false',
  'We say ''I play swimming'' and ''I go basketball'' in English.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What''s the weather like when there are no clouds and the sun shines bright?',
  '["sunny", "rainy", "snowy", "windy"]'::jsonb,
  '"sunny"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What''s the weather like when white flakes fall down and it''s very cold?',
  '["snowy", "sunny", "cloudy", "rainy"]'::jsonb,
  '"snowy"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What''s the weather like when drops of water fall from the clouds?',
  '["rainy", "sunny", "snowy", "foggy"]'::jsonb,
  '"rainy"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What''s the weather like when the wind blows hard and leaves fly away?',
  '["windy", "sunny", "rainy", "icy"]'::jsonb,
  '"windy"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What''s the weather like when flashes of lightning and thunder appear in the sky?',
  '["stormy", "dry", "sunny", "foggy"]'::jsonb,
  '"stormy"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What''s the weather like when it is difficult to see because of a low white cloud?',
  '["foggy", "sunny", "wet", "stormy"]'::jsonb,
  '"foggy"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What is the antonym of ''wet'' when there is no water at all?',
  '["dry", "icy", "cloudy", "stormy"]'::jsonb,
  '"dry"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What are you doing when the wind blows and you hold a string with a toy in the sky?',
  '["flying a kite", "planting flowers", "making a snowman", "going cycling"]'::jsonb,
  '"flying a kite"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What are you doing when you ride your bicycle in the park?',
  '["going cycling", "having a picnic", "flying a kite", "planting flowers"]'::jsonb,
  '"going cycling"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'What activity means sitting on a blanket outdoors to eat some snacks?',
  '["having a picnic", "planting flowers", "making a snowman", "going cycling"]'::jsonb,
  '"having a picnic"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the sentence: ''I don''t like ___ flowers in winter.''',
  '["planting", "plant", "planted", "plants"]'::jsonb,
  '"planting"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the question: ''___ you like making a snowman?''',
  '["Do", "Does", "Is", "Are"]'::jsonb,
  '"Do"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Complete the question for a girl: ''Does she like ___ a picnic?''',
  '["having", "have", "has", "had"]'::jsonb,
  '"having"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Answer the question: ''Do you like playing in the snow?'' (Positive response)',
  '["Yes, I do", "No, I don''t", "Yes, I am", "No, I''m not"]'::jsonb,
  '"Yes, I do"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'multiple_choice',
  'Answer the question: ''What is the weather like?'' (It is rainy)',
  '["It is rainy", "It''s sunny", "They are rainy", "I am rainy"]'::jsonb,
  '"It is rainy"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'true_false',
  'In English months of the year like ''May'' or ''September'' must start with a capital letter.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000007',
  'true_false',
  '''Spring, Summer, Autumn and Winter'' are the four seasons of the year.',
  NULL,
  'true'::jsonb,
  1
);

-- Lengua / Expresión oral y escrita (35)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Un texto literario que se escribe en versos y suele tener rima es un...',
  '["Poema", "Noticia", "Folleto", "Anuncio"]'::jsonb,
  '"Poema"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Un texto instructivo que explica los ingredientes y pasos para cocinar un plato es una...',
  '["Receta", "Carta", "Entrevista", "Noticia"]'::jsonb,
  '"Receta"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Una frase corta, llamativa y fácil de recordar que se usa en publicidad se llama...',
  '["Eslogan", "Noticia", "Verso", "Fórmula"]'::jsonb,
  '"Eslogan"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Un texto periodístico escrito que relata un hecho real e importante sucedido recientemente es una...',
  '["Noticia", "Poema", "Receta", "Ficha de lectura"]'::jsonb,
  '"Noticia"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Un diálogo donde una persona hace preguntas ordenadas para conocer a otra es una...',
  '["Entrevista", "Carta", "Eslogan", "Descripción"]'::jsonb,
  '"Entrevista"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Un texto escrito que mandamos por correo dentro de un sobre a un amigo lejano es una...',
  '["Carta", "Receta", "Entrevista", "Eslogan"]'::jsonb,
  '"Carta"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'true_false',
  'Las normas o reglas de un juego nos sirven para saber cómo se gana y se juega de forma limpia.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'El documento donde anotamos el título, autor y resumen de un libro que nos hemos leído es una...',
  '["Ficha de lectura", "Receta", "Noticia", "Carta"]'::jsonb,
  '"Ficha de lectura"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Cuando expresas lo que te divierte hacer en tu tiempo libre estás hablando de tus...',
  '["Gustos y aficiones", "Recetas", "Fórmulas de cortesía", "Eslóganes"]'::jsonb,
  '"Gustos y aficiones"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Cuando dices ''¿Qué quiero ser de mayor?'' estás hablando sobre...',
  '["Las profesiones", "Las recetas", "Los poemas", "Los nombres propios"]'::jsonb,
  '"Las profesiones"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Decir ''Muchas gracias'' o ''Por favor'' son ejemplos de...',
  '["Fórmulas de cortesía", "Eslóganes publicitarios", "Fichas de lectura", "Antónimos"]'::jsonb,
  '"Fórmulas de cortesía"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Si detallas de forma ordenada el aspecto, clima y elementos de un pueblo estás haciendo una...',
  '["Descripción de lugares", "Entrevista", "Noticia", "Receta"]'::jsonb,
  '"Descripción de lugares"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'true_false',
  'El titular es la frase grande que va al principio de una noticia para llamar la atención.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Una serie de preguntas que se hacen a muchas personas para reunir datos u opiniones se llama...',
  '["Encuesta", "Coloquio", "Receta", "Cómic"]'::jsonb,
  '"Encuesta"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Una conversación organizada entre varias personas para dar sus opiniones sobre un tema es un...',
  '["Coloquio", "Encuesta", "Instrucción", "Ficha de lectura"]'::jsonb,
  '"Coloquio"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Una historia explicada mediante una serie de viñetas con dibujos y burbujas de texto es un...',
  '["Cómic", "Poema", "Receta", "Ficha de lectura"]'::jsonb,
  '"Cómic"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'true_false',
  'Un texto descriptivo de animales sirve para detallar su físico, alimentación y costumbres.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000006',
  'true_false',
  'Las instrucciones nos indican las normas prohibidas que jamás debemos seguir.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000006',
  'true_false',
  'Hacer preguntas breves a varias personas para saber su animal favorito es una encuesta.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Un debate o charla libre donde varias personas hablan de forma respetuosa sobre un tema es un...',
  '["Coloquio", "Anuncio", "Receta", "Examen"]'::jsonb,
  '"Coloquio"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Una narración visual con recuadros llamadas viñetas y globos de texto es un...',
  '["Cómic", "Poema", "Diccionario", "Ficha"]'::jsonb,
  '"Cómic"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000006',
  'true_false',
  'Una descripción de lugares sirve para explicar cómo es un paisaje, pueblo o habitación.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000006',
  'true_false',
  'Las instrucciones nos enseñan las normas paso a paso para armar un juguete.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Un dicho popular que contiene una enseñanza o consejo de los abuelos es un...',
  '["Refrán", "Cómic", "Menú", "Resumen"]'::jsonb,
  '"Refrán"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Una narración breve y divertida de algo curioso que nos ha pasado en la vida real es una...',
  '["Anécdota", "Biografía", "Instrucción", "Diccionario"]'::jsonb,
  '"Anécdota"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Un mensaje digital rápido que enviamos por internet usando el ordenador se llama...',
  '["Correo electrónico", "Carta", "Cuento", "Refrán"]'::jsonb,
  '"Correo electrónico"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Un texto escrito que narra de forma ordenada la vida de una persona importante es una...',
  '["Biografía", "Menú", "Anécdota", "Onomatopeya"]'::jsonb,
  '"Biografía"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'El documento del restaurante donde viene la lista de platos y postres con su precio es el...',
  '["Menú", "Resumen", "Cómic", "Diccionario"]'::jsonb,
  '"Menú"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Un texto corto que escribimos extrayendo solo las ideas principales de una lectura larga es un...',
  '["Resumen", "Biografía", "Cuento ilustrado", "Entrevista"]'::jsonb,
  '"Resumen"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Las frases tradicionales cortas que riman y nos dicen consejos de la vida se llaman...',
  '["Refranes", "Cómics", "Menús", "Biografías"]'::jsonb,
  '"Refranes"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Cuando explicas paso a paso cómo armar un mueble estás dando unas...',
  '["Instrucciones", "Anécdotas", "Fichas de lectura", "Recetas"]'::jsonb,
  '"Instrucciones"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Un correo electrónico es un texto que se envía principalmente usando...',
  '["Internet", "Un sobre de papel", "Un buzón de la calle", "Un periódico"]'::jsonb,
  '"Internet"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000006',
  'multiple_choice',
  'Un libro corto para niños que combina texto narrativo con dibujos bonitos es un...',
  '["Cuento ilustrado", "Diccionario", "Menú de restaurante", "Resumen"]'::jsonb,
  '"Cuento ilustrado"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000006',
  'true_false',
  'Un menú de restaurante contiene la lista ordenada de comidas que se pueden elegir.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000006',
  'true_false',
  'El vasco o euskera es una de las lenguas que se hablan en una zona de España.',
  NULL,
  'true'::jsonb,
  1
);

-- Lengua / Reflexión sobre la lengua (105)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra está ordenada correctamente en orden alfabético?',
  '["Avión, barco, coche", "Coche, barco, avión", "Barco, avión, coche", "Avión, coche, barco"]'::jsonb,
  '"Avión, barco, coche"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'true_false',
  'Los nombres de los meses del año se escriben siempre con mayúscula inicial.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'true_false',
  'La primera palabra de una oración siempre empieza con mayúscula.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'numeric',
  '¿Cuántas sílabas tiene la palabra ''mariposa''?',
  NULL,
  '4'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué elemento es una oración completa y correcta?',
  '["El perro corre en el jardín.", "perro el jardín", "Corre jardín verde", "La casa de"]'::jsonb,
  '"El perro corre en el jardín."'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el sinónimo de la palabra ''contento''?',
  '["Alegre", "Triste", "Enfadado", "Asustado"]'::jsonb,
  '"Alegre"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el antónimo de la palabra ''subir''?',
  '["Bajar", "Escalar", "Saltar", "Correr"]'::jsonb,
  '"Bajar"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos a las palabras que tienen varios significados como ''pico'' (de ave o montaña)?',
  '["Polisémicas", "Sinónimos", "Antónimos", "Colectivos"]'::jsonb,
  '"Polisémicas"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra se escribe correctamente con la sílaba ''que''?',
  '["Queso", "Ceso", "Quiso", "Cueso"]'::jsonb,
  '"Queso"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra se escribe correctamente con la sílaba ''qui''?',
  '["Quirófano", "Cirófano", "Quejido", "Quero"]'::jsonb,
  '"Quirófano"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de palabra es un nombre común?',
  '["gato", "Madrid", "Sofía", "España"]'::jsonb,
  '"gato"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de palabra es un nombre propio?',
  '["Carlos", "niño", "ciudad", "río"]'::jsonb,
  '"Carlos"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos al nombre que se refiere a un solo objeto en singular (ej. ''oveja'')?',
  '["Individual", "Colectivo", "Propio", "Artículo"]'::jsonb,
  '"Individual"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos al nombre que en singular se refiere a un conjunto de objetos (ej. ''rebaño'')?',
  '["Colectivo", "Individual", "Común", "Artículo"]'::jsonb,
  '"Colectivo"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuáles son los artículos determinados en español?',
  '["El, la, los, las", "Un, una, unos, unas", "Yo, tú, él", "Este, ese, aquel"]'::jsonb,
  '"El, la, los, las"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra completa la ortografía natural de la serie: ca, ___, cu?',
  '["co", "que", "qui", "ce"]'::jsonb,
  '"co"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'numeric',
  '¿Cuántas letras ''co'' tiene la palabra ''cocodrilo''?',
  NULL,
  '2'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué grupo de letras está ordenado correctamente según el abecedario?',
  '["m, n, o, p", "o, m, p, n", "p, o, n, m", "n, p, m, o"]'::jsonb,
  '"m, n, o, p"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'true_false',
  'Los nombres propios de personas y ciudades se escriben con mayúscula inicial.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'true_false',
  'Las letras juntas forman sílabas y las sílabas ordenadas forman palabras.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'numeric',
  '¿Cuántas sílabas tiene la palabra ''sol''?',
  NULL,
  '1'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el antónimo (lo contrario) de la palabra ''grande''?',
  '["Pequeño", "Enorme", "Gigante", "Alto"]'::jsonb,
  '"Pequeño"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el sinónimo (significa lo mismo) de la palabra ''caminar''?',
  '["Andar", "Correr", "Saltar", "Dormir"]'::jsonb,
  '"Andar"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra se escribe correctamente con la sílaba ''qui''?',
  '["Quince", "Cince", "Quece", "Cuince"]'::jsonb,
  '"Quince"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra se escribe correctamente con la sílaba ''que''?',
  '["Paquete", "Pacuete", "Paquite", "Pacete"]'::jsonb,
  '"Paquete"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de nombre es ''Madrid'' u ''Oliver''?',
  '["Nombre propio", "Nombre común", "Nombre colectivo", "Artículo"]'::jsonb,
  '"Nombre propio"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de nombre es ''libro'' o ''perro''?',
  '["Nombre común", "Nombre propio", "Nombre colectivo", "Artículo"]'::jsonb,
  '"Nombre común"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el nombre colectivo que define a un conjunto de peces?',
  '["Banco", "Rebaño", "Jauría", "Pajarería"]'::jsonb,
  '"Banco"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuáles son los artículos indeterminados o indefinidos en español?',
  '["Un, una, unos, unas", "El, la, los, las", "Este, ese, aquel", "Mi, tu, su"]'::jsonb,
  '"Un, una, unos, unas"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué sílaba completa la ortografía natural de la serie: ___, co, cu?',
  '["ca", "que", "qui", "ce"]'::jsonb,
  '"ca"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'numeric',
  '¿Cuántas palabras tiene la oración: ''El coche azul es muy rápido.''?',
  NULL,
  '7'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'true_false',
  'Las palabras polisémicas son aquellas que se escriben igual pero tienen significados diferentes.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra está bien escrita con z o con c?',
  '["Zueco", "Zesta", "Zielo", "Cana"]'::jsonb,
  '"Zueco"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra lleva correctamente la sílaba ''ce'' o ''ci''?',
  '["Cisne", "Zisne", "Cebra", "Zebra"]'::jsonb,
  '"Cisne"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letras faltan para escribir ''manguera''?',
  '["gue", "ge", "gui", "gi"]'::jsonb,
  '"gue"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra lleva diéresis para que suene la letra ''u''?',
  '["Paragüero", "Guitarra", "Gato", "Girasol"]'::jsonb,
  '"Paragüero"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra se escribe con ''g'' con sonido fuerte como en ''girasol''?',
  '["Gigante", "Jirafa", "Gato", "Guerra"]'::jsonb,
  '"Gigante"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra termina correctamente con la letra ''d''?',
  '["Pared", "Parez", "Redz", "Madris"]'::jsonb,
  '"Pared"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra termina correctamente con la letra ''z''?',
  '["Lápiz", "Lápid", "Pezd", "Arrod"]'::jsonb,
  '"Lápiz"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué conjunto de palabras forman una familia de palabras?',
  '["Flor, floristería, florero", "Flor, árbol, planta", "Sol, luna, cielo", "Pan, queso, leche"]'::jsonb,
  '"Flor, floristería, florero"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el diminutivo correcto de la palabra ''sol''?',
  '["Solcito", "Solazo", "Solecito", "Solana"]'::jsonb,
  '"Solecito"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el aumentativo correcto de la palabra ''perro''?',
  '["Perrazo", "Perrito", "Perrucho", "Perrera"]'::jsonb,
  '"Perrazo"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos a las palabras que imitan ruidos de la realidad como ''¡guau!'' o ''¡tic-tac!''?',
  '["Onomatopeyas", "Sinónimos", "Diminutivos", "Compuestas"]'::jsonb,
  '"Onomatopeyas"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál de estas es una palabra compuesta hecha por dos palabras juntas?',
  '["Espantapájaros", "Pajarito", "Asustar", "Campo"]'::jsonb,
  '"Espantapájaros"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de palabra nos dice cómo es o cómo está un nombre (ej. ''casa grande'')?',
  '["Un adjetivo", "Un verbo", "Un determinante", "Un pronombre"]'::jsonb,
  '"Un adjetivo"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de palabra expresa una acción que hacemos (ej. ''saltar'', ''escribir'')?',
  '["Un verbo", "Un adjetivo", "Un nombre", "Un artículo"]'::jsonb,
  '"Un verbo"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué determinante demostrativo usamos para señalar algo que está muy cerca?',
  '["Este", "Ese", "Aquel", "Mi"]'::jsonb,
  '"Este"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué determinante posesivo nos indica que algo pertenece a nosotros?',
  '["Nuestra", "Esa", "Dos", "La"]'::jsonb,
  '"Nuestra"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué determinante numeral expresa una cantidad exacta como en ''tres osos''?',
  '["Tres", "Muchos", "Aquellos", "Tus"]'::jsonb,
  '"Tres"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra contiene el adjetivo en la frase ''El gato negro duerme''?',
  '["negro", "gato", "duerme", "El"]'::jsonb,
  '"negro"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra es un verbo en la frase ''Sofía cocina una tarta''?',
  '["cocina", "Sofía", "tarta", "una"]'::jsonb,
  '"cocina"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'numeric',
  '¿Cuántos adjetivos hay en la frase ''La manzana roja es muy sabrosa''?',
  NULL,
  '2'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra está bien escrita con z ante la o?',
  '["Zueco", "Zorro", "Zerezo", "Zielo"]'::jsonb,
  '"Zorro"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra lleva correctamente la sílaba ''ce'' o ''ci'' con sonido suave?',
  '["Cielo", "Zielo", "Zintura", "Cura"]'::jsonb,
  '"Cielo"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letras faltan para escribir ''águila''?',
  '["gui", "gi", "gue", "ge"]'::jsonb,
  '"gui"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra lleva diéresis para que suene la ''u'' en la combinación ''güi''?',
  '["Pingüino", "Guitarra", "Guiso", "Gente"]'::jsonb,
  '"Pingüino"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra se escribe con ''g'' con sonido fuerte delante de la ''e''?',
  '["Gemelo", "Jemelo", "Gato", "Guerra"]'::jsonb,
  '"Gemelo"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra termina correctamente con la letra ''d''?',
  '["Juventud", "Juventuz", "Verdadz", "Saludz"]'::jsonb,
  '"Juventud"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra termina correctamente con la letra ''z''?',
  '["Arroz", "Arrod", "Lápizd", "Pezd"]'::jsonb,
  '"Arroz"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué conjunto de palabras forman una familia de palabras derivada de ''pan''?',
  '["Pan, panadero, panadería", "Pan, trigo, harina", "Pan, leche, queso", "Pan, horno, comida"]'::jsonb,
  '"Pan, panadero, panadería"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el diminutivo correcto de la palabra ''casa''?',
  '["Casita", "Casaza", "Casona", "Caserón"]'::jsonb,
  '"Casita"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el aumentativo correcto de la palabra ''barco''?',
  '["Barcazo", "Barquito", "Barquero", "Barca"]'::jsonb,
  '"Barcazo"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos a la palabra ''guau'' que imita el ladrido de un perro?',
  '["Onomatopeya", "Sinónimo", "Antónimos", "Compuesta"]'::jsonb,
  '"Onomatopeya"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál de estas es una palabra compuesta hecha por dos palabras juntas?',
  '["Lavacoches", "Cochecito", "Conductor", "Garaje"]'::jsonb,
  '"Lavacoches"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de palabra es ''inteligente'' o ''rápido''?',
  '["Un adjetivo", "Un verbo", "Un sustantivo", "Un artículo"]'::jsonb,
  '"Un adjetivo"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de palabra es ''escribir'' o ''cantar''?',
  '["Un verbo", "Un adjetivo", "Un sustantivo", "Un nexo"]'::jsonb,
  '"Un verbo"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué determinante demostrativo usamos para señalar algo lejano como ''___ montaña''?',
  '["Aquel", "Este", "Ese", "Nuestra"]'::jsonb,
  '"Aquel"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué determinante posesivo nos indica que algo es tuyo?',
  '["Tu", "Esa", "Nuestra", "El"]'::jsonb,
  '"Tu"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué determinante numeral expresa una cantidad exacta como en ''cuatro coches''?',
  '["Cuatro", "Muchos", "Estos", "Tus"]'::jsonb,
  '"Cuatro"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra contiene el adjetivo en la frase ''El coche rojo vuela''?',
  '["rojo", "coche", "vuela", "El"]'::jsonb,
  '"rojo"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra es un verbo en la frase ''El niño juega fútbol''?',
  '["juega", "niño", "fútbol", "El"]'::jsonb,
  '"juega"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'numeric',
  '¿Cuántas palabras componen la oración: ''Mi perro corre feliz.''?',
  NULL,
  '4'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra completa correctamente la frase: ''¿___ estás feliz?''?',
  '["Por qué", "porque", "por que", "porqué"]'::jsonb,
  '"Por qué"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra completa correctamente la frase: ''Estudio ___ quiero aprender.''?',
  '["porque", "Por qué", "por que", "porqué"]'::jsonb,
  '"porque"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letra va siempre delante de la letra ''p'' en palabras como ''campo''?',
  '["m", "n", "v", "b"]'::jsonb,
  '"m"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letra va siempre delante de la letra ''b'' en palabras como ''bombero''?',
  '["m", "n", "p", "v"]'::jsonb,
  '"m"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra se escribe con una sola ''r'' porque suena suave al final de sílaba?',
  '["Cantar", "Perro", "Turrón", "Rana"]'::jsonb,
  '"Cantar"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra necesita llevar ''rr'' porque suena fuerte y va en medio de dos vocales?',
  '["Pájaro", "Guitarra", "Caracol", "Ratonera"]'::jsonb,
  '"Guitarra"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué conjunto de palabras forman el campo semántico de los ''muebles''?',
  '["Silla, mesa, armario", "Rojo, verde, azul", "Perro, gato, león", "Lunes, martes, mayo"]'::jsonb,
  '"Silla, mesa, armario"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es la palabra derivada que procede de la palabra primitiva ''flor''?',
  '["Floristería", "Árbol", "Planta", "Jardín"]'::jsonb,
  '"Floristería"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué significa la frase hecha ''estar en las nubes''?',
  '["Estar despistado", "Tener frío", "Volar en avión", "Estar enfadado"]'::jsonb,
  '"Estar despistado"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué libro consultamos por orden alfabético para saber el significado de una palabra?',
  '["El diccionario", "El cómic", "El cuento", "El resumen"]'::jsonb,
  '"El diccionario"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000005',
  'true_false',
  'En España se hablan distintas lenguas como el castellano, el catalán, el gallego o el vasco.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra es un pronombre personal que sustituye a las personas en una frase?',
  '["Ellos", "Mesa", "Grande", "Correr"]'::jsonb,
  '"Ellos"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de oración usamos para hacer preguntas como ''¿Qué hora es?''?',
  '["Interrogativa", "Exclamativa", "Enunciativa", "Sujeto"]'::jsonb,
  '"Interrogativa"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué tipo de oración expresa alegría, sorpresa o miedo como ''¡Qué bien!''?',
  '["Exclamativa", "Interrogativa", "Enunciativa", "Predicado"]'::jsonb,
  '"Exclamativa"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos a la persona, animal o cosa que realiza la acción en una oración?',
  '["Sujeto", "Predicado", "Adjetivo", "Diminutivo"]'::jsonb,
  '"Sujeto"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cómo llamamos a la parte de la oración que nos dice lo que hace el sujeto (e incluye el verbo)?',
  '["Predicado", "Sujeto", "Aumentativo", "Onomatopeya"]'::jsonb,
  '"Predicado"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000005',
  'true_false',
  'La coma se utiliza en un texto para hacer una pequeña pausa cuando leemos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el sujeto en la oración ''El perro corre mucho''?',
  '["El perro", "corre", "mucho", "El"]'::jsonb,
  '"El perro"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'numeric',
  '¿Cuántas oraciones completas hay en este texto: ''Amo los libros. Leo cada noche.''?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra está escrita correctamente con la combinación ''mp''?',
  '["Trampa", "Tranpa", "Tranba", "Tramba"]'::jsonb,
  '"Trampa"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra está escrita correctamente con la combinación ''mb''?',
  '["Sombra", "Sonbra", "Sonpra", "Sompra"]'::jsonb,
  '"Sombra"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué letra va siempre al principio de la palabra ''ratón'' aunque suene fuerte?',
  '["r", "rr", "er", "l"]'::jsonb,
  '"r"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra se escribe con una sola ''r'' porque va en medio y suena suave?',
  '["Caracol", "Pelirrojo", "Perro", "Turrón"]'::jsonb,
  '"Caracol"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué conjunto de palabras forman el campo semántico de las ''prendas de vestir''?',
  '["Camiseta, pantalón, chaqueta", "Manzana, pera, plátano", "Mesa, silla, cama", "Lunes, martes, miércoles"]'::jsonb,
  '"Camiseta, pantalón, chaqueta"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es la palabra derivada que procede de la palabra primitiva ''pan''?',
  '["Panadería", "Leche", "Queso", "Trigo"]'::jsonb,
  '"Panadería"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué significa la frase hecha ''echar una mano''?',
  '["Ayudar a alguien", "Lanzar un objeto", "Saludar de lejos", "Pintar un cuadro"]'::jsonb,
  '"Ayudar a alguien"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué pronombre personal en plural usamos para referirnos a nosotros mismos?',
  '["Nosotros", "Ellos", "Vosotros", "Yo"]'::jsonb,
  '"Nosotros"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué clase de oración usamos para afirmar un hecho como ''Hoy es martes.''?',
  '["Enunciativa", "Interrogativa", "Exclamativa", "Sujeto"]'::jsonb,
  '"Enunciativa"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Cuál es el predicado en la oración ''El gato duerme en el sofá''?',
  '["duerme en el sofá", "El gato", "El gato duerme", "en el sofá"]'::jsonb,
  '"duerme en el sofá"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'true_false',
  'En una oración, el sujeto y el verbo deben concordar siempre en número y persona.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'true_false',
  'El punto final se coloca justo al empezar a escribir una oración en el cuaderno.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000005',
  'multiple_choice',
  '¿Qué palabra completa correctamente la frase: ''No fui al colegio ___ estaba enfermo.''?',
  '["porque", "Por qué", "por qué", "porqué"]'::jsonb,
  '"porque"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000005',
  'numeric',
  '¿Cuántas sílabas tiene la palabra compuesta ''saltamontes''?',
  NULL,
  '4'::jsonb,
  1
);

-- Matemáticas / Datos y dinero (16)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b2000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Si tiras un dado normal con números del 1 al 6 ¿sacar un número menor que 7 es un suceso...?, Greece',
  '["Seguro", "Posible", "Imposible", "Ninguno"]'::jsonb,
  '"Seguro"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Si metes la mano en una bolsa con caramelos rojos y verdes ¿sacar un caramelo verde es un suceso...?, Greece',
  '["Posible", "Seguro", "Imposible", "Ninguno"]'::jsonb,
  '"Posible"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Si tienes una caja llena solo de pinturas azules ¿sacar una pintura de color rojo es un suceso...?, Greece',
  '["Imposible", "Seguro", "Posible", "Fácil"]'::jsonb,
  '"Imposible"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000004',
  'numeric',
  'Si pagas un juguete con un billete de 20 euros y te cuesta 15 euros ¿cuántos euros te devuelven?',
  NULL,
  '5'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000004',
  'numeric',
  '¿Cuántos céntimos de euro forman una moneda completa de 1 euro?',
  NULL,
  '100'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000004',
  'numeric',
  'Si en tu hucha tienes tres monedas de 2 euros ¿cuántos euros tienes en total?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000004',
  'true_false',
  'Un pictograma utiliza dibujos o iconos para representar cantidades e información.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000004',
  'multiple_choice',
  '¿Cómo se llama el gráfico que utiliza rectángulos o barras para organizar los datos recogidos?',
  '["Gráfico de barras", "Pictograma", "Calendario", "Reloj analógico"]'::jsonb,
  '"Gráfico de barras"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Si en invierno el cielo se cubre de nubes negras oscuras ¿que llueva es un suceso...?, Greece',
  '["Posible", "Seguro", "Imposible", "Ninguno"]'::jsonb,
  '"Posible"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Si tiras una moneda al aire ¿que caiga un elefante volando es un suceso...?, Greece',
  '["Imposible", "Seguro", "Posible", "Fácil"]'::jsonb,
  '"Imposible"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Si abres un libro de cuentos infantiles ¿encontrar letras escritas es un suceso...?, Greece',
  '["Seguro", "Posible", "Imposible", "Difícil"]'::jsonb,
  '"Seguro"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000004',
  'numeric',
  'Si compras un cuaderno por 3 euros y pagas con un billete de 10 euros ¿cuántos euros te devuelven?',
  NULL,
  '7'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000004',
  'numeric',
  'Si juntas tres billetes de 5 euros ¿cuántos euros tienes en total?',
  NULL,
  '15'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000004',
  'numeric',
  '¿Cuántas monedas de 50 céntimos necesitas para formar 1 euro completo?',
  NULL,
  '2'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000004',
  'true_false',
  'Un gráfico de barras horizontales funciona igual que un gráfico de barras verticales.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000004',
  'multiple_choice',
  'Si en un pictograma el dibujo de una pelota vale por 2 pelotas ¿cuántas pelotas representan 3 dibujos?',
  '["6 pelotas", "3 pelotas", "2 pelotas", "5 pelotas"]'::jsonb,
  '"6 pelotas"'::jsonb,
  2
);

-- Matemáticas / Medida y geometría (32)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b2000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos días tiene el fin de semana (sábado y domingo)?',
  NULL,
  '2'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'Si la aguja pequeña está en el 2 y la grande en el 3 ¿qué hora es en el reloj analógico?',
  '["Las dos en punto", "Las dos y cuarto", "Las dos y media", "Las tres menos cuarto"]'::jsonb,
  '"Las dos y cuarto"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'En un reloj digital si marca 08:45 significa que son...',
  '["Las ocho y cuarto", "Las ocho y media", "Las nueve menos cuarto", "Las nueve en punto"]'::jsonb,
  '"Las Structural menos cuarto"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'Si miras el mapa y giras hacia la mano con la que normalmente no escribes es la...',
  '["Izquierda", "Derecha", "Arriba", "Abajo"]'::jsonb,
  '"Izquierda"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos meses enteros tiene un año completo?',
  NULL,
  '12'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'Si la aguja pequeña está en el 5 y la grande en el 6 ¿qué hora es en el reloj analógico?',
  '["Las cinco en punto", "Las cinco y cuarto", "Las cinco y media", "Las seis menos cuarto"]'::jsonb,
  '"Las cinco y media"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'En un reloj digital si marca 10:15 significa que son...',
  '["Las diez en punto", "Las diez y cuarto", "Las diez y media", "Las once menos cuarto"]'::jsonb,
  '"Las diez y cuarto"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'Si estás caminando hacia el norte y giras hacia tu mano derecha ¿hacia qué dirección vas?',
  '["Este", "Oeste", "Norte", "Sur"]'::jsonb,
  '"Este"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cómo llamamos a una línea que cambia de dirección sin formar esquinas?',
  '["Línea curva", "Línea recta", "Línea poligonal", "Línea mixta"]'::jsonb,
  '"Línea curva"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cómo llamamos a las figuras que se pueden doblar por la mitad de modo que ambas partes coincidan?',
  '["Figuras simétricas", "Polígonos", "Cuerpos redondos", "Prismas"]'::jsonb,
  '"Figuras simétricas"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cómo llamamos a una figura plana cerrada formada por líneas rectas?',
  '["Polígono", "Circunferencia", "Círculo", "Cono"]'::jsonb,
  '"Polígono"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cómo se llama la línea curva y redonda que rodea a un círculo?',
  '["Circunferencia", "Círculo", "Esfera", "Cilindro"]'::jsonb,
  '"Circunferencia"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué cuerpo redondo tiene una base circular y una punta llamada vértice?',
  '["Cono", "Cilindro", "Esfera", "Prisma"]'::jsonb,
  '"Cono"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué cuerpo geométrico redondo tiene la forma de una pelota de fútbol?',
  '["Esfera", "Cilindro", "Cono", "Pirámide"]'::jsonb,
  '"Esfera"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántas bases circulares tiene un cilindro?',
  NULL,
  '2'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cómo llamamos a una línea recta que va de izquierda a derecha bien tumbada?',
  '["Línea horizontal", "Línea vertical", "Línea curva", "Línea oblicua"]'::jsonb,
  '"Línea horizontal"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Cómo llamamos a los lados rectos que cierran un polígono?',
  '["Lados", "Vértices", "Ángulos", "Bases"]'::jsonb,
  '"Lados"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos lados rectos tiene un polígono que es un triángulo?',
  NULL,
  '3'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántas esquinas o vértices tiene un cuadrado?',
  NULL,
  '4'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué cuerpo geométrico plano tiene una forma perfecta de anillo y no tiene esquinas?',
  '["Circunferencia", "Triángulo", "Prisma", "Cubo"]'::jsonb,
  '"Circunferencia"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué unidad de medida usamos para medir el largo de un cuaderno pequeño con la regla?',
  '["Centímetros (cm)", "Metros (m)", "Kilómetros (Km)", "Kilogramos"]'::jsonb,
  '"Centímetros (cm)"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué unidad de medida usarías para medir la distancia larga entre dos ciudades de España?',
  '["Kilómetros (Km)", "Centímetros (cm)", "Metros (m)", "Litros"]'::jsonb,
  '"Kilómetros (Km)"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'Si juntas dos cuartos de kilo de fruta ¿qué cantidad formas en total?',
  '["Medio kilo", "Un kilo", "Tres cuartos de kilo", "Un cuarto de kilo"]'::jsonb,
  '"Medio kilo"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos cuartos de litro necesitas juntar para rellenar una botella completa de 1 litro?',
  NULL,
  '4'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000003',
  'true_false',
  'El metro (m) es una unidad que sirve para medir el peso de los objetos.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'true_false',
  'Un kilogramo pesa exactamente lo mismo que dos medios kilos juntos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué unidad de medida de longitud equivale exactamente a 1000 metros?',
  '["Kilómetro (Km)", "Centímetro (cm)", "Metro (m)", "Litro"]'::jsonb,
  '"Kilómetro (Km)"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  '¿Qué unidad de medida principal usamos si queremos comprar un cartón de leche o de zumo?',
  '["Litro (l)", "Kilogramo (kg)", "Metro (m)", "Centímetro (cm)"]'::jsonb,
  '"Litro (l)"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000003',
  'multiple_choice',
  'Si una sandía pesa un kilo entero ¿cuántos medios kilos pesa esa misma sandía?',
  '["Dos medios kilos", "Un medio kilo", "Cuatro medios kilos", "Tres medios kilos"]'::jsonb,
  '"Dos medios kilos"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'numeric',
  '¿Cuántos cuartos de kilo necesitamos juntar para tener medio kilo de harina?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000003',
  'true_false',
  'Para medir de forma exacta el largo de una línea pequeña en un folio usamos la regla.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000003',
  'true_false',
  'Un cuarto de kilo pesa más que medio kilo de cualquier alimento.',
  NULL,
  'false'::jsonb,
  1
);

-- Matemáticas / Números (30)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b2000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número se forma con 2 centenas, 5 decenas y 3 unidades?',
  NULL,
  '253'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuántas unidades hay en una centena completa?',
  NULL,
  '100'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número va justo antes del 200?',
  NULL,
  '199'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número va justo después del 298?',
  NULL,
  '299'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuál es el valor de posición del número 2 en el número 245?',
  NULL,
  '200'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 189 es mayor que el número 201.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 256 es menor que el número 265.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿A qué decena se redondea el número 87?',
  '["80", "90", "70", "100"]'::jsonb,
  '"90"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿A qué decena se redondea el número 142?',
  '["140", "150", "100", "130"]'::jsonb,
  '"140"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuántas decenas completas forman una centena?',
  NULL,
  '10'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número se lee como ''doscientos ocho''?',
  NULL,
  '208'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número va justo en medio en esta serie: 150, 160, ___, 180, 190?',
  NULL,
  '170'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuántas unidades vale el número 7 si está en el lugar de las decenas?',
  NULL,
  '70'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 299 tiene exactamente 3 centenas.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'true_false',
  'Si contamos en serie descendente: 250, 240, 230... el siguiente número es 220.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿A qué decena se redondea el número 216?',
  '["210", "220", "200", "230"]'::jsonb,
  '"220"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿A qué decena se redondea el número 93?',
  '["90", "100", "80", "95"]'::jsonb,
  '"90"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número se forma con 9 centenas y 9 unidades?',
  NULL,
  '909'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuál es el valor de posición del número 5 en el número 543?',
  NULL,
  '500'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 875 es menor que el número 857.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿A qué centena se redondea el número 280?',
  '["200", "300", "250", "400"]'::jsonb,
  '"300"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿A qué centena se redondea el número 615?',
  '["600", "700", "620", "500"]'::jsonb,
  '"600"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número sigue en la serie: 996, 997, 998...?',
  NULL,
  '999'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número va justo antes del 900?',
  NULL,
  '899'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Cuántas unidades forman 7 centenas completas?',
  NULL,
  '700'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número sigue en la serie hacia atrás: 500, 400, 300...?',
  NULL,
  '200'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'numeric',
  '¿Qué número se descompone como 600 + 40 + 8?',
  NULL,
  '648'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'true_false',
  'El número 950 es posterior al número 949.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿A qué centena se redondea el número 785?',
  '["700", "800", "750", "900"]'::jsonb,
  '"800"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000001',
  'multiple_choice',
  '¿A qué centena se redondea el número 430?',
  '["400", "500", "450", "300"]'::jsonb,
  '"400"'::jsonb,
  1
);

-- Matemáticas / Operaciones (272)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada: 125 + 138',
  NULL,
  '263'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada de tres cifras: 146 + 27',
  NULL,
  '173'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta con llevada: 85 - 37',
  NULL,
  '48'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta con llevada de dos cifras: 91 - 45',
  NULL,
  '46'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cómo llamamos a los números que se suman en una adición?',
  '["Sumandos", "Suma o total", "Minuendo", "Diferencia"]'::jsonb,
  '"Sumandos"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cómo se llama el primer número de una resta (al que le quitamos algo)?',
  '["Minuendo", "Sustraendo", "Diferencia", "Sumando"]'::jsonb,
  '"Minuendo"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cómo llamamos al resultado final de una resta?',
  '["Diferencia", "Minuendo", "Sustraendo", "Total"]'::jsonb,
  '"Diferencia"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 multiplicado por 3?',
  NULL,
  '15'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 multiplicado por 8?',
  NULL,
  '16'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 10 multiplicado por 6?',
  NULL,
  '60'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Según la tabla del 0 o del 1: ¿Cuánto es 1 x 9?',
  NULL,
  '9'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuál es el doble del número 7?',
  NULL,
  '14'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma en vertical de tres cifras: 156 + 126',
  NULL,
  '282'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta en vertical con llevada: 73 - 29',
  NULL,
  '44'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si el minuendo es 80 y el sustraendo es 30 ¿cuál es la diferencia?',
  NULL,
  '50'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si los sumandos son 100 y 150 ¿cuál es la suma o total?',
  NULL,
  '250'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 multiplicado por 8?',
  NULL,
  '40'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 multiplicado por 7?',
  NULL,
  '14'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 10 multiplicado por 9?',
  NULL,
  '90'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Según la tabla del 0: ¿Cuánto es 0 x 100?',
  NULL,
  '0'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuál es el doble del número 9?',
  NULL,
  '18'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto nos da sumar 120 + 10?',
  NULL,
  '130'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto nos da restar 260 - 10?',
  NULL,
  '250'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si completas los ''amigos del 10'': ¿Qué número le falta al 4 para llegar a 10?',
  NULL,
  '6'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si completas los ''amigos del 10'': ¿Qué número le falta al 7 para llegar a 10?',
  NULL,
  '3'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada: 456 + 238',
  NULL,
  '694'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta con llevada: 524 - 182',
  NULL,
  '342'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'true_false',
  'La propiedad conmutativa dice que el orden de los sumandos no cambia el resultado de la suma.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Qué operación hacemos para comprobar si una resta está bien hecha?',
  '["Sumar el sustraendo y la diferencia", "Restar el sustraendo de la diferencia", "Multiplicar los términos", "Dividir"]'::jsonb,
  '"Sumar el sustraendo y la diferencia"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 multiplicado por 6?',
  NULL,
  '18'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 multiplicado por 7?',
  NULL,
  '28'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 multiplicado por 5?',
  NULL,
  '30'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto nos da sumar 450 + 100?',
  NULL,
  '550'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto nos da restar 890 - 100?',
  NULL,
  '790'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 350 + 40?',
  NULL,
  '390'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si en una libreta tengo 3 filas de pegatinas y en cada fila hay 5 pegatinas ¿cuántas tengo en total?',
  NULL,
  '15'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Tengo 20 caramelos y me como 5 por la mañana y 3 por la tarde ¿cuántos caramelos me quedan?',
  NULL,
  '12'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'true_false',
  'La propiedad asociativa dice que al sumar tres números, el resultado es igual sin importar cómo los agrupemos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta con llevada de tres cifras: 631 - 215',
  NULL,
  '416'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada en vertical: 345 + 287',
  NULL,
  '632'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si realizas la prueba de la resta sumando el sustraendo (40) y la diferencia (60) ¿qué número obtienes?',
  NULL,
  '100'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 multiplicado por 6?',
  NULL,
  '24'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 multiplicado por 9?',
  NULL,
  '27'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 multiplicado por 4?',
  NULL,
  '24'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 multiplicado por 10?',
  NULL,
  '20'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto nos da restar 900 - 100?',
  NULL,
  '800'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 600 + 100?',
  NULL,
  '700'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 420 + 30?',
  NULL,
  '450'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Tengo 4 estuches y en cada estuche hay 5 lápices ¿cuántos lápices tengo en total?',
  NULL,
  '20'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'En una cesta hay 10 manzanas. Meto 8 más y luego me como 3 ¿cuántas manzanas quedan?',
  NULL,
  '15'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cómo llamamos a los números que terminan en 0, 2, 4, 6 u 8?',
  '["Números pares", "Números impares", "Centenas", "Multiplicaciones"]'::jsonb,
  '"Números pares"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'multiple_choice',
  '¿Cómo llamamos a los números que terminan en 1, 3, 5, 7 o 9?',
  '["Números impares", "Números pares", "Unidades", "Series"]'::jsonb,
  '"Números impares"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si calculas la mitad de una cantidad: ¿cuánto es la mitad de 40?',
  NULL,
  '20'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si calculas la mitad de una cantidad: ¿cuánto es la mitad de 100?',
  NULL,
  '50'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Qué número sigue en la serie ascendente: 991, 992, 993, 994...?',
  NULL,
  '995'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Qué número va justo antes del 800?',
  NULL,
  '799'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Qué número obtienes al descomponer 7 centenas, 3 decenas y 5 unidades?',
  NULL,
  '735'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'true_false',
  'El número 555 es un número impar.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la suma con llevada de tres cifras: 524 + 318',
  NULL,
  '842'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta con llevada de tres cifras: 712 - 405',
  NULL,
  '307'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'En una tienda hay 5 cajas de lápices y cada caja contiene 6 lápices ¿cuántos hay en total?',
  NULL,
  '30'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Qué número par va justo después del 452?',
  NULL,
  '454'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Qué número impar va justo antes del 300?',
  NULL,
  '799'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si calculas la mitad de una cantidad: ¿cuánto es la mitad de 600?',
  NULL,
  '300'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Qué número sigue en la serie descendente: 850, 840, 830...?',
  NULL,
  '820'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'true_false',
  'El número 888 es un número par.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'true_false',
  'Todos los números que terminan en la cifra 0 son considerados números impares.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la resta con llevada de tres cifras: 925 - 450',
  NULL,
  '475'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la multiplicación: 5 x 9',
  NULL,
  '45'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Resuelve la multiplicación con un factor de una cifra: 6 x 3',
  NULL,
  '18'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'En un autobús viajan 45 personas. En la primera parada se bajan 10 y suben 5 ¿cuántas quedan dentro?',
  NULL,
  '40'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si tengo 3 bolsas con 10 caramelos en cada una ¿cuántos caramelos tengo en total?',
  NULL,
  '30'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 x 1?',
  NULL,
  '2'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 x 2?',
  NULL,
  '4'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 x 3?',
  NULL,
  '6'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 x 4?',
  NULL,
  '8'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 x 5?',
  NULL,
  '10'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 x 6?',
  NULL,
  '12'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 x 7?',
  NULL,
  '14'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 x 8?',
  NULL,
  '16'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 x 9?',
  NULL,
  '18'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 x 10?',
  NULL,
  '20'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 x 1?',
  NULL,
  '3'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 x 2?',
  NULL,
  '6'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 x 3?',
  NULL,
  '9'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 x 4?',
  NULL,
  '12'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 x 5?',
  NULL,
  '15'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 x 6?',
  NULL,
  '18'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 x 7?',
  NULL,
  '21'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 x 8?',
  NULL,
  '24'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 x 9?',
  NULL,
  '27'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 x 10?',
  NULL,
  '30'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 x 1?',
  NULL,
  '4'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 x 2?',
  NULL,
  '8'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 x 3?',
  NULL,
  '12'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 x 4?',
  NULL,
  '16'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 x 5?',
  NULL,
  '20'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 x 6?',
  NULL,
  '24'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 x 7?',
  NULL,
  '28'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 x 8?',
  NULL,
  '32'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 x 9?',
  NULL,
  '36'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 x 10?',
  NULL,
  '40'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 x 1?',
  NULL,
  '5'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 x 2?',
  NULL,
  '10'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 x 3?',
  NULL,
  '15'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 x 4?',
  NULL,
  '20'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 x 5?',
  NULL,
  '25'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 x 6?',
  NULL,
  '30'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 x 7?',
  NULL,
  '35'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 x 8?',
  NULL,
  '40'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 x 9?',
  NULL,
  '45'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 x 10?',
  NULL,
  '50'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 x 1?',
  NULL,
  '6'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 x 2?',
  NULL,
  '12'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 x 3?',
  NULL,
  '18'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 x 4?',
  NULL,
  '24'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 x 5?',
  NULL,
  '30'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 x 6?',
  NULL,
  '36'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 x 7?',
  NULL,
  '42'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 x 8?',
  NULL,
  '48'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 x 9?',
  NULL,
  '54'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 x 10?',
  NULL,
  '60'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 10 x 1?',
  NULL,
  '10'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 10 x 2?',
  NULL,
  '20'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 10 x 3?',
  NULL,
  '30'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 10 x 4?',
  NULL,
  '40'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 10 x 5?',
  NULL,
  '50'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 10 x 6?',
  NULL,
  '60'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 10 x 7?',
  NULL,
  '70'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 10 x 8?',
  NULL,
  '80'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 10 x 9?',
  NULL,
  '90'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 10 x 10?',
  NULL,
  '100'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 1 x 5?',
  NULL,
  '5'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 1 x 9?',
  NULL,
  '9'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 0 x 4?',
  NULL,
  '0'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 0 x 8?',
  NULL,
  '0'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si juntas 2 cajas con 3 manzanas cada una ¿cuántas manzanas tienes?',
  NULL,
  '6'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Tengo 5 sobres y cada uno tiene 4 cromos ¿cuántos cromos hay en total?',
  NULL,
  '20'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'En una mesa hay 3 estuches con 6 lápices en cada uno ¿cuántos lápices hay?',
  NULL,
  '18'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Lucas compra 4 bolsas de gominolas y cada bolsa trae 10 gominolas ¿cuántas tiene?',
  NULL,
  '40'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'María hace 6 bandejas de galletas y mete 3 galletas en cada una ¿cuántas hizo?',
  NULL,
  '18'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si tengo 5 amigos y a cada uno le regalo 2 caramelos ¿cuántos reparto?',
  NULL,
  '10'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'En un aparcamiento hay 4 coches y cada coche tiene 4 ruedas ¿cuántas ruedas hay?',
  NULL,
  '16'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Un ciclista da 6 vueltas a la pista y en cada vuelta tarda 2 minutos ¿cuánto tarda?',
  NULL,
  '12'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si un gato tiene 4 patas ¿cuántas patas tienen 3 gatos juntos?',
  NULL,
  '12'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Tengo 10 estanterías con 5 libros en cada una ¿cuántos libros tengo?',
  NULL,
  '50'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 x 0?',
  NULL,
  '0'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 x 0?',
  NULL,
  '0'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 1 x 10?',
  NULL,
  '10'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 x 0?',
  NULL,
  '0'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 x 0?',
  NULL,
  '0'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 x 0?',
  NULL,
  '0'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 1 x 7?',
  NULL,
  '7'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 1 x 1?',
  NULL,
  '1'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 1 x 3?',
  NULL,
  '3'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 1 x 6?',
  NULL,
  '6'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si un paquete de caramelos cuesta 2 euros ¿cuánto cuestan 9 paquetes?',
  NULL,
  '18'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'En una granja hay 4 gallineros con 5 gallinas cada uno ¿cuántas gallinas hay?',
  NULL,
  '20'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si leo 3 páginas de un libro cada día ¿cuántas páginas leo en 7 días?',
  NULL,
  '21'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Una libreta tiene 10 filas de cuadrados y en cada fila hay 8 cuadrados ¿cuántos hay?',
  NULL,
  '80'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si una araña tiene 8 patas ¿cuántas patas tienen 2 arañas juntas?',
  NULL,
  '16'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Compro 5 cajas de bombones y en cada una vienen 5 bombones ¿cuántos tengo?',
  NULL,
  '25'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'En una carrera corren 6 equipos con 4 niños cada uno ¿cuántos niños corren?',
  NULL,
  '24'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si una abeja tiene 6 patas ¿cuántas patas tienen 3 abejas juntas?',
  NULL,
  '18'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si un bolígrafo cuesta 2 euros ¿cuánto pagaré por 10 bolígrafos?',
  NULL,
  '20'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'En un armario hay 4 estantes y en cada estante hay 6 camisetas ¿cuántas hay?',
  NULL,
  '24'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si ahorro 10 céntimos cada día de la semana durante 4 días ¿cuánto ahorro?',
  NULL,
  '40'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 multiplicado por 8?',
  NULL,
  '27'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 multiplicado por 9?',
  NULL,
  '36'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 multiplicado por 6?',
  NULL,
  '30'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 multiplicado por 7?',
  NULL,
  '42'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 multiplicado por 5?',
  NULL,
  '15'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 7 x 1?',
  NULL,
  '7'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 7 x 2?',
  NULL,
  '14'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 7 x 3?',
  NULL,
  '21'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 7 x 4?',
  NULL,
  '28'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 7 x 5?',
  NULL,
  '35'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 7 x 6?',
  NULL,
  '42'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 7 x 7?',
  NULL,
  '49'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 7 x 8?',
  NULL,
  '56'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 7 x 9?',
  NULL,
  '63'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 7 x 10?',
  NULL,
  '70'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 8 x 1?',
  NULL,
  '8'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 8 x 2?',
  NULL,
  '16'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 8 x 3?',
  NULL,
  '24'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 8 x 4?',
  NULL,
  '32'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 8 x 5?',
  NULL,
  '40'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 8 x 6?',
  NULL,
  '48'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 8 x 7?',
  NULL,
  '56'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 8 x 8?',
  NULL,
  '64'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 8 x 9?',
  NULL,
  '72'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 8 x 10?',
  NULL,
  '80'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 9 x 1?',
  NULL,
  '9'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 9 x 2?',
  NULL,
  '18'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 9 x 3?',
  NULL,
  '27'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 9 x 4?',
  NULL,
  '36'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 9 x 5?',
  NULL,
  '45'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 9 x 6?',
  NULL,
  '54'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 9 x 7?',
  NULL,
  '63'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 9 x 8?',
  NULL,
  '72'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 9 x 9?',
  NULL,
  '81'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 9 x 10?',
  NULL,
  '90'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 x 7?',
  NULL,
  '14'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 x 8?',
  NULL,
  '16'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 x 9?',
  NULL,
  '18'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 x 7?',
  NULL,
  '21'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 x 8?',
  NULL,
  '24'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 x 9?',
  NULL,
  '27'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 x 7?',
  NULL,
  '28'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 x 8?',
  NULL,
  '32'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 x 9?',
  NULL,
  '36'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 x 7?',
  NULL,
  '35'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 x 8?',
  NULL,
  '40'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 x 9?',
  NULL,
  '45'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 x 7?',
  NULL,
  '42'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 x 8?',
  NULL,
  '48'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 x 9?',
  NULL,
  '54'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 10 x 7?',
  NULL,
  '70'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 10 x 8?',
  NULL,
  '80'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 10 x 9?',
  NULL,
  '90'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 7 x 0?',
  NULL,
  '0'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 8 x 0?',
  NULL,
  '0'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 9 x 0?',
  NULL,
  '0'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 7 x 2?',
  NULL,
  '14'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 8 x 2?',
  NULL,
  '16'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 9 x 2?',
  NULL,
  '18'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 7 x 5?',
  NULL,
  '35'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 8 x 5?',
  NULL,
  '40'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 9 x 5?',
  NULL,
  '45'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 7 x 10?',
  NULL,
  '70'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 8 x 10?',
  NULL,
  '80'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 9 x 10?',
  NULL,
  '90'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si una semana tiene 7 días ¿cuántos días hay en 2 semanas enteras?',
  NULL,
  '14'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si una semana tiene 7 días ¿cuántos días hay en 3 semanas enteras?',
  NULL,
  '21'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si una semana tiene 7 días ¿cuántos días hay en 4 semanas enteras?',
  NULL,
  '28'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si una semana tiene 7 días ¿cuántos días hay en 5 semanas enteras?',
  NULL,
  '35'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si una semana tiene 7 días ¿cuántos días hay en 10 semanas enteras?',
  NULL,
  '70'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Tengo 7 cajas con 6 rotuladores en cada una ¿cuántos rotuladores hay en total?',
  NULL,
  '42'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'En una estantería hay 7 filas con 7 libros en cada fila ¿cuántos libros hay?',
  NULL,
  '49'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Un pulpo tiene 8 patas ¿cuántas patas tienen 2 pulpos juntos?',
  NULL,
  '16'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Un pulpo tiene 8 patas ¿cuántas patas tienen 3 pulpos juntos?',
  NULL,
  '24'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Un pulpo tiene 8 patas ¿cuántas patas tienen 4 pulpos juntos?',
  NULL,
  '32'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Un pulpo tiene 8 patas ¿cuántas patas tienen 5 pulpos juntos?',
  NULL,
  '40'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Un pulpo tiene 8 patas ¿cuántas patas tienen 6 pulpos juntos?',
  NULL,
  '48'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Un pulpo tiene 8 patas ¿cuántas patas tienen 10 pulpos juntos?',
  NULL,
  '80'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Compro 8 paquetes de chicles y cada paquete trae 7 chicles ¿cuántos tengo?',
  NULL,
  '56'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'En una libreta hay 8 páginas con 8 pegatinas en cada una ¿cuántas hay?',
  NULL,
  '64'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si compro 8 cajas de bombones y cada una trae 9 bombones ¿cuántos tengo?',
  NULL,
  '72'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Una caja de pinturas tiene 9 lápices ¿cuántos lápices tienen 2 cajas?',
  NULL,
  '18'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Una caja de pinturas tiene 9 lápices ¿cuántos lápices tienen 3 cajas?',
  NULL,
  '27'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Una caja de pinturas tiene 9 lápices ¿cuántos lápices tienen 4 cajas?',
  NULL,
  '36'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Una caja de pinturas tiene 9 lápices ¿cuántos lápices tienen 5 cajas?',
  NULL,
  '45'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Una caja de pinturas tiene 9 lápices ¿cuántos lápices tienen 6 cajas?',
  NULL,
  '54'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Una caja de pinturas tiene 9 lápices ¿cuántos lápices tienen 10 cajas?',
  NULL,
  '90'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'En un jardín hay 9 filas con 7 flores en cada una ¿cuántas flores hay?',
  NULL,
  '63'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Carlos tiene 9 huchas y en cada hucha guarda 8 euros ¿cuántos euros tiene?',
  NULL,
  '72'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  'Si en un juego ganas 9 puntos cada vez que aciertas y aciertas 9 veces ¿cuántos puntos sumas?',
  NULL,
  '81'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 x 7?',
  NULL,
  '28'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 x 8?',
  NULL,
  '32'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 4 x 9?',
  NULL,
  '36'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 x 7?',
  NULL,
  '35'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 x 8?',
  NULL,
  '40'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 5 x 9?',
  NULL,
  '45'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 x 7?',
  NULL,
  '42'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 x 8?',
  NULL,
  '48'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 6 x 9?',
  NULL,
  '54'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 x 7?',
  NULL,
  '21'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 x 8?',
  NULL,
  '24'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 3 x 9?',
  NULL,
  '27'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 2 x 9?',
  NULL,
  '18'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 1 x 8?',
  NULL,
  '8'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000002',
  'numeric',
  '¿Cuánto es 1 x 9?',
  NULL,
  '9'::jsonb,
  1
);

-- Natural Science / Animals (46)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  '¿Qué característica principal diferencia a los animales de las plantas?',
  '["Los animales pueden desplazarse", "Los animales son seres vivos", "Los animales nacen", "Los animales mueren"]'::jsonb,
  '"Los animales pueden desplazarse"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  '¿Cómo se clasifican los animales que tienen un esqueleto interno con columna vertebral?',
  '["Vertebrados", "Invertebrados", "Artrópodos", "Moluscos"]'::jsonb,
  '"Vertebrados"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  '¿Cómo se clasifican los animales que no tienen columna vertebral ni esqueleto de hueso?',
  '["Invertebrados", "Vertebrados", "Mamíferos", "Reptiles"]'::jsonb,
  '"Invertebrados"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  '¿A qué grupo de vertebrados pertenece un perro o un gato que toma leche al nacer?',
  '["Mamíferos", "Aves", "Reptiles", "Anfibios"]'::jsonb,
  '"Mamíferos"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  '¿A qué grupo de vertebrados pertenece un animal con plumas, pico y alas?',
  '["Aves", "Peces", "Reptiles", "Mamíferos"]'::jsonb,
  '"Aves"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  '¿A qué grupo de vertebrados pertenece un cocodrilo o una serpiente con escamas duras que repta?',
  '["Reptiles", "Anfibios", "Peces", "Aves"]'::jsonb,
  '"Reptiles"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  '¿A qué grupo pertenecen las ranas que sufren una metamorfosis y viven en agua y tierra?',
  '["Anfibios", "Peces", "Reptiles", "Invertebrados"]'::jsonb,
  '"Anfibios"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  '¿A qué grupo de vertebrados pertenece un animal que respira por branquias y tiene aletas?',
  '["Peces", "Anfibios", "Mamíferos", "Aves"]'::jsonb,
  '"Peces"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  '¿Qué grupo de invertebrados tiene las patas articuladas y un cuerpo protegido (ej. hormiga)?',
  '["Artrópodos", "Moluscos", "Peces", "Mamíferos"]'::jsonb,
  '"Artrópodos"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  '¿Qué grupo de invertebrados tiene el cuerpo blando y a veces una concha (ej. caracol)?',
  '["Moluscos", "Artrópodos", "Anfibios", "Reptiles"]'::jsonb,
  '"Moluscos"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000012',
  'true_false',
  'Los mamíferos son animales vivíparos porque nacen del vientre de su madre.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'true_false',
  'Las aves y los peces son animales ovíparos porque nacen de huevos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'true_false',
  'Un caracol es un ejemplo de animal vertebrado.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'true_false',
  'Los insectos pertenecen al grupo de los artrópodos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  '¿Qué grupo de vertebrados se caracteriza por tener el cuerpo cubierto de pelo y respirar por pulmones?',
  '["Mamíferos", "Aves", "Reptiles", "Anfibios"]'::jsonb,
  '"Mamíferos"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  '¿Qué grupo de vertebrados pone huevos con cáscara dura, tiene escamas y repta por el suelo?',
  '["Reptiles", "Anfibios", "Peces", "Aves"]'::jsonb,
  '"Reptiles"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  '¿Qué grupo de vertebrados nace en el agua respirando por branquias y de adulto desarrolla pulmones?',
  '["Anfibios", "Peces", "Reptiles", "Mamíferos"]'::jsonb,
  '"Anfibios"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  '¿Qué invertebrados tienen el cuerpo dividido en cabeza, tórax y abdomen, y seis patas?',
  '["Artrópodos (Insectos)", "Moluscos", "Anfibios", "Peces"]'::jsonb,
  '"Artrópodos (Insectos)"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000012',
  'true_false',
  'Los animales invertebrados forman el grupo más numeroso de la Tierra.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'true_false',
  'Un mejillón y un pulpo son ejemplos de animales moluscos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'true_false',
  'Todos los animales mamíferos son terrestres y ninguno puede nadar o volar.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  '¿A qué grupo pertenece un águila o un gorrión?',
  '["Aves", "Mamíferos", "Reptiles", "Peces"]'::jsonb,
  '"Aves"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'Which of the following categories is a living thing?',
  '["animals", "objects", "cars", "clocks"]'::jsonb,
  '"animals"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'Which of the following categories is a non-living thing?',
  '["objects", "plants", "human beings", "animals"]'::jsonb,
  '"objects"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'What do we call animals that have got an internal skeleton and a backbone?',
  '["vertebrate animals", "invertebrate animals", "arthropods", "molluscs"]'::jsonb,
  '"vertebrate animals"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'What do we call animals that haven''t got a skeleton or backbone?',
  '["invertebrate animals", "vertebrate animals", "mammals", "reptiles"]'::jsonb,
  '"invertebrate animals"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'Which group of vertebrates are viviparous because they give birth to live babies?',
  '["mammals", "birds", "fish", "reptiles"]'::jsonb,
  '"mammals"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'Which group of vertebrates has got feathers and breathes using lungs?',
  '["birds", "mammals", "amphibians", "fish"]'::jsonb,
  '"birds"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'Which group of vertebrates has got scales, lays eggs, and breathes using gills?',
  '["fish", "reptiles", "mammals", "amphibians"]'::jsonb,
  '"fish"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'Which group of vertebrates has got hard scales, lungs, and repta on land?',
  '["reptiles", "fish", "birds", "amphibians"]'::jsonb,
  '"reptiles"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'Which group of vertebrates has got wet skin and lays eggs in water?',
  '["amphibians", "mammals", "birds", "fish"]'::jsonb,
  '"amphibians"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'Which group of invertebrates has got many legs and a hard external body?',
  '["arthropods", "molluscs", "mammals", "fish"]'::jsonb,
  '"arthropods"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'Which group of invertebrates has got soft bodies and sometimes shells or tentacles?',
  '["molluscs", "arthropods", "reptiles", "birds"]'::jsonb,
  '"molluscs"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'Which of the following invertebrates belongs to the arthropod group?',
  '["ladybug", "snail", "octopus", "squid"]'::jsonb,
  '"ladybug"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'Which of the following invertebrates belongs to the mollusc group?',
  '["snail", "centipede", "scorpion", "ladybug"]'::jsonb,
  '"snail"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'What body part do fish use to breathe oxygen inside the water?',
  '["gills", "lungs", "beak", "scales"]'::jsonb,
  '"gills"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'What body part do birds use to fly in the air?',
  '["wings", "fins", "scales", "gills"]'::jsonb,
  '"wings"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'What body part do fish use to change direction and swim?',
  '["fins", "beak", "feathers", "wings"]'::jsonb,
  '"fins"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'What covers the body of a mammal like a lion or a fox?',
  '["fur", "feathers", "scales", "wet skin"]'::jsonb,
  '"fur"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'true_false',
  'An octopus has got tentacles and a soft body without a skeleton.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'true_false',
  'Most mollusc animals live on land and most arthropods live in water.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'true_false',
  'Mammal babies drink their mother''s milk to grow.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'true_false',
  'Vertebrate animals have got a skeleton and a backbone.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'true_false',
  'A snake has got two wings and a hard bird beak.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'Which invertebrate group has got an internal soft body and a hard external protective shell (ej. mussels)?',
  '["molluscs", "arthropods", "mammals", "amphibians"]'::jsonb,
  '"molluscs"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000012',
  'multiple_choice',
  'What covers the body of reptiles like a crocodile to protect its skin?',
  '["scales", "fur", "feathers", "wet skin"]'::jsonb,
  '"scales"'::jsonb,
  1
);

-- Natural Science / Light and sound (42)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b2000001-0001-4000-8000-000000000014',
  'true_false',
  'La luz y el sonido son formas de energía que viajan por el espacio.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Qué tipo de material deja pasar toda la luz y nos permite ver claramente a través de él?',
  '["Transparentes", "Opacos", "Traslúcidos", "Artificiales"]'::jsonb,
  '"Transparentes"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Qué tipo de material bloquea la luz por completo y produce una sombra detrás?',
  '["Opacos", "Transparentes", "Traslúcidos", "Naturales"]'::jsonb,
  '"Opacos"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Qué tipo de material deja pasar solo un poco de luz y no nos deja ver de forma nítida?',
  '["Traslúcidos", "Transparentes", "Opacos", "Energéticos"]'::jsonb,
  '"Traslúcidos"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Cuál de estas es una fuente de luz completamente natural?',
  '["El Sol", "Una bombilla", "Una linterna", "Una vela de cera"]'::jsonb,
  '"El Sol"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Cuál de estas es una fuente de luz artificial construida por las personas?',
  '["Una lámpara eléctrica", "Las estrellas", "El Sol", "Un relámpago"]'::jsonb,
  '"Una lámpara eléctrica"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'true_false',
  'El sonido se produce cuando los objetos vibran y esa vibración viaja por el aire.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'true_false',
  'La luz del sol no tiene ningún uso práctico para las plantas.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Qué sentido usamos para percibir el sonido de la música?',
  '["El oído", "La vista", "El gusto", "El tacto"]'::jsonb,
  '"El oído"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Qué sentido usamos para percibir la luz y los colores de la naturaleza?',
  '["La vista", "El oído", "El olfato", "El tacto"]'::jsonb,
  '"La vista"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'true_false',
  'Los sonidos pueden ser fuertes o débiles.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'true_false',
  'Una linterna encendida es una fuente de luz natural.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Qué animal produce luz natural propia por la noche?',
  '["La luciérnaga", "El perro", "El gato", "El pájaro"]'::jsonb,
  '"La luciérnaga"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Con qué órgano del cuerpo escuchamos los sonidos altos y bajos?',
  '["El oído", "La vista", "El olfato", "El tacto"]'::jsonb,
  '"El oído"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Con qué órgano del cuerpo podemos ver la luz natural del Sol?',
  '["Los ojos", "Las orejas", "La nariz", "Las manos"]'::jsonb,
  '"Los ojos"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'true_false',
  'Los sonidos artificiales son aquellos producidos por objetos creados por el hombre, como un coche.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'true_false',
  'Un cristal limpio de una ventana es un ejemplo de material opaco.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Qué insecto de la naturaleza tiene luz propia por las noches?',
  '["La luciérnaga", "La mosca", "La abeja", "La hormiga"]'::jsonb,
  '"La luciérnaga"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'true_false',
  'La luz y el sonido se consideran formas de energía que nos rodean.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Qué tipo de material permite que la luz pase totalmente y ver todo al otro lado?',
  '["Transparentes", "Opacos", "Traslúcidos", "Artificiales"]'::jsonb,
  '"Transparentes"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Qué tipo de material impide el paso de la luz y genera una sombra oscura?',
  '["Opacos", "Transparentes", "Traslúcidos", "Naturales"]'::jsonb,
  '"Opacos"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Qué tipo de material deja pasar la luz a medias y emborrona las figuras?',
  '["Traslúcidos", "Transparentes", "Opacos", "Puros"]'::jsonb,
  '"Traslúcidos"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Cuál es la fuente de luz y calor natural más grande de nuestro planeta?',
  '["El Sol", "Una lámpara", "El fuego", "Una bombilla"]'::jsonb,
  '"El Sol"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  '¿Cuál de estas es una fuente de luz artificial inventada por las personas?',
  '["Una linterna", "Las estrellas", "El Sol", "El rayo"]'::jsonb,
  '"Una linterna"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'true_false',
  'El sonido viaja por el aire en forma de ondas cuando un objeto vibra.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'true_false',
  'Los seres humanos usamos la luz únicamente para generar calor y nada más.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What form of energy allows us to see the things around us?',
  '["light", "sound", "materials", "structures"]'::jsonb,
  '"light"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What type of material lets all the light pass through clearly (ej. a clean window)?',
  '["transparent", "translucent", "opaque", "natural"]'::jsonb,
  '"transparent"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What type of material lets only some light pass through (ej. dark sunglasses)?',
  '["translucent", "transparent", "opaque", "artificial"]'::jsonb,
  '"translucent"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What type of material blocks all the light completely (ej. a school backpack)?',
  '["opaque", "transparent", "translucent", "pure"]'::jsonb,
  '"opaque"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'Which of the following is an artificial source of light made by humans?',
  '["light bulb", "sun", "lightning", "stars"]'::jsonb,
  '"light bulb"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'Which of the following is a natural source of light in the sky?',
  '["sun", "tv", "lighthouse", "candle"]'::jsonb,
  '"sun"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What category describes using traffic lights or talking to share messages?',
  '["communication", "fun", "materials", "energy"]'::jsonb,
  '"communication"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What category describes listening to music or watching a show for pleasure?',
  '["fun", "communication", "structures", "science"]'::jsonb,
  '"fun"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What type of sound can damage your hearing if it is too high or intense?',
  '["loud sound", "soft sound", "quiet sound", "natural sound"]'::jsonb,
  '"loud sound"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What good habit helps us save light energy at home?',
  '["Turn off lights when you leave", "Watch TV very close", "Use screens before bed", "Look directly at the sun"]'::jsonb,
  '"Turn off lights when you leave"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'true_false',
  'We can use both light and sound for human communication.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'true_false',
  'Translucent materials block all the light and make a dark shadow.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'true_false',
  'Loud noises are very good for protecting your human hearing.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'true_false',
  'We must not look at the Sun directly because it hurts our eyes.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What type of sound does a small bird make compared to a big drum?',
  '["high sound", "low sound", "loud sound", "artificial sound"]'::jsonb,
  '"high sound"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000014',
  'multiple_choice',
  'What type of sound does a lightning storm or explosion make?',
  '["loud sound", "soft sound", "quiet sound", "transparent sound"]'::jsonb,
  '"loud sound"'::jsonb,
  1
);

-- Natural Science / Machines and technology (56)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Cómo llamamos a los objetos sencillos que usamos con las manos para hacer un trabajo (ej. unas tijeras)?, Greece',
  '["Herramientas", "Aparatos electrónicos", "Estructuras", "Líneas del tiempo"]'::jsonb,
  '"Herramientas"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Cómo llamamos a los objetos formados por muchas piezas que usan energía para funcionar (ej. una lavadora)?, Greece',
  '["Máquinas", "Herramientas sencillas", "Sustancias puras", "Rocas"]'::jsonb,
  '"Máquinas"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Qué aparato o máquina de la vida cotidiana usamos en la cocina para mantener fría la comida?, Greece',
  '["El frigorífico", "La televisión", "El coche", "El martillo"]'::jsonb,
  '"El frigorífico"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Cómo definimos al conjunto de conocimientos y aparatos modernos creados por el ser humano para hacernos la vida más fácil?',
  '["La tecnología", "El paisaje", "El ciclo del agua", "La estructura"]'::jsonb,
  '"La tecnología"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Cuál de estos es un trabajo moderno directamente relacionado con la tecnología?',
  '["Programador de ordenadores", "Agricultor tradicional", "Pescador", "Escultor de piedra"]'::jsonb,
  '"Programador de ordenadores"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'Un martillo es una máquina compleja que necesita internet para funcionar.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'Los ordenadores y las tablets son herramientas tecnológicas que nos sirven para estudiar y buscar información.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Qué energía utiliza un ordenador portátil para poder encenderse y funcionar?',
  '["Energía eléctrica", "Fuerza de las manos", "Energía del viento", "Ninguna"]'::jsonb,
  '"Energía eléctrica"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'Las herramientas manuales como el destornillador multiplican la fuerza de nuestras manos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'Hacer un uso responsable de la tecnología consiste en estar enganchado a las pantallas todo el día.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Qué máquina de transporte nos permite viajar de forma rápida por carretera?',
  '["El coche", "El barco", "El avión", "El tren"]'::jsonb,
  '"El coche"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'La rueda es uno de los inventos mecánicos más importantes de la historia.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Qué instrumento tecnológico usamos para calcular operaciones matemáticas muy rápido?',
  '["La calculadora", "El lápiz", "La regla", "El diccionario"]'::jsonb,
  '"La calculadora"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'Un teléfono móvil moderno es un aparato tecnológico.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Qué herramienta manual utiliza un carpintero para cortar madera de forma recta?',
  '["El serrucho", "El martillo", "El pincel", "La lavadora"]'::jsonb,
  '"El serrucho"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'La tecnología ayuda a los médicos a curar mejor a los enfermos en los hospitales.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Cómo llamamos a los objetos sencillos que potencian nuestras manos, como un destornillador?',
  '["Herramientas", "Máquinas complejas", "Estructuras artificiales", "Líneas del tiempo"]'::jsonb,
  '"Herramientas"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Cómo llamamos a los aparatos formados por circuitos, cables o motores que usan electricidad (ej. una tablet)?',
  '["Máquinas y tecnología", "Herramientas manuales", "Estructuras naturales", "Sustancias puras"]'::jsonb,
  '"Máquinas y tecnología"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Qué máquina o aparato tecnológico portátil usamos para comunicarnos y hacer videollamadas?',
  '["El teléfono móvil", "El martillo", "El serrucho", "La regla"]'::jsonb,
  '"El teléfono móvil"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Cómo llamamos al uso de inventos y ciencia para solucionar problemas de las personas?',
  '["La tecnología", "El paisaje", "El ciclo del agua", "La simetría"]'::jsonb,
  '"La tecnología"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Cuál de estos empleos consiste en arreglar las máquinas y motores de los coches en un taller?',
  '["Mecánico", "Agricultor", "Escritor", "Profesor"]'::jsonb,
  '"Mecánico"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'Una escoba y un recogedor son ejemplos de herramientas tecnológicas modernas que usan internet.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'Los electrodomésticos nos ayudan a realizar los trabajos del hogar de forma más rápida.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Qué fuente de energía utiliza una lavadora para poder girar y limpiar la ropa suelta?',
  '["Energía eléctrica", "Energía del viento", "Fuerza manual", "Energía solar"]'::jsonb,
  '"Energía eléctrica"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'Las herramientas como las tijeras sirven para cortar papel o telas de forma precisa.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'Un ordenador de mesa es una máquina simple compuesta por una sola pieza de madera.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Qué herramienta manual golpea los clavos para unirlos a la madera?',
  '["El martillo", "El serrucho", "La calculadora", "El lápiz"]'::jsonb,
  '"El martillo"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'Las máquinas necesitan algún tipo de energía para poder realizar movimientos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Qué aparato tecnológico nos permite imprimir en papel los dibujos que hacemos en la tablet?',
  '["La impresora", "El frigorífico", "El microondas", "La lavadora"]'::jsonb,
  '"La impresora"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'Las herramientas e instrumentos deben guardarse ordenados y limpios para evitar que se estropeen.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  '¿Qué aparato de la cocina usamos para calentar la leche muy rápido por las mañanas?',
  '["El microondas", "La lavadora", "El frigorífico", "El televisor"]'::jsonb,
  '"El microondas"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'Los coches eléctricos son máquinas tecnológicas que no producen humo y cuidan el aire.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What part of a machine has a spiral thread to hold things together?',
  '["screw", "lever", "spring", "switch"]'::jsonb,
  '"screw"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What machine part is a bar that tilts on a point to lift heavy objects?',
  '["lever", "screw", "motor", "wheel"]'::jsonb,
  '"lever"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What curly piece of metal bounces back after you press it?',
  '["spring", "switch", "motor", "wheel"]'::jsonb,
  '"spring"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What machine part turns around and around to make vehicles roll?',
  '["wheel", "screw", "lever", "switch"]'::jsonb,
  '"wheel"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What part do you press or click to turn a machine on or off?',
  '["switch", "motor", "spring", "screw"]'::jsonb,
  '"switch"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What internal part of an electric machine gives it power to move?',
  '["motor", "lever", "screw", "spring"]'::jsonb,
  '"motor"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'Which electric machine is used at home to blend or mix food?',
  '["blender", "oven", "vacuum", "fridge"]'::jsonb,
  '"blender"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'Which electric machine is used to keep our food very cold and fresh?',
  '["fridge", "microwave", "tv", "washing machine"]'::jsonb,
  '"fridge"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'Which appliance do we use to suck up dust and clean the floors?',
  '["vacuum", "blender", "oven", "microwave"]'::jsonb,
  '"vacuum"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'Which appliance gives us information and shows movies on a screen?',
  '["tv", "washing machine", "fridge", "blender"]'::jsonb,
  '"tv"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'Which technology invention uses science to let us talk to people far away?',
  '["telephone", "pen", "speaker", "rudder"]'::jsonb,
  '"telephone"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What small electronic device is used to store and carry data from a computer?',
  '["pen drive", "speaker", "roller skates", "excavator"]'::jsonb,
  '"pen drive"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What big technology invention is used on construction sites to dig big holes?',
  '["excavator", "bicycle", "aeroplane", "car"]'::jsonb,
  '"excavator"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What do we call the technology job of a person who thinks of new ideas for machines?',
  '["scientists", "technicians", "engineers", "computer experts"]'::jsonb,
  '"scientists"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What do we call the technology job of a person who designs new machines?',
  '["engineers", "scientists", "computer experts", "technicians"]'::jsonb,
  '"engineers"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What do we call the technology experts who code or programme machines?',
  '["computer experts", "technicians", "scientists", "engineers"]'::jsonb,
  '"computer experts"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'What do we call the technology job of a person who installs or fixes machines?',
  '["technicians", "engineers", "scientists", "computer experts"]'::jsonb,
  '"technicians"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'A vacuum helps you to clean our houses.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'A microwave is used to give you information and news.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'A blender makes a kitchen task easier and faster.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'A switch can be big or small and helps us turn appliances on.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'true_false',
  'An iron or a fan are devices that give us helpful text information.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'Which appliance uses heat to bake bread or cakes at home?',
  '["oven", "blender", "vacuum", "tv"]'::jsonb,
  '"oven"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000015',
  'multiple_choice',
  'Which machine part is a wheel with ridges used with a chain (ej. on a bicycle)?',
  '["wheel", "screw", "lever", "switch"]'::jsonb,
  '"wheel"'::jsonb,
  1
);

-- Natural Science / Materials and structures (50)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Cómo llamamos a los materiales que están hechos por un solo componente natural como el agua pura?',
  '["Sustancias puras", "Mezclas", "Transparentes", "Artificiales"]'::jsonb,
  '"Sustancias puras"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Cómo llamamos al resultado de juntar varios materiales diferentes como el agua con sal?',
  '["Mezclas", "Sustancias puras", "Opacos", "Energías"]'::jsonb,
  '"Mezclas"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'Utilizar un filtro o colador para separar la arena fina del agua es un proceso de separación de mezclas.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Cuál de estas es una propiedad observable de un cristal?',
  '["Es transparente", "Es elástico", "Es blando", "Es opaco"]'::jsonb,
  '"Es transparente"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'La ensalada de lechuga y tomate es un ejemplo de mezcla.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'El oro puro es un ejemplo de sustancia pura.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Qué material se usa para hacer vasos porque es transparente y duro?',
  '["El vidrio", "La madera", "La lana", "El papel"]'::jsonb,
  '"El vidrio"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'Podemos separar una mezcla de garbanzos y agua usando un colador.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'La sopa de fideos es un ejemplo de mezcla en la cocina.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'La sal común es un ejemplo de sustancia pura en la naturaleza.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Qué material se usa para fabricar ventanas debido a que es transparente?',
  '["El vidrio", "La madera", "El metal", "La lana"]'::jsonb,
  '"El vidrio"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'Podemos separar una mezcla de agua y fideos usando la filtración con un colador.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Qué material de la naturaleza es un ejemplo de sustancia pura?',
  '["El agua pura", "La ensalada", "El aire", "El plástico"]'::jsonb,
  '"El agua pura"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Cómo llamamos a la combinación de varios materiales sueltos como agua y arena?',
  '["Mezcla", "Sustancia pura", "Luz", "Sonido"]'::jsonb,
  '"Mezcla"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'Usar las manos o un tamiz para separar piedras de la tierra es un proceso para separar mezclas.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'Los materiales tienen propiedades observables como el color, el brillo o la textura.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Cómo llamamos a las estructuras formadas en la naturaleza sin intervención humana (ej. el nido de un pájaro)?, Greece',
  '["Estructuras naturales", "Estructuras artificiales", "Máquinas", "Tecnologías"]'::jsonb,
  '"Estructuras naturales"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Cómo llamamos a las estructuras construidas por las personas (ej. un puente o un edificio)?, Greece',
  '["Estructuras artificiales", "Estructuras naturales", "Herramientas", "Árboles"]'::jsonb,
  '"Estructures artificiales"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'Los puentes son estructuras artificiales construidas para cruzar ríos o carreteras con seguridad.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'El esqueleto de los animales es una estructura natural que sostiene su cuerpo.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Cuál de estas es una estructura artificial construida en las ciudades?',
  '["Una casa", "Una cueva de oso", "Una montaña", "Un tronco de árbol"]'::jsonb,
  '"Una casa"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Qué estructura fabrican las arañas de forma natural para atrapar a sus presas?',
  '["La telaraña", "El panal", "El nido", "La madriguera"]'::jsonb,
  '"La telaraña"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'Las estructuras de los edificios se diseñan para soportar mucho peso sin caerse.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'Las colmenas son estructuras artificiales construidas por ingenieros humanos.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'numeric',
  '¿Cuántas patas o pilares de apoyo suele tener una mesa ordinaria para mantenerse estable?',
  NULL,
  '4'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Cómo se clasifican los puentes, edificios y carreteras que construyen los obreros?',
  '["Estructuras artificiales", "Estructuras naturales", "Máquinas complejas", "Sustancias puras"]'::jsonb,
  '"Estructuras artificiales"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Cómo llamamos a las cuevas, montañas o los árboles que sirven de refugio natural a los animales?',
  '["Estructuras naturales", "Estructuras artificiales", "Herramientas manuales", "Mezclas"]'::jsonb,
  '"Estructuras naturales"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'Las estructuras artificiales son aquellas creadas únicamente por las arañas y los pájaros.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'Las casas y los colegios tienen estructuras fuertes para resistir el viento y la lluvia.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Qué estructura natural construyen las abejas para almacenar la miel en su colmena?',
  '["El panal", "El nido", "La madriguera", "La tela de araña"]'::jsonb,
  '"El panal"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  '¿Qué estructura artificial flotante construyen las personas para navegar por los ríos y mares?',
  '["Un barco", "Un puente", "Una casa", "Un coche"]'::jsonb,
  '"Un barco"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'Un nido de cigüeña en lo alto de una torre es un ejemplo de estructura natural.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'Las patas de una silla forman una estructura que soporta nuestro cuerpo cuando nos sentamos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'numeric',
  '¿Cuántas alas de apoyo suelen tener los aviones comerciales como estructura para volar?',
  NULL,
  '2'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'Which of the following is a completely natural structure from an animal''s body?',
  '["skeleton", "building", "bridge", "chair"]'::jsonb,
  '"skeleton"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'Which natural structure is built by beavers across a river?',
  '["beaver dam", "cave", "nest", "tree trunk"]'::jsonb,
  '"beaver dam"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'Which structure is artificial and built by humans to cross over a river?',
  '["bridge", "cave", "shell", "nest"]'::jsonb,
  '"bridge"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'Which artificial structure do humans use to reach the top of a roof?',
  '["ladder", "chair", "building", "bridge"]'::jsonb,
  '"ladder"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'What use of a structure describes an umbrella protecting a girl from the sun?',
  '["protect", "support", "hold", "reach"]'::jsonb,
  '"protect"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'What use of a structure describes crutches helping a boy to walk?',
  '["support", "reach", "protect", "give shape"]'::jsonb,
  '"support"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'What use of a structure describes a plastic bottle containing water?',
  '["hold", "support", "reach", "give shape"]'::jsonb,
  '"hold"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'What movement description means pulling a flexible structure to make it longer?',
  '["stretch", "push", "fold", "spin"]'::jsonb,
  '"stretch"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'What movement describes a spinning top moving around and around very fast?',
  '["spin", "bend", "fold", "pull"]'::jsonb,
  '"spin"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'What movement describes making a paper aeroplane by creasing the sheets?',
  '["fold", "stretch", "spin", "push"]'::jsonb,
  '"fold"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'Artificial structures are found ready-made in nature without human work.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'We use a bag to hold multiple objects inside.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'A shell protects a turtle''s body from weather or predators.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'true_false',
  'A chair is a natural structure made by honeybees.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'Which natural structure is built into rocks or ground and used as shelter?',
  '["cave", "nest", "tree trunk", "building"]'::jsonb,
  '"cave"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000016',
  'multiple_choice',
  'Which use of a structure describes a column supporting a roof?',
  '["support", "protect", "hold", "reach"]'::jsonb,
  '"support"'::jsonb,
  1
);

-- Natural Science / Plants (38)
INSERT INTO public.preguntas (tema_id, tipo, enunciado, opciones, respuesta, dificultad) VALUES
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Cómo llamamos a las plantas que crecen solas en la naturaleza sin que nadie las cuide?',
  '["Silvestres", "Cultivadas", "De hoja caduca", "Perennes"]'::jsonb,
  '"Silvestres"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Cómo llamamos a las plantas que siembran y riegan los agricultores para obtener alimentos?',
  '["Cultivadas", "Silvestres", "De hoja perenne", "Caducas"]'::jsonb,
  '"Cultivadas"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Cómo se llaman los árboles que pierden todas sus hojas cuando llega el otoño?',
  '["De hoja caduca", "De hoja perenne", "Silvestres", "Cultivadas"]'::jsonb,
  '"De hoja caduca"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Cómo se llaman los árboles que mantienen sus hojas verdes durante todo el año?',
  '["De hoja perenne", "De hoja caduca", "Cultivadas", "Hierbas"]'::jsonb,
  '"De hoja perenne"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'true_false',
  'La reproducción de muchas plantas comienza gracias a los insectos que visitan sus flores.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Qué parte de la planta protege a las semillas en su interior?',
  '["El fruto", "La raíz", "El tallo", "La hoja"]'::jsonb,
  '"El fruto"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Qué elemento enterramos en la tierra húmeda para que germine y crezca una planta nueva?',
  '["La semilla", "La flor", "El fruto", "La hoja"]'::jsonb,
  '"La semilla"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000013',
  'true_false',
  'El ciclo de vida de una planta incluye germinar, crecer, reproducirse y finalmente morir.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'true_false',
  'Las plantas son fundamentales porque fabrican el oxígeno que respiramos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'true_false',
  'Los cactus tienen espinas para adaptarse y sobrevivir en lugares muy secos donde no llueve.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Cuál de estas plantas es un árbol cultivado por el ser humano en un huerto?',
  '["El manzano", "El pino del bosque", "El musgo", "La amapola silvestre"]'::jsonb,
  '"El manzano"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Cómo se llaman las plantas que sembramos en los jardines y parques para adornar?',
  '["Plantas cultivadas", "Plantas silvestres", "Hoja caduca", "Arbustos"]'::jsonb,
  '"Plantas cultivadas"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Cómo llamamos a los árboles que pierden sus hojas secas en la estación de otoño?',
  '["De hoja caduca", "De hoja perenne", "Silvestres", "Hierbas"]'::jsonb,
  '"De hoja caduca"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000013',
  'true_false',
  'Las plantas de hoja perenne cambian y pierden todas sus hojas a la vez en invierno.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  '¿Qué parte coloreada y vistosa de la planta se transforma después en el fruto?',
  '["La flor", "La raíz", "El tallo", "La semilla"]'::jsonb,
  '"La flor"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'true_false',
  'Las semillas se encuentran guardadas y protegidas dentro de los frutos.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'true_false',
  'Las plantas no necesitan adaptarse al medio porque pueden caminar si cambia el clima.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'true_false',
  'Las plantas purifican el aire y sirven de alimento y refugio para muchos animales.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What do we call plants that grow completely alone in nature without human care?',
  '["wild plants", "cultivated plants", "deciduous plants", "evergreen plants"]'::jsonb,
  '"wild plants"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What do we call plants that grow in farms or gardens because people plant them?',
  '["cultivadas o cultivated", "wild plants", "non-seed plants", "spores"]'::jsonb,
  '"cultivadas o cultivated"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What group of plants uses seeds, flowers, fruits or cones to reproduce?',
  '["seed plants", "non-seed plants", "mosses", "ferns"]'::jsonb,
  '"seed plants"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What group of non-seed plants reproduces using tiny spores (ej. ferns and mosses)?',
  '["non-seed plants", "seed plants", "apple trees", "pine trees"]'::jsonb,
  '"non-seed plants"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What specific type of tree loses all its leaves during autumn and winter?',
  '["deciduous tree", "evergreen tree", "wild tree", "spore tree"]'::jsonb,
  '"deciduous tree"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What specific type of tree keeps its green leaves during all seasons of the year?',
  '["evergreen tree", "deciduous tree", "cultivated tree", "moss"]'::jsonb,
  '"evergreen tree"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What is the first step in the life cycle of a seed plant?',
  '["seed planting", "germination", "sprout", "seedling"]'::jsonb,
  '"seed planting"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What do we call the very young baby plant that just came out of the seed?',
  '["sprout", "seedling", "adult plant", "flower"]'::jsonb,
  '"sprout"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What do we call a small growing plant before it becomes an adult plant?',
  '["seedling", "sprout", "seed", "cone"]'::jsonb,
  '"seedling"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What useful product can humans make using the wheat plant?',
  '["bread", "clothes", "paper", "objects"]'::jsonb,
  '"bread"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What useful item can humans make using the soft cotton plant?',
  '["clothes", "bread", "juice", "paper"]'::jsonb,
  '"clothes"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What can we make using the hard wood from tree trunks?',
  '["paper", "clothes", "bread", "juice"]'::jsonb,
  '"paper"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What important plant function describes leaves turning to find sunlight?',
  '["adaptation o adapt", "germination", "reproduction", "cleaning air"]'::jsonb,
  '"adaptation o adapt"'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'true_false',
  'Ferns and mosses are examples of plants that reproduce with seeds.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'true_false',
  'An apple tree is a deciduous tree and a pine tree is an evergreen tree.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'true_false',
  'Plants are important because they clean the air we breathe.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'true_false',
  'A daisy is a cultivated plant grown in fields of wheat.',
  NULL,
  'false'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'true_false',
  'Deciduous trees lose all their leaves in autumn and winter.',
  NULL,
  'true'::jsonb,
  1
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'What do we call the stage where a seed breaks open and a tiny root starts to grow?',
  '["germination", "seed planting", "seedling", "adult plant"]'::jsonb,
  '"germination"'::jsonb,
  2
),
(
  'b2000001-0001-4000-8000-000000000013',
  'multiple_choice',
  'Which of the following is a non-seed plant that likes wet areas?',
  '["mosses", "pine tree", "apple tree", "wheat"]'::jsonb,
  '"mosses"'::jsonb,
  1
);

COMMIT;

-- Resumen: 1043 preguntas · 4 asignaturas
