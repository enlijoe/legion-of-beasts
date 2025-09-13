# Legion of Beasts Infrastructure

Infrastructure-as-code for managing the **Legion of Beasts** Minecraft Bedrock server cluster.  
This repo defines **Dev**, **Test**, and **Prod** environments, their Docker Compose specs, and deployment scripts.

---

## 📂 Repo Structure


---

## 🌍 Environments

- **Dev**
  - Runs with creative mode for testing features.
  - Port: `19134`
  - Container: `bedrock-dev`

- **Test**
  - Mirrors Prod settings for pre-production validation.
  - Port: `19133`
  - Container: `bedrock-test`

- **Prod**
  - Public server environment.
  - Port: `19132`
  - Container: `bedrock-prod`

---

## 🚀 Workflow

1. **Edit configs**  
   Modify `docker-compose.yml`, `server.properties`, `allowlist.json`, or `permissions.json` under the relevant env.

2. **Commit and push**  
   Push to the `main` branch.

3. **CI/CD (GitHub Actions)**  
   On push, CI/CD will:
   - Validate configs
   - Sync files to the server (`/opt/minecraft/<env>`)
   - Run `remote-deploy.sh` to backup + redeploy
   - Verify the server booted successfully

4. **Connect to servers**
   - **Prod:** `<host-ip>:19132`
   - **Test:** `<host-ip>:19133`
   - **Dev:** `<host-ip>:19134`

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

