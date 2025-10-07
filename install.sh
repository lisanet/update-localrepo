#!/bin/bash

echo "Installing local apt repo updater"
if [ $EUID -ne 0 ]; then
   echo "Error: This script must be run with sudo."
   exit 1
fi

mkdir -p /etc/localrepo
cp packages.conf /etc/localrepo

cp update-localrepo /usr/local/bin
chmod a+x /usr/local/bin/update-localrepo

mkdir -p /var/lib/localrepo
cp update-localrepo.service update-localrepo.timer /var/lib/localrepo

systemctl link /var/lib/localrepo/update-localrepo.timer /var/lib/localrepo/update-localrepo.service
systemctl enable --now update-localrepo.timer

echo -e "Installation done.\n"
echo "To start the first repo update please run:"
echo "sudo systemctl start update-localrepo.service"
