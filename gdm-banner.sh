#!/bin/bash -e

message=""

echo "user-db:user
system-db:gdm
file-db:/usr/share/gdm/greeter-dconf-defaults" > /etc/dconf/profile/gdm

echo "[org/gnome/login-screen]
banner-message-enable=true
banner-message-text='$message'" > /etc/dconf/db/gdm.d/01-banner-message

dconf update
