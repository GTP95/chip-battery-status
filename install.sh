#!/bin/bash

if [ "$(id -u)" != "0" ]
then
   echo "This script must be run as root (use sudo ./install.sh)." 1>&2
   exit 1
fi



# Set up polling service to check battery status periodically
echo "Copying systemd units and setting permissions"
cp ./source/systemd/chip-battery-status-check.* /etc/systemd/system/
chmod +x /etc/systemd/system/chip-battery-status-check.*
systemctl start chip-battery-status-check.timer
systemctl enable chip-battery-status-check.timer

# Copy polling script
echo "Copying battery status checker script and setting permissions"
cp ./source/bin/chip-battery-monitor.py /usr/local/bin/
# Change permissions so everybody can read or execute the script, but nobody can modify it
chmod 0555 /usr/local/bin/chip-battery-monitor.py

echo ""
echo "Done!"
echo ""

