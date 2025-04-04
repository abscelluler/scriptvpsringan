#!/bin/bash

# SSH + Dropbear Installer - Ringan untuk Injek
echo "Installing SSH & Dropbear..."

# Set timezone
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# OpenSSH config
sed -i 's/#Port 22/Port 22\nPort 2253/' /etc/ssh/sshd_config
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

# Install Dropbear
apt install -y dropbear

# Dropbear config
cat > /etc/default/dropbear << END
NO_START=0
DROPBEAR_PORT=442
DROPBEAR_EXTRA_ARGS="-p 109 -p 144"
DROPBEAR_BANNER="/etc/issue.net"
END

echo "Selamat datang di server Injek" > /etc/issue.net

# Restart service
systemctl restart ssh
systemctl enable dropbear
systemctl restart dropbear
