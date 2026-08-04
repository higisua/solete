# Solete — Rediseño del Álbum (Concepto B: Mapa de colección)

Fecha: 2026-08-04  
Estado: **implementado**

## 1. Problemas detectados (antes)

- Legendarios escondidos tras acordeón (“pulsa para ver”).
- Sensación de dos álbumes o de lista de tareas.
- Objetivo poco claro: ¿completar categoría? ¿legendarios? ¿todo?
- Sin “siguiente cromo / siguiente mundo” emocional.
- Scroll denso de 5 bloques expandibles poco infantil.

## 2. Tres propuestas (diseño)

| Concepto | Idea |
|---|---|
| **A · Páginas** | Una categoría = una pantalla paginada |
| **B · Mapa** | Hub de 5 mundos + detalle (elegido) |
| **C · Vitrina** | Una pantalla plana + filtros “Me faltan” |

Detalle completo en la conversación de diseño previa.

## 3. Propuesta elegida

**Concepto B — Mapa de colección**

1. **Hub** (`MapaColeccion`): overview de 5 mundos, totales, tip Solete, card “Siguiente objetivo”.
2. **Detalle** (`CategoriaDetalle`): cromos + legendarios **siempre visibles**, sin acordeón.

## 4. Motivos

- Rompe la lista vertical / acordeón.
- Dos preguntas claras: *¿qué mundo?* → *¿qué me falta aquí?*
- Legendarios dejan de ocultarse.
- Alineado con la metáfora “Mundo de Solete”.
- Maximiza ilusión (islas) sin cambiar mecánicas.

## 5. Antes / después

| Antes | Después |
|---|---|
| Lista de categorías + acordeón de legendarios | Hub de mundos + detalle |
| “Toca para ver legendarios” | Legendarios siempre a la vista en el mundo |
| Sin foco de objetivo | “Siguiente objetivo” → mundo más cercano |
| Un solo scroll infinito | Hub corto + detalle enfocado |

*(Capturas de pantalla: añadir en QA manual si se desea.)*

## 6. Componentes nuevos

| Archivo | Rol |
|---|---|
| `MapaColeccion.tsx` | Hub |
| `MundoCategoriaCard.tsx` | Isla / mundo |
| `CategoriaDetalle.tsx` | Detalle de categoría |
| `mapa-coleccion.ts` | Helpers (colores, siguiente objetivo) |

Reutilizados: `CardGrid`, `LegendarySection`, `coleccion-mensajes`.

Eliminado: `CollectionCategory.tsx` (acordeón).

`CabeceraNino`: soporte `onVolver` para volver al mapa.

## 7. Validaciones

Ejecutado en el repo (2026-08-04):

| Check | Resultado |
|---|---|
| Typecheck (`npx tsc --noEmit` + build TS) | OK |
| Lint (`npm run lint`) | OK (warnings previos ajenos) |
| Build (`npm run build`) | OK |

## Sin cambios de negocio

Economía, cromos, rarezas, desbloqueos, legendarios y `getColeccionVista` intactos. Solo UX/navegación.
