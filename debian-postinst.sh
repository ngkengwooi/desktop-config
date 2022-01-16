#!/bin/bash -e

if [ "$EUID" == 0 ]; then

  ###################
  # Configure repos #
  ###################
  echo "deb https://deb.debian.org/debian/ bullseye main non-free contrib" > /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ bullseye-updates main contrib non-free" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian-security/ bullseye-security main contrib non-free" >> /etc/apt/sources.list
  echo "deb https://deb.debian.org/debian/ bullseye-backports main contrib non-free" >> /etc/apt/sources.list
  
  ######################
  # Add fasttrack repo #
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
  apt-get -yy install \
    0ad \
    audacity \
    brasero \
    curl \
    evolution-ews \
    ffmpeg \
    filezilla \
    freecad \
    frogatto \
    gchempaint \
    gcu-bin \
    ghostwriter \
    gimp \
    git \
    gnome-games \
    gnome-mastermind \
    gnome-shell-extension-caffeine \
    gnome-subtitles \
    handbrake \
    homebank \
    ibus-libpinyin \
    imagej \
    inkscape \
    keepassxc \
    lame \
    lyx \
    mkvtoolnix-gui \
    musescore3 \
    nextcloud-desktop \
    pandoc \
    pdfarranger \
    pitivi \
    pronterface \
    prusa-slicer \
    puddletag \
    remmina \
    rhythmbox-plugin-alternative-toolbar \
    simplescreenrecorder \
    soundconverter \
    sound-juicer \
    supertux \
    supertuxkart \ 
    texlive \
    unattended-upgrades \
    unknown-horizons \
    virtualbox \
    virtualbox-guest-additions-iso \
    warzone2100 \
    webext-https-everywhere \
    webext-privacy-badger \
    webext-ublock-origin-firefox \
    wget
 
  ####################
  # Install flatpaks #
  ####################
  apt-get -yy install \
    flatpak \
    gnome-software-plugin-flatpak
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
