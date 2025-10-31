#!/bin/bash
set -e

SSH_DIR="$HOME/.ssh"
AUTHORIZED_KEYS="$SSH_DIR/authorized_keys"

echo "🔐 Ensuring .ssh directory exists..."
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

# Append keys only if not already present
if ! grep -q "BEGIN PVE" "$AUTHORIZED_KEYS" 2>/dev/null; then
  echo "📎 Appending PVE SSH keys..."
  cat <<'EOF' >> "$AUTHORIZED_KEYS"
  
# --- BEGIN PVE ---
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB0KBZXw10f0fUFRdtVMXn7xG3dQJRKId3ExjXgtfGrZ pramathsb@gmail.com
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdl+nVz/iBkQIAilOdptR5Uw+ZdKJ+FhKkr5K8KzFoW pramathsb@gmail.com
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHfgVCl/iJ6znJsh4g6wZ5/Zrrqzw7rY3LXXNK9eLok2 pramathsb@gmail.com
# --- END PVE ---
EOF
else
  echo "✅ PVE keys already present — skipping append."
fi

chmod 600 "$AUTHORIZED_KEYS"

echo -e "\n📋 Contents of authorized_keys:\n"
cat "$AUTHORIZED_KEYS"

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

echo "📥 Installing NVM (Node Version Manager)..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

echo "🔧 Loading NVM into current shell..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

echo "🧩 Verifying NVM installation..."
nvm --version

echo "⬇️  Installing latest Node.js version via NVM..."
nvm install node  # "node" alias points to latest version

echo "📦 Installing pnpm and pm2..."
npm install -g pnpm
pnpm setup
source ~/.bashrc

echo "🔄 Reloading shell configuration..."
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