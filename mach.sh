#!/bin/bash
# MACH - ifconfig based mac changer
echo "You may need to change the names of your interfaces!"
sleep 5.0
#ifconfig eth0 down
#ifconfig wlan0 down
#ifconfig wlan1 down
/etc/init.d/networking stop
sleep 0.1
ifconfig eth0 down
ifconfig eth0 hw ether 00:00:00:00:00:01
sleep 0.3
ifconfig eth0 up
ifconfig wlan0 down
ifconfig wlan0 hw ether 00:00:00:00:00:05
sleep 0.3
ifconfig wlan0 up
ifconfig wlan1 down
ifconfig wlan1 hw ether 00:00:00:00:00:07
sleep 0.3
ifconfig wlan1 up
sleep 0.1
/etc/init.d/networking start
# UMMM, FIX THIS
echo "Finished! Your interfaces now have a 00:00:00:00:00:0X MAC Address!"
# Some Reason It Broke a Realtek Card. Be Careful...
# YIKES
