# Solete — Fase 1: UX Foundation

Fecha de análisis: 2026-08-04  
Estado: análisis → implementación

## 1. Qué hay en el proyecto

### Stack y rutas
- Next.js App Router (`src/app`), React 19, Tailwind v4 (tokens en `globals.css`, sin `tailwind.config`).
- Framer Motion en `src/components/ui/motion.tsx` (`Aparecer`, `ListaAparecer`, `Pulsable` — este último casi sin uso).
- Zona infantil: `/mundo`, `/practica`, `/jugar/*`, `/coleccion`, `/tienda`, `/medallas`, `/calendario`, `/quien-juega`.
- Zona adulta: `/zona-padres/*` (PIN + tabs), auth en `/(auth)` y `/` (`AccesoPantalla`).

### Sistema de diseño actual
- Colores: `--color-sol`, `sol-claro`, `mar`, `mar-claro`, `limon`, `crema`, `acierto`, `fallo`.
- Fuentes: Mali (`font-titulo`), Quicksand (`font-cuerpo`).
- UI compartida en `src/components/ui/`: `Boton`, `Tarjeta`, `Pantalla`, `Campo`, `EncabezadoPantalla` (casi sin uso).
- Stack paralelo legacy: `auth-ui.tsx` (`Button`/`Field`/`ErrorBox`) + botones/cabeceras inventados en cada pantalla.

### Problemas principales
1. **Incoherencia visual**: sombras (`0_6px_20px` vs `0_10px_28px`), radios (`22`/`24`/`26`/`3xl`), botones de 3 familias distintas.
2. **Cabeceras duplicadas**: chip “volver” copiado en colección, tienda, medallas, calendario; `EncabezadoPantalla` muerto.
3. **Jerarquía débil en home**: misión y secundarias compiten; logout adulto junto a la acción infantil.
4. **Contraste**: textos `text-black/45`–`/55` a veces flojos; coral claro como “error” poco semántico.
5. **Táctil**: chips de filtro tienda y celdas de calendario &lt; ~44px; locked cromos no anunciados.
6. **Estados**: sin `loading.tsx`/`error.tsx`, sin `EstadoVacio`/`EstadoError` compartidos; loaders = texto “…” .
7. **A11y**: `MotorPreguntas` ignora `prefers-reduced-motion`; modal colección sin focus trap; tabs acceso sin `aria-controls`.
8. **Pantalla**: `max-w-md` + blurs propios que a veces se suman a `.fondo-halo-sol`.

## 2. Archivos a modificar / crear

### Crear
- `docs/solete-phase-1-ux-foundation.md` (este documento)
- `src/components/ui/CabeceraNino.tsx` — volver + título + trailing
- `src/components/ui/BotonIcono.tsx` — chip circular 44×44
- `src/components/ui/EstadoVacio.tsx`
- `src/components/ui/EstadoError.tsx`
- `src/components/ui/ModalBase.tsx` — dialog accesible reutilizable
- `src/app/(privada)/loading.tsx` — skeleton ligero

### Consolidar / endurecer
- `src/app/globals.css` — tokens semánticos + sombras/radios/espaciado
- `src/components/ui/Boton.tsx` — size `sm`, variante `peligro`, reduced-motion, loading
- `src/components/ui/Tarjeta.tsx` — sombra unificada producto
- `src/components/ui/Pantalla.tsx` — safe-area, halo opcional, max-width
- `src/components/ui/EncabezadoPantalla.tsx` — integrar con CabeceraNino o deprecar uso
- `src/components/ui/index.ts` — exports

### Pantallas infantiles
- `MundoVista.tsx`, `practica/page.tsx`, `MotorPreguntas.tsx`, `QuienJuegaVista.tsx`
- `ColeccionAlbum.tsx`, `TiendaCromos.tsx`, `MedallasVista.tsx`, `CalendarioVista.tsx`
- `AccesoPantalla.tsx` (botones → `Boton`)

### Zona adulta (pulido ligero)
- `ZonaPadresShell.tsx`, `PinGate.tsx` — focus/targets/contraste sin rediseño estructural

## 3. Componentes compartidos propuestos

| Componente | Propósito |
|---|---|
| Tokens CSS semánticos | `bg-surface`, `text-primary`, sombras `--shadow-card` |
| `CabeceraNino` | Volver grande + título centrado + slot derecho |
| `BotonIcono` | Acciones discretas (ajustes, cambiar jugador) ≥44px |
| `Boton` ampliado | sm / peligro / isLoading / reduced-motion |
| `Tarjeta` unificada | Misma elevación en todo el producto |
| `EstadoVacio` / `EstadoError` | Copy + CTA reintentar |
| `ModalBase` | Overlay + dialog + Escape + scroll lock + focus |

## 4. Fuera de alcance (explícito)
Sin cambios de economía, medallas, cromos, misión, práctica extrema, RLS, SQL, sonidos, mapa, legendarios, tipos de pregunta nuevos.

---

## Implementación (completada)

Fecha de cierre: 2026-08-04  
Estado: **completada**

### 1. Resumen de cambios

- Tokens semánticos centralizados en `globals.css` (background, surface, text, primary, error, focus, sombras, radios, safe-area).
- Componentes base consolidados: `CabeceraNino`, `BotonIcono`, `BarraProgreso`, `ModalBase`, `EstadoVacio`, `EstadoError`, `Skeleton` / `PantallaCargando`.
- `Boton` ampliado (sm, peligro, isLoading, reduced-motion); `Tarjeta` / `Pantalla` unificados.
- `auth-ui` pasa a puente sobre `Boton` / `Campo` / `EstadoError` (sin romper formularios existentes).
- Home infantil: misión elevada; secundarias más ligeras; **cerrar sesión** relegado al pie.
- Práctica: jerarquía Normal vs Extremo; asignaturas/temas agrupados en tarjetas.
- Preguntas: enunciado, teclado, opciones y progreso más táctiles; `prefers-reduced-motion`.
- Colección / tienda / medallas / calendario: cabeceras unificadas, sombras/radios coherentes, estados vacío/progreso.
- Zona padres: contraste, focus y safe-area en shell; PIN con texto más legible.
- Loading boundary en `(privada)` con skeleton.

