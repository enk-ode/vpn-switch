# TODO: IPv6-Teile in WireGuard-Configs ernsthaft behandeln

Status: offen (angelegt 2026-08-02)

## Problem

Neuere ProtonVPN-WireGuard-Configs (beobachtet ab ca. Juli 2026, z. B.
`wg-RS-39.conf` vom 2026-08-01) enthalten IPv6-Anteile:

```
Address = 10.2.0.2/32, 2a07:b944::2:2/128
DNS = 10.2.0.1, 2a07:b944::2:1
```

Auf einem Host ohne globales IPv6 (illyria: nd6 IFDISABLED, kein
GUA) schlägt `service wireguard start` mit einer so importierten
Config fehl. Ältere Configs (nur IPv4, z. B. `wg-AL-54.conf`) starten
problemlos.

## Aktueller Workaround (nur vorübergehend akzeptabel)

Die IPv6-Teile von Hand aus `Address =` und `DNS =` entfernen. Das
ist fehleranfällig und geht bei jedem neuen Config-Download verloren.

## Anforderung an vpn-switch

Der Import soll IPv6 explizit behandeln statt stillschweigend zu
scheitern:

1. Beim Import erkennen, ob der Host funktionsfähiges globales IPv6
   hat (nicht nur Link-Local).
2. Ohne IPv6: die IPv6-Anteile aus `Address`, `DNS` (und ggf.
   `AllowedIPs ::/0`) beim Import automatisch entfernen — mit
   sichtbarem Hinweis, nicht still.
3. Mit IPv6: Anteile unverändert übernehmen.
4. Verhalten per Flag übersteuerbar machen (z. B. `--strip-ipv6` /
   `--keep-ipv6`).
5. Tests: je eine Fixture mit IPv4-only- und Dual-Stack-Config in
   `test-configs/`, Fälle „Host ohne IPv6 importiert Dual-Stack" und
   „Host mit IPv6 importiert Dual-Stack".

## Offene Designfrage

Ob `AllowedIPs = ::/0` auf IPv4-only-Hosts entfernt oder belassen
wird, ist zu entscheiden: Belassen routet IPv6 ins Nichts (gewollt
als Leak-Schutz?), Entfernen ist minimal-invasiv. Leak-Schutz-Sicht
bevorzugt: belassen und dokumentieren.
