#!/bin/bash

echo "Installing local apt repo updater"
if [ $EUID -ne 0 ]; then
   echo "Error: This script must be run with sudo."
   exit 1
fi

mkdir -p /etc/localrepo/scripts
cp geturl-plex /etc/localrepo/scripts
[ ! -f /etc/localrepo/packages.conf ] && cp packages.conf /etc/localrepo

cp update-localrepo /usr/local/bin
chmod a+x /usr/local/bin/update-localrepo

mkdir -p /var/lib/localrepo
cp update-localrepo.service update-localrepo.timer /var/lib/localrepo

systemctl link /var/lib/localrepo/update-localrepo.timer /var/lib/localrepo/update-localrepo.service
systemctl enable --now update-localrepo.timer

systemctl start update-localrepo.service

echo -e "Installation done.\n"
echo "You can edit the package list in /etc/localrepo/packages.conf"
echo "To manually update the local repository, run:"
echo "  sudo update-localrepo"
