import { requireZonaPadres } from "@/app/actions/zona-padres";
import { ToggleTema } from "@/components/zona-padres/ToggleTema";
import { getNinosDeMiFamilia } from "@/lib/familia";
import { createClient } from "@/lib/supabase/server";

export default async function TemasPage() {
  await requireZonaPadres();
  const ninos = await getNinosDeMiFamilia();
  const supabase = await createClient();

  const { data: asignaturas } = await supabase
    .from("asignaturas")
    .select("id, nombre, curso")
    .order("nombre");

  const { data: temas } = await supabase
    .from("temas")
    .select("id, nombre, asignatura_id, orden")
    .order("orden");

  const ninoIds = ninos.map((n) => n.id);
  const { data: activosRows } =
    ninoIds.length > 0
      ? await supabase
          .from("temas_activos")
          .select("nino_id, tema_id, activo")
          .in("nino_id", ninoIds)
      : { data: [] as { nino_id: string; tema_id: string; activo: boolean }[] };

  const activoMap = new Map(
    (activosRows ?? []).map((r) => [`${r.nino_id}:${r.tema_id}`, r.activo]),
  );

  function estaActivo(ninoId: string, temaId: string): boolean {
    const key = `${ninoId}:${temaId}`;
    if (!activoMap.has(key)) return true; // sin fila = activo
    return activoMap.get(key) === true;
  }

  if (ninos.length === 0) {
    return (
      <div>
        <h1 className="font-titulo text-2xl font-semibold text-sol">Temas</h1>
        <p className="mt-4 font-cuerpo text-black/55">
          Añade un hijo para configurar temas.
        </p>
      </div>
    );
  }

  return (
    <div>
      <h1 className="font-titulo text-2xl font-semibold text-sol">Temas</h1>
      <p className="mt-1 font-cuerpo text-sm text-black/50">
        Activa o desactiva lo que practica cada niño.
      </p>

      <div className="mt-6 flex flex-col gap-8">
        {ninos.map((nino) => {
          const asigs = (asignaturas ?? []).filter((a) => a.curso === nino.curso);
          return (
            <section key={nino.id}>
              <h2 className="font-titulo text-lg font-semibold text-mar">
                {nino.nombre}
              </h2>
              <div className="mt-3 flex flex-col gap-3">
                {asigs.map((asig) => {
                  const temasAsig = (temas ?? [])
                    .filter((t) => t.asignatura_id === asig.id)
                    .sort((a, b) => a.orden - b.orden);
                  return (
                    <div
                      key={asig.id}
                      className="rounded-[22px] bg-white p-4 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.25)]"
                    >
                      <p className="font-titulo text-base font-semibold text-sol">
                        {asig.nombre}
                      </p>
                      <ul className="mt-3 flex flex-col gap-1">
                        {temasAsig.map((tema) => {
                          const activo = estaActivo(nino.id, tema.id);
                          return (
                            <li
                              key={tema.id}
                              className="flex items-center justify-between gap-3 rounded-xl px-1 py-2"
                            >
                              <span className="font-cuerpo text-base text-black/75">
                                {tema.nombre}
                              </span>
                              <ToggleTema
                                ninoId={nino.id}
                                temaId={tema.id}
                                activo={activo}
                                etiqueta={`${tema.nombre} para ${nino.nombre}`}
                              />
                            </li>
                          );
                        })}
                        {temasAsig.length === 0 ? (
                          <li className="font-cuerpo text-sm text-black/40">
                            Sin temas
                          </li>
                        ) : null}
                      </ul>
                    </div>
                  );
                })}
              </div>
            </section>
          );
        })}
      </div>
    </div>
  );
}
