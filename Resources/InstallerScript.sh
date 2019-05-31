#!/bin/bash

COREBRIGHTNESS="/System/Library/PrivateFrameworks/CoreBrightness.framework"
COREBRIGHTNESS_A="/System/Library/PrivateFrameworks/CoreBrightness.framework/Versions/A/CoreBrightness"
CBSIGNATURE="/System/Library/PrivateFrameworks/CoreBrightness.framework/Versions/A/_CodeSignature"
CBBACKUP="/Library/CoreBrightness Backup"
MACMODEL="$(sysctl -n hw.model)"
OSVERSION="$(sw_vers -productVersion)"

OFFSET_FULL="$(nm "${COREBRIGHTNESS_A}" | grep _ModelMinVersion | cut -d' ' -f 1 | sed -e 's/^0*//g' | head -1)"
OFFSET="0x${OFFSET_FULL}"

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
		echo "Backing Up older CoreBrightness Framework. It's in your Library Folder"
		sudo mkdir -p $CBBACKUP
		sudo cp $COREBRIGHTNESS_A /Library/CoreBrightness\ Backup/CoreBrightness.bak
		sudo cp -r $CBSIGNATURE /Library/CoreBrightness\ Backup/_CodeSignature.bak

		
	#Patching  Framework
		echo "Patching Framework"

		if [ -z ${OFFSET_FULL} ]; then
			echo -e "Can't find the offset to patch, Installation will not continue."
			exit
		fi
		echo "Offset: ${OFFSET}"

		echo 'Getting Offset Hex Data'
		OFFSET_ORIGINAL="$(xxd -s ${OFFSET} -c 24 -l 24 "${COREBRIGHTNESS_A}")"
		echo "Original Hex: ${OFFSET_ORIGINAL}"

		if [[ $OFFSET_ORIGINAL == *'0100 0000 0100 0000 0100 0000 0100 0000 0100 0000 0100 0000'* ]]; then
			echo -e "A patch was already applied on \"${COREBRIGHTNESS}\". No Need to worry."
			exit
		fi
		# Checking for temp files
		if [ -f "${COREBRIGHTNESS}/Versions/Current/CoreBrightness.temp" ]; then
			echo -e "Detected obsolete file CoreBrightness.temp from the backup, removing"
			sudo rm "${COREBRIGHTNESS}/Versions/Current/CoreBrightness.temp"
		fi
		if [[ -f "/System/Library/PrivateFrameworks/CoreBrightness.framework/Versions/A/CoreBrightness.tbd" ]]; then
			echo "Detected CoreBrightness.tbd, removing..."
			sudo rm "${COREBRIGHTNESS}/Versions/A/CoreBrightness.tbd"
		fi		
		# 
		printf "\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00\x01\x00\x00\x00" | sudo dd count=24 bs=1 seek=$((${OFFSET})) of="${COREBRIGHTNESS_A}" conv=notrunc
		echo 'Checking offset hex changed...'
		OFFSET_CHECK="$(xxd -s ${OFFSET} -c 24 -l 24 "${COREBRIGHTNESS_A}")"
		echo "New Hex Data: ${OFFSET_CHECK}"
		
				
	# Codesigning
		echo "New CoreBrightness will be Codesigned"
		sudo codesign -f -s - $COREBRIGHTNESS_A
		sudo chmod +x $COREBRIGHTNESS_A
		echo ""
		echo "Backing up new CoreBrightness Framework in Application Support Folder"
		sudo cp -R $COREBRIGHTNESS $APPSUPPORT
		echo "Finished. Please restart your Mac. After this, there should be a Night Shift Tab within System Preferences > Displays"
		echo "Enjoy"
		
		echo ""
		echo "If you have issues, please feel free to go to the Github Repository"


