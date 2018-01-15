#!/bin/bash

		
function vertifySIP {
	echo -n "Verifying SIP..."
	if [[ !($(csrutil status | grep enabled | wc -l) -eq 0) ]]; then
		echo "SIP is enabled on this system. Please boot into Recovery HD or a Sierra Installer USB drive, open a new Terminal Window, and enter 'csrutil disable'. When completed, reboot back into your standard Sierra install, and run this script again."
		return 0
	elif [[ "$(csrutil status | head -n 1)" == *"status: enabled (Custom Configuration)"* ]]; then
		echo "The SIP status has a Custom Configuration. The script might or mighty not work."
		return 1		
	else	
		echo ""
		echo "System Integrity Protection is already disabled"
		return 3
	fi
			
		
}

vertifySIP

