# Solete — Fase 5: La aventura diaria (etapas)

Fecha: 2026-08-04  
Estado: **completada**

## Objetivo

Convertir la misión de ~20 preguntas en una **pequeña aventura de 4 retos**, sin cambiar contenido, evaluación, economía, DB, álbum, legendarios ni medallas.

El niño no siente “una ficha de 20”. Siente: *superé cuatro retos y completé una aventura*.

## Qué no cambia

- Supabase / SQL  
- Economía, diamantes, estrellas  
- Tienda, álbum, legendarios, medallas  
- Banco de preguntas y dificultad  
- `finalizarPartida` y reglas de puntuación  

## Arquitectura

Sistema **config-driven** (no hay `if (pregunta === 5)`):

| Pieza | Rol |
|---|---|
| `src/lib/juego/mission-stages.ts` | `MISSION_STAGES` + `planificarEtapas` / `posicionEnEtapa` |
| `MotorPreguntas` | Fases UX de misión: intro → preguntas → puentes → última → resultados |
| Componentes de puente / progreso | UI de aventura |

Cambiar en el futuro a 4 preguntas/etapa o 6 etapas = editar `MISSION_STAGES` (y opcionalmente el array `stages`).

### Plan dinámico

`planificarEtapas(totalPreguntas)` reparte según `questionsPerStage`.  
Misión corta: menos etapas o última más corta; la lógica de evaluación sigue igual.

## Configuración (`MISSION_STAGES`)

- `questionsPerStage`: 5  
- `stages` (4): identidad infantil + color + mensajes de cierre  
  - ☀️ Primer reto  
  - 🌟 Segundo reto  
  - 🚀 Tercer reto  
  - 🏆 Gran final  
- `intro` / `lastStage` / `timings`  

Sin mapa, sin mundos, sin narrativa de exploración (eso es una fase posterior).

## Flujo UX

1. **Intro** — Solete + “¡Hoy tenemos una nueva aventura!” + ¡Empezar!  
2. **Preguntas** — misma experiencia Fase 3 (animaciones intactas)  
3. **Progreso dual** — segmentos de etapa + `pregunta / 5`  
4. **Puente** tras retos 1–3 (~1,1 s, auto) — Solete + mensaje elegante (sin confeti)  
5. **Inicio último reto** — “¡Ya estamos en el último reto!”  
6. **Gran final** — pantalla de resultados rediseñada (aventura completada)

## Componentes

### Nuevos
- `MisionIntro.tsx`
- `MisionPuenteEtapa.tsx`
- `ProgresoMisionEtapas.tsx`
- `mission-stages.ts`

### Modificados
- `MotorPreguntas.tsx` — fases de aventura (solo `modo === "mision"`)
- `ResultadosPartida.tsx` — final de aventura (sin confeti; resumen de retos)
- `lib/juego/index.ts` — exports

La **práctica** (`modo === "libre"`) no usa etapas.

## Validaciones

Ejecutado en el repo (2026-08-04):

| Check | Resultado |
|---|---|
| Typecheck (`npx tsc --noEmit` + build TS) | OK |
| Lint (`npm run lint`) | OK (warnings previos ajenos) |
| Build (`npm run build`) | OK |

## Responsive

Layout pensado para anchos típicos 320–1024 (`max-w-md`, tipografía fluida, cabecera compacta).