### 2. Archivos modificados / creados

**Nuevos**
- `docs/solete-phase-1-ux-foundation.md`
- `src/app/(privada)/loading.tsx`
- `src/components/ui/BotonIcono.tsx`
- `src/components/ui/CabeceraNino.tsx`
- `src/components/ui/BarraProgreso.tsx`
- `src/components/ui/ModalBase.tsx`
- `src/components/ui/EstadoVacio.tsx`
- `src/components/ui/EstadoError.tsx`
- `src/components/ui/Skeleton.tsx`

**Modificados (principales)**
- `src/app/globals.css`
- `src/components/ui/{Boton,Tarjeta,Pantalla,Campo,EncabezadoPantalla,motion,index}.tsx`
- `src/components/auth-ui.tsx`
- `src/components/mundo/MundoVista.tsx`
- `src/components/quien-juega/QuienJuegaVista.tsx`
- `src/app/(privada)/practica/page.tsx`
- `src/app/(privada)/jugar/mision/page.tsx`
- `src/components/juego/{MotorPreguntas,PreguntaMultiple,PreguntaTrueFalse,TecladoNumerico}.tsx`
- `src/components/cromos/{ColeccionAlbum,TiendaCromos}.tsx`
- `src/components/medallas/MedallasVista.tsx`
- `src/components/calendario/CalendarioVista.tsx`
- `src/components/acceso/AccesoPantalla.tsx`
- `src/components/zona-padres/{ZonaPadresShell,PinGate}.tsx`

### 3. Componentes nuevos o consolidados

| Componente | Rol |
|---|---|
| Tokens CSS | Roles semánticos + `shadow-card` / `rounded-card` / `touch-target` / `safe-*` |
| `CabeceraNino` | Volver + título + trailing |
| `BotonIcono` | Acciones ≥44×44 con `aria-label` |
| `Boton` | Variantes + loading + reduced-motion |
| `Tarjeta` | Elevaciones `card` / `elevated` |
| `BarraProgreso` | Progreso animado accesible |
| `ModalBase` | Dialog Escape + scroll lock + focus inicial |
| `EstadoVacio` / `EstadoError` | Estados recuperables |
| `PantallaCargando` | Skeleton de ruta privada |

### 4. Decisiones de diseño

- Mantener identidad coral/turquesa/crema y tipografías Mali/Quicksand.
- `--color-fallo` / `error` oscurecido a `#b54a32` para contraste (antes coral claro).
- Textos secundarios vía `text-readable` (`#4a453f`) en lugar de `black/45`.
- Logout fuera de la cabecera infantil (pie discreto).
- Normal = CTA elevado; Extremo = tarjeta secundaria (mismas reglas de economía).
- Sin BottomSheet dedicado: `ModalBase` adapta a bottom en móvil.
- `auth-ui` no eliminado: puente para no romper formularios adultos.

### 5. Mejoras de accesibilidad

- Focus visible unificado (`outline-focus`).
- `aria-label` en icon buttons; tabs de acceso con `aria-controls` / `aria-labelledby`.
- Modal: Escape, scroll lock, focus al panel.
- Teclado numérico: labels en borrar/OK.
- `prefers-reduced-motion` en botones, motor de preguntas y opciones.
- Cromos bloqueados mantienen `aria-label="Cromo pendiente"`.

### 6. Mejoras de rendimiento

- Duraciones de entrada acortadas (~240 ms).
- Press feedback con duración fija corta (sin springs pesados en botones).
- Skeleton de ruta evita flash vacío en navegación privada.
- Sin dependencias nuevas.

### 7. Pruebas ejecutadas

- Typecheck: `npx tsc --noEmit` — OK
- Lint: `npm run lint` — 0 errores (5 warnings preexistentes en actions)
- Build: `npm run build` — OK
- Tests automatizados: no hay suite de tests en el proyecto
- Revisión manual de código de flujos principales (login, perfiles, misión, práctica, colección, tienda, medallas, calendario, PIN, logout)

### 8. Resultados lint / typecheck / tests / build

| Check | Resultado |
|---|---|
| TypeScript | Pass |
| ESLint | Pass (warnings previos en `actions/*`) |
| Tests | N/A (sin tests) |
| `next build` | Pass |

### 9. Problemas detectados fuera de esta fase

- Formularios adultos de zona-padres aún usan radios/sombras inline en varias páginas (parcialmente cubiertos vía `auth-ui`, no migrados uno a uno).
- `EncabezadoPantalla` sigue poco usado (supersedido por `CabeceraNino` en flujos infantiles).
- Modal sin focus trap completo (sin dependencia de focus-trap).
- Sin `error.tsx` de ruta (solo loading skeleton).
- Tienda: botón del sobre grande sigue con tinte azul custom (marca del pack, no economía).

### 10. Recomendaciones Fase 2 (sin implementar)

- Mapa / aventura y misión por etapas.
- Game-feel de acierto/fallo (celebraciones, reacciones Solete, sonidos).
- Legendarios y rediseño funcional de tienda/economía.
- BottomSheet real para filtros / confirmaciones complejas.
- `error.tsx` + toasts no bloqueantes.
- Migrar resto de zona-padres 100% a `Tarjeta`/`Boton`/`Campo`.
- Focus trap robusto en modales si se añaden flujos adultos densos.
