#!/bin/bash

MACMODEL="$(sysctl -n hw.model)"

# Checks Mac Model
function checkMac(){
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
		return 1
	fi
	return 0
}

echo "Checking Mac Model"
checkMac