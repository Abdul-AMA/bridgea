# BridgeAI - Docker Deployment Configuration

This repository contains the Docker deployment configuration files for BridgeAI production deployment.

## Repository Structure

This is the **deployment configuration repository**. The application code is in separate repositories:

- **Backend**: `bridgeai-backend/` (separate git repo)
- **Frontend**: `bridgeai-frontend/` (separate git repo)
- **Deployment**: This repo (docker-compose, nginx, etc.)

## Files in This Repo

```
bridgeai/
├── docker-compose.yml      # Container orchestration
├── nginx.conf              # Reverse proxy configuration
├── .gitignore              # Ignores backend/frontend folders
├── DEPLOY.md               # Deployment instructions
├── VPS_QUICK_FIX.md        # Troubleshooting guide
├── VPS_CHECKLIST.txt       # Deployment checklist
└── README.md               # This file
```

## Deployment Strategy

### 1. On VPS - Clone All Repos

```bash
# Clone this deployment config repo
git clone https://github.com/Abdul-AMA//bridgeai.git
cd bridgeai

# Clone backend into the folder
git clone https://github.com/Abdul-AMA//bridgeai-backend.git

# Clone frontend into the folder
git clone https://github.com/Abdul-AMA//bridgeai-frontend.git
```

### 2. Copy Production Config

From your local machine:
```bash
scp .env.production root@your-vps-ip:/root/bridgeai/
```

### 3. Start Services

On VPS:
```bash
cd /root/bridgeai
chmod 600 .env.production
docker compose --env-file .env.production up -d --build
```

## Repository Setup

### This Deployment Repo
- Contains: docker-compose.yml, nginx.conf, deployment scripts
- Ignores: backend/, frontend/ folders
- Purpose: VPS deployment configuration

### Backend Repo (Separate)
- Clone into: `bridgeai-backend/`
- Contains: FastAPI application code
- Has its own: .gitignore, requirements.txt, Dockerfile

### Frontend Repo (Separate)
- Clone into: `bridgeai-frontend/`
- Contains: Next.js application code
- Has its own: .gitignore, package.json, Dockerfile

## Why Separate Repos?

1. **Independent Versioning**: Backend and frontend can be versioned separately
2. **Clean Deployment**: This repo only has deployment config
3. **Security**: .env.production is never committed
4. **Flexibility**: Backend/frontend can be swapped or updated independently

## Updating Code

### Update Backend
```bash
cd bridgeai-backend
git pull origin main
cd ..
docker compose up -d --build backend
```

### Update Frontend
```bash
cd bridgeai-frontend
git pull origin main
cd ..
docker compose up -d --build frontend
```

### Update Deployment Config
```bash
git pull origin main
docker compose up -d
```

## Tech Stack

- **Backend**: Python 3.12, FastAPI, Claude 4.5 AI
- **Frontend**: Next.js 20, TypeScript, Tailwind CSS
- **Database**: MySQL 8.0
- **Vector DB**: ChromaDB
- **Reverse Proxy**: Nginx
- **Container**: Docker Compose v2

## Domain Configuration

- **Production Domain**: bridge-ai.dev
- **Frontend**: https://bridge-ai.dev
- **Backend API**: https://api.bridge-ai.dev
- **Database**: Docker MySQL (internal)

## Documentation

- [DEPLOY.md](DEPLOY.md) - Full deployment guide
- [VPS_QUICK_FIX.md](VPS_QUICK_FIX.md) - Troubleshooting
- [VPS_CHECKLIST.txt](VPS_CHECKLIST.txt) - Deployment checklist

## Quick Commands

```bash
# Start all services
docker compose --env-file .env.production up -d

# View logs
docker compose logs -f

# Restart a service
docker compose restart backend

# Stop everything
docker compose down

# Rebuild after code changes
docker compose up -d --build
```

## Important Notes

- Never commit `.env.production` to any repository
- Backend and frontend folders are gitignored in this repo
- Each repo (deployment, backend, frontend) is independent
- Production uses Docker Compose v2 (not v1)

## License

[Your License]

## Support

For deployment issues, see [VPS_QUICK_FIX.md](VPS_QUICK_FIX.md)
