import Image from "next/image";
import type { ReactNode } from "react";
import { Flame, Gem, Star } from "lucide-react";
import { requireZonaPadres } from "@/app/actions/zona-padres";
import { getNinosDeMiFamilia } from "@/lib/familia";
import { AVATARES } from "@/lib/avatares";
import { publicAsset } from "@/lib/public-asset";
import { createClient } from "@/lib/supabase/server";
import { cn } from "@/lib/cn";

export default async function ResultadosPage() {
  await requireZonaPadres();
  const ninos = await getNinosDeMiFamilia();
  const supabase = await createClient();

  if (ninos.length === 0) {
    return (
      <div>
        <h1 className="font-titulo text-2xl font-semibold text-sol">
          Resultados
        </h1>
        <p className="mt-4 font-cuerpo text-black/55">Aún no hay niños.</p>
      </div>
    );
  }

  const ninoIds = ninos.map((n) => n.id);

  const [{ data: progresos }, { data: sesiones }, { data: temas }] =
    await Promise.all([
      supabase.from("progreso").select("*").in("nino_id", ninoIds),
      supabase
        .from("sesiones")
        .select("*")
        .in("nino_id", ninoIds)
        .order("fecha", { ascending: false })
        .limit(40),
      supabase.from("temas").select("id, nombre"),
    ]);

  const nombreTema = new Map((temas ?? []).map((t) => [t.id, t.nombre]));

  return (
    <div>
      <h1 className="font-titulo text-2xl font-semibold text-sol">Resultados</h1>
      <p className="mt-1 font-cuerpo text-sm text-black/50">
        Cómo van tus hijos, de un vistazo
      </p>

      <div className="mt-6 flex flex-col gap-5">
        {ninos.map((nino) => {
          const prog = (progresos ?? []).filter((p) => p.nino_id === nino.id);
          const puntos = prog.reduce((s, p) => s + (p.puntos ?? 0), 0);
          const estrellas = prog.reduce((s, p) => s + (p.estrellas ?? 0), 0);
          const diamantes =
            typeof nino.diamantes === "number" ? nino.diamantes : puntos;
          const recientes = (sesiones ?? [])
            .filter((s) => s.nino_id === nino.id)
            .slice(0, 5);
          const racha = nino.racha_dias ?? 0;
          const avatar = AVATARES.find((a) => a.id === nino.avatar);

          return (
            <section
              key={nino.id}
              className="rounded-[24px] bg-white p-4 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.28)]"
            >
              <div className="flex items-center gap-3">
                <div className="relative h-12 w-12 shrink-0 overflow-hidden rounded-full bg-[#FFF8ED] ring-2 ring-white">
                  {avatar ? (
                    <Image
                      src={publicAsset(`assets/avatares/${avatar.id}`)}
                      alt=""
                      width={48}
                      height={48}
                      unoptimized
                      className="h-full w-full object-contain p-0.5"
                    />
                  ) : (
                    <span className="flex h-full w-full items-center justify-center font-titulo text-lg text-sol">
                      {nino.nombre.slice(0, 1)}
                    </span>
                  )}
                </div>
                <div className="min-w-0">
                  <h2 className="font-titulo text-xl font-semibold text-sol">
                    {nino.nombre}
                  </h2>
                  <p className="font-cuerpo text-xs text-black/45">
                    {nino.curso}º primaria
                  </p>
                </div>
              </div>

              <div className="mt-4 grid grid-cols-3 gap-2">
                <Indicador
                  icono={<Gem className="h-4 w-4 stroke-mar stroke-[2]" />}
                  etiqueta="Diamantes"
                  valor={String(diamantes)}
                  tono="mar"
                />
                <Indicador
                  icono={
                    <Star className="h-4 w-4 fill-[#FAC775] stroke-[#E8A84A] stroke-[1.5]" />
                  }
                  etiqueta="Estrellas"
                  valor={String(estrellas)}
                  tono="sol"
                />
                <Indicador
                  icono={<Flame className="h-4 w-4 stroke-sol stroke-[2]" />}
                  etiqueta="Racha"
                  valor={`${racha} ${racha === 1 ? "día" : "días"}`}
                  tono="sol"
                />
              </div>

              {prog.length > 0 ? (
                <div className="mt-5">
                  <p className="font-titulo text-sm font-semibold text-black/50">
                    Por tema
                  </p>
                  <ul className="mt-2 flex flex-col gap-1.5">
                    {prog.map((p) => (
                      <li
                        key={p.id}
                        className="flex items-center justify-between gap-2 rounded-xl bg-[#FFF8ED]/80 px-3 py-2"
                      >
                        <span className="min-w-0 truncate font-cuerpo text-sm text-black/70">
                          {nombreTema.get(p.tema_id) ?? "Tema"}
                        </span>
                        <span className="inline-flex shrink-0 items-center gap-2 font-titulo text-xs font-semibold text-black/55">
                          <span className="inline-flex items-center gap-0.5">
                            <Star className="h-3 w-3 fill-[#FAC775] stroke-[#E8A84A]" />
                            {p.estrellas}
                          </span>
                          <span className="inline-flex items-center gap-0.5">
                            <Gem className="h-3 w-3 stroke-mar" />
                            {p.puntos}
                          </span>
                        </span>
                      </li>
                    ))}
                  </ul>
                </div>
              ) : (
                <p className="mt-4 font-cuerpo text-sm text-black/40">
                  Sin progreso todavía
                </p>
              )}

              {recientes.length > 0 ? (
                <div className="mt-5">
                  <p className="font-titulo text-sm font-semibold text-black/50">
                    Últimas partidas
                  </p>
                  <ul className="mt-2 flex flex-col gap-1.5">
                    {recientes.map((s) => {
                      const fecha = new Date(s.fecha).toLocaleDateString(
                        "es-ES",
                        { day: "numeric", month: "short" },
                      );
                      const esMision = s.modo === "mision";
                      return (
                        <li
                          key={s.id}
                          className="flex items-start justify-between gap-2 rounded-xl border border-black/[0.04] px-3 py-2"
                        >
                          <div className="min-w-0">
                            <p className="font-cuerpo text-sm text-black/70">
                              {fecha}
                              <span className="mx-1.5 text-black/25">·</span>
                              <span
                                className={cn(
                                  "font-titulo text-xs font-semibold",
                                  esMision ? "text-sol" : "text-mar",
                                )}
                              >
                                {esMision ? "Misión" : "Práctica"}
                              </span>
                            </p>
                            <p className="truncate font-cuerpo text-xs text-black/40">
                              {nombreTema.get(s.tema_id) ?? "tema"}
                            </p>
                          </div>
                          <p className="shrink-0 font-titulo text-sm font-semibold text-black/60">
                            {s.aciertos}/{s.total}
                          </p>
                        </li>
                      );
                    })}
                  </ul>
                </div>
              ) : null}
            </section>
          );
        })}
      </div>
    </div>
  );
}

function Indicador({
  icono,
  etiqueta,
  valor,
  tono,
}: {
  icono: ReactNode;
  etiqueta: string;
  valor: string;
  tono: "sol" | "mar";
}) {
  return (
    <div className="rounded-2xl bg-[#FFF8ED] px-2 py-3 text-center">
      <div className="flex justify-center">{icono}</div>
      <p className="mt-1 font-cuerpo text-[10px] uppercase tracking-wide text-black/40">
        {etiqueta}
      </p>
      <p
        className={cn(
          "mt-0.5 font-titulo text-lg font-semibold leading-tight",
          tono === "mar" ? "text-mar" : "text-sol",
        )}
      >
        {valor}
      </p>
    </div>
  );
}
