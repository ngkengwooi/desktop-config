#!/bin/bash -e
################################################################################
# Script to install a banner message on the GDM greeter screen.
# Execute as superuser.
# Usage:
#   gdm-banner "Insert custom message here."
################################################################################

message="$1"

echo "user-db:user
system-db:gdm
file-db:/usr/share/gdm/greeter-dconf-defaults" > /etc/dconf/profile/gdm

echo "[org/gnome/login-screen]
banner-message-enable=true
banner-message-text='$message'" > /etc/dconf/db/gdm.d/01-banner-message

dconf update
