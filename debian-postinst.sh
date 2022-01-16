#!/bin/bash -e

echo "[Setup] Started."

if [ "$EUID" == 0 ]; then
  echo "User is root."
  
  echo "Update repositories."
  
  echo "deb https://deb.debian.org/debian/ bullseye main non-free contrib" > /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian-security/ bullseye-security main contrib non-free" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ bullseye-backports main contrib non-free" >> /etc/apt/sources.list
  
  ######################
  # Add Fasttrack repo #
  ######################
  apt-get -qq update
  apt-get -yy install fasttrack-archive-keyring
  apt-add-repository "deb https://fasttrack.debian.net/debian-fasttrack/ bullseye-fasttrack main contrib"
  apt-add-repository "deb https://fasttrack.debian.net/debian-fasttrack/ bullseye-backports-staging main contrib"
  
  ############################
  # Update existing packages #
  ############################
  apt-get -qq update
  apt-get -yy dist-upgrade
  
  ###############################
  # Install additional packages #
  ###############################
  apt-get -yy install lame ffmpeg audacity puddletag soundconverter sound-juicer
  apt-get -yy install pitivi mkvtoolnix-gui handbrake gnome-subtitles
  apt-get -yy install gnome-games gnome-mastermind frogatto 0ad unknown horizons supertux supertuxkart warzone2100
  apt-get -yy install lyx texlive
  apt-get -yy install evolution evolution-ews
  apt-get -yy install virtualbox virtualbox-guest-additions-iso
  
else
  echo "Aborted, user is not root."
  exit 1
fi
