#!/bin/bash
# MACH - ifconfig based mac changer written by Diveyez 2/10/2018
echo "You may need to change the names of your interfaces in this script for it to work, You have 5 seconds to do that before erorrs occur."
sleep 5.0
#/etc/init.d/networking stop
sleep 0.1
ifconfig eth0 down
ifconfig eth0 hw ether $(printf '02:%02X:%02X:%02X:%02X:%02X \n' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
sleep 0.3
ifconfig eth0 up
sleep 0.1
ifconfig wlan0 down
ifconfig wlan0 hw ether $(printf '02:%02X:%02X:%02X:%02X:%02X \n' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
sleep 0.3
ifconfig wlan0 up
sleep 0.1
ifconfig wlan1 down
ifconfig wlan1 hw ether $(printf '02:%02X:%02X:%02X:%02X:%02X \n' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
sleep 0.3
ifconfig wlan1 up
sleep 0.3
ifconfig wlan2 down
ifconfig wlan2 hw ether $(printf '02:%02X:%02X:%02X:%02X:%02X \n' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
sleep 0.3
ifconfig wlan2 up
sleep 0.1
#/etc/init.d/networking restart
# UMMM, FIX THIS
echo "Finished! Your interfaces now have a entirely random MAC Address!"
# Some Reason It Broke a Realtek Card. Be Careful...
# YIKES
