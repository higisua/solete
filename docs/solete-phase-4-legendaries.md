# Solete — Fase 4: Legendarios

Fecha: 2026-08-04  
Estado: **completada**

## Objetivo

Introducir los **15 cromos Legendarios** como progresión clara y motivadora (3 por categoría), **sin modificar** economía, diamantes, estrellas, sobres, tienda, misión, práctica, preguntas, medallas, Supabase/SQL ni autenticación.

Los legendarios son una **colección adicional**: no sustituyen comunes/raros/especiales y **nunca** se venden ni salen en sobres.

## Arquitectura

Sistema config-driven, reutilizable:

| Pieza | Rol |
|---|---|
| `src/lib/juego/legendaries.ts` | Catálogo central (`CATALOGO_LEGENDARIOS`) |
| `src/lib/juego/legendarios-eval.ts` | Stats, progreso, otorgamiento |
| `cromos_nino` | Ownership (sin tablas nuevas; `via: "compra"`, `diamantes_gastados: 0`) |
| Fila meta `__meta_racha_correctas` | Mejor racha de aciertos (`diamantes_gastados` = valor) |

Añadir un legendario = nueva entrada en `legendaries.ts` (+ PNG en `public/assets/cromos/`). No hace falta código por carta.

Cada definición incluye: `id`, `category`, `title`, `rarity`, `asset`, `description`, `unlockType`, `target` (si aplica), `hidden`, `orden`.

## Desbloqueos (exactos)

### Animales
- **Mariquita** — `missions_completed` → 5
- **Conejito** — `stars_earned` → 10
- **Pingüino** — `category_completed` (Animales, solo 5+2+1 normales)

### Transportes
- **Bicicleta** — `practice_sessions` → 10
- **Camión** — `questions_answered` → 200
- **Submarino** — `perfect_missions` → 5

### Comidas
- **Espaguetti** — `language_questions` → 75
- **Gofre** — `stars_earned` → 20
- **Huevos con patatas** — `all_medals`

### Deportes
- **Rugby** — `math_questions` → 100
- **Patinaje sobre hielo** — `correct_streak` → 15
- **Equitación** — `missions_completed` → 20

### Ciudades
- **Nueva York** — `cards_collected` → 30
- **Tokio** — `all_normal_albums_completed`
- **Marrakech** — `all_previous_legendaries` (último del juego)

## Progreso automático

`evaluarLegendarios(ninoId)` recalcula stats desde datos existentes (`misiones_diarias`, `sesiones`, `progreso`+asignaturas, `medallas_nino`, `cromos_nino`) y otorga los pendientes de forma idempotente.

Se invoca tras:
- `finalizarPartida` (misión y práctica; incluye racha de la sesión)
- compra / apertura de sobre (cuando hay cromo nuevo)

El álbum (`getLegendariosVista`) muestra progreso actual sin pasos manuales.

## Pantallas / componentes

### Nuevos
- `DesbloqueoLegendario` — celebración premium (`Solete` mood `cheer`, carta grande, borde legendario; **sin** confeti/partículas)
- Sección **Legendarios** en `ColeccionAlbum` (por categoría: imagen bloqueada, nombre oculto, descripción, barra `actual / meta`)

### Modificados
- `MotorPreguntas` — rastrea mejor racha de aciertos de la sesión
- `finalizarPartida` / `ResultadoGuardado` — `legendariosNuevos`
- `ResultadosPartida` — cola de celebración tras medallas (misión) o al terminar práctica
- `CromoCara` / `EtiquetaRareza` — soporte bloqueado legendario + etiqueta visible
- `cromos.ts` — exclusión tienda/sobres; `ColeccionVista.legendarios`

## Garantías tienda / sobres

- Legendarios **no** están en `CATALOGO_CROMOS`
- `probsSobre` no incluye legendary
- Fallback de sobres filtra `esRarezaVisible`
- `comprarCromo` rechaza rareza legendary

## Assets

Rutas existentes en `public/assets/cromos/*_legendaria_*` (incluye nombres NFD para ó/í). No se generaron ni renombraron imágenes.

## Validaciones

Ejecutado en el repo (2026-08-04):

| Check | Resultado |
|---|---|
| Typecheck (`npx tsc --noEmit` + build TS) | OK |
| Lint (`npm run lint`) | OK (solo warnings previos en actions, sin errores) |
| Build (`npm run build`) | OK |
