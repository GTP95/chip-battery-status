#!/bin/python

import subprocess
import logging
import os

cmd="systemctl poweroff"	#specifies the command to run on low battery

def main():
	os.makedirs("/var/log/chip-battery-monitor", exist_ok=True)
	logging.basicConfig(filename='/var/log/chip-battery-monitor', level=logging.INFO, format='%(asctime)s %(message)s', datefmt='%d/%m/%Y %I:%M:%S %p')
	percentageFile=open("/usr/local/lib/chip-battery-status/percentage", "r")
	isChargingFile=open("/usr/local/lib/chip-battery-status/charging", "r")
	percentage=percentageFile.read()
	isCharging=isChargingFile.read()
	if percentage<=5 && isCharging==0:
		logging.info('I think battery is at %i\% so I'm shutting down C.H.I.P.', percentage)
		subprocess.call(cmd, shell=True)
