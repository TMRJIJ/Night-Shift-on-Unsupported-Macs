# Night Shift on Unsupported Macs

Updated April 13, 2017 

Night Shift Enable Script for Unsupported Macs
Script made by Isiah Johnson (TMRJIJ) / [OS X Hackers](http://osxhackers.net "OS X Hackers") & Dosdude1

![alt tag](http://dl.osxhackers.net/.images/NightShift.png)

This script will replace the CoreBrightness.framework with one already patched with the matching hex value in CoreBrightness.framework for most older/unsupported hardware.

All credits for this work goes to Piker Alpha. Thanks!
As requested, this script is intended as non-commerical, with no Donation requests, Open Source, and must give thanks to Pike!
Blog URL: https://pikeralpha.wordpress.com/2017/01/30/4398/

# History

macOS Sierra 10.12.4 brings iOS's Night Shift mode to the Mac for the first time. Night Shift, first introduced on iOS devices in iOS 9.3, is designed to gradually shift the display of a device from blue to a subtle yellow, cutting down on exposure to blue light. Blue light is believed to interrupt the circadian rhythm, disrupting sleep patterns. 

Night Shift is activated through the Displays section of System Preferences, where a setting to have it come on at sunset and turn off at sunrise is available. It can also be set to turn on and off at custom times. Night Shift can also be toggled on manually using the Notification Center or Siri. 

Night Shift was introduced in macOS Sierra 10.12.4 (Build 16E144f and Public Beta 1) and is controlled by the CoreBrightness.framework. The official minimum requirements for this feature are: 

- MacBookPro9,x
- iMac13,x
- Macmini6,x
- MacBookAir5,x
- MacPro6,x
- MacBook8,x

Of course, this patch is intended to bypass this check completely.

# OS Version Requirements

- macOS 10.12.4 (16E195) Supported
- macOS 10.12.5 Developer Beta 1 (16F43c) Supported
- macOS 10.12.5 Developer Beta 2 (16F54b) Supported

macOS Public Betas are assume to match its respective Developer Builds.
__Warning: This patch might stop working in certain macOS 10.12.5 Developer Betas or later. Please be cautious and watch this repository for changes.__

# Patching Instructions

Note: System Integrity Protection must be disabled beforehand in order to patch the framework. You can re-enable it after you're done. Software Updates may revert this patch so always check this repository for updates. [HOW TO DISABLE SIP?](http://apple.stackexchange.com/questions/208478/how-do-i-disable-system-integrity-protection-sip-aka-rootless-on-os-x-10-11 )

Always BACKUP before attempting this patch!

1. Open the Terminal app in your Applications Folder
2. Drag the 'Enable NightShift.sh' into the Terminal Window
3. Following the instructions
4. After Patching. Restart your Mac.
5. You will see that the Night Shift tab is now available in System Preferences > Display as well as the toggle at the top of your Notification Center.

# Uninstall

1. Open the Terminal app in your Applications Folder
2. Drag the 'Uninstaller.sh' into the Terminal Window
3. Following the instructions
4. After Reverting. Restart your Mac.
5. You will see that the Night Shift tab is no longer available.
    

# Known Bugs

- Certain Third-party monitors are NOT Compatible with this Patch.


# Support

As such, if something goes wrong (like the Display tab in System Preference crashing) or if this framework copy doesn't work. Please feel free to email me at support@osxhackers.net, let me know in the Issues Tab, or attempt it manually via [Pike's original blog post.](https://pikeralpha.wordpress.com/2017/01/30/4398/)

Have Fun!


![alt tag](http://osxhackers.net/img/osxhfullblack.png)
