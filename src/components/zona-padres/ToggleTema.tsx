"use client";

import { useRouter } from "next/navigation";
import { useTransition } from "react";
import { motion } from "framer-motion";
import { setTemaActivoParaNino } from "@/app/actions/zona-padres";
import { cn } from "@/lib/cn";

type Props = {
  ninoId: string;
  temaId: string;
  activo: boolean;
  etiqueta: string;
};

export function ToggleTema({ ninoId, temaId, activo, etiqueta }: Props) {
  const router = useRouter();
  const [pending, startTransition] = useTransition();

  function cambiar() {
    const fd = new FormData();
    fd.set("nino_id", ninoId);
    fd.set("tema_id", temaId);
    fd.set("activo", activo ? "false" : "true");
    startTransition(async () => {
      await setTemaActivoParaNino(fd);
      router.refresh();
    });
  }

  return (
    <button
      type="button"
      role="switch"
      aria-checked={activo}
      aria-label={etiqueta}
      disabled={pending}
      onClick={cambiar}
      className={cn(
        "relative h-9 w-14 shrink-0 rounded-full transition disabled:opacity-50",
        activo ? "bg-mar" : "bg-black/15",
      )}
    >
      <motion.span
        className="absolute top-1 h-7 w-7 rounded-full bg-white shadow-md"
        animate={{ left: activo ? 26 : 4 }}
        transition={{ type: "spring", stiffness: 480, damping: 28 }}
      />
    </button>
  );
}
