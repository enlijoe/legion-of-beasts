import { world, system } from "@minecraft/server";

// Welcome on first spawn
world.afterEvents.playerSpawn.subscribe((ev) => {
  if (!ev.initialSpawn) return;
  system.run(() => ev.player.sendMessage("§aWelcome! Type §e!hello§a."));
});

// Simple chat commands (afterEvents is more tolerant on BDS)
world.afterEvents.chatSend.subscribe((ev) => {
  const msg = (ev.message ?? "").trim().toLowerCase();
  const p = ev.sender;
  if (msg === "!hello") {
    // reply only to the sender
    p.sendMessage("Hi from Script API 👋");
  }
});
