import Link from "next/link";
import { ChevronRight } from "lucide-react";
import { cn } from "@/lib/cn";

export type MigaItem = {
  label: string;
  href?: string;
};

/** Migas de pan para la jerarquía Contenido → asignatura → tema. */
export function MigasContenido({
  items,
  className,
}: {
  items: MigaItem[];
  className?: string;
}) {
  return (
    <nav
      aria-label="Ruta"
      className={cn(
        "flex flex-wrap items-center gap-1 font-cuerpo text-sm text-black/45",
        className,
      )}
    >
      {items.map((item, i) => {
        const esUltimo = i === items.length - 1;
        return (
          <span key={`${item.label}-${i}`} className="inline-flex items-center gap-1">
            {i > 0 ? (
              <ChevronRight className="h-3.5 w-3.5 shrink-0 stroke-[2]" aria-hidden />
            ) : null}
            {item.href && !esUltimo ? (
              <Link
                href={item.href}
                className="font-titulo font-semibold text-mar hover:underline"
              >
                {item.label}
              </Link>
            ) : (
              <span
                className={cn(
                  esUltimo
                    ? "font-titulo font-semibold text-sol"
                    : "font-titulo font-semibold text-mar",
                )}
              >
                {item.label}
              </span>
            )}
          </span>
        );
      })}
    </nav>
  );
}
