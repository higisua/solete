import { requireSuperadmin } from "@/app/actions/superadmin";
import { createClient } from "@/lib/supabase/server";
import { createClient as createAdminClient } from "@supabase/supabase-js";

type FamiliaAdmin = {
  id: string;
  nombre: string;
  rol: string;
  creado_en: string;
  user_id: string;
  num_ninos: number;
  email: string | null;
};

async function emailsPorUserId(
  userIds: string[],
): Promise<Map<string, string>> {
  const map = new Map<string, string>();
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL?.trim();
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY?.trim();
  if (!url || !serviceKey || userIds.length === 0) return map;

  try {
    const admin = createAdminClient(url, serviceKey, {
      auth: { persistSession: false, autoRefreshToken: false },
    });
    // listUsers es paginado; para pocas familias basta la primera página ampliada
    const { data, error } = await admin.auth.admin.listUsers({ perPage: 200 });
    if (error || !data?.users) return map;
    const wanted = new Set(userIds);
    for (const u of data.users) {
      if (wanted.has(u.id) && u.email) map.set(u.id, u.email);
    }
  } catch (e) {
    console.warn("[usuarios] no se pudieron leer emails:", e);
  }
  return map;
}

export default async function UsuariosPage() {
  await requireSuperadmin();
  const supabase = await createClient();

  const { data: familias } = await supabase
    .from("familias")
    .select("id, nombre, rol, creado_en, user_id")
    .order("creado_en", { ascending: false });

  const { data: ninos } = await supabase.from("ninos").select("id, familia_id");

  const countByFamilia = new Map<string, number>();
  for (const n of ninos ?? []) {
    countByFamilia.set(n.familia_id, (countByFamilia.get(n.familia_id) ?? 0) + 1);
  }

  const emailMap = await emailsPorUserId((familias ?? []).map((f) => f.user_id));

  const filas: FamiliaAdmin[] = (familias ?? []).map((f) => ({
    id: f.id,
    nombre: f.nombre,
    rol: f.rol,
    creado_en: f.creado_en,
    user_id: f.user_id,
    num_ninos: countByFamilia.get(f.id) ?? 0,
    email: emailMap.get(f.user_id) ?? null,
  }));

  const sinServiceRole = !process.env.SUPABASE_SERVICE_ROLE_KEY?.trim();

  return (
    <div>
      <h1 className="font-titulo text-2xl font-semibold text-sol">Usuarios</h1>
      <p className="mt-1 text-sm text-black/55">
        Familias registradas ({filas.length}). Solo lectura en esta versión.
      </p>
      {sinServiceRole ? (
        <p className="mt-2 rounded-xl bg-limon/30 px-3 py-2 text-xs text-black/70">
          Para ver emails, añade <code>SUPABASE_SERVICE_ROLE_KEY</code> en{" "}
          <code>.env.local</code> (nunca en el cliente ni en git).
        </p>
      ) : null}

      <ul className="mt-6 flex flex-col gap-3">
        {filas.map((f) => {
          const fecha = new Date(f.creado_en).toLocaleDateString("es-ES", {
            day: "numeric",
            month: "short",
            year: "numeric",
          });
          return (
            <li key={f.id} className="rounded-2xl bg-white p-4 shadow-sm">
              <div className="flex items-start justify-between gap-2">
                <p className="font-titulo text-lg text-sol">{f.nombre}</p>
                <span
                  className={`rounded-full px-2 py-0.5 text-xs font-semibold ${
                    f.rol === "superadmin"
                      ? "bg-sol/15 text-sol"
                      : "bg-black/5 text-black/55"
                  }`}
                >
                  {f.rol}
                </span>
              </div>
              <p className="mt-1 text-sm text-black/60">
                {f.email ?? "email no disponible"}
              </p>
              <p className="mt-2 text-sm text-black/70">
                {f.num_ninos} {f.num_ninos === 1 ? "niño" : "niños"} · alta {fecha}
              </p>
            </li>
          );
        })}
        {filas.length === 0 ? (
          <li className="text-black/55">No hay familias.</li>
        ) : null}
      </ul>

      <p className="mt-8 text-xs text-black/45">
        Acciones sensibles (borrar familias, cambiar roles, etc.) no están
        implementadas aún: las decidimos juntos antes de programarlas.
      </p>
    </div>
  );
}
