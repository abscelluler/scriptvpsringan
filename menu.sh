#!/bin/bash

# Simple Menu untuk kontrol layanan

while true; do
  clear
  echo "=============================="
  echo "  MENU - VPN INJEK MANAGER   "
  echo "=============================="
  echo "1. Status Layanan"
  echo "2. Restart Layanan"
  echo "3. Exit"
  echo -n "Pilih: "
  read -r opt

  case $opt in
    1)
      echo "--- STATUS ---"
      systemctl status ssh --no-pager | grep Active
      systemctl status dropbear --no-pager | grep Active
      systemctl status ws-ssh --no-pager | grep Active
      systemctl status xray --no-pager | grep Active
      read -n 1 -s -r -p "Tekan tombol apa saja untuk kembali..."
      ;;
    2)
      echo "Restarting all services..."
      systemctl restart ssh
      systemctl restart dropbear
      systemctl restart ws-ssh
      systemctl restart xray
      echo "Done."
      sleep 1
      ;;
    3)
      exit 0
      ;;
    *)
      echo "Opsi tidak valid."
      sleep 1
      ;;
  esac
done
