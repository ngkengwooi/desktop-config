#!/usr/bin/sh

# Run this script with root privileges, e.g.
# curl -sSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/main/fedora-home.sh | sudo sh
# (Piping to shell because I wrote this script and I trust it)

# Install Ansible:
dnf -y install ansible flatpak

# Replace the Fedora-curated flathub repo
# The flathub.org repo will be added back by Ansible Pull
flatpak remote-delete flathub

# Configure system with Ansible:
ansible-pull -U https://github.com/ngkengwooi/desktop-config fedora-home.yml
