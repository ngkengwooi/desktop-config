#!/bin/bash -e
################################################################################
# Configure GNOME desktop.
# Execute as superuser.
################################################################################

# Apply common configuration
curl -fsSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/main/scripts/debian-common.sh | bash

# Harmonise theming for QT apps
echo "QT_STYLE_OVERRIDE=Adwaita" > /etc/environment

# Use Ansible to manage apps
ansible-pull -U https://github.com/ngkengwooi/desktop-config ansible/debian-gnome.yml

# Final update and cleanup
system-upgrade
