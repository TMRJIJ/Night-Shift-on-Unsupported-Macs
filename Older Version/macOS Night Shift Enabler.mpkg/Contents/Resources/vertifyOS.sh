#!/bin/bash



function vertifyOS {
	if [[ "$(sw_vers -productVersion | cut -d"." -f2)" -lt 12 ]]; then
		echo "Incompatible version of macOS, exiting..."
		echo ""
		return 1
		elif [[ "$(sw_vers -productVersion | cut -d"." -f2)" == 12 ]]; then
			if [[ "$(sw_vers -productVersion | cut -d"." -f3)" -lt 4 ]]; then	
				echo "Requires macOS 10.12.4 or higher. You have version: $(sw_vers -productVersion), exiting..."
				echo ""
				return 1
			fi
	fi	
return 0
}

echo "Checking OS..."
vertifyOS