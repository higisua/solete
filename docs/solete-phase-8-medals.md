# Solete — Fase 8: Medallas (panel de retos)

Fecha: 2026-08-04  
Estado: **completada**

## Objetivo

Replantear por completo la pantalla de medallas: de **listado de logros** a **panel de objetivos** que motive a seguir jugando.

Sin cambios en Supabase, SQL, economía, diamantes, condiciones de desbloqueo ni catálogo de medallas.

## Filosofía UX

| Antes | Ahora |
|---|---|
| Catálogo uniforme | Jerarquía clara de retos |
| Todas iguales | Dorada / casi / bloqueada |
| Poco progreso visible | Progreso protagonista |
| “Hay 26 tarjetas” | “¡Solo me falta una!” |

## Nueva estructura

1. **SummaryHeader** — conteo, %, barra general, tip Solete, mensaje de la próxima  
2. **A punto de conseguir** (`NextMedals`) — 3–4 más cercanas, tarjetas featured  
3. **Conseguidas** — agrupadas por tema, look dorado de premio  
4. **Por descubrir** — resto agrupado, compacto, curiosidad (no tristeza)

### Agrupación temática (solo UI)

| Grupo | Contenido |
|---|---|
| ☀️ Constancia | rachas / mes |
| 🏆 Misiones | perfectos, conteo de misiones |
| 📚 Aprendizaje | aciertos + práctica |
| 💎 Colección | cromos / álbumes |
| ⭐ Especiales | bienvenida |

## Componentes

| Componente | Rol |
|---|---|
| `SummaryHeader` | Cabecera potente |
| `NextMedals` | Retos casi listos |
| `MedalCard` | featured / earned / locked |
| `MedalProgress` | `6 / 7` + barra viva |
| `MedalGroup` | Grupo temático |
| `InsigniaMedalla` | Estados `earned` · `almost` · `locked` |

Helpers: `medallas-grupos.ts`, `medallas-ui.ts` (orden cercanas, mensajes, mood).

## Celebración al desbloquear

`FanfarriaNuevaMedalla`: sin confeti; Solete `cheer` + insignia dorada con spring.

## Iconos

Iconos de álbum diferenciados por categoría (huella, edificio, cubiertos, etc.) manteniendo el lenguaje Lucide.

## Pantallas modificadas

- `MedallasVista.tsx` — rediseño total  
- `InsigniaMedalla.tsx` — estados visuales  
- `FanfarriaNuevaMedalla.tsx` — celebración elegante  

Lógica: `getMedallasVista` / catálogo / otorgamiento **sin cambios de reglas**.

## Validaciones

Ejecutado en el repo (2026-08-04):

| Check | Resultado |
|---|---|
| Typecheck (`npx tsc --noEmit` + build TS) | OK |
| Lint (`npm run lint`) | OK (warnings previos ajenos) |
| Build (`npm run build`) | OK |
