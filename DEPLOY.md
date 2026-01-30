# Deploy to VPS - bridge-ai.dev

## Deployment Strategy

**Code**: Clone from GitHub repository
**Config**: Copy only 5 config files to VPS

## Files to Copy Manually

Only these 5 files from the main directory:
```
├── docker-compose.yml          ← Container orchestration
├── .env.production             ← Your production config (NEVER commit to Git!)
├── .gitignore                  ← Git settings
├── nginx.conf                  ← Reverse proxy config
└── DEPLOY.md                   ← This file (optional)
```

**IMPORTANT**: Never commit `.env.production` to GitHub!

## Deployment Steps

### 1. On Your VPS - Clone Repository

```bash
# SSH into your VPS
ssh root@207.154.233.229

# Clone your repository
cd /root
git clone https://github.com/yourusername/bridgeai.git
cd bridgeai
```

### 2. From Local - Copy Config Files

```bash
# From your local machine, copy the 5 files
cd /home/abood/coding/bridgeai

# Copy to VPS
scp docker-compose.yml root@207.154.233.229:/root/bridgeai/
scp .env.production root@207.154.233.229:/root/bridgeai/
scp .gitignore root@207.154.233.229:/root/bridgeai/
scp nginx.conf root@207.154.233.229:/root/bridgeai/
scp DEPLOY.md root@207.154.233.229:/root/bridgeai/
```

### 3. On VPS - Secure and Start

```bash
# SSH into VPS
ssh root@207.154.233.229
cd /root/bridgeai

# Secure the environment file
chmod 600 .env.production

# Start all services
docker-compose --env-file .env.production up -d

# Check logs
docker-compose logs -f
```

### 4. Verify Services Running

```bash
# Check all containers are up
docker-compose ps

# Should show:
# - bridgeai-mysql
# - bridgeai-chromadb
# - bridgeai-backend
# - bridgeai-frontend
# - bridgeai-nginx
```

## Access Your Application

- **Frontend**: https://bridge-ai.dev
- **Backend API**: https://api.bridge-ai.dev/docs
- **Health Check**: https://api.bridge-ai.dev/health

## Setup SSL (After Services Running)

```bash
# Install certbot
sudo apt update
sudo apt install certbot python3-certbot-nginx -y

# Get SSL certificates
sudo certbot --nginx -d bridge-ai.dev -d www.bridge-ai.dev -d api.bridge-ai.dev

# Follow prompts, certificates will auto-renew
```

## Update Code Later

When you push code updates to GitHub:

```bash
# SSH into VPS
ssh root@207.154.233.229
cd /root/bridgeai

# Pull latest code
git pull origin main

# Rebuild and restart services
docker-compose --env-file .env.production up -d --build

# Check logs
docker-compose logs -f
```

## Troubleshooting

### View logs
```bash
docker-compose logs -f backend
docker-compose logs -f frontend
docker-compose logs -f mysql
```

### Restart a service
```bash
docker-compose restart backend
```

### Stop everything
```bash
docker-compose down
```

### Remove everything (including data)
```bash
docker-compose down -v
```

## What Docker Does Automatically

✓ Creates MySQL database (bridgeai_db)
✓ Sets up ChromaDB for AI memory
✓ Installs backend Python dependencies
✓ Installs frontend Node.js dependencies
✓ Runs database migrations
✓ Starts all services
✓ Configures networking between containers

---

## Summary

**Repository**: Clone from GitHub (backend + frontend code)
**Config Files**: Copy 5 files manually (never commit .env.production!)
**Domain**: bridge-ai.dev
**Database**: Docker MySQL (bridgeai_db)
**AI**: Claude 4.5 Sonnet + Haiku

**One-time setup, then just `git pull` for updates!** 🚀
