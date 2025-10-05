#!/bin/bash

echo "Uninstalling local apt repo updater"
if [ $EUID -ne 0 ]; then
   echo "Error: This script must be run with sudo."
   exit 1
fi

systemctl stop update-localrepo.timer
systemctl disable update-localrepo.timer update-localrepo.service
rm -rf /var/lib/localrepo

rm /usr/local/bin/update-localrepo

rm -rf /etc/localrepo

echo "Done."
