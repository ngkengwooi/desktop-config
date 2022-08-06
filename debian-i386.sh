#!/bin/bash -e

########################
# Check root privilege #
########################
if [ $EUID -eq 0 ]; then
  
  ################
  # Set up repos #
  ################
  echo "deb https://deb.debian.org/debian/ bullseye main non-free contrib" > /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian-security/ bullseye-security main contrib non-free" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ bullseye-backports main contrib non-free" >> /etc/apt/sources.list
  apt-get -qq update
  
  #############################
  # Upgrade existing packages #
  #############################
  apt-get -yy dist-upgrade
  
  ################################
  # Enable GTK theme for QT apps #
  ################################
  echo "QT_QPA_PLATFORMTHEME=gtk2" > /etc/environment
  
  #############################
  # Configure GRUB bootloader #
  #############################
  sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/' /etc/default/grub
  sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="splash quiet"/' /etc/default/grub
  update-grub
  
  ###############################
  # Hand over config to ansible #
  ###############################
  apt-get -yy install ansible git
  ansible-pull -U https://github.com/ngkengwooi/desktop-config debian-i386.yml
  
else
  echo "Please execute this script as root."
  exit 1
fi
