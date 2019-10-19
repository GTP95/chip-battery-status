# CHIP battery status for headless server

A simple script to monitor battery percentage and automatically shutdown on low battery

## How to install
Download/clone the files to your CHIP.
```
cd chip-battery-status
sudo ./install.sh
```



## How to uninstall
```
sudo ./uninstall.sh
```
This will disable the battery status polling service
and remove previously-installed scripts and files.

It will not remove the desktop panel item. To remove that 
simply right-click (_or Ctrl-click_) the item and select 
`Remove`.

## Customisation
