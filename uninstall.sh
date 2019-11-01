#!/bin/bash

read -p "Are you sure? [y/N]" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

if [ "$(id -u)" != "0" ]
then
   echo "This script must be run as root (use sudo ./uninstall.sh)." 1>&2
   exit 1
fi

# Disable updater service
echo "Stopping, disabling and removing systemd units"
systemctl stop chip-battery-status-check.timer
systemctl disable chip-battery-status-check.timer
rm -f /etc/systemd/system/chip-battery-status-check.service
rm -f /etc/systemd/system/chip-battery-status-check.timer

# Remove polling script
echo "Removing battery checking script"
rm -f /usr/local/bin/chip-battery-monitor.py

echo ""
echo "Done!"
echo ""
