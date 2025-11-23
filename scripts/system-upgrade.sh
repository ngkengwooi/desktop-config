#!/bin/bash -e

##########################################################
# This script will install all available updates for any #
# software installed system-wide via APT or Flatpak.     #
# Save this script as /usr/local/sbin/system-update      #
# and make it executable:                                #
#   sudo chmod +x /usr/local/sbin/system-update          #
# Invoke as follows:                                     #
#   sudo system-update                                  #
##########################################################

apt-get update
apt-get -yy dist-upgrade
apt-get -yy autoremove --purge
apt-get -yy autoclean
flatpak -y uninstall --unused
flatpak -y update
