#!/bin/bash
# MACH - ifconfig based mac changer
echo "Network Manager? If you dont have it uncomment!"
service network-manager stop
echo "You may need to change the names of your interfaces!"
ifconfig eth0 down && ifconfig wlan0 down && ifconfig wlan1 down
ifconfig eth0 hw ether 00:00:00:00:00:00
ifconfig wifi0 hw ether 00:00:00:00:00:00
ifconfig wifi1 hw ether 00:00:00:00:00:00
service network-manager start
ifconfig eth0 up && ifconfig wlan0 up && ifconfig wlan1 up
# more functions to come
echo "Finished! Your interfaces now have a 00:00:00:00:00:00 MAC Address!"
