#!/bin/bash -e
if [ $EUID -eq 0 ]; then
  echo "{
  "  default-address-pools" : [
    {
      "base" : "172.17.0.0/12",
      "size" : 20
    },
    {
      "base" : "192.168.0.0/16",
      "size" : 24
    }
  ]
}" > /etc/docker/daemon.json
  curl -fsSL https://get.docker.com | bash  
else
  echo "Please execute this script as root."
  exit 1
fi
