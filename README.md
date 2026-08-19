<div align="center">

# mod-multibot-bridge

### AzerothCore server-side bridge module for MultiBot Chatless

<strong>mod-multibot-bridge</strong> is the companion AzerothCore module used by the
<a href="https://github.com/Wishmaster117/MultiBot-Chatless">MultiBot-Chatless</a>
World of Warcraft addon.

It provides a structured addon-message bridge between the client UI and the server,
allowing MultiBot to refresh bot data without relying on automatic legacy chat parsing.

<br>

<a href="https://github.com/Wishmaster117/mod-multibot-bridge">
  <img alt="Repository" src="https://img.shields.io/badge/repository-mod--multibot--bridge-blue" />
</a>
<a href="https://github.com/Wishmaster117/MultiBot-Chatless">
  <img alt="Addon" src="https://img.shields.io/badge/addon-MultiBot--Chatless-green" />
</a>
<img alt="Core" src="https://img.shields.io/badge/core-AzerothCore-orange" />
<img alt="Architecture" src="https://img.shields.io/badge/protocol-MBOT-success" />
<img alt="Client" src="https://img.shields.io/badge/client-WotLK%203.3.5a-lightgrey" />

<br>

<img alt="linux-build" src="https://github.com/Wishmaster117/mod-multibot-bridge/actions/workflows/linux-build.yml/badge.svg?branch=main" />
<img alt="windows-build" src="https://github.com/Wishmaster117/mod-multibot-bridge/actions/workflows/windows-build.yml/badge.svg?branch=main" />
<img alt="macos-build" src="https://github.com/Wishmaster117/mod-multibot-bridge/actions/workflows/macos-build.yml/badge.svg?branch=main" />

<br><br>

<table>
  <tr>
    <th>Component</th>
    <th>Repository</th>
    <th>Install Location</th>
  </tr>
  <tr>
    <td><strong>Server Module</strong></td>
    <td>
      <a href="https://github.com/Wishmaster117/mod-multibot-bridge">
        mod-multibot-bridge
      </a>
    </td>
    <td>
      <code>azerothcore/modules/mod-multibot-bridge</code>
    </td>
  </tr>
  <tr>
    <td><strong>Client Addon</strong></td>
    <td>
      <a href="https://github.com/Wishmaster117/MultiBot-Chatless">
        MultiBot-Chatless
      </a>
    </td>
    <td>
      <code>World of Warcraft/Interface/AddOns/MultiBot</code>
    </td>
  </tr>
</table>

</div>

---

## Important Notice

This repository contains **only the AzerothCore server-side bridge module**.

You also need the client addon:

<div align="center">

### 👉 <a href="https://github.com/Wishmaster117/MultiBot-Chatless">MultiBot-Chatless</a>

</div>

Without the addon, this module does nothing visible by itself.  
Without this module, the addon cannot use the new bridge-first / mostly chatless UI refresh paths.

---

# What is mod-multibot-bridge?

`mod-multibot-bridge` is a server-side module that exposes structured Playerbot data to the MultiBot addon using addon messages.

Instead of forcing the addon to trigger bot commands and parse localized chat replies, the addon can send structured `MBOT GET~...` requests to the server.

The bridge then answers with structured payloads that the addon can consume directly.

<div align="center">

<table>
  <tr>
    <th>Legacy behavior</th>
    <th>Bridge-first behavior</th>
  </tr>
  <tr>
    <td>Addon triggers bot commands</td>
    <td>Addon sends structured <code>MBOT GET~...</code> requests</td>
  </tr>
  <tr>
    <td>Bots answer with chat text</td>
    <td>Bridge answers with structured addon messages</td>
  </tr>
  <tr>
    <td>Addon parses localized chat lines</td>
    <td>Addon consumes stable protocol payloads</td>
  </tr>
  <tr>
    <td>Automatic UI refresh creates chat spam</td>
    <td>Main UI refresh paths become mostly chatless</td>
  </tr>
</table>

</div>

---

# Requirements

