#!/bin/bash
set -e

echo "🧹 Cleaning up PM2 and old projects..."
pm2 delete all || true
pm2 flush
rm -rf /root/.pm2/logs/* /root/projects

echo "📂 Preparing projects directory..."
mkdir -p /root/projects && cd /root/projects

echo "🔐 Setting up Git SSH..."
export GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=accept-new"

echo "📥 Cloning repositories..."
git clone git@github.com:pramathsb/raildata.git
git clone git@github.com:pramathsb/hooks.git
# git clone git@github.com:pramathsb/scrapped-data.git

echo "⚙️ Installing hooks service..."
cd /root/projects/hooks/raildata
pnpm install
pm2 start git.hook.js --name webhook

echo "🌐 Setting up frontend..."
cd /root/projects/raildata/frontend
pnpm install
pm2 start "npm run dev" --name rd-relayFrontend

echo "🧠 Setting up backend..."
cd /root/projects/raildata/backend
pnpm run build
pm2 start "environment=production schedule=hourly npm run start" --name rd-hourlyScrapper
pm2 start "environment=production schedule=nightly npm run start" --name rd-nightlyScrapper
pm2 start "port=5000 channel=nightly_dev_state npm run relay" --name rd-relayDev
pm2 start "port=5001 channel=hourly_production_state npm run relay" --name rd-relayHourlyScrapper
pm2 start "port=5002 channel=nightly_production_state npm run relay" --name rd-relayNightlyScrapper

echo "💾 Saving PM2 processes..."
pm2 save

echo "📜 Showing logs..."
pm2 logs
