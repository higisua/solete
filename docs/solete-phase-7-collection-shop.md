# Solete — Fase 7: Colección & Tienda 2.0

Fecha: 2026-08-04  
Estado: **completada**

## Objetivo

Rediseñar **Mi colección** y **Tienda** para alinearlas visualmente con el resto de Solete.  
**Sin cambiar** economía, precios, sobres, probabilidades, desbloqueos, Supabase ni lógica de compra.

## Principio clave

> La colección se organiza **por categorías**, no por rarezas.

El niño piensa: *“quiero completar Animales”*, no *“quiero la sección Legendarios”*.

## Colección

### Antes
- Cromos normales arriba
- Bloque global de Legendarios abajo → dos álbumes aparentes

### Ahora
Cada categoría (`CollectionCategory`) incluye:
1. Cabecera + doble progreso (`8/8` · `👑 1/3`)
2. Grid de cromos normales
3. Barra de progreso
4. Expandible → legendarios + objetivos + tip Solete

Sin sección global de legendarios.

### Componentes
| Componente | Rol |
|---|---|
| `CollectionCategory` | Tarjeta expandible por temática |
| `CardGrid` | Grid de cromos del álbum |
| `LegendarySection` | Legendarios + progreso dentro de la categoría |
| `coleccion-mensajes.ts` | Tips Solete (`cheer` / `gift` / `happy`) |

## Tienda

### Jerarquía
1. **Categoría** — chips en wrap (sin scroll horizontal)
2. **Cromos** — protagonistas, tarjetas compactas
3. **Sobres** — acceso rápido abajo, unificado y compacto

### Componentes
| Componente | Rol |
|---|---|
| `ShopHeader` | Cabecera + tip Solete |
| `ShopFilters` | Chips de categoría |
| `CardItem` | Cromo en venta (imagen, rareza, nombre, precio) |
| `PackSelector` | Dos sobres lado a lado, mismo lenguaje visual |

### CardItem
Altura reducida: solo imagen + rareza + nombre + precio.

## Pantallas modificadas

- `ColeccionAlbum.tsx`
- `TiendaCromos.tsx`

Actions / economía / `cromos.ts` **sin cambios de reglas**.

## Microinteracciones

- Expandir/contraer categoría (chevron + height)
- Tap/active scale en cromos y chips
- Sobres con balanceo ligero (respeta reduced-motion)
- Solete solo cuando el tip aporta valor

## Validaciones

Ejecutado en el repo (2026-08-04):

| Check | Resultado |
|---|---|
| Typecheck (`npx tsc --noEmit` + build TS) | OK |
| Lint (`npm run lint`) | OK (warnings previos ajenos) |
| Build (`npm run build`) | OK |
