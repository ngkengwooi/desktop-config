#!/bin/bash -e

DEBIAN_RELEASE=bullseye

########################
# Check root privilege #
########################
if [ $EUID -eq 0 ]; then
  
  ################
  # Set up repos #
  ################
  echo "deb https://deb.debian.org/debian/ $DEBIAN_RELEASE main non-free contrib" > /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ $DEBIAN_RELEASE-updates main contrib non-free" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian-security/ $DEBIAN_RELEASE-security main contrib non-free" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ $DEBIAN_RELEASE-backports main contrib non-free" >> /etc/apt/sources.list
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
  sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=10/' /etc/default/grub
  sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="splash quiet"/' /etc/default/grub
  update-grub2
  
  ###############################
  # Hand over config to ansible #
  ###############################
  apt-get -yy install ansible git
  ansible-pull -U https://github.com/ngkengwooi/desktop-config debian-lab-xfce.yml
  
else
  echo "Please execute this script as root."
  exit 1
fi
