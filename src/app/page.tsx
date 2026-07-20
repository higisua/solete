import Image from "next/image";

export default function Home() {
  return (
    <main className="flex min-h-dvh flex-col items-center justify-center bg-crema px-6">
      <Image
        src="/assets/logos/solete_logo.png"
        alt="Solete"
        width={280}
        height={120}
        priority
        className="h-auto w-full max-w-[280px]"
      />
      <h1 className="mt-6 text-center font-titulo text-3xl font-semibold text-sol sm:text-4xl">
        ¡Bienvenido a Solete!
      </h1>
    </main>
  );
}
