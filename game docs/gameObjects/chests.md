# Player Chest Rules

## Overview

The **Player Chest** is a custom block with special rules for placement, access, and ownership. Its behavior depends on the world (dimension) where it is placed.

---

## Rules by World

### Hardcore (Overworld)

* **Placement:** Allowed anywhere.
* **Access:** Any player may open and use any chest.
* **Break/Move/Pickup:** Any player may break, move, or pick up a chest.
* **Ownership Transfer:** When a chest is removed from its location (broken, moved, picked up), ownership transfers to the player who performed the action.
* **Death Effect:** When a player dies, all Player Chests they own in the Hardcore world are deleted and all contents are lost.

### Nether (Under)

* **Placement:** Chests may only be placed within a 25-block radius of the player’s base portal.
* **Access:** Any player may open and use any chest.
* **Break/Move/Pickup:** Only the owner may break or move their chest. Admins with the `chest_admin` tag may bypass this rule.
* **Ownership Transfer:** Ownership does not change unless the chest is removed by the owner.

### End

* **Placement:** Chests may only be placed within a 25-block radius of the player’s base portal.
* **Access:** Only the owner may open and use their chest.
* **Break/Move/Pickup:** Only the owner may break or move their chest. Admins with the `chest_admin` tag may bypass this rule.
* **Ownership Transfer:** Ownership does not change unless the chest is removed by the owner.

---

## Special Conditions

* **Portal Requirement:** In the Nether and End, players must have a base portal set. Chests cannot be placed otherwise.
* **Explosions/Redstone:** Chests cannot be moved or destroyed by pistons, TNT, or other non-player forces, except in Hardcore where normal destruction applies.
* **Admin Bypass:** Players with the `chest_admin` tag can override break/move restrictions in any dimension.

---

## Key Points

1. Hardcore = free placement, free access, free breaking, but deletion on death.
2. Nether = portal radius placement, open access, break restricted to owner.
3. End = portal radius placement, **locked access**, break restricted to owner.
4. Ownership transfer only happens in Hardcore when another player removes a chest.
