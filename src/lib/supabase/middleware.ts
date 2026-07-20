import { createServerClient } from "@supabase/ssr";
import { NextResponse, type NextRequest } from "next/server";

export async function updateSession(request: NextRequest) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL?.trim();
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY?.trim();

  if (!url || !key) {
    return NextResponse.next({ request });
  }

  let supabaseResponse = NextResponse.next({ request });

  const supabase = createServerClient(url, key, {
    cookies: {
      getAll() {
        return request.cookies.getAll();
      },
      setAll(cookiesToSet) {
        cookiesToSet.forEach(({ name, value }) => {
          request.cookies.set(name, value);
        });
        supabaseResponse = NextResponse.next({ request });
        cookiesToSet.forEach(({ name, value, options }) => {
          supabaseResponse.cookies.set(name, value, options);
        });
      },
    },
  });

  // Enlaces de confirmación / magia que llegan a /?code=... (no solo a /auth/callback)
  const code = request.nextUrl.searchParams.get("code");
  if (code) {
    const { error: exchangeError } = await supabase.auth.exchangeCodeForSession(code);
    const clean = request.nextUrl.clone();
    clean.searchParams.delete("code");
    if (!exchangeError && (clean.pathname === "/" || clean.pathname === "/login")) {
      clean.pathname = "/familia";
    }
    const redirectResponse = NextResponse.redirect(clean);
    supabaseResponse.cookies.getAll().forEach((cookie) => {
      redirectResponse.cookies.set(cookie.name, cookie.value);
    });
    return redirectResponse;
  }

  const {
    data: { user },
  } = await supabase.auth.getUser();

  const path = request.nextUrl.pathname;

  const rutasPublicas = [
    "/",
    "/login",
    "/registro",
    "/recuperar",
    "/actualizar-contrasena",
    "/auth/callback",
  ];
  const esPublica = rutasPublicas.some(
    (ruta) => path === ruta || path.startsWith(`${ruta}/`),
  );
  const esAuthForm =
    path.startsWith("/login") ||
    path.startsWith("/registro") ||
    path.startsWith("/recuperar");

  if (!user && !esPublica) {
    const redirectUrl = request.nextUrl.clone();
    redirectUrl.pathname = "/login";
    return NextResponse.redirect(redirectUrl);
  }

  if (user && esAuthForm) {
    const redirectUrl = request.nextUrl.clone();
    redirectUrl.pathname = "/familia";
    return NextResponse.redirect(redirectUrl);
  }

  return supabaseResponse;
}
