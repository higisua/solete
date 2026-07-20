import { resolverEntradaJuego } from "@/app/actions/juego";

/** Punto de entrada tras login: redirige a mundo, quién juega o familia. */
export default async function EntradaPage() {
  await resolverEntradaJuego();
}
