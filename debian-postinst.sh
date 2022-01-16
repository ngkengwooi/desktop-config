#!/bin/bash -e

echo "[Setup] Started."

if [ "$EUID" == 0 ]; then
  echo "User is root."
  
  echo "Update repositories."
  
  echo "deb https://deb.debian.org/debian/ bullseye main non-free contrib" > /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian-security/ bullseye-security main contrib non-free" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ bullseye-backports main contrib non-free" >> /etc/apt/sources.list
  
  echo "Update packages."
  
  apt-get -qq update
  apt-get -yy dist-upgrade
  
  echo "Install packages."
  
  apt-get -yy install $(cat ./packages.txt)
  
else
  echo "Aborted, user is not root."
  exit 1
fi
