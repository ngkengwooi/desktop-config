#!/bin/bash -e
################################################################################
# Configure GNOME desktop
################################################################################
curl -fsSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/main/debian-common.sh | bash
ansible-pull -U https://github.com/ngkengwooi/desktop-config debian-xfce.yml
system-upgrade
