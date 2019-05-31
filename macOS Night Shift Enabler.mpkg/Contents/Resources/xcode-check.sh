#!/bin/bash


# Checks for Command Line Tool Installation
function xcodetoolsCheck {
if [[ ! -d "$("xcode-select" -p)" ]]; then
		echo "Your Mac doesn't appear to have Command Line Tool. Please type 'xcode-select --install' command in the terminal to install it, then run this script again."
		return 1
	fi
	return 0
}

echo "Checking for Command Line Tools"
xcodetoolsCheck