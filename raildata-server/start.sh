#!/bin/bash
(
  cd /projects/
  # git clone https://github.com/yourname/yourrepo.git
  # git clone https://github.com/yourname/yourrepo.git
)
(
  cd /projects/hooks/server
  pm2 start raildata.hook.js --name webhook
  pm2 save
)
(
  cd /projects/raildata/backend
  pnpm install --prod
  pm2 start npm --name scrapper -- run start
  pm2 save
)