#!/bin/bash
set -e

echo "🧹 Flushing old PM2 logs..."
pm2 flush

echo "📦 Updating project code..."
cd /root/projects/raildata
git pull origin main

echo "⚙️ Rebuilding backend..."
cd backend
pnpm install
pnpm run build

echo "🚀 Restarting PM2 services..."
pm2 restart /rd-/

echo "✅ Server restarted with the latest code!"
