#!/bin/bash

echo "Installing local apt repo updater"
if [ $EUID -ne 0 ]; then
   echo "Error: This script must be run with sudo."
   exit 1
fi

sudo cp packages.conf /etc/localrepo

sudo cp update-localrepo /usr/local/bin
sudo chmod a+x /usr/local/bin/update-localrepo

sudo mkdir -p /var/lib/localrepo
sudo cp update-localrepo.service update-localrepo.timer /var/lib/localrepo

sudo systemctl link /var/lib/localrepo/update-localrepo.timer /var/lib/localrepo/update-localrepo.service
sudo systemctl enable --now update-localrepo.timer

echo -e "Installation done.\n"
echo "To start the first repo update please run:"
echo "sudo systemctl start update-localrepo.service"
