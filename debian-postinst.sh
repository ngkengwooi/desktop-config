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
  apt-get -yy install git wget curl filezilla
  apt-get -yy install flatpak gnome-software-plugin-flatpak unattended-upgrades
  apt-get -yy install ibus-libpinyin
  apt-get -yy install pdfarranger pandoc ghostwriter
  apt-get -yy install gimp inkscape imagej
  apt-get -yy install freecad prusa-slicer pronterface
  apt-get -yy install homebank keepassxc nextcloud-desktop
  apt-get -yy install gcu-bin gchempaint
  apt-get -yy install gnome-shell-extension-caffeine
  apt-get -yy install rhythmbox-plugin-alternative-toolbar
  apt-get -yy install webext-ublock-origin-firefox webext-https-everywhere webext-privacy-badger
  apt-get -yy install lame ffmpeg audacity puddletag soundconverter sound-juicer musescore3
  apt-get -yy install pitivi mkvtoolnix-gui handbrake gnome-subtitles simplescreenrecorder brasero
  apt-get -yy install gnome-games gnome-mastermind frogatto 0ad unknown horizons supertux supertuxkart warzone2100
  apt-get -yy install lyx texlive
  apt-get -yy install evolution evolution-ews
  apt-get -yy install virtualbox virtualbox-guest-additions-iso remmina
  
  ####################
  # Install flatpaks #
  ####################
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  flatpak -y install flathub \
    com.microsoft.Teams \
    org.zotero.Zotero \
    us.zoom.Zoom
 
  ##############################
  # Make QT apps use GTK theme #
  ##############################
  apt-get -yy install \
    adwaita-qt \
    qt5-style-plugins \
    qt5-gtk-platformtheme
  echo "QT_QPA_PLATFORMTHEME='gnome'"
  
  #############################
  # Configure GRUB bootloader #
  #############################
  sed -i 's/quiet/quiet splash/' /etc/default/grub
  update-grub2
  
else
  echo "Aborted, user is not root."
  exit 1
fi
