# Solete — Fase 3: Game feel de la misión

Fecha: 2026-08-04  
Estado: **completada**

## Objetivo

Que responder ~20 preguntas se sienta como un **juego premium**, no como un formulario.  
Sin cambios de base de datos, economía, tienda, álbum, legendarios ni tipos de pregunta.

## Componentes nuevos / modificados

### Nuevos
- `src/components/juego/ContadorMision.tsx` — contador `1 / 20` con número animado

### Modificados
- `src/components/juego/MotorPreguntas.tsx` — timing, transiciones, Solete moods, cabecera viva
- `src/components/juego/FeedbackCapa.tsx` — feedback ligero (chip inferior, no pantalla muerta)
- `src/components/juego/PreguntaMultiple.tsx` — tarjetas más grandes, brillo, check, shake
- `src/components/juego/PreguntaTrueFalse.tsx` — botones mayores + feedback
- `src/components/juego/TecladoNumerico.tsx` — teclas modernas, press inmediato
- `src/components/juego/ResultadosPartida.tsx` — celebración de misión rediseñada
- `src/components/ui/BarraProgreso.tsx` — barra “viva” (`scaleX` + brillo al avanzar)

## Timing (sin botón Continuar)

| Fase | Duración |
|---|---|
| Revelar tarjeta (color/check/shake) | ~320 ms |
| Feedback acierto (overlay ligero) | ~580 ms |
| **Total acierto → siguiente** | **≈ 900 ms** |
| Feedback fallo | ~880 ms (+ revelar) ≈ 1,2 s |

## Animaciones añadidas

- Entrada/salida de pregunta: slide horizontal ~230 ms (`AnimatePresence mode="sync"`, sin pantalla en blanco)
- Contador y estrellas de aciertos: popLayout / spring
- Barra: spring en `scaleX` (GPU) + destello al avanzar
- Opciones: `whileTap` inmediato; acierto → escala + brillo; fallo → shake corto
- Teclado: escala al pulsar (~80 ms)
- Solete: `thinking` → `cheer` / `nervous` → `happy` (puente) → `thinking`
- Final de misión: Solete hero, estrellas escalonadas, diamantes, CTA con spring

## Mejoras UX

- Feedback inmediato al tocar (no “momento muerto”)
- Fallo nunca punitivo: shake suave + “¡Casi!” + respuesta correcta clara
- Overlay de feedback no tapa toda la pantalla (chip inferior)
- Barra y contador se sienten vivos
- Pantalla final más satisfactoria (misma lógica de estrellas/diamantes/medallas)

## Pantallas afectadas

- Misión diaria (`/jugar/mision`)
- Práctica libre (mismo motor)
- Resultados de misión / práctica

## Accesibilidad y rendimiento

- `prefers-reduced-motion` en todas las animaciones nuevas
- Preferencia por `transform`/`opacity` (barra con `scaleX`)
- Sin dependencias nuevas (React + Framer Motion)

## Validaciones

| Check | Resultado |
|---|---|
| `npx tsc --noEmit` | Pass |
| `npm run lint` | Pass (0 errores; warnings previos en actions) |
| `npm run build` | Pass |

## Cómo probar manualmente

1. Arrancar Solete en local y entrar a la **misión diaria**.
2. Comprobar: Solete `thinking` en cabecera; barra y contador animados.
3. Acertar: tarjeta brilla + check; Solete `cheer`; ~0,9 s y pasa sola.
4. Fallar: shake corto; Solete `nervous`; se ve la correcta; avanza sola.
5. Probar numérico, V/F y múltiple en móvil (320–430) y tablet.
6. Terminar misión: celebración (estrellas, diamantes, Solete, botones).
7. Activar “reducir movimiento”: animaciones estáticas / instantáneas.
8. Confirmar: sin botón Continuar; sin cambios en diamantes/estrellas reales.

## Fuera de alcance (siguientes fases)

- Cofres, legendarios visibles, mapa/aventura, sonidos, partículas nuevas, IA.
