#!/bin/python

import subprocess

cmd="poweroff"	#specifies the command to run on low battery

def main():
	percentageFile=open("/usr/local/lib/chip-battery-status/percentage", "r")
	isChargingFile=open("/usr/local/lib/chip-battery-status/charging", "r")
	percentage=percentageFile.read()
	isCharging=isChargingFile.read()
	if percentage<=5 && isCharging==0:
		subprocess.call(cmd, shell=True)
