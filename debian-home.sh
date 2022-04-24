#!/bin/sh -e

# Run this script with root privileges, e.g.
# curl -sSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/main/debian-home.sh | sudo sh
# (Piping to shell because I wrote this script and I trust it)

# Install Ansible:
apt-get update
apt-get -y install ansible

# Configure system with Ansible:
ansible-pull -U https://github.com/ngkengwooi/desktop-config debian-home.yml
