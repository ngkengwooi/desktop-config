#!/bin/bash -e
################################################################################
# Configure GNOME desktop
################################################################################
curl -fsSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/main/scripts/debian-common.sh | bash
ansible-pull -U https://github.com/ngkengwooi/desktop-config ansible/debian-xfce.yml
system-upgrade
