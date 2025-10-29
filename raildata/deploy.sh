#!/bin/bash
cd /root/projects/raildata/
git pull origin main
cd backend/
pnpm install
pm2 flush
pm2 restart scrapper
pm2 restart relayServer
echo "Server restarted with latest code"