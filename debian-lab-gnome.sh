#!/bin/bash -e

CODENAME=bullseye

########################
# Check root privilege #
########################
if [ $EUID -eq 0 ]; then
  
  ################
  # Set up repos #
  ################
  echo "deb https://deb.debian.org/debian/ $CODENAME main contrib non-free" > /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ $CODENAME-updates main contrib non-free" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian-security/ $CODENAME-security main contrib non-free" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ $CODENAME-backports main contrib non-free" >> /etc/apt/sources.list
  apt-get -qq update
  
  # Disable fasttrack repos
  #apt-get -yy install fasttrack-archive-keyring
  #apt-add-repository "deb https://fasttrack.debian.net/debian-fasttrack/ $CODENAME-fasttrack main contrib"
  #apt-add-repository "deb https://fasttrack.debian.net/debian-fasttrack/ $CODENAME-backports-staging main contrib"
  
  #############################
  # Upgrade existing packages #
  #############################
  apt-get -qq update
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
  update-grub
  
  ###############################
  # Hand over config to ansible #
  ###############################
  apt-get -yy install ansible git
  ansible-pull -U https://github.com/ngkengwooi/desktop-config debian-lab-gnome.yml
  
else
  echo "Please execute this script as root."
  exit 1
fi
