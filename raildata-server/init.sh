#!/bin/bash

# Exit if any command fails
#!/bin/bash
set -e

echo "⏳ Setting timezone to Asia/Kolkata..."
sudo timedatectl set-timezone Asia/Kolkata

echo "🔄 Updating package lists..."
sudo apt update

echo "📦 Installing git, nodejs, and npm..."
sudo apt install -y git nodejs npm

echo "⚙️ Configuring git user info..."
git config --global user.name "Pramath S.B"
git config --global user.email "pramathsb@gmail.com"

echo "📥 Installing corepack globally via npm..."
sudo npm install -g corepack

echo "🔍 Checking corepack version..."
corepack --version

echo "🚀 Enabling corepack..."
corepack enable

echo "📦 Preparing and activating latest pnpm..."
corepack prepare pnpm@latest --activate

pnpm setup
source /root/.bashrc


echo "📦 Installing pm2 globally using pnpm..."
pnpm install -g pm2

SSH_KEY="$HOME/.ssh/id_ed25519"

if [[ -f "$SSH_KEY" ]]; then
    echo "🔑 SSH key already exists at $SSH_KEY"
else
    echo "🔑 Generating new SSH key..."
    ssh-keygen -t ed25519 -C "pramathsb@gmail.com" -N "" -q -f "$SSH_KEY"
fi

echo -e "\n📋 Your public SSH key is:\n"
cat "${SSH_KEY}.pub"
echo -e "\nCopy this key to your GitHub or other services as needed."


# pnpm setup
# pnpm config set global-bin-dir "$HOME/.local/share/pnpm/bin"
# export PNPM_HOME="/root/.local/share/pnpm"
# export PATH="$PNPM_HOME/bin:$PATH"