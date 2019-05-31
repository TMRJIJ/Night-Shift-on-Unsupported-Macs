#!/bin/bash

MACMODEL="$(sysctl -n hw.model)"
OSVERSION="$(sw_vers -productVersion)"

function vertifyOS {
if [[ "$(echo "${OSVERSION}" | cut -d"." -f2)" -lt 12 ]]; then
	echo "Incompatible version of macOS, install macOS Sierra and run this script again"
	return 1
	elif [[ "$(echo "${OSVERSION}" | cut -d"." -f2)" == 12 ]]; then
		if [[ "$(echo "${OSVERSION}" | cut -d"." -f3)" -lt 4 ]]; then	
			echo "Requires macOS 10.12.4 or higher. You have version: $(sw_vers -productVersion), install the newest macOS update and run this script again"
			echo ""
			return 1
		fi
fi
return 0
}

echo "Checking OS..."
vertifyOS