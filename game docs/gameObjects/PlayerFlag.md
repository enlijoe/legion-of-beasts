# Player Portal / Flag — Design Document

## Placement & Spawning

* **Spawn grant:** On first join, if the player has no base, they automatically receive **one Flag item** in inventory.
* **Peaceful-only placement:** That starter Flag can **only** be placed in the **Peaceful world**.
* **One per player (global).** If already placed anywhere, no new starter Flag is granted.

## Zone Geometry & Ownership

* **Base Zone shape:** A **vertical cylinder** with **radius = 25 blocks** that extends **from world bottom to world top**.
* **Ownership scope:** The player owns/build-governs **all land and blocks within that cylinder** across the full height.

## Distance Rules (XY-only)

* **Horizontal spacing only:** All spacing checks use **XY distance** (top-down plane), **ignoring Z**.
* **Peaceful & Under worlds:** Flag centers must be **≥ 3× radius apart** **in XY** (**≥ 75 blocks** if radius=25).
* **Hardcore world:** **No distance requirement** between flags.

## Movement / Relocation

* **Immovable by default.**
* **Ticketed move:** Only the **owner** can move their base by **consuming a Move Ticket**.

  * **UFO event:**

    * All **items owned by the player** (tagged objects, containers, pets, etc.) are **moved with the base**.
    * Any **blocks not placed by the player** are **not moved**.
    * **Peaceful & Survival:** After the UFO move, the **original map area is reset** to its pre-base state.
    * **Hardcore:**

      * Bases **can be moved with a ticket and UFO**, but they must **remain in Hardcore** (cannot leave this dimension).
      * No map reset occurs; the original terrain remains altered, creating **permanent scarring** where blocks were removed or resources consumed.
      * Over time, the Hardcore map will be **reset globally**. All surviving players will be moved back into the Survival map, and the Hardcore world will be reset clean. Surviving players receive an **award for being alive from one reset to the next**.
  * **Target worlds:** UFO can relocate the base to **any of the three maps**, **above ground only** (except Hardcore, which is restricted to Hardcore only).
  * **Peaceful rule remains:** The *initial* placement must be in Peaceful; later moves can target any allowed map (above ground).

## Flag Customization

* **Three sections on each flag:**

  1. **Team Art** — represents the player’s current team or faction; updates if team changes.
  2. **Player Art** — customizable by the player for personal identity.
  3. **Achievements / Ranks** — dynamically displays earned status markers:

     * **Conditional achievements**: only visible while the player continues to meet requirements.
     * **Permanent achievements**: once earned, never lost.
* **Dynamic updating:** Flag visuals automatically refresh when art or achievements change.

## Visibility Rules

* **Always visible:** The flag must never be hidden by player-placed blocks.
* **Z-axis adjustment:** If blocks are placed above the flag, it will automatically **move upward in the Z axis** to sit on top of those blocks.
* **XY lock:** The flag’s **X and Y coordinates never change** once placed.

## Shared Structures & Co-Ownership

* **Co-ownership model:** If multiple players contribute blocks to the same structure, that structure becomes **co-owned** by all contributors.

* **On death of a co-owner:** The deceased player’s contributions are **deleted**. It is as though they never existed, except:

  * The **resources they consumed** remain lost to the world.
  * The deletion leaves **permanent scars** where their blocks were removed.
  * **Side effect:** Co-owned builds carry **risk**. If one contributor dies, the structure may become broken or unstable.

* **Overlap resolution:** In overlapping builds, **block ownership determines outcome**. Each block is deleted or preserved based on which player owned it.

* **Chest ownership:**

  * If a player owns a chest and dies, the chest is **deleted**.
  * Any items in the chest that are owned by **other players** are also lost along with the chest.
  * **Note to players:** This is intentional behavior; storing items in another player’s chest is risky.

## Enforcement & Checks

* **XY-distance check** on placement and on ticketed move (must satisfy **≥75 blocks in XY** in Peaceful/Under worlds; Z is ignored).
* **Above-ground check** for UFO destinations in all three maps.
* **Origin cleanup:** On UFO move, run **terrain rollback** to the snapshot captured **before the player built anything** in that area (Peaceful & Survival only).
* **Inventory grant guard:** Starter Flag only appears if **no active/placed flag** exists for the player.

## Commands / Events

* `/pp moveticket give <player> <n>` — admin economy hook.
* `OnMoveTicketConsumed(player, fromPos, toPos, dim)`
* `OnTerrainRollback(area, snapshotId, result)`
* `OnFlagPlaced(player, pos, dim)`
* `OnFlagUpdated(player, section, type, value)` — fired when art or achievements change.
* `OnFlagRelocatedZ(player, newZ)` — fired when the flag auto-adjusts its Z height.
* `OnHardcoreReset(playersAlive, award)` — triggered when Hardcore map is globally reset.
* `OnCoOwnerDeath(structureId, player)` — triggered when a co-owner dies and their contributions are removed.

## Hardcore Special Rules

* **No flag spacing rules.** Flags can be placed close together.
* **Interaction freedom:** Players can interact with any game object **as in normal Minecraft**, except they cannot move or destroy **other players’ flags**.
* **Moves allowed within Hardcore only.**
* **Death reset:** On hardcore death, all items/bases wiped. Player spawns with new Flag in Peaceful world to start again.
* **Map scarring:** Since no resets happen on UFO moves, Hardcore maps accumulate permanent scars as resources are used up.
* **Periodic reset:** The Hardcore map is periodically reset; survivors are returned to Survival and awarded for lasting from one reset to the next.
