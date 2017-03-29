# Night Shift on Unsupported Macs

Night Shift Enable Script for Unsupported Macs
Script made by Isiah Johnson (TMRJIJ) / OS X Hackers

![alt tag](http://dl.osxhackers.net/.images/NightShift.png)

This script will replace the CoreBrightness.framework with one already patched with the matching hex value in CoreBrightness.framework for most older/unsupported hardware.

All credits for this work goes to Piker Alpha. Thanks!
As requested, this script is intended as non-commerical, with no Donation requests, Open Source, and must give thanks to Pike!
URL: https://pikeralpha.wordpress.com/2017/01/30/4398/

Night Shift was introduced in macOS Sierra 10.12.4 (Build 16E144f and Public Beta-1) and is controlled by the CoreBrightness.framework. The official minimum requirements for this feature are: 

MacBookPro9,x

iMac13,x

Macmini6,x

MacBookAir5,x

MacPro6,x

MacBook8,x

__Warning: This patch has not been tested on macOS 10.12.5 Developer Previews yet.__

# Patching Instructions
1. Open the Terminal app in your Applications Folder
2. Drag the 'Enable NightShift.sh' into the Terminal Window
3. Following the instructions
4. After Patching. Restart your Mac.

# Uninstall
I haven't made an uninstallation script yet but you can easily revert back to the original CoreBrightness framework.
1. Copy the Backup ~/CoreBrightness/CoreBrightness.framework' into '/System/Library/PrivateFrameworks/'
Terminal Command:
> sudo cp -r "~/CoreBrightness/CoreBrightness.framework" "/System/Library/PrivateFrameworks/" 
    




As such, if something goes wrong (like the Display tab in System Preference crashing) or if this framework copy doesn't work. Please feel free to email me at support@osxhackers.net or attempt it manually via Pike's original blog post.