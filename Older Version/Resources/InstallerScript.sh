#!/bin/bash

COREBRIGHTNESS='/System/Library/PrivateFrameworks/CoreBrightness.framework'
OFFSET="0x$(nm /System/Library/PrivateFrameworks/CoreBrightness.framework/Versions/A/CoreBrightness | grep _ModelMinVersion | cut -d' ' -f 1 | sed -e 's/^0*//g')"
MACMODEL="$(ioreg -l | awk '/product-name/ { split($0, line, "\""); printf("%s\n", line[4]); }')"
APPSUPPORT="/Library/Application Support/Night Shift/"

echo "Night Shift Enable Installer for Unsupported Macs"
echo "version 2.0"
echo "Installer made by Isiah Johnson (TMRJIJ) / OS X Hackers and Dosdude1"
echo ""
echo "All credits for this work goes to Piker Alpha. Thanks!"
echo "Special thanks to pookjw, PeterHolbrook, dosdude1, and aonez for their continued critiques and support from their own source work."
echo ""
echo "As told, this script is intended as non-commerical, with no Donation requests, Open Source, and must give thanks to PIke!"
echo "URL: https://pikeralpha.wordpress.com/2017/01/30/4398/"

#Backup Original Framework
echo "Backing Up older CoreBrightness Framework. It's in your Home Folder"
mkdir ~/CoreBrightness\ Backup
sudo cp -r $COREBRIGHTNESS ~/CoreBrightness\ Backup/

#Downloading and Replacing New Framework
echo "Downloading and Replacing Original with Modified Framework"
if [[ "$(sw_vers -productVersion | cut -d"." -f2)" == 13 ]]; then
	curl -o ~/CoreBrightness-HighSierra.zip "http://dl.osxhackers.net/NightShift/Resources/Curl/CoreBrightness-HighSierra.zip"
	sudo unzip -o ~/CoreBrightness-HighSierra.zip -d "/System/Library/PrivateFrameworks/"
	rm ~/CoreBrightness-HighSierra.zip			
else
	curl -o ~/CoreBrightness-Sierra.zip "http://dl.osxhackers.net/NightShift/Resources/Curl/CoreBrightness-Sierra.zip"	
	sudo unzip -o ~/CoreBrightness-Sierra.zip -d "/System/Library/PrivateFrameworks/"
	rm ~/CoreBrightness-Sierra.zip	
fi						

# Codesigning
echo "New CoreBrightness will be Codesigned"
sudo codesign -f -s - /S*/L*/PrivateFrameworks/CoreBrightness.framework/Versions/Current/CoreBrightness
echo ""
echo "Backing up new CoreBrightness Framework in Application Support Folder"
sudo cp -r $COREBRIGHTNESS $APPSUPPORT
echo "Finished. Please restart your Mac. After this, there should be a Night Shift Tab within System Preference > Displays"
echo "Enjoy"

echo""
echo"If you have issues, please feel free to go to the Github Repository"
		