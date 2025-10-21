#!/bin/bash

pm2 delete all
pm2 flush
rm -rf /root/projects

export GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=accept-new"

cd /root/projects || mkdir -p /root/projects && cd /root/projects
git clone git@github.com:pramathsb/raildata.git
git clone git@github.com:pramathsb/hooks.git
git clone git@github.com:pramathsb/scrapped-data.git

cd /root/projects/hooks/raildata/frontend
pnpm install
pm2 start "npm run dev" --name relay
pm2 save

cd /root/projects/hooks/raildata/
pnpm install
pm2 start git.hook.js --name webhook
pm2 save

cd /root/projects/raildata/backend
pnpm install
pm2 start npm --name scrapper -- run start
pm2 save

pm2 logs