#!/bin/bash

# Xray Core Installer - Trojan WS + TLS Ringan

echo "Installing Xray Core..."

mkdir -p /etc/xray
mkdir -p /var/log/xray

curl -s https://raw.githubusercontent.com/XTLS/Xray-install/main/install-release.sh | bash

cat > /etc/xray/config.json << EOF
{
  "log": {
    "loglevel": "warning",
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log"
  },
  "inbounds": [
    {
      "port": 443,
      "protocol": "trojan",
      "settings": {
        "clients": [
          {
            "password": "2ab534eb-8116-48cc-bf53-14373649df93"
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        },
        "wsSettings": {
          "path": "/trojan-ws",
          "headers": {
            "Host": "your.sni.domain"
          }
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
EOF

mkdir -p /etc/xray
openssl req -x509 -nodes -days 365 -newkey rsa:2048   -keyout /etc/xray/xray.key   -out /etc/xray/xray.crt   -subj "/C=ID/ST=Jakarta/L=Jakarta/O=SelfSigned/CN=your.sni.domain"

systemctl enable xray
systemctl restart xray

echo "Xray Trojan WS TLS aktif di port 443. SNI: your.sni.domain"
