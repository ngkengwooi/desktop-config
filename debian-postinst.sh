#!/bin/bash -e

if [ $EUID -eq 0 ]; then
  
  # By default, the bullseye, bullseye-updates and bullseye-security repos are enabled.
  # Just need to change the HTTP protocol to HTTPS and remove comments.
  sed -i "s/http\:\/\//https\:\/\//" /etc/apt/sources.list
  sed -i "/^[[:space:]]*$/d" /etc/apt/sources.list
  
  # Add the backports repo.
  apt-add-repository "deb https://deb.debian.org/debian/ bullseye-backports main contrib non-free"
  
  # Add the fasttrack repo, needed for VirtualBox.
  apt-get -qq update
  apt-get -yy install fasttrack-archive-keyring
  apt-add-repository "deb https://fasttrack.debian.net/debian-fasttrack/ bullseye-fasttrack main contrib"
  apt-add-repository "deb https://fasttrack.debian.net/debian-fasttrack/ bullseye-backports-staging main contrib"
  
  # Upgrade existing packages.
  # Update repos first since new repos have been added.
  apt-get -qq update
  apt-get -yy dist-upgrade
  
  # Install additional packages.
  apt-get -yy install \
    0ad \
    audacity \
    brasero \
    clamtk \
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
 
  # Install flatpaks.
  apt-get -yy install \
    flatpak \
    gnome-software-plugin-flatpak
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  flatpak -y install flathub \
    com.microsoft.Teams \
    org.zotero.Zotero \
    us.zoom.Zoom
 
  # Make QT apps use GTK theme.
  apt-get -yy install \
    adwaita-qt \
    qt5-gtk-platformtheme \
    qt5-style-plugins
  echo "QT_QPA_PLATFORMTHEME='gnome'" > /etc/environment
  
  # Configure the GRUB bootloader.
  set -i "s/GRUB_TIMEOUT=\d+/GRUB_TIMEOUT=0/" /etc/default/grub
  sed -i "s/quiet/quiet splash/" /etc/default/grub
  update-grub2
  
  # Upgrade Python installer and other apps.
  python3 -m pip install --upgrade pip youtube-dl
  
else
  echo "Aborted, user is not root."
  exit 1
fi
