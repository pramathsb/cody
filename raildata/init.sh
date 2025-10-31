#!/bin/bash
set -e

echo "⏳ Setting timezone..."
sudo timedatectl set-timezone Asia/Kolkata

echo "🔄 Updating system and installing packages..."
sudo apt update
sudo apt install -y curl nginx git

echo "🚀 Starting and enabling Nginx..."
sudo systemctl enable --now nginx

echo "⚙️ Setting Git user info..."
git config --global user.name "Pramath S.B"
git config --global user.email "pramathsb@gmail.com"

echo "📦 Installing pnpm and pm2..."
npm install -g pnpm
pnpm setup
source ~/.bashrc
pnpm add -g pm2

SSH_KEY="$HOME/.ssh/id_ed25519"
if [[ ! -f "$SSH_KEY" ]]; then
  echo "🔑 Generating SSH key..."
  ssh-keygen -t ed25519 -C "pramathsb@gmail.com" -N "" -q -f "$SSH_KEY"
else
  echo "🔑 SSH key already exists."
fi

echo "✅ Nginx status:"
sudo systemctl status nginx --no-pager

echo -e "\n📋 Public SSH key:\n"
cat "${SSH_KEY}.pub"
echo -e "\n➡️  Copy this key to GitHub or other services."


# pnpm setup
# pnpm config set global-bin-dir "$HOME/.local/share/pnpm/bin"
# export PNPM_HOME="/root/.local/share/pnpm"
# export PATH="$PNPM_HOME/bin:$PATH"


# echo "📥 Installing corepack globally via npm..."
# sudo npm install -g corepack

# echo "🔍 Checking corepack version..."
# corepack --version

# echo "🚀 Enabling corepack..."
# corepack enable

# echo "📦 Preparing and activating latest pnpm..."
# corepack prepare pnpm@latest --activate