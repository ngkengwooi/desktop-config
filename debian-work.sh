#!/bin/bash -e

########################
# Check root privilege #
########################
if [ $EUID -eq 0 ]; then
  
  ################
  # Set up repos #
  ################
  echo "deb https://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware" > /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ bookworm-backports main contrib non-free non-free-firmware" >> /etc/apt/sources.list
  apt-get update
  
  #############################
  # Upgrade existing packages #
  #############################
  apt-get update
  apt-get -yy dist-upgrade
  
  ################################
  # Enable GTK theme for QT apps #
  ################################
  echo "QT_STYLE_OVERRIDE=Adwaita" > /etc/environment
  
  #############################
  # Configure GRUB bootloader #
  #############################
  sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=3/' /etc/default/grub
  sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="splash quiet"/' /etc/default/grub
  update-grub2
  
  ###############################
  # Hand over config to ansible #
  ###############################
  apt-get -yy install ansible git
  ansible-pull -U https://github.com/ngkengwooi/desktop-config debian-work.yml
  
else
  echo "Please execute this script as root."
  exit 1
fi
