export const AVATARES = [
  {
    id: "solete_avatar_conejo.png",
    nombre: "Conejo",
    src: "/assets/avatares/solete_avatar_conejo.png",
  },
  {
    id: "solete_avatar_leon.png",
    nombre: "León",
    src: "/assets/avatares/solete_avatar_leon.png",
  },
  {
    id: "solete_avatar_pez.png",
    nombre: "Pez",
    src: "/assets/avatares/solete_avatar_pez.png",
  },
  {
    id: "solete_avatar_pulpo.png",
    nombre: "Pulpo",
    src: "/assets/avatares/solete_avatar_pulpo.png",
  },
  {
    id: "solete_avatar_tiburon.png",
    nombre: "Tiburón",
    src: "/assets/avatares/solete_avatar_tiburon.png",
  },
  {
    id: "solete_avatar_tortuga.png",
    nombre: "Tortuga",
    src: "/assets/avatares/solete_avatar_tortuga.png",
  },
] as const;

export type AvatarId = (typeof AVATARES)[number]["id"];
