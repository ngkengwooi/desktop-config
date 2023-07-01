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
  
  # Disable fasttrack repos
  # Not yet available for bookworm
  #apt-get -yy install fasttrack-archive-keyring
  #apt-add-repository "deb https://fasttrack.debian.net/debian-fasttrack/ $CODENAME-fasttrack main contrib"
  #apt-add-repository "deb https://fasttrack.debian.net/debian-fasttrack/ $CODENAME-backports-staging main contrib"
  
  #############################
  # Upgrade existing packages #
  #############################
  apt-get update
  apt-get -y dist-upgrade
  
  ################################
  # Enable GTK theme for QT apps #
  ################################
  echo "QT_STYLE_OVERRIDE=Adwaita" > /etc/environment
  
  #############################
  # Configure GRUB bootloader #
  #############################
  sed -Ei "s/GRUB_TIMEOUT=[0-9]+/GRUB_TIMEOUT=3/" /etc/default/grub
  sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="splash quiet"/' /etc/default/grub
  update-grub

  #################################
  # Install system upgrade script #
  #################################
  curl \
    -o /usr/local/bin/system-upgrade \
    -fsSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/main/system-upgrade
  chmod +x /usr/local/bin/system-upgrade
  
  ###############################
  # Hand over config to ansible #
  ###############################
  apt-get -yy install ansible git
  ansible-pull -U https://github.com/ngkengwooi/desktop-config debian-lab-gnome-$CODENAME.yml
  
else
  echo "Please execute this script as root."
  exit 1
fi
