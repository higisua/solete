"use client";

import { useMemo } from "react";
import {
  Aparecer,
  CabeceraNino,
  Pantalla,
} from "@/components/ui";
import { MedalGroup } from "@/components/medallas/MedalGroup";
import { NextMedals } from "@/components/medallas/NextMedals";
import { SummaryHeader } from "@/components/medallas/SummaryHeader";
import { GRUPOS_MEDALLAS } from "@/lib/juego/medallas-grupos";
import {
  medallasCercanas,
  mensajeProxima,
  moodMedallas,
} from "@/lib/juego/medallas-ui";
import type { MedallaVistaItem } from "@/lib/juego/medallas-vista";

type Props = {
  conseguidas: number;
  total: number;
  items: MedallaVistaItem[];
};

/**
 * Panel de retos de medallas (Fase 8).
 * No modifica desbloqueos ni recompensas.
 */
export function MedallasVista({ conseguidas, total, items }: Props) {
  const { cercanas, earned, lockedByGroup, mensaje, mood } = useMemo(() => {
    const next = medallasCercanas(items, 4);
    const nextIds = new Set(next.map((m) => m.id));
    const earnedItems = items.filter((m) => m.conseguida);
    const lockedItems = items.filter(
      (m) => !m.conseguida && !nextIds.has(m.id),
    );

    const byGroup = GRUPOS_MEDALLAS.map((g) => ({
      ...g,
      earned: earnedItems.filter((m) => g.medallaIds.includes(m.id)),
      locked: lockedItems.filter((m) => g.medallaIds.includes(m.id)),
    }));

    return {
      cercanas: next,
      earned: earnedItems,
      lockedByGroup: byGroup,
      mensaje: mensajeProxima(next[0] ?? null),
      mood: moodMedallas({
        conseguidas,
        total,
        cercanas: next.length,
      }),
    };
  }, [items, conseguidas, total]);

  const hayBloqueadas = lockedByGroup.some((g) => g.locked.length > 0);

  return (
    <Pantalla className="fondo-halo-sol pb-10 pt-5" sinAtmosfera>
      <Aparecer>
        <CabeceraNino titulo="Medallas" />
      </Aparecer>

      <Aparecer delay={0.06} className="mt-4">
        <SummaryHeader
          conseguidas={conseguidas}
          total={total}
          mensaje={mensaje}
          mood={mood}
        />
      </Aparecer>

      <Aparecer delay={0.1} className="mt-6">
        <NextMedals items={cercanas} />
      </Aparecer>

      {earned.length > 0 ? (
        <Aparecer delay={0.14} className="mt-8">
          <h2 className="font-titulo text-lg font-semibold text-primary sm:text-xl">
            Conseguidas
          </h2>
          <p className="mt-0.5 font-cuerpo text-sm text-readable">
            ¡Tus premios!
          </p>
          <div className="mt-3 flex flex-col gap-5">
            {GRUPOS_MEDALLAS.map((g) => {
              const delGrupo = earned.filter((m) =>
                g.medallaIds.includes(m.id),
              );
              return (
                <MedalGroup
                  key={`earned-${g.id}`}
                  emoji={g.emoji}
                  titulo={g.titulo}
                  items={delGrupo}
                  mode="earned"
                />
              );
            })}
          </div>
        </Aparecer>
      ) : null}

      {hayBloqueadas ? (
        <Aparecer delay={0.18} className="mt-8">
          <h2 className="font-titulo text-lg font-semibold text-primary sm:text-xl">
            Por descubrir
          </h2>
          <p className="mt-0.5 font-cuerpo text-sm text-readable">
            Retos que todavía te esperan
          </p>
          <div className="mt-3 flex flex-col gap-5 opacity-95">
            {lockedByGroup.map((g) => (
              <MedalGroup
                key={`locked-${g.id}`}
                emoji={g.emoji}
                titulo={g.titulo}
                items={g.locked}
                mode="locked"
              />
            ))}
          </div>
        </Aparecer>
      ) : null}

      {conseguidas >= total && total > 0 ? (
        <Aparecer delay={0.2} className="mt-8 text-center">
          <p className="font-titulo text-lg font-semibold text-mar">
            ¡Has conseguido todas las medallas!
          </p>
        </Aparecer>
      ) : null}
    </Pantalla>
  );
}
