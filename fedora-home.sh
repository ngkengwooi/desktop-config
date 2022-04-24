#!/usr/bin/sh

# Run this script with root privileges, e.g.
# curl -sSL https://github.com/ngkengwooi/desktop-config/fedora-home.sh | sudo sh
# (Piping to shell because I wrote this script and I trust it)

# Install Ansible:
dnf -y install ansible

# Configure system with Ansible:
ansible-pull -U https://github.com/ngkengwooi/desktop-config fedora-home.yml
