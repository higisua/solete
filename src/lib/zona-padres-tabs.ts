export type TabZonaPadres = {
  href: string;
  label: string;
  icono: string;
  /** Solo visible para superadmin (Fase 5B). */
  soloSuperadmin?: boolean;
};

/** Pestañas base — todos los adultos. */
export const TABS_ZONA_PADRES_BASE: TabZonaPadres[] = [
  { href: "/zona-padres/hijos", label: "Hijos", icono: "👶" },
  { href: "/zona-padres/temas", label: "Temas", icono: "📚" },
  { href: "/zona-padres/resultados", label: "Resultados", icono: "📊" },
  { href: "/zona-padres/ajustes", label: "Ajustes", icono: "⚙️" },
];

/** Pestañas solo para superadmin (Fase 5B). */
export const TABS_ZONA_PADRES_SUPERADMIN: TabZonaPadres[] = [
  { href: "/zona-padres/contenido", label: "Contenido", icono: "✏️", soloSuperadmin: true },
  { href: "/zona-padres/usuarios", label: "Usuarios", icono: "👥", soloSuperadmin: true },
];

export function tabsZonaPadres(rol: "user" | "superadmin"): TabZonaPadres[] {
  if (rol === "superadmin") {
    return [...TABS_ZONA_PADRES_BASE, ...TABS_ZONA_PADRES_SUPERADMIN];
  }
  return [...TABS_ZONA_PADRES_BASE];
}
