#!/usr/bin/python3.7

import subprocess
import logging
import os

cmd="systemctl poweroff"	#specifies the command to run on low battery


os.makedirs("/var/log/chip-battery-monitor", exist_ok=True)
logging.basicConfig(filename='/var/log/chip-battery-monitor/log', level=logging.INFO, format='%(asctime)s %(message)s', datefmt='%d/%m/%Y %I:%M:%S %p')
subprocess.run("i2cset -y -f 0 0x34 0x82 0xC3", shell=True)	#Force ADC enable for battery voltage and current
percentageHex=subprocess.run("i2cget -y -f 0 0x34 0xb9", shell=True, capture_output=True) #read battery percentage
percentage=int(percentageHex.stdout, 16) #convert from hex to int
powerMode=subprocess.run("i2cget -y -f 0 0x34 0x01", shell=True, capture_output=True) # Read Power OPERATING MODE register @01h
isCharging=(int(powerMode.stdout, 16) & int("0x40", 16))/64	#I know it's ugly, I don't know Python well...
if percentage<=5 and isCharging==0:
	logging.info('I think battery is at %i\% so I\'m shutting down C.H.I.P.', percentage)
	subprocess.run(cmd, shell=True)
