# Solete — Fase 6: El Mundo de Solete (home)

Fecha: 2026-08-04  
Estado: **completada**

## Objetivo

Transformar la pantalla principal infantil (`/mundo`) de un **dashboard de tarjetas** en **El Mundo de Solete**: una home de juego limpia, sin scroll, con una sola acción dominante.

Sin cambios de lógica, economía, DB, misión, preguntas, álbum, tienda, legendarios ni medallas.

## Filosofía UX

| Antes | Ahora |
|---|---|
| “¿Qué menú pulso?” | “¿Qué aventura me espera hoy?” |
| Varias tarjetas compitiendo | Una misión protagonista |
| Sensación de app | Sensación de juego |

**No** se implementa mapa, bosque, ciudades, exploración, historia ni NPC.

## Estructura visual

```
┌─────────────────────────┐
│ avatar · ★ · 💎 · ⚙️    │  barra compacta
├─────────────────────────┤
│        Solete           │
│     ¡Hola Lola!         │  Greeting
│  mensaje diario corto   │  DailyStatus
├─────────────────────────┤
│                         │
│   MISIÓN / AVENTURA     │  MissionCard (~60% atención)
│   ¡Jugar! (pulso)       │
│                         │
├─────────────────────────┤
│ 📘 🗂 🛒 🏅 📅         │  QuickAccess
└─────────────────────────┘
```

Jerarquía: **una** acción primaria. El resto es secundario (iconos, sin tarjetas blancas grandes).

## Componentes nuevos

| Componente | Rol |
|---|---|
| `Greeting` | Solete + saludo personalizado |
| `DailyStatus` | Mensaje dinámico (máx. 2 líneas) |
| `MissionCard` | CTA / estrellas de la aventura del día |
| `QuickAccess` | Práctica, Álbum, Tienda, Medallas, Calendario |
| `daily-status.ts` | `resolverDailyStatus` (saludo + mood + mensaje) |

## Pantallas modificadas

- `src/components/mundo/MundoVista.tsx` — composición del Mundo
- `src/app/(privada)/mundo/page.tsx` — pasa `rachaDias` (ya en `ninos`)

Rutas de destino intactas (`/jugar/mision`, `/practica`, etc.).

## Mensajes dinámicos

- Sin jugar hoy → “¡Vamos a comenzar la aventura!” (`happy` / `wave`)
- Completada → “¡Buen trabajo! Descansa hasta mañana.” (`sleep` / `love`)
- Con racha (≥2) → “¡Llevas N días aprendiendo!” (combinable, máx. 2 líneas)

## Animaciones

- Solete con `animate` (respiración / mood existente)
- Botón ¡Jugar! con pulso suave periódico
- Entradas `Aparecer` / `ListaAparecer` ligeras
- Respeto a `prefers-reduced-motion`

## Decisiones

1. **Sin scroll** en móviles normales: `h-dvh` + `overflow-hidden` + flex.
2. **Sin mapa** todavía: solo reorganización de lo existente.
3. **Tienda** entra en QuickAccess (antes no estaba en la home de 4 chips).
4. **Colores / identidad** del design system sin cambios.
5. Logout adulto permanece discreto al pie.

## Validaciones

Ejecutado en el repo (2026-08-04):

| Check | Resultado |
|---|---|
| Typecheck (`npx tsc --noEmit` + build TS) | OK |
| Lint (`npm run lint`) | OK (warnings previos ajenos) |
| Build (`npm run build`) | OK |
