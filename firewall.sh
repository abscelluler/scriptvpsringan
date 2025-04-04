#!/bin/bash

# Firewall & Port Opener

echo "Setting up firewall and port rules..."

PORTS=(22 2253 442 109 144 80 443)

for port in "${PORTS[@]}"; do
  iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $port -j ACCEPT
  iptables -I INPUT -m state --state NEW -m udp -p udp --dport $port -j ACCEPT
done

iptables-save > /etc/iptables.up.rules

echo 1 > /proc/sys/net/ipv4/ip_forward
sed -i '/net.ipv4.ip_forward/d' /etc/sysctl.conf
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

iptables -A FORWARD -m string --string "BitTorrent" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "peer_id=" --algo bm -j DROP

clear
echo "Firewall rules applied. Ports open: ${PORTS[*]}"
