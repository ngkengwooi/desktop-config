#!/bin/bash -e

CODENAME=bookworm

########################
# Check root privilege #
########################
if [ $EUID -eq 0 ]; then
  
  ################
  # Set up repos #
  ################
  echo "deb https://deb.debian.org/debian/ $CODENAME main contrib non-free non-free-firmware" > /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ $CODENAME-updates main contrib non-free non-free-firmware" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian-security/ $CODENAME-security main contrib non-free non-free-firmware" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ $CODENAME-backports main contrib non-free non-free-firmware" >> /etc/apt/sources.list
  apt-get -qq update
  
  #############################
  # Upgrade existing packages #
  #############################
  apt-get -yy dist-upgrade
  
  ####################################
  # Make QT and GTK themes get along #
  ####################################
  echo "QT_QPA_PLATFORMTHEME=gtk2" > /etc/environment
  
  #############################
  # Configure GRUB bootloader #
  #############################
  sed -Ei "s/GRUB_TIMEOUT=[0-9]+/GRUB_TIMEOUT=3/" /etc/default/grub
  sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="splash quiet"/' /etc/default/grub
  update-grub2
  
  #################################
  # Make home directories private #
  # Since bookworm default=0700   #
  #################################
  chmod 0700 /home/*/
  sed -Ei "s/DIR_MODE=[0-9]+/DIR_MODE=0700/" /etc/adduser.conf
  
  ###############################
  # Hand over config to ansible #
  ###############################
  apt-get -yy install ansible git
  ansible-pull -U https://github.com/ngkengwooi/desktop-config debian-lab-xfce-$CODENAME.yml
  
else
  echo "Please execute this script as root."
  exit 1
fi
