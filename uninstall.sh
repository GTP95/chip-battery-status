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
systemctl stop chip-battery-status-update.timer
systemctl disable chip-battery-status-update.timer
rm -f /etc/systemd/system/chip-battery-status-update.service
rm -f /etc/systemd/system/chip-battery-status-update.timer

# Remove status files
rm -f /usr/local/lib/chip-battery-status/charging
rm -f /usr/local/lib/chip-battery-status/percentage

# Remove status update script
rm -f /usr/local/sbin/chip-battery-update-status

# Remove polling script
rm -f /usr/local/bin/chip-battery-monitor

echo ""
echo "Done!"
echo ""
