"use client";

import { useRouter } from "next/navigation";
import { useTransition } from "react";
import { setTemaActivoParaNino } from "@/app/actions/zona-padres";

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
      className={`relative h-8 w-14 shrink-0 rounded-full transition ${
        activo ? "bg-mar" : "bg-black/20"
      } disabled:opacity-50`}
    >
      <span
        className={`absolute top-1 h-6 w-6 rounded-full bg-white shadow transition ${
          activo ? "left-7" : "left-1"
        }`}
      />
    </button>
  );
}
