#!/bin/bash

if [ "$(id -u)" != "0" ]
then
   echo "This script must be run as root (use sudo ./install.sh)." 1>&2
   exit 1
fi

# Set up files that will store battery status information so that it
# can be accessed by any user, not just root.
mkdir -p /usr/local/lib/chip-battery-status
echo "0" > /usr/local/lib/chip-battery-status/charging
echo "0" > /usr/local/lib/chip-battery-status/percentage
chmod +r /usr/local/lib/chip-battery-status/*

# Put status update script in place
mkdir -p /usr/local/sbin
cp ./source/sbin/chip-battery-update-status /usr/local/sbin/
chmod +x /usr/local/sbin/chip-battery-update-status

# Set up polling service to update battery status periodically
cp ./source/systemd/chip-battery-status-update.* /etc/systemd/system/
chmod +x /etc/systemd/system/chip-battery-status-update.*
systemctl start chip-battery-status-update.timer
systemctl enable chip-battery-status-update.timer

# Copy polling script
cp ./source/bin/chip-battery-monitor.py /usr/local/bin/
# Change permissions so everybody can read or execute the script, but nobody can modify it
chmod 0555 /usr/local/bin/chip-battery-monitor.py

echo ""
echo "Done!"
echo ""

