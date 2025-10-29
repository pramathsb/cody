#!/bin/bash
pm2 flush
cd /root/projects/raildata/
git pull origin main
cd backend/
pnpm install
pnpm run build
pm2 restart scrapper
pm2 restart relayBack
pm2 restart relayFront
echo "Server restarted with latest code"