#!/bin/bash
sudo timedatectl set-timezone Asia/Kolkata
sudo apt update
sudo apt install git nodejs npm -y
git config --global user.name "Pramath S.B"
git config --global user.email "pramathsb@gmail.com"
sudo npm install -g pnpm
sudo pnpm install -g pm2 node-webhook
ssh-keygen -t ed25519 -C "pramathsb@gmail.com" -N "" -q <<< $'\n'
cat ~/.ssh/id_ed25519.pub
