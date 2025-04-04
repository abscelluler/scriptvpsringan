#!/bin/bash

# Auto Installer VPS Ringan - SSH + WebSocket + Xray Trojan WS

REPO="https://raw.githubusercontent.com/abscelluler/scriptvpsringan/main"

# Update & install kebutuhan dasar
apt update -y && apt upgrade -y
apt install -y curl wget sudo socat cron bash coreutils screen net-tools

# Jalankan tiap bagian dari script
bash <(curl -s ${REPO}/core/ssh.sh)
bash <(curl -s ${REPO}/core/websocket.sh)
bash <(curl -s ${REPO}/core/xray.sh)
bash <(curl -s ${REPO}/core/firewall.sh)

# Tambahkan menu ke /usr/bin
curl -o /usr/bin/menu ${REPO}/core/menu.sh
chmod +x /usr/bin/menu

clear
echo "Installasi selesai. Jalankan menu dengan perintah: menu"
