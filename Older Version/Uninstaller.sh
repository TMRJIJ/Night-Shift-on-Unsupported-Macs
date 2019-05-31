#!/bin/bash

echo "Night Shift Enable Script for Unsupported Macs"
echo "Uninstaller v1.1"
echo ""
echo "Script made by Isiah Johnson (TMRJIJ) / OS X Hackers and Dosdude1"
echo ""
echo "All credits for the Framework script goes to Piker Alpha. Thanks!"
echo "URL: https://pikeralpha.wordpress.com/2017/01/30/4398/"
echo ""

# Checks if System Version is at least 10.12.4
echo "Checking System Version..."
echo ""

if [[ "$(sw_vers -productVersion | cut -d"." -f2)" -lt 12 ]]; then
	echo "Incompatible version of macOS, exiting..."
	echo ""
	exit
	elif [[ "$(sw_vers -productVersion | cut -d"." -f2)" == 12 ]]; then
		if [[ "$(sw_vers -productVersion | cut -d"." -f3)" -lt 4 ]]; then	
			echo "Requires macOS 10.12.4 or higher. You have version: $(sw_vers -productVersion), exiting..."
			echo ""
			exit
		fi
fi

# Check if SIP is enabled. Exits if enabled.
echo "Checking System Integrity Protection status..."
echo ""

if [[ !($(csrutil status | grep enabled | wc -l) -eq 0) ]]; then
	echo "SIP is enabled on this system. Please boot into Recovery HD or a Sierra Installer USB drive, open a new Terminal Window, and enter 'csrutil disable'. When completed, reboot back into your standard Sierra install, and run this script again."
	echo ""
	exit
fi

# Reverting Framework from Backup. Quits if there the Backup directory does not exists.
read -p "Are you sure you want to revert your Mac back to normal? [y/n]: " prompt
if [[ $prompt == 'y' ]]; then
	if [  -d ~/CoreBrightness\ Backup/CoreBrightness.framework ]; then
		echo "Reverting Framework"
		sudo cp -r ~/CoreBrightness\ Backup/CoreBrightness.framework "/System/Library/PrivateFrameworks/"
		echo "Original CoreBrightness will be Codesigned"
		sudo codesign -f -s - /S*/L*/PrivateFrameworks/CoreBrightness.framework/Versions/Current/CoreBrightness
		echo "Removing Backup"
		sudo rm -rf ~/CoreBrightness\ Backup
		echo ""
		echo "Finished. Please restart your Mac. After this, the Night Shift feature should be removed"
		echo "Enjoy"
	else	
		echo "No CoreBrightness Framework Backup found. Exiting..."	
		exit 
	fi
elif [[ $prompt == 'n' ]]; then
		echo""
		echo "Okay cool. Let me know if you need to uninstall then..."
		exit 
	else
		echo "No idea what you mean by '$prompt'. Closing Script now. Bye!" 
		exit  	
	fi
		