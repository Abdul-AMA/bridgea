# Quick Fix for VPS Issues

## Problems:
1. Old docker-compose v1.29.2 (causes ContainerConfig error)
2. Python 3.11 → Need 3.12
3. debconf warnings

## Solution:

### On Your VPS (as root):

```bash
# Step 1: Clean up old containers
docker-compose down --remove-orphans
docker rm -f bridgeai-db-1

# Step 2: Install Docker Compose v2 (plugin)
apt-get update
apt-get install -y docker-compose-plugin

# Step 3: Remove old docker-compose v1
apt-get remove -y docker-compose

# Step 4: Verify new version
docker compose version
# Should show: Docker Compose version v2.x.x

# Step 5: From local, copy updated files
```

### From Your Local Machine:

```bash
cd /home/abood/coding/bridgeai

# Copy updated files
scp bridgeai-backend/Dockerfile root@207.154.233.229:/root/bridgeai/bridgeai-backend/
scp docker-compose.yml root@207.154.233.229:/root/bridgeai/
```

### Back on VPS:

```bash
cd /root/bridgeai

# Use docker compose (v2 - with space, not hyphen)
docker compose --env-file .env.production up -d --build

# Check logs
docker compose logs -f
```

## What Changed:

✓ **Python 3.11 → 3.12** in Dockerfile
✓ **Added DEBIAN_FRONTEND=noninteractive** (fixes debconf warnings)
✓ **Removed version: '3.8'** from docker-compose.yml (v2 doesn't need it)
✓ **Docker Compose v2** uses `docker compose` (space) not `docker-compose` (hyphen)

## Note:

The old `docker-compose` (hyphen) command is deprecated.
The new command is `docker compose` (space).

If you want an alias for convenience:
```bash
echo 'alias docker-compose="docker compose"' >> ~/.bashrc
source ~/.bashrc
```

---

**After fixing, your stack will use:**
- Python 3.12 ✓
- Next.js 20 ✓ (already configured)
- Docker Compose v2 ✓
