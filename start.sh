#!/bin/bash
echo "COMING SOON!"
echo "For now we just start with changing mac's"
ifconfig wlan1mon down && ifconfig wlan2mon down
macchanger -r wlan1mon && macchanger -r wlan2mon
echo "I hope those were your antennas"
