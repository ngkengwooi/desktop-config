#!/bin/bash -e
################################################################################
# Script to set up Docker.
# Execute as superuser.
################################################################################

mkdir -p /etc/docker
curl -fsSL https://raw.githubusercontent.com/ngkengwooi/desktop-config/docker/daemon.json -o /etc/docker/daemon.json
curl -fsSL https://get.docker.com | bash
