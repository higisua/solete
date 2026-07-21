export type TabZonaPadres = {
  href: string;
  label: string;
  /** Clave de icono Lucide resuelta en el shell. */
  icono:
    | "hijos"
    | "temas"
    | "resultados"
    | "ajustes"
    | "contenido"
    | "usuarios";
  /** Solo visible para superadmin (Fase 5B). */
  soloSuperadmin?: boolean;
};

/** Pestañas base — todos los adultos. */
export const TABS_ZONA_PADRES_BASE: TabZonaPadres[] = [
  { href: "/zona-padres/hijos", label: "Hijos", icono: "hijos" },
  { href: "/zona-padres/temas", label: "Temas", icono: "temas" },
  { href: "/zona-padres/resultados", label: "Resultados", icono: "resultados" },
  { href: "/zona-padres/ajustes", label: "Ajustes", icono: "ajustes" },
];

/** Pestañas solo para superadmin (Fase 5B). */
export const TABS_ZONA_PADRES_SUPERADMIN: TabZonaPadres[] = [
  {
    href: "/zona-padres/contenido",
    label: "Contenido",
    icono: "contenido",
    soloSuperadmin: true,
  },
  {
    href: "/zona-padres/usuarios",
    label: "Usuarios",
    icono: "usuarios",
    soloSuperadmin: true,
  },
];

export function tabsZonaPadres(rol: "user" | "superadmin"): TabZonaPadres[] {
  if (rol === "superadmin") {
    return [...TABS_ZONA_PADRES_BASE, ...TABS_ZONA_PADRES_SUPERADMIN];
  }
  return [...TABS_ZONA_PADRES_BASE];
}
