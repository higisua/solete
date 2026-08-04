# Solete — Fase 2: Mascota y game feel

Fecha: 2026-08-04  
Estado: **completada**

## Objetivo

Convertir a Solete de logo decorativo en **compañero** del niño, y mejorar el *game feel* de las preguntas **sin** cambiar mecánicas, economía ni base de datos.

## Componentes creados

| Archivo | Rol |
|---|---|
| `src/components/solete/moods.ts` | Moods y tamaños centralizados |
| `src/components/solete/Solete.tsx` | Único punto de entrada de la mascota |
| `src/components/solete/index.ts` | Reexportes públicos |

### API

```tsx
<Solete mood="thinking" size="lg" animate className="…" />
```

Props: `mood`, `size`, `animate` (default true), `className`, `alt`, `priority`.

**No** usar `<Image src="/assets/mascot/…" />` directamente.

## Moods

`wave` · `happy` · `thinking` · `nervous` · `cry` · `gift` · `cheer` · `love` · `sleep`

Assets: `public/assets/mascot/{mood}.png` (sin modificar).

## Tamaños

`xs` (40) · `sm` (56) · `md` (80) · `lg` (112) · `xl` (144) · `hero` (192)

## Animaciones (Framer Motion, sutiles)

| Mood | Animación |
|---|---|
| happy | Respiración ligera |
| thinking | Balanceo lento |
| wave | Inclinación corta |
| gift | Rebote suave |
| cheer | Saltito corto |
| love | Latido suave |
| sleep | Respiración lenta |
| nervous | Temblor leve |
| cry | Sin animación |

Todas respetan `prefers-reduced-motion`.

## Pantallas modificadas

| Pantalla | Mood / cambio |
|---|---|
| ¿Quién juega? | `wave` |
| Mundo (home) | `happy` / `sleep` si misión hecha |
| Preguntas (cabecera) | `thinking` mientras responde |
| Feedback acierto | `cheer` + check elegante |
| Feedback fallo | `nervous` (nunca `cry`) |
| Resultados misión | `cheer` / `love` |
| Resultados práctica | `happy` |
| Acceso (login) | `wave` |
| Calendario | `happy` / `wave` |
| Apertura de sobre | `gift` |
| PIN zona padres | `thinking` |
| Familia (sin niños) | `wave` |
| Pronto | `thinking` |

Wordmark `solete_texto.png` se mantiene como marca; no es mascota.

## Game feel (sin cambiar reglas)

- Opciones: check en acierto, vibración horizontal suave en fallo.
- Verdadero/falso: misma filosofía.
- Teclado numérico: escala / shake al revelar.
- Transición entre preguntas algo más clara.
- Barra de progreso ya animada (Fase 1) + Solete acompañando.
- Feedback overlay más amable (fondo cálido, sin cruz agresiva).

## Rareza `legendary` (oculta)

- Tipo `RarezaCromo` incluye `"legendary"`.
- Color/label/precio tipados (`cromos-estilo`, `CROMOS_ECONOMIA.precios.legendary`).
- **No** está en `probsSobre` ni en el catálogo visible.
- Álbum filtra con `esRarezaVisible`.
- `EtiquetaRareza` no renderiza `legendary`.
- Assets en `public/assets/cromos/*_legendaria_*.png` listos; **no** se muestran.

Economía de comun/raro/especial/sobres: **sin cambio**.

## Decisiones

1. Solete es compañero, no juez: fallo → `nervous` + “¡Casi!”, nunca `cry`.
2. Misión hecha → `sleep` (descanso del día).
3. Animaciones cortas e infinitas muy suaves; reduced-motion = estático.
4. Un solo componente para toda la app.
5. Legendarios preparados en tipos, cero UX.

## Validaciones

| Check | Resultado |
|---|---|
| `npx tsc --noEmit` | Pass |
| `npm run lint` | Pass (warnings previos en actions) |
| `npm run build` | Pass |

## Cómo probar

1. `npm run dev` (p. ej. puerto 3001 si 3000 es otra app).
2. Login → ¿Quién juega? → Solete saluda (`wave`).
3. Mundo → Solete feliz; tras misión, dormido.
4. Misión → thinking en cabecera; acierto cheer; fallo nervous.
5. Práctica → mismos feedbacks; resultados happy.
6. Tienda → abrir sobre → gift.
7. Calendario / acceso / PIN → mascota coherente.
8. Activar “reducir movimiento” en el SO: animaciones parado.
9. Confirmar: tienda/álbum **sin** cromos legendarios; precios iguales.

## Fuera de alcance (siguiente)

- Legendarios visibles, mapa, sonidos, confeti nuevo, partículas, IA, nuevos tipos de pregunta.
