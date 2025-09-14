# Project Scripts

Centralized tooling for the **Legion of Beasts** project.  
Use these scripts to manage the development environment, Minecraft servers, and asset pipeline.

---

## 🔧 Environment

### `dev_env.sh`
Sets up environment variables and PATH.  

**Usage:**
```bash
source scripts/dev_env.sh
```

**Exports:**
- `REPO_ROOT` → repo root directory  
- `DOCKER_ROOT` → Docker infra root (`infra/`)  
- Adds `scripts/` to `PATH`  

---

### `dev.sh`
Wrapper that launches a new interactive shell with the dev environment preloaded.  

**Usage:**
```bash
scripts/dev.sh
```

---

## 🎮 Minecraft Server Management

### `minecraft`
Helper for managing Dockerized Bedrock servers.  

**Usage:**
```bash
minecraft <command> [env]
```

**Commands:**  
- `start` — start the server  
- `stop` — stop the server  
- `restart` — restart the server  
- `logs` — tail server logs  
- `status` — container status  

**Environments:**  
- `dev`  
- `test`  
- `prod`  

**Examples:**
```bash
minecraft start dev
minecraft logs prod
```

---

## 🏗️ Asset Pipeline

### `blender_export.py`
Blender script (run inside Blender) to export the currently opened `.blend` to `.glb`.  
Normally called by `build_models.sh`.  

**Usage (internal):**
```bash
blender -b file.blend --python scripts/blender_export.py -- --outdir assets/blender/build
```

---

### `build_models.sh`
Builds all `.blend` files in `assets/blender/src/` into `.glb` files in `assets/blender/build/`.  

**Usage:**
```bash
build_models.sh
```

**Optional vars:**  
- `BLENDER_BIN` → path to Blender binary (default: `blender`)  
- `SRC_DIR` → override source dir  
- `BUILD_DIR` → override build dir  

---

### `stage_models.sh`
Stages `.glb` files from `assets/blender/build/` into the resource pack models folder.  

**Usage:**
```bash
stage_models.sh
```

---

## 📝 Notes
- **Source of truth**: `.blend` files (committed to Git).  
- **Artifacts**: `.glb` files (ignored in Git, generated during build).  
- Scripts can be run from anywhere inside the repo if `dev_env.sh` has been sourced, or use `dev.sh` for convenience.  
