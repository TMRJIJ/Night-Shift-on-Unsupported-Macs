#!/bin/bash

txtFile="/Library/Application Support/Night Shift/BuildVersions.txt"
checkBuildNumber=$(sw_vers -buildVersion)

echo $checkBuildNumber

function vertifyBuild {
	if grep -q $checkBuildNumber "$txtFile"; then
		echo "macOS hasn't been updated. Framework should remain intact. Quitting script"
		exit 0
	else
		
		# sudo cp -r "/System/Library/PrivateFrameworks/CoreBrightness.framework" ~/CoreBrightness\ Backup/
		# sudo cp -r "/Library/Application Support/Night Shift/CoreBrightness.framework" "/System/Library/PrivateFrameworks/"
		echo "$checkBuildNumber" >> "$txtFile"
	fi		
}

echo "starting..."
vertifyBuild