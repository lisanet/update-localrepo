#!/bin/bash

echo "Uninstalling local apt repo updater"
if [ $EUID -ne 0 ]; then
   echo "Error: This script must be run with sudo."
   exit 1
fi

sudo systemctl stop update-localrepo.timer
sudo systemctl disable update-localrepo.timer update-localrepo.service
sudo rm -rf /var/lib/localrepo

sudo rm /usr/local/bin/update-localrepo

echo "Done."