## Server

- AzerothCore WotLK.
- AzerothCore source build environment.
- `mod-playerbots` installed and working.
- Ability to rebuild the server after adding a module.

## Client

- World of Warcraft 3.3.5a client.
- [`MultiBot-Chatless`](https://github.com/Wishmaster117/MultiBot-Chatless) installed in the client AddOns folder.

---

# Installation

## 1. Clone the module

Clone this repository into your AzerothCore `modules` directory:

```bash
cd /path/to/azerothcore/modules
git clone https://github.com/Wishmaster117/mod-multibot-bridge.git mod-multibot-bridge
```

Expected structure:

```text
azerothcore/
└── modules/
    └── mod-multibot-bridge/
        ├── conf/
        └── src/
```

---

## 2. Re-run CMake

After adding a new module, re-run CMake using your usual AzerothCore build workflow.

Example:

```bash
cd /path/to/azerothcore/build
cmake ../ -DCMAKE_INSTALL_PREFIX=/path/to/azerothcore/env/dist
```

Use the same CMake options you normally use for your server.

---

## 3. Rebuild AzerothCore

Rebuild your server after CMake detects the module.

Example:

```bash
cmake --build . --config Release
```

Or use your normal build command / IDE workflow.

---

## 4. Install or verify the module configuration

The module provides a configuration template:

```text
conf/MultiBotBridge.conf.dist
```

Depending on your AzerothCore setup, make sure the module configuration is copied, installed, or available in the configuration directory used by your worldserver.

Typical final layout may look similar to:

```text
azerothcore/env/dist/etc/modules/MultiBotBridge.conf
```

or:

```text
azerothcore/env/dist/etc/modules/MultiBotBridge.conf.dist
```

Follow the same config handling pattern you use for your other AzerothCore modules.

---

## 5. Start the server

Start `worldserver`.

When the module is loaded correctly and the addon connects, the server console should show bridge traffic similar to:

```text
MBOT HELLO
MBOT HELLO_ACK
MBOT PING
MBOT PONG
GET~ROSTER
GET~STATES
GET~DETAILS
```

---

# Client Addon Installation

Install the companion addon from:

<div align="center">

### 👉 <a href="https://github.com/Wishmaster117/MultiBot-Chatless">MultiBot-Chatless</a>

</div>

Clone it into your World of Warcraft AddOns directory:

```bash
cd "World of Warcraft/Interface/AddOns"
git clone https://github.com/Wishmaster117/MultiBot-Chatless.git MultiBot
```

Expected client structure:

```text
World of Warcraft/
└── Interface/
    └── AddOns/
        └── MultiBot/
            ├── MultiBot.toc
            ├── Core/
            ├── UI/
            └── ...
```

The addon folder must be named:

```text
MultiBot
```

not:

```text
MultiBot-Chatless
```

---

# Updating

## Update the bridge module

```bash
cd /path/to/azerothcore/modules/mod-multibot-bridge
git pull
```

Then re-run CMake if needed and rebuild AzerothCore.

## Update the addon

```bash
cd "World of Warcraft/Interface/AddOns/MultiBot"
git pull
```

---

# Protocol Overview

The bridge uses the `MBOT` addon-message prefix. The current **protocol version is `2`**
(`kProtocolVersion` in `MultiBotBridge.cpp`, `Comm.version` in the addon's `MultiBotComm.lua`).

**Framing.** A packet is `MBOT\t<OPCODE>~<payload>`. Fields inside a payload are separated
by `~`. Any field that could contain a delimiter or a newline is percent-encoded (`%` `~`
`\r` `\n` → `%XX`); the addon reverses this. Free-text fields (item lines, quest titles,
outfit names, error reasons) and the bot name in most streams are URL-encoded so they can
never collide with a separator. The `INV_*`, `SB_*` and `STATE`/`STATES` streams send the
bot name raw, and the addon reads it raw — safe on 3.3.5a, where a legal character name
cannot contain `%`, `~`, `\r` or `\n`, but the two sides must stay aligned if that ever
changes.

**Unknown verbs.** A message that carries the `MBOT` prefix is always consumed by the bridge,
never relayed on as ordinary addon chat. An unimplemented verb is answered with
`ERR~UNKNOWN_OPCODE~<verb>`.

**Streaming.** Any list that could exceed the addon-message length limit is sent as a
`<NAME>_BEGIN` / `<NAME>_ITEM` (one per element) / `<NAME>_END` sequence rather than a single
message — this applies to inventory, bank, guild bank, spellbook, quests, glyphs, outfits,
trainer, professions recipes, reputations, emblems, and (as of v2) the **roster**. Per-bot
streams that aren't `BEGIN/END`-framed (`DETAIL`, `STATE`) are always followed by a single
empty `DETAILS` / `STATES` terminator so the client can tell when the batch is complete.

Common request / response flow:

```text
Addon  -> Server: MBOT HELLO~<protocolVersion>
Server -> Addon:  MBOT HELLO_ACK~<protocolVersion>~mod-multibot-bridge

Addon  -> Server: MBOT PING~<token>
Server -> Addon:  MBOT PONG~<token>

Addon  -> Server: MBOT GET~ROSTER
Server -> Addon:  MBOT ROSTER_BEGIN~
                  MBOT ROSTER_ITEM~<name>,<class>,<level>,<map>,<alive>,<hp%>,<mp%>   (one per bot)
                  MBOT ROSTER_END~

Addon  -> Server: MBOT GET~STATES
Server -> Addon:  MBOT STATE~<name>~<combatStrategies>~<nonCombatStrategies>          (one per bot)
                  MBOT STATES~                                                        (terminator)
```

The exact payloads are consumed internally by the MultiBot addon.

**Rate limiting.** Bridge requests are throttled per player with a token bucket
(`MultiBotBridge.RequestsPerSecond`, default 10/s, and `MultiBotBridge.RequestBurst`,
default 20, in `MultiBotBridge.conf`; set `RequestsPerSecond = 0` to disable). Requests
beyond the budget are dropped silently — the addon's request watchdog surfaces the
timeout on the client side.

> **Version history**
> - **v2** — `ROSTER` is streamed as `ROSTER_BEGIN`/`ROSTER_ITEM`/`ROSTER_END` (was a single
>   `ROSTER~a;b;c` message that could be truncated for large raids); roster names are now
>   URL-encoded; `DETAIL` and `STATE` streams always emit their `DETAILS`/`STATES` terminator.
>   A v2 addon still accepts a v1 single-message `ROSTER` from an older bridge.
> - **v1** — initial bridge protocol.
>
> Additive, still v2 (no bump — every existing opcode is byte-for-byte unchanged, so older v2
> addons keep working): the bridge now answers unknown verbs with `ERR`, always terminates the
> `PROFESSION` stream with `PROFESSIONS~` (it previously did so only when the batch was empty),
> and ignores `RUN~OUTFIT`'s trailing persist flag — outfit writes are persisted unconditionally.
> It also adds `GET~RTSC` (`RTSC_BEGIN`/`RTSC_ITEM`/`RTSC_END`) and `RUN~RTSC` (`RTSC_ACK`) for
> playerbots' RTS-control feature; both are new opcodes, so a v2 addon that does not know them is
> unaffected.
>
> Additive, still v2: `RUN~RTSC` accepts two further bridge-only sub-commands, `lock` and
> `unlock`, which set playerbots' `RTSC selection locked` flag. While it is set, a plain marker
> cast moves the selected bots without rewriting anybody's `RTSC selected` — the fix for the
> rubber-band branch silently swapping an explicit role/group selection for "whoever stood within
> 10 yards of the click". They need the matching `RTSCSelectionLockedValue` in mod-playerbots; on a
> worldserver without it the flag does not exist, `RTSC_ACK` reports `executed = 0`, and the addon
> falls back to re-asserting the selection after each cast.

---

# Supported Bridge Areas

<table>
  <tr>
    <th>Area</th>
    <th>Purpose</th>
  </tr>
  <tr>
    <td><code>HELLO</code> / <code>HELLO_ACK</code></td>
    <td>Bridge handshake and protocol detection.</td>
  </tr>
  <tr>
    <td><code>PING</code> / <code>PONG</code></td>
    <td>Connection check between addon and bridge.</td>
  </tr>
  <tr>
    <td><code>GET~ROSTER</code></td>
    <td>Refresh bot roster without legacy chat parsing.</td>
  </tr>
  <tr>
    <td><code>GET~STATES</code></td>
    <td>Refresh bot state flags and UI state data.</td>
  </tr>
  <tr>
    <td><code>GET~DETAILS</code></td>
    <td>Refresh detailed bot information.</td>
  </tr>
  <tr>
    <td><code>GET~STATS</code></td>
    <td>Refresh stat panel data.</td>
  </tr>
  <tr>
    <td><code>GET~PVP_STATS</code></td>
    <td>Refresh PvP statistics panel data.</td>
  </tr>
  <tr>
    <td><code>GET~TALENT_SPEC_LIST</code></td>
    <td>Refresh available talent spec templates without automatic chat parsing.</td>
  </tr>
  <tr>
    <td><code>GET~INVENTORY</code></td>
    <td>Refresh inventory data with item links and icons.</td>
  </tr>
  <tr>
    <td><code>GET~BANK</code></td>
    <td>Refresh bot bank contents when a banker is available near the bot.</td>
  </tr>
  <tr>
    <td><code>GET~GBANK</code></td>
    <td>Refresh the bot guild bank snapshot and withdrawal-rights state without requiring the player to be in the same guild.</td>
  </tr>
  <tr>
    <td><code>GET~SPELLBOOK</code></td>
    <td>Refresh spellbook data.</td>
  </tr>
  <tr>
    <td><code>GET~BOT_SKILLS</code></td>
    <td>Refresh character info skills, professions, secondary skills, weapon skills and armor skills.</td>
  </tr>
  <tr>
    <td><code>GET~BOT_REPUTATIONS</code></td>
    <td>Refresh visible bot reputation standings for the Character Info frame.</td>
  </tr>
  <tr>
    <td><code>GET~BOT_EMBLEMS</code></td>
    <td>Refresh bot emblem counts and money for the Character Info currencies tab.</td>
  </tr>
  <tr>
    <td><code>GET~PROFESSION_RECIPES</code></td>
    <td>Refresh known profession recipes, materials, craftable counts and recipe output metadata.</td>
  </tr>
  <tr>
    <td><code>GET~GLYPHS</code></td>
    <td>Refresh glyph sockets, glyph spell IDs and tooltip data.</td>
  </tr>
  <tr>
    <td><code>GET~OUTFITS</code></td>
    <td>Refresh outfit sets and bridge outfit actions.</td>
  </tr>
  <tr>
    <td><code>GET~TRAINER</code></td>
    <td>Refresh spells a bot can learn from the player's currently selected trainer, including costs and affordability.</td>
  </tr>
  <tr>
    <td><code>GET~QUESTS</code></td>
    <td>Refresh bot quest lists without localized chat parsing.</td>
  </tr>
  <tr>
    <td><code>GET~GAMEOBJECTS</code></td>
    <td>Refresh game object search results for the addon results frame.</td>
  </tr>
  <tr>
    <td><code>RUN~CRAFT_RECIPE</code></td>
    <td>Ask a bot to craft one known profession recipe and return detailed cast failure reasons.</td>
  </tr>
  <tr>
    <td><code>RUN~ITEM_ACTION</code></td>
    <td>Run whitelisted inventory item actions such as bank deposit, bank withdraw, guild bank deposit, guild bank withdraw and vendor buy.</td>
  </tr>
  <tr>
    <td><code>RUN~OUTFIT</code></td>
    <td>Run outfit create, update, reset, equip and replace actions through the bridge. Outfit
    writes (<code>update</code> / <code>reset</code>) are persisted to the playerbots database
    immediately, so they survive a bot relog.</td>
  </tr>
  <tr>
    <td><code>RUN~TRAINER_LEARN</code></td>
    <td>Ask a bot to learn one trainer spell or all available trainer spells after revalidating the selected trainer.</td>
  </tr>
  <tr>
    <td><code>RUN~RTI</code></td>
    <td>Run whitelist-only RTI icon and RTI target commands.</td>
  </tr>
  <tr>
    <td><code>RUN~COMBAT</code></td>
    <td>Run whitelist-only combat strategy commands.</td>
  </tr>
  <tr>
    <td><code>RUN~POSITION</code></td>
    <td>Run whitelist-only disperse distance and disable commands.</td>
  </tr>
  <tr>
    <td><code>RUN~LOOT</code></td>
    <td>Run whitelist-only loot rules and loot list commands without addon-side chat parsing.</td>
  </tr>
  <tr>
    <td><code>GET~RTSC</code></td>
    <td>Read each bot's RTS-control state — selected flag, armed next-cast action, and the names of
    its saved locations. Streamed as <code>RTSC_BEGIN</code> / <code>RTSC_ITEM</code> /
    <code>RTSC_END</code>. Replaces playerbots' <code>rtsc show</code>, which answers by whisper.</td>
  </tr>
  <tr>
    <td><code>RUN~RTSC</code></td>
    <td>Run whitelist-only RTS-control commands (<code>enable</code>, <code>select</code>,
    <code>cancel</code>, <code>toggle</code>, <code>reset</code>, <code>move</code>,
    <code>last</code>, <code>show</code>, <code>go|show|save|unsave &lt;name&gt;</code>,
    <code>save here|selected &lt;name&gt;</code>), optionally prefixed with one playerbots chat
    filter such as <code>@tank</code> or <code>@group1-3</code>. Two sub-commands are bridge-only:
    <code>persist</code> flushes a bot's context to the playerbots DB (an armed
    <code>save</code> lands inside <code>SeeSpellAction</code>, which the bridge never sees), and
    <code>here</code> seeds <code>see spell location</code> with the requester's own position and
    replays it via <code>rtsc last</code>, regrouping the bots on the player in formation without
    any spell cast. <code>lock</code> / <code>unlock</code> set playerbots'
    <code>RTSC selection locked</code> flag, which stops a plain marker cast from replacing the
    selection with "whoever was within 10 yards of the click". Note the marker position itself can
    still only reach a bot through a real ground cast of spell 30758 from the master's client.</td>
  </tr>
  <tr>
    <td><code>ERR</code></td>
    <td>Server-to-addon only. Sent when a well-formed <code>MBOT</code> message carries a verb
    the bridge does not implement; the addon stores it in <code>MultiBot.bridge.lastError</code>.</td>
  </tr>
</table>

---

# Chatless Design

This module is designed to reduce automatic chat spam caused by UI refresh operations.

It does **not** remove manual playerbot commands.

Manual commands are still useful for diagnostics and gameplay actions.  
For example, players can still intentionally use commands such as:

```text
who
co ?
nc ?
ss ?
```

The bridge only replaces the automatic data-refresh paths used by the addon UI.

---

# Troubleshooting

<details>
<summary><strong>The module does not appear to load</strong></summary>

Check that the module is installed here:

```text
azerothcore/modules/mod-multibot-bridge
```

and that the structure is not nested incorrectly.

Correct:

```text
azerothcore/modules/mod-multibot-bridge/src
azerothcore/modules/mod-multibot-bridge/conf
```

Incorrect:

```text
azerothcore/modules/mod-multibot-bridge/mod-multibot-bridge/src
```

Then re-run CMake and rebuild the server.

</details>

<details>
<summary><strong>The addon loads but does not connect to the bridge</strong></summary>

Check that:

- `mod-multibot-bridge` was compiled into the server.
- `worldserver` was restarted after rebuilding.
- `MultiBot-Chatless` is installed in `Interface/AddOns/MultiBot`.
- The addon is enabled on the character selection screen.
- The server console shows `MBOT HELLO` / `HELLO_ACK` traffic when logging in or reloading the UI.

</details>

<details>
<summary><strong>I still see some bot chat messages</strong></summary>

The bridge removes automatic UI-refresh spam for migrated paths.

Manual commands and some gameplay write actions may still intentionally produce chat output.

In the addon, normal bridge-first usage should keep:

```lua
MultiBot.allowLegacyChatFallback = false
```

Only enable legacy fallback temporarily for debugging.

</details>

<details>
<summary><strong>Inventory, spellbook, glyphs or outfits are not updating</strong></summary>

Check the server console for requests such as:

```text
GET~INVENTORY
GET~SPELLBOOK
GET~GLYPHS
GET~OUTFITS
```

If these do not appear, the addon may not be connected to the bridge.

If they appear but data is missing, verify that the target bot is online, grouped, and available to the player.

</details>

<details>
<summary><strong>Profession recipe crafting fails from the addon</strong></summary>

Check the server console for responses such as:

```text
PROFESSION_RECIPE_CRAFT~BotName~token~skillId~spellId~itemId~ERR~REQUIRES_SPELL_FOCUS
PROFESSION_RECIPE_CRAFT~BotName~token~skillId~spellId~itemId~ERR~MOVING
PROFESSION_RECIPE_CRAFT~BotName~token~skillId~spellId~itemId~ERR~NO_MATERIALS
```

The addon displays localized messages for known bridge reasons.

For cooking recipes, `REQUIRES_SPELL_FOCUS` usually means the bot must be near a cooking fire.

</details>

---

# Repository Layout

```text
mod-multibot-bridge/
├── conf/
│   └── MultiBotBridge.conf.dist
└── src/
    ├── MultiBotBridge.cpp
    └── mod_multibot_bridge.cpp
```

---

# Related Repositories

<table>
  <tr>
    <th>Repository</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>
      <a href="https://github.com/Wishmaster117/MultiBot-Chatless">
        MultiBot-Chatless
      </a>
    </td>
    <td>
      Client-side World of Warcraft addon using the bridge-first UI refresh path.
    </td>
  </tr>
  <tr>
    <td>
      <a href="https://github.com/Wishmaster117/mod-multibot-bridge">
        mod-multibot-bridge
      </a>
    </td>
    <td>
      AzerothCore server-side bridge module.
    </td>
  </tr>
  <tr>
    <td>
      <a href="https://github.com/Wishmaster117/MultiBot-Standalone">
        MultiBot-Standalone
      </a>
    </td>
    <td>
      Deprecated combined repository kept for history.
    </td>
  </tr>
  <tr>
    <td>
      <a href="https://github.com/mod-playerbots/mod-playerbots">
        mod-playerbots
      </a>
    </td>
    <td>
      Original AzerothCore Playerbots module required for bot functionality.
    </td>
  </tr>
</table>

---

# Notes for Developers

This module is intentionally focused on exposing structured data to the addon.

Design goals:

- Keep the addon UI refresh paths independent from localized chat parsing.
- Preserve manual playerbot commands for diagnostics and gameplay.
- Keep the bridge protocol stable enough for addon-side consumers.
- Avoid unnecessary server-side behavior changes outside the bridge.
- Keep the module installable as a normal AzerothCore module.

---

# Credits

Built for use with AzerothCore `mod-playerbots` and the MultiBot addon ecosystem.

Thanks to the Playerbots team and the AzerothCore community.

---

<div align="center">

## mod-multibot-bridge

<strong>Structured server data for a cleaner, mostly chatless MultiBot UI.</strong>

<br><br>

<a href="https://github.com/Wishmaster117/mod-multibot-bridge">
  Bridge Module
</a>
&nbsp;•&nbsp;
<a href="https://github.com/Wishmaster117/MultiBot-Chatless">
  Client Addon
</a>

</div>
