# Flag Game Object

## Overview
The Flag is a core game object representing a capture or control point in the world. This document defines its foundational structure and initial placement logic.

## Properties
- **id**: Unique identifier for the flag
- **position**: World coordinates for initial placement
- **owner**: (optional) Player or team that owns the flag
- **state**: Current state (e.g., placed, captured)

## Initial Placement
- Flags are placed at predefined coordinates when the world is initialized.
- Placement logic should ensure flags do not overlap with other objects.
- Example initial placement:
  - `position: { x: 100, y: 64, z: 100 }`

## Setup Instructions
1. Define flag objects in the world configuration.
2. On world initialization, place each flag at its designated position.
3. No UFO-related code or logic is included at this stage.

## Example JSON
```json
{
  "id": "flag_1",
  "position": { "x": 100, "y": 64, "z": 100 },
  "owner": null,
  "state": "placed"
}
```

## Next Steps
- Implement flag interaction logic (capture, scoring, etc.)
- Add visual representation in the game world
- Integrate with player/team systems
