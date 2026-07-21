import { Baby, CalendarDays, Mail, Shield } from "lucide-react";
import { requireSuperadmin } from "@/app/actions/superadmin";
import { createClient } from "@/lib/supabase/server";
import { createClient as createAdminClient } from "@supabase/supabase-js";
import { cn } from "@/lib/cn";

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
      <p className="mt-1 font-cuerpo text-sm text-black/50">
        Familias registradas ({filas.length}). Solo lectura en esta versión.
      </p>
      {sinServiceRole ? (
        <p className="mt-3 rounded-[18px] bg-limon/35 px-3 py-2.5 font-cuerpo text-xs text-black/70">
          Para ver emails, añade <code className="font-semibold">SUPABASE_SERVICE_ROLE_KEY</code>{" "}
          en <code className="font-semibold">.env.local</code> (nunca en el
          cliente ni en git).
        </p>
      ) : null}

      <ul className="mt-6 flex flex-col gap-3">
        {filas.map((f) => {
          const fecha = new Date(f.creado_en).toLocaleDateString("es-ES", {
            day: "numeric",
            month: "short",
            year: "numeric",
          });
          const esSuper = f.rol === "superadmin";
          return (
            <li
              key={f.id}
              className="rounded-[22px] bg-white p-4 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.25)]"
            >
              <div className="flex items-start justify-between gap-2">
                <p className="min-w-0 font-titulo text-lg font-semibold text-sol">
                  {f.nombre}
                </p>
                <span
                  className={cn(
                    "inline-flex shrink-0 items-center gap-1 rounded-full px-2.5 py-1 font-titulo text-[11px] font-semibold",
                    esSuper
                      ? "bg-sol/15 text-sol"
                      : "bg-black/[0.05] text-black/50",
                  )}
                >
                  {esSuper ? (
                    <Shield className="h-3 w-3 stroke-[2]" aria-hidden />
                  ) : null}
                  {f.rol}
                </span>
              </div>

              <ul className="mt-3 flex flex-col gap-1.5">
                <li className="flex items-center gap-2 font-cuerpo text-sm text-black/60">
                  <Mail className="h-3.5 w-3.5 shrink-0 stroke-black/35 stroke-[2]" aria-hidden />
                  <span className="min-w-0 truncate">
                    {f.email ?? "email no disponible"}
                  </span>
                </li>
                <li className="flex items-center gap-2 font-cuerpo text-sm text-black/60">
                  <Baby className="h-3.5 w-3.5 shrink-0 stroke-black/35 stroke-[2]" aria-hidden />
                  {f.num_ninos} {f.num_ninos === 1 ? "niño" : "niños"}
                </li>
                <li className="flex items-center gap-2 font-cuerpo text-sm text-black/60">
                  <CalendarDays className="h-3.5 w-3.5 shrink-0 stroke-black/35 stroke-[2]" aria-hidden />
                  Alta {fecha}
                </li>
              </ul>
            </li>
          );
        })}
        {filas.length === 0 ? (
          <li className="rounded-[22px] bg-white px-4 py-6 text-center font-cuerpo text-black/50 shadow-[0_10px_28px_-14px_rgba(216,90,48,0.2)]">
            No hay familias.
          </li>
        ) : null}
      </ul>

      <p className="mt-8 font-cuerpo text-xs text-black/40">
        Acciones sensibles (borrar familias, cambiar roles, etc.) no están
        implementadas aún: las decidimos juntos antes de programarlas.
      </p>
    </div>
  );
}
