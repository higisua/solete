import Image, { type ImageProps } from "next/image";
import { publicAsset } from "@/lib/public-asset";

type Props = Omit<ImageProps, "src"> & {
  /** Ruta relativa dentro de /public, ej. assets/logos/solete_logo.png */
  path: string;
};

/** Imagen de /public con cache-busting automático al cambiar el archivo. */
export function PublicImage({ path, alt, ...props }: Props) {
  return <Image src={publicAsset(path)} alt={alt} unoptimized {...props} />;
}
