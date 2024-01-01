#!/bin/bash -e
################################################################################
# Script to set up Debian Linux.
# Execute this script as superuser.
################################################################################

# Change this to the latest stable release
CODENAME=bookworm

# Set up Debian's official repos
echo "deb https://deb.debian.org/debian/ $CODENAME main contrib non-free non-free-firmware
deb https://deb.debian.org/debian/ $CODENAME-updates main contrib non-free
deb https://deb.debian.org/debian-security/ $CODENAME-security main contrib non-free
deb https://deb.debian.org/debian/ $CODENAME-backports main contrib non-free" > /etc/apt/sources.list
apt-get update
apt-get -y dist-upgrade

# Install some core utilities
apt-get -y install \
  ansible \
  git \
  htop \
  neofetch \
  unattended-upgrades

# Set up Tailscale
curl -fsSL https://tailscale.com/install.sh | bash

# Harmonise theming for QT apps
echo "QT_STYLE_OVERRIDE=gtk2" > /etc/environment

# Configure boot behaviour
sed -i "s/GRUB_TIMEOUT=\d+/GRUB_TIMEOUT=0/" /etc/default/grub
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="splash quiet"/' /etc/default/grub
update-grub2

# Install custom scripts
curl -fsSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/main/scripts/system-upgrade -o /usr/local/sbin/system-upgrade
curl -fsSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/main/scripts/nextcloud-folders -o /usr/local/bin/nextcloud-folders
chmod +x /usr/local/bin/* /usr/local/bin/*
