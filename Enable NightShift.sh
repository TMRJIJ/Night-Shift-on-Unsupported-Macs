#!/bin/bash

echo "Night Shift Enable Script for Unsupported Macs"
echo "version 1.4"
echo "Script made by Isiah Johnson (TMRJIJ) / OS X Hackers and Dosdude1"
echo ""
echo "All credits for this work goes to Piker Alpha. Thanks!"
echo "As told, this script is intended as non-commerical, with no Donation requests, Open Source, and must give thanks to PIke!"
echo "URL: https://pikeralpha.wordpress.com/2017/01/30/4398/"
echo ""
# Details about the script
echo "Night Shift was introduced in macOS Sierra 10.12.4 (Build 16E144f and Public Beta-1) and is controlled by the CoreBrightness.framework. The official minimum requirements for this feature are: 

MacBookPro9,x
iMac13,x
Macmini6,x
MacBookAir5,x
MacPro6,x
MacBook8,x

This script will replace the CoreBrightness.framework with one already patched with the matching hex value in CoreBrightness.framework for most older/unsupported hardware.

As such, if something goes wrong (like the Display tab in System Preference crashing) or if this framework copy doesn't work. Please feel free to email me at support@osxhackers.net or attempt it manually via Pike's original blog post.
"

# Expecting determination of Mac Model 
macModel="$(ioreg -l | awk '/product-name/ { split($0, line, "\""); printf("%s\n", line[4]); }')"

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

# Actual Patching of Framework
read -p "Ready to begin Patching? [y/n]: " prompt
if [[ $prompt == 'y' ]]; then
		echo "Let get started then"
		echo ""
		echo "Backing Up older CoreBrightness Framework. It's in your Home Folder"
		mkdir ~/CoreBrightness\ Backup
		sudo cp -r "/System/Library/PrivateFrameworks/CoreBrightness.framework" ~/CoreBrightness\ Backup/
		echo "Downloading and Replacing Original with Modified Framework"
		curl -o ~/CoreBrightness.framework.zip "http://dosdude1.com/sierra/NightShiftPatch/CoreBrightness.framework.zip"
        sudo unzip -o ~/CoreBrightness.framework.zip -d "/System/Library/PrivateFrameworks/"
        rm ~/CoreBrightness.framework.zip
		echo "New CoreBrightness will be Codesigned"
		sudo codesign -f -s - /S*/L*/PrivateFrameworks/CoreBrightness.framework/Versions/Current/CoreBrightness
		echo ""
		echo "Finished. Please restart your Mac. After this, there should be a Night Shift Tab within System Preference > Displays"
		echo "Enjoy"


elif [[ $prompt == 'n' ]]; then
	echo""
	echo "Okay then, bye :P"
	exit 
else
	echo "No idea what you mean by '$prompt'. Closing Script now. Bye!" 
	exit  	
fi
		