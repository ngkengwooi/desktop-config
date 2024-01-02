#!/bin/bash -e
################################################################################
# Configure GNOME desktop.
# Execute as superuser.
################################################################################
curl -fsSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/main/scripts/debian-common.sh | bash

# Harmonise theming for QT apps
echo "QT_STYLE_OVERRIDE=Adwaita" > /etc/environment

ansible-pull -U https://github.com/ngkengwooi/desktop-config ansible/debian-gnome.yml

system-upgrade
