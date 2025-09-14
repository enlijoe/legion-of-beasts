# Minecraft Project Tool Chain

*Last updated: 2025-09-14*

## 1) Purpose

Single-source reference for the tools, locations, and workflows used to
build, test, and deploy the Minecraft project across **Dax** (Windows
workstation) and **Kenzi** (Ubuntu server).

------------------------------------------------------------------------

## 2) Hosts & Storage

-   **Dax (Windows, RTX 4080)**: Primary IDE/workstation; opens project
    files over network share.
-   **Kenzi (Ubuntu, RAID10, 10GbE)**: Server-side builds, Git
    operations, containers, and runtime.
-   **Share mapping**: `\\kenzi\\share` → **F:\\** on Dax; Kenzi local
    path: `/home/enli/share`
-   **Project root**: `/home/enli/share/Minecraft/` (inside the share)
-   **Infra/ops**: `/opt/minecraft` (deployment scripts, service files,
    etc.)

------------------------------------------------------------------------

## 3) Source Control

-   **GitHub**: Remote repository hosting (private).
-   **Git (CLI on Kenzi)**: Primary push/pull from server for clean
    deploys.
-   **Auth**: SSH keys configured on Kenzi (`~/.ssh`).
-   **Conventions**: Feature branches → PRs; tag releases for server
    rollouts.

------------------------------------------------------------------------

## 4) Editors & Tools

-   **Visual Studio Code (on Dax)**
    -   Opens workspace from **F:\\** (Samba share)
    -   Typical extensions: Git, Docker, YAML, JSON, Markdown
-   **Amulet Editor**
    -   World edits / map adjustments for Bedrock
    -   Works on exported/backup world files; never on live world
        directory
-   **JSON/YAML linters** (VS Code extensions) for config sanity

------------------------------------------------------------------------

## 5) Runtime & Packaging

-   **Minecraft Bedrock Dedicated Server (BDS)**
    -   Runs inside Docker containers
    -   Per-env data directories mounted into containers
-   **Docker & docker-compose**
    -   Compose files kept in repo (infra folder)
    -   Ports and volumes defined per environment (dev/test/prod)

------------------------------------------------------------------------

## 6) Networking & Access

-   **Samba**: Dax ↔ Kenzi file access (F:\\ on Dax)
-   **10GbE link**: Fast transfer between Dax and Kenzi
-   **Port forwarding**: Gateway rules per server (dev/test/prod)
-   **Allow-list / ops**: Managed via BDS config & JSON files

------------------------------------------------------------------------

## 7) CI/CD & Scripts

-   **Ops folder**: `/opt/minecraft`
    -   Deployment scripts
    -   Server start/stop/restart helpers
    -   Backup/export helpers for worlds
-   **Repo**: `legion-of-beasts-infra` (example name) holds compose
    files, env templates, docs
-   **Secrets & env**: `.env` files kept outside repo; `.gitignore`
    enforces exclusion

------------------------------------------------------------------------

## 8) Data & Paths (Bedrock)

-   `server.properties`, `allowlist.json`, `permissions.json` per
    environment
-   Volume mounts: `./data:/data` (compose) pointing to env-specific
    world directories
-   Backups stored under a dated folder structure, separate from live
    data

------------------------------------------------------------------------

## 9) Standard Workflows

### A. Edit → Commit (on Dax)

1.  Open **VS Code** on **F:\\Minecraft**.
2.  Edit code/config; run linters.
3.  Commit (can commit from Dax) or push via Kenzi git CLI.

### B. Pull → Deploy (on Kenzi)

1.  `cd /home/enli/share/Minecraft` (or infra repo)
2.  `git pull`
3.  Update `.env`/secrets if needed
4.  `docker compose up -d` (per env) or restart specific service

### C. World Editing (safe)

1.  Stop target server
2.  Backup/export world
3.  Edit copy in **Amulet**
4.  Validate locally; then replace world directory and restart

------------------------------------------------------------------------

## 10) Conventions & Hygiene

-   **No live edits** to running world directories
-   **.gitignore** includes: world data, backups, `.env`, secrets, logs
-   **Tagged releases** for prod changes; changelog notes for game-rule
    updates

------------------------------------------------------------------------

## 11) Future/Optional Tools

-   **Watchtower/Auto-redeploy** (container updates)
-   **Promtail/Loki/Grafana** or simple journald tailing for logs
-   **Uptime checks** (external pingers)

------------------------------------------------------------------------

## 12) Quick Reference

-   **Share paths**: Dax `F:\\` ↔ Kenzi `/home/enli/share`
-   **Ops dir**: `/opt/minecraft`
-   **Compose**: repo's infra folder
-   **Start/Stop**: `docker compose up -d` / `docker compose stop`
-   **Allow-list**: `allowlist.json`; **Ops** via `permissions.json`
