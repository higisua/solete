import { CatchupPremios } from "@/components/CatchupPremios";

export default function PrivadaLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <>
      <CatchupPremios />
      {children}
    </>
  );
}
