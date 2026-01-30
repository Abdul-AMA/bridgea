#!/bin/bash
# Fix VPS Docker Compose Issues

echo "================================"
echo "Fixing Docker Compose Issues"
echo "================================"

# Step 1: Remove old containers and orphans
echo "Step 1: Cleaning up old containers..."
docker-compose down --remove-orphans 2>/dev/null || true
docker rm -f bridgeai-db-1 2>/dev/null || true

# Step 2: Upgrade to Docker Compose v2
echo "Step 2: Upgrading to Docker Compose v2..."
apt-get update
apt-get install -y docker-compose-plugin

# Step 3: Remove old docker-compose v1
echo "Step 3: Removing old docker-compose..."
apt-get remove -y docker-compose
rm -f /usr/bin/docker-compose 2>/dev/null || true

# Step 4: Create docker compose alias
echo "Step 4: Setting up docker compose alias..."
echo 'alias docker-compose="docker compose"' >> ~/.bashrc
source ~/.bashrc

# Step 5: Verify installation
echo "Step 5: Verifying installation..."
docker compose version

echo ""
echo "================================"
echo "✓ Docker Compose v2 installed!"
echo "================================"
echo ""
echo "Now run: docker compose --env-file .env.production up -d --build"
echo ""
