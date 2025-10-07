cat authorized_keys
# --- BEGIN PVE ---
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC+SHY592K//RM8ArRcBTtWwSO3+ztCMUN4/7Xn+8w/m pramathsb@gmail.com
# --- END PVE ---

rsync -avz --progress /Volumes/Store/projects/cody/raildata-server/ root@192.168.0.15:/root/scripts/