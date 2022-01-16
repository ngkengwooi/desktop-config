#!/bin/bash -e

echo "[Setup] Started."

if [ "$EUID" == 0 ]; then
  echo "[Setup] User is root."
  
  echo "[Setup] Update repositories."
  
  echo "deb https://deb.debian.org/debian/ bullseye main non-free contrib" > /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian-security/ bullseye-security main contrib non-free" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ bullseye-backports main contrib non-free" >> /etc/apt/sources.list
  
else
  echo "[Setup] Aborted, user is not root."
  exit 1
fi
