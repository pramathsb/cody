#!/bin/bash

(
  cd /root/projects || mkdir -p /root/projects && cd /root/projects
  git clone git@github.com:pramathsb/raildata.git
  git clone git@github.com:pramathsb/cody.git
)
# (
#   cd /projects/hooks/server
#   pm2 start raildata.hook.js --name webhook
#   pm2 save
# )
(
  cd /root/projects/raildata/backend
  pnpm install --prod
  pm2 start npm --name scrapper -- run start
  pm2 save
)