import { requireZonaPadres } from "@/app/actions/zona-padres";
import { getNinosDeMiFamilia } from "@/lib/familia";
import { createClient } from "@/lib/supabase/server";

export default async function ResultadosPage() {
  await requireZonaPadres();
  const ninos = await getNinosDeMiFamilia();
  const supabase = await createClient();

  if (ninos.length === 0) {
    return (
      <div>
        <h1 className="font-titulo text-2xl font-semibold text-sol">Resultados</h1>
        <p className="mt-4 text-black/60">Aún no hay niños.</p>
      </div>
    );
  }

  const ninoIds = ninos.map((n) => n.id);

  const [{ data: progresos }, { data: sesiones }, { data: temas }] = await Promise.all([
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
      <p className="mt-1 text-sm text-black/55">Resumen del progreso de tus hijos</p>

      <div className="mt-6 flex flex-col gap-6">
        {ninos.map((nino) => {
          const prog = (progresos ?? []).filter((p) => p.nino_id === nino.id);
          const puntos = prog.reduce((s, p) => s + (p.puntos ?? 0), 0);
          const estrellas = prog.reduce((s, p) => s + (p.estrellas ?? 0), 0);
          const recientes = (sesiones ?? [])
            .filter((s) => s.nino_id === nino.id)
            .slice(0, 5);
          const racha = nino.racha_dias ?? 0;

          return (
            <section key={nino.id} className="rounded-2xl bg-white p-4 shadow-sm">
              <h2 className="font-titulo text-xl text-sol">{nino.nombre}</h2>
              <div className="mt-3 grid grid-cols-3 gap-2 text-center">
                <div className="rounded-xl bg-crema py-2">
                  <p className="text-xs text-black/45">Puntos</p>
                  <p className="font-titulo text-xl text-mar">{puntos}</p>
                </div>
                <div className="rounded-xl bg-crema py-2">
                  <p className="text-xs text-black/45">Estrellas</p>
                  <p className="font-titulo text-xl text-sol">{estrellas}</p>
                </div>
                <div className="rounded-xl bg-crema py-2">
                  <p className="text-xs text-black/45">Racha</p>
                  <p className="font-titulo text-xl text-sol">{racha}🔥</p>
                </div>
              </div>

              {prog.length > 0 ? (
                <div className="mt-4">
                  <p className="text-sm font-semibold text-black/55">Por tema</p>
                  <ul className="mt-2 flex flex-col gap-1">
                    {prog.map((p) => (
                      <li
                        key={p.id}
                        className="flex justify-between text-sm text-black/75"
                      >
                        <span>{nombreTema.get(p.tema_id) ?? "Tema"}</span>
                        <span>
                          ⭐ {p.estrellas} · 💎 {p.puntos}
                        </span>
                      </li>
                    ))}
                  </ul>
                </div>
              ) : (
                <p className="mt-3 text-sm text-black/45">Sin progreso todavía</p>
              )}

              {recientes.length > 0 ? (
                <div className="mt-4">
                  <p className="text-sm font-semibold text-black/55">Últimas partidas</p>
                  <ul className="mt-2 flex flex-col gap-1">
                    {recientes.map((s) => {
                      const fecha = new Date(s.fecha).toLocaleDateString("es-ES", {
                        day: "numeric",
                        month: "short",
                      });
                      return (
                        <li key={s.id} className="text-sm text-black/70">
                          {fecha} · {s.modo === "mision" ? "Misión" : "Libre"} ·{" "}
                          {s.aciertos}/{s.total} ·{" "}
                          {nombreTema.get(s.tema_id) ?? "tema"}
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
