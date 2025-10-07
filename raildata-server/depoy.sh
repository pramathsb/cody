#!/bin/bash
cd /projects/raildata/
git pull origin main
pnpm install --production
pm2 restart scrapper