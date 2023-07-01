#!/bin/bash -e
if [ $EUID -eq 0 ]; then
  curl -fsSL https://get.docker.com | bash
else
  echo "Please execute this script as root."
  exit 1
fi
