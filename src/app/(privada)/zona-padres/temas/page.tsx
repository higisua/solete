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
        <p className="mt-4 text-black/60">Añade un hijo para configurar temas.</p>
      </div>
    );
  }

  return (
    <div>
      <h1 className="font-titulo text-2xl font-semibold text-sol">Temas</h1>
      <p className="mt-1 text-sm text-black/55">
        Activa o desactiva lo que practica cada niño.
      </p>

      <div className="mt-6 flex flex-col gap-8">
        {ninos.map((nino) => {
          const asigs = (asignaturas ?? []).filter((a) => a.curso === nino.curso);
          return (
            <section key={nino.id}>
              <h2 className="font-titulo text-xl text-mar">{nino.nombre}</h2>
              <div className="mt-3 flex flex-col gap-4">
                {asigs.map((asig) => {
                  const temasAsig = (temas ?? [])
                    .filter((t) => t.asignatura_id === asig.id)
                    .sort((a, b) => a.orden - b.orden);
                  return (
                    <div key={asig.id} className="rounded-2xl bg-white p-4 shadow-sm">
                      <p className="font-titulo text-lg text-sol">{asig.nombre}</p>
                      <ul className="mt-3 flex flex-col gap-3">
                        {temasAsig.map((tema) => {
                          const activo = estaActivo(nino.id, tema.id);
                          return (
                            <li
                              key={tema.id}
                              className="flex items-center justify-between gap-3"
                            >
                              <span className="text-base text-black/80">{tema.nombre}</span>
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
                          <li className="text-sm text-black/45">Sin temas</li>
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
