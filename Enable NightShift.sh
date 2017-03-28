#!/bin/bash
rsrcPath=$1
volPath=$2
specPath=$3



echo "Night Shift Enable Script for Unsupported Macs"
echo"version 1.0"
echo "Script made by Isiah Johnson (TMRJIJ) / OS X Hackers"
echo ""
echo "All credits for this work goes to Piker Alpha. Thanks!"
echo "As told, this script is intended as non-commerical, with no Donation requests, Open Source, and must give thanks to PIke!"
echo "URL: https://pikeralpha.wordpress.com/2017/01/30/4398/"
echo ""
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

echo "Checking  System Integrity Protection status"
echo "If SIP status  below shows as enabled, please boot into Recovery HD, open a new Terminal Window, and type and enter 'csrutil disable' and restart your Mac. This won't work otherwise"
echo ""
csrutil status


read -p "Ready to begin Patching? Enter [y/n]: " prompt
if [[ $prompt == 'y' ]]; then
		echo "Let get started then"
		echo ""
		echo "Backing Up older CoreBrightness Framework. It's in your Home Folder"
		mkdir ~/CoreBrightness\ Backup
		sudo cp -r "/System/Library/PrivateFrameworks/CoreBrightness.framework" ~/CoreBrightness\ Backup/
		echo "Replacing Original with Modified Framework"
		sudo cp -r "./Resources/CoreBrightness.framework"  "/System/Library/PrivateFrameworks/"
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
		