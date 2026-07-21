"use client";

import { Gem } from "lucide-react";
import { cn } from "@/lib/cn";

type Props = {
  diamantes: number;
  className?: string;
  size?: "sm" | "md";
};

export function SaldoDiamantes({ diamantes, className, size = "md" }: Props) {
  return (
    <div
      className={cn(
        "inline-flex items-center gap-1.5 rounded-full bg-white/90 font-titulo font-semibold text-mar shadow-[0_4px_14px_-8px_rgba(29,158,117,0.45)]",
        size === "md" ? "px-3 py-1.5 text-base" : "px-2.5 py-1 text-sm",
        className,
      )}
      aria-label={`${diamantes} diamantes`}
    >
      <Gem
        className={cn(size === "md" ? "h-4 w-4" : "h-3.5 w-3.5", "stroke-[2]")}
        aria-hidden
      />
      <span>{diamantes}</span>
    </div>
  );
}
