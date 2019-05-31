#!/bin/bash

# Do NOT Change. New Version will need these variables
#CATALOGURL="https://swscan.apple.com/content/catalogs/others/index-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog.gz"
COREBRIGHTNESS="/System/Library/PrivateFrameworks/CoreBrightness.framework"
COREBRIGHTNESS_A="/System/Library/PrivateFrameworks/CoreBrightness.framework/Versions/A/CoreBrightness"
CBSIGNATURE="/System/Library/PrivateFrameworks/CoreBrightness.framework/Versions/A/_CodeSignature"
CBBACKUP="/Library/CoreBrightness Backup"
MACMODEL="$(sysctl -n hw.model)"
OSVERSION="$(sw_vers -productVersion)"

OFFSET_FULL="$(nm "${COREBRIGHTNESS_A}" | grep _ModelMinVersion | cut -d' ' -f 1 | sed -e 's/^0*//g' | head -1)"
OFFSET="0x${OFFSET_FULL}"

APPSUPPORT="/Library/Application Support/Night Shift/"


echo "Night Shift Enable Script for Unsupported Macs"
echo "version 2.0"
echo "Script made by Isiah Johnson (TMRJIJ) / OS X Hackers and Dosdude1"
echo ""
echo "All credits for this work goes to Piker Alpha. Thanks!"
echo "Special thanks to pookjw, PeterHolbrook, dosdude1, and aonez for their continued critiques and support from their own source work."
echo ""
echo "This script is intended as non-commerical, with no Donation requests, Open Source, and must give thanks to PIke!"
echo "URL: https://pikeralpha.wordpress.com/2017/01/30/4398/"
echo ""
echo ""

# Details about the script
echo "Night Shift was introduced in macOS Sierra 10.12.4 (16E144f) and is controlled by the CoreBrightness.framework. The official minimum requirements for this feature are: 

MacBookPro9,x
iMac13,x
Macmini6,x
MacBookAir5,x
MacPro6,x
MacBook8,x

This script will replace the CoreBrightness.framework with one already patched with the matching hex value in CoreBrightness.framework for most older/unsupported hardware.

As such, if something goes wrong (like the Display tab in System Preference crashing) or if this framework copy doesn't work. Please feel free to email me at support@osxhackers.net or attempt it manually via Pike's original blog post."
echo ""



# Checks if System Version is at least 10.12.4
echo "Checking System Version..."
echo ""

if [[ "$(echo "${OSVERSION}" | cut -d"." -f2)" -lt 12 ]]; then
	echo "Incompatible version of macOS, install macOS Sierra and run this script again"
	exit
	elif [[ "$(echo "${OSVERSION}" | cut -d"." -f2)" == 12 ]]; then
		if [[ "$(echo "${OSVERSION}" | cut -d"." -f3)" -lt 4 ]]; then	
			echo "Requires macOS 10.12.4 or higher. You have version: $(sw_vers -productVersion), install the newest macOS update and run this script again"
			echo ""
			exit
		fi
fi

# Checks Mac Model
if [[ ! -z "$(echo "${MACMODEL}" | grep "MacBookPro")" ]]; then
		if [[ "$(echo "${MACMODEL}" | cut -d"o" -f4 | cut -d"," -f1)" -ge 9 ]]; then
			SUPPORTEDMAC=YES
		fi
	elif [[ ! -z "$(echo "${MACMODEL}" | grep "iMacPro")" ]]; then
			SUPPORTEDMAC=YES
	elif [[ ! -z "$(echo "${MACMODEL}" | grep "iMac")" ]]; then
		if [[ "$(echo "${MACMODEL}" | cut -d"c" -f2 | cut -d"," -f1)" -ge 13 ]]; then
			SUPPORTEDMAC=YES
		fi
	elif [[ ! -z "$(echo "${MACMODEL}" | grep "Macmini")" ]]; then
		if [[ "$(echo "${MACMODEL}" | cut -d"i" -f3 | cut -d"," -f1)" -ge 6 ]]; then
			SUPPORTEDMAC=YES
		fi
	elif [[ ! -z "$(echo "${MACMODEL}" | grep "MacBookAir")" ]]; then
		if [[ "$(echo "${MACMODEL}" | cut -d"r" -f2 | cut -d"," -f1)" -ge 5 ]]; then
			SUPPORTEDMAC=YES
		fi
	elif [[ ! -z "$(echo "${MACMODEL}" | grep "MacPro")" ]]; then
		if [[ "$(echo "${MACMODEL}" | cut -d"o" -f2 | cut -d"," -f1)" -ge 6 ]]; then
			SUPPORTEDMAC=YES
		fi
	elif [[ ! -z "$(echo "${MACMODEL}" | grep "MacBook")" ]]; then
		if [[ "$(echo "${MACMODEL}" | cut -d"k" -f2 | cut -d"," -f1)" -ge 8 ]]; then
			SUPPORTEDMAC=YES
		fi
	fi
	if [[ "${SUPPORTEDMAC}" == YES ]]; then
		echo "Your Mac already supports Night Shift. It is not Recommended to use this Patch."
		echo "Quitting..."
		exit
	fi

#Determining the Offset from OS Version
if [[ "$(echo "${OSVERSION}" | cut -d"." -f2)" == 13 ]]; then
		if [[ -z "$(echo "${OSVERSION}" | cut -d"." -f3)" ]]; then # High Sierra 
			PATCH=1
		else
			if [ "$(echo "${OSVERSION}" | cut -d"." -f3)" -ge 2 ]; then
				PATCH=2 # High Sierra 10.13.2 to Mojave
			else
				PATCH=1 # 10.13.1
			fi
		fi
	elif [ "$(echo "${OSVERSION}" | cut -d"." -f2)" -gt 13 ]; then # Mojave or newer
		Patch=2
	else
		PATCH=1 # Sierra 10.12.4 or later
	fi



# Check if SIP is enabled. Exits if enabled.
echo "Checking System Integrity Protection status..."
echo ""

if [[ !($(csrutil status | grep enabled | wc -l) -eq 0) ]]; then
	echo "SIP is enabled on this system. Please boot into Recovery HD or a Sierra Installer USB drive, open a new Terminal Window, and enter 'csrutil disable'. When completed, reboot back into your standard Sierra install, and run this script again."
	echo ""
	exit
elif [[ "$(csrutil status | head -n 1)" == *"status: enabled (Custom Configuration)"* ]]; then
	echo "The SIP status has a Custom Configuration. The script might not work."
fi

# Check if Command Line Tools from XCode are installed
if [[ ! -d "$("xcode-select" -p)" ]]; then
		echo "Your Mac doesn't appear to have Command Line Tool. Please type 'xcode-select --install' command in the terminal to install it, then run this script again."
		exit
	fi

# Actual Patching of Framework
read -p "Ready to begin Patching? [y/n]: " prompt
	if [[ $prompt == 'y' ]]; then
		echo "Let get started then"
		echo ""
		
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


elif [[ $prompt == 'n' ]]; then
	echo""
	echo "Okay then, bye :P"
	exit 
else
	echo "No idea what you mean by '$prompt'. Closing Script now. Bye!" 
	exit  	
fi
		