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
# --- END PVE ---
EOF
else
  echo "✅ PVE keys already present — skipping append."
fi

chmod 600 "$AUTHORIZED_KEYS"

echo -e "\n📋 Contents of authorized_keys:\n"
cat "$AUTHORIZED_KEYS"
