# Legion of Beasts Infrastructure

Infrastructure-as-code for managing the **Legion of Beasts** Minecraft Bedrock server cluster.
This repo defines **Dev**, **Test**, and **Prod** environments, their Docker Compose specs, deployment scripts, and now includes the full tool chain for asset creation and deployment.

---

## 📂 Repo Structure

* `packs/` – Minecraft resource and behavior packs

  * `resource_packs/lob_base/` – Models, textures, animations, render controllers
  * `behavior_packs/lob_base/` – Entities, items, blocks, recipes
* `assets/blender/` – 3D source assets

  * `src/` – **Source of truth**: `.blend` files, textures, reference art
  * `build/` – Generated `.glb` exports (ignored in Git)
* `scripts/` – Utility scripts (deployment, build, helpers)
* `docs/` – Documentation (`minecraft_tool_chain.md` etc.)
* `infra/` – Docker Compose files, environment templates, CI/CD configs

---

## 🌍 Environments

* **Dev**

  * Runs with creative mode for testing features.
  * Port: `19112`
  * Container: `bedrock-dev`

* **Test**

  * Mirrors Prod settings for pre-production validation.
  * Port: `19122`
  * Container: `bedrock-test`

* **Prod**

  * Public server environment.
  * Port: `19132`
  * Container: `bedrock-prod`

---

## 🚀 Workflow

1. **Edit configs / assets**

   * Game configs (`docker-compose.yml`, `server.properties`, `allowlist.json`, `permissions.json`).
   * 3D assets in Blender (`assets/blender/src/*.blend`).

2. **Build artifacts (local or CI)**

   * Use Blender (headless) to export `.glb` into `assets/blender/build/`.
   * CI/CD copies `.glb` models into `packs/resource_packs/lob_base/models/`.

3. **Commit and push**

   * Push source (`.blend`, configs, JSONs) to the `main` branch.

4. **CI/CD (GitHub Actions)**
   On push, CI/CD will:

   * Validate configs
   * Export + place model artifacts into ignored paths
   * Sync files to the server (`/opt/minecraft/<env>`)
   * Run `remote-deploy.sh` to backup + redeploy
   * Verify the server booted successfully

5. **Connect to servers**

  * **Prod:** `<host-ip>:19132`
  * **Test:** `<host-ip>:19122`
  * **Dev:** `<host-ip>:19112`

---

## 🔧 Management Commands

On the server:

```bash
# Enter an environment directory
cd /opt/minecraft/prod

# Start
sudo docker compose up -d

# Stop
sudo docker compose down

# Restart
sudo docker compose restart

# Logs
sudo docker logs -f bedrock-prod
```

---

## 🛠️ Tool Chain Overview

* **GitHub** – Remote repo hosting
* **Git CLI (Kenzi)** – Server-side pulls for deploys
* **VS Code (Dax)** – Main IDE with extensions (Git, Docker, JSON/YAML)
* **Amulet Editor** – Map/world editing (on exported backups)
* **Blender (4.5.3 LTS)** – 3D asset creation (source of truth)
* **Blockbench** – Converts Blender exports into Minecraft geometry/JSON when needed
* **Docker + docker-compose** – Containerized Bedrock servers
* **Samba (SMB)** – File sharing between Dax ↔ Kenzi
* **Custom scripts (/opt/minecraft, repo scripts/)** – Deployment, backup, build

---

## 🔒 Repo Policy

* **Do commit**: `.blend` source, textures, JSON configs, scripts, docs.
* **Do NOT commit**: `.glb` exports, world data, backups, `.env`, secrets, logs.
* `.gitignore` enforces these rules.
