import { AccesoPantalla, type PestanaAcceso } from "@/components/acceso/AccesoPantalla";

type Props = {
  searchParams: Promise<{ tab?: string }>;
};

export default async function LoginPage({ searchParams }: Props) {
  const params = await searchParams;
  const pestanaInicial: PestanaAcceso =
    params.tab === "crear" || params.tab === "registro" ? "crear" : "entrar";

  return <AccesoPantalla pestanaInicial={pestanaInicial} />;
}
