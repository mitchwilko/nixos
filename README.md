# UNSC Device Naming Scheme

A Halo-inspired naming scheme for personal devices and homelab infrastructure.

The naming scheme is intentionally restricted to the **UNSC and associated characters/AIs**. Names should reflect the role of the device where possible.

## Current Devices

| Device       | Hostname            | Role                              |
| ------------ | ------------------- | --------------------------------- |
| MacBook      | `noble-six`         | Primary portable computer         |
| iPad         | `kelly`             | Portable secondary device         |
| iPhone       | `linda`             | Mobile device                     |
| HP Mini      | `infinity`          | Main server                       |
| ThinkPad     | `forward-unto-dawn` | Remote development machine        |
| Raspberry Pi | `roland`            | DNS / Caddy / network services    |
| Windows VM   | `reach`             | Windows compatibility environment |
| AI container | `cortana`           | Local AI                          |

## Naming Categories

### Personal Devices — Spartans

Personal computers and mobile devices are named after **Spartans**.

Examples:

* `noble-six` — primary laptop
* `kelly` — tablet
* `linda` — phone
* `john-117` — primary desktop
* `kat` — engineering workstation
* `jorge` — powerful workstation
* `jun` — lightweight/mobile computer
* `emile` — rugged or dedicated machine

Use Spartan names primarily for devices that are directly used by a person.

---

### Servers — UNSC Ships

Servers and major computing infrastructure are named after **UNSC ships**.

Examples:

* `infinity` — primary server / central infrastructure
* `forward-unto-dawn` — development server
* `pillar-of-autumn` — backup server
* `spirit-of-fire` — storage/media server
* `in-amber-clad` — secondary services
* `savannah` — smaller server

Larger or more important infrastructure should generally receive a more significant ship name.

---

### Small Infrastructure — UNSC Personnel

Small dedicated devices such as Raspberry Pis can use **UNSC personnel**.

For example:

* `roland` — Raspberry Pi providing DNS and Caddy
* `sergeant-johnson` — dedicated monitoring appliance
* `captain-keyes` — management/controller appliance
* `cortana` — AI service

This category is intentionally flexible and is particularly useful for small devices that don't warrant a ship name.

---

### AI and Software Services

AI services should use **Halo AI names**.

Examples:

* `cortana` — primary local AI
* `roland` — secondary/general-purpose AI
* `serina` — automation or orchestration AI
* `the-weapon` — experimental AI

AI names should refer to the **service**, rather than necessarily the physical machine hosting it.

For example:

```text
infinity
└── cortana
    └── qwen
```

This allows the AI to be moved to another server without changing its identity.

---

## Virtual Machines

Virtual machines can use **locations associated with the UNSC/Halo universe**.

For example:

* `reach` — Windows compatibility VM
* `harvest` — Linux testing VM
* `arcadia` — development/testing environment

VM names should describe the environment rather than the physical host.

For example:

```text
forward-unto-dawn
└── reach
    └── Windows
```

---

# Network Expansion

New infrastructure should follow the same basic rules.

## Routers and Gateways

Use significant UNSC ships for core network equipment.

Examples:

* `in-amber-clad` — main router
* `aegis-fate` — firewall
* `long-night-of-solace` — external/VPN gateway

## DNS / Network Services

Use smaller UNSC personnel or ships for dedicated network services.

Examples:

* `roland` — DNS
* `savannah` — DHCP
* `captain-keyes` — network management

## Additional Servers

Use UNSC ships according to their role.

```text
infinity
└── Main infrastructure

forward-unto-dawn
└── Development

pillar-of-autumn
└── Backup

spirit-of-fire
└── Storage

in-amber-clad
└── Secondary services
```

## Future Example Network

A larger network might eventually look like:

```text
                         INTERNET
                             │
                     in-amber-clad
                       Main Router
                             │
              ┌──────────────┴──────────────┐
              │                             │
          infinity                  forward-unto-dawn
        Main Server                  Dev Machine
              │                             │
       ┌──────┼──────┐                      └── reach
       │      │      │                          Windows VM
    cortana  gitea  webdav
       │
      Qwen

           roland
        Raspberry Pi
       DNS / Caddy
```

## Naming Principles

1. **UNSC only.**
2. **Spartans for personal devices.**
3. **UNSC ships for major servers.**
4. **UNSC personnel for small dedicated appliances.**
5. **AI names for AI/software agents.**
6. **Halo locations for virtual machines.**
7. Prefer names that reflect the device's role.
8. Don't reuse names when replacing hardware unless the new device has the same role.
9. Hostnames should use lowercase and hyphens where required.

The goal is for the hostname to be both **recognisable as part of the Halo theme** and **useful for identifying what the machine actually does**.

