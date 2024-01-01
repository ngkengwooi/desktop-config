#!/bin/bash -e
################################################################################
# Configure XFCE desktop.
# Execute as superuser.
################################################################################
curl -fsSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/main/scripts/debian-common.sh | bash
ansible-pull -U https://github.com/ngkengwooi/desktop-config ansible/debian-xfce.yml
system-upgrade
