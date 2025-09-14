// Flag Game Object Foundation
// This script defines the Flag object and sets up its initial placement in the world.
// No UFO code is included.

const FLAG_INITIAL_POSITION = { x: 100, y: 64, z: 100 };


class Flag {
    constructor(id, position = FLAG_INITIAL_POSITION, owner = null) {
        this.id = id;
        this.position = position;
        this.owner = owner;
        this.state = 'placed';
    }

    place(world) {
        // Logic to place the flag in the world at its position
        // This is a stub; actual implementation depends on game API
        world.placeObject({
            type: 'flag',
            id: this.id,
            position: this.position,
            owner: this.owner,
            state: this.state
        });
    }
}

// Grant starter flag to player inventory on first join
function grantStarterFlag(player, world) {
    // Check if player already has a base/placed flag
    if (player.hasPlacedFlag()) {
        return; // Do not grant if flag already placed
    }
    // Only grant in Peaceful world
    if (world.name !== 'Peaceful') {
        return;
    }
    // Grant one Flag item to inventory
    const flagItem = {
        type: 'block', // Ensure this is a block item
        blockType: 'flag', // Custom block type identifier
        id: `flag_${player.id}`,
        owner: player.id,
        state: 'inventory',
        position: null
    };
    player.inventory.add(flagItem);
}

// Example setup function for initial flag placement
function setupInitialFlags(world) {
    const flag = new Flag('flag_1');
    flag.place(world);
}

module.exports = {
    Flag,
    setupInitialFlags,
    grantStarterFlag
};
