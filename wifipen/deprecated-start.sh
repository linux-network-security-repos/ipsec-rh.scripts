#!/bin/bash
echo "COMING SOON!"
echo "I have two attack antennas, a TP link and a Alfa"
echo "I am going to utilize them both, with all this code in this repository"
echo "If those antennas are not in monitor mode, ctrl+c and do that now!!!"
sleep 10
echo "For now we just start with changing mac's"
ifconfig wlan1mon down && ifconfig wlan2mon down
macchanger -r wlan1mon && macchanger -r wlan2mon
ifconfig wlan1mon up && ifconfig wlan2mon up
echo "I hope those were your antennas"
