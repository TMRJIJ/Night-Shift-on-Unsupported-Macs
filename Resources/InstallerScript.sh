#!/bin/bash

echo "Night Shift Enable Installer for Unsupported Macs"
echo "version 1.3"
echo "Installer made by Isiah Johnson (TMRJIJ) / OS X Hackers and Dosdude1"
echo ""
echo "All credits for this work goes to Piker Alpha. Thanks!"
echo "As told, this script is intended as non-commerical, with no Donation requests, Open Source, and must give thanks to PIke!"
echo "URL: https://pikeralpha.wordpress.com/2017/01/30/4398/"
# Actual Patching of Framework


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
		