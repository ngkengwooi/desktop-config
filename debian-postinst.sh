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
  apt-get -yy install fasttrack-archive-keyring
  apt-add-repository "deb https://fasttrack.debian.net/debian-fasttrack/ bullseye-fasttrack main contrib"
  apt-add-repository "deb https://fasttrack.debian.net/debian-fasttrack/ bullseye-backports-staging main contrib"
  
  #############################
  # Upgrade existing packages #
  #############################
  apt-get -qq update
  apt-get -yy dist-upgrade
  
  ################################
  # Enable GTK theme for QT apps #
  ################################
  echo "QT_QPA_PLATFORMTHEME='gnome'" > /etc/environment
  
  #############################
  # Configure GRUB bootloader #
  #############################
  sed -i 's/GRUB_TIMEOUT\=\d+/GRUB_TIMEOUT\=0/' /etc/default/grub
  sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT\="[^"]+"/GRUB_CMDLINE_LINUX_DEFAULT\="splash quiet"/' /etc/default/grub
  update-grub2
  
  ###############################
  # Hand over config to ansible #
  ###############################
  apt-get -yy install ansible git
  ansible-pull -U https://github.com/ngkengwooi/desktop-config debian-home.yml
  
else
  echo "Please execute this script as root."
  exit 1
fi
