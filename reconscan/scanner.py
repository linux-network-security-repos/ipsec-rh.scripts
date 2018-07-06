
import socket
import os
import struct
from ctypes import *
from netaddr import IPNetwork, IPAddress
import threading
import time

# host to listen on
host = "172.25.1.132"

# subnet
subnet = "172.25.1.0/24"

# icmp message to be sent
magic_message = "PYTHONRULES!"

# this sprays out the udp datagrams
def udp_sender(subnet, magic_message):
    time.sleep(5)
    sender = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    for ip in IPNetwork(subnet):
        try:
            if ip == host:
                pass
            else:
                #print "Sending magic_message to %s" % ip
                sender.sendto(magic_message, ("%s" % ip, 65212))
                #print
        except:
            pass


# adding ICMP class
class ICMP(Structure):
    _fields_ = [
        ("type", c_ubyte),
        ("code", c_ubyte),
        ("checksum", c_ushort),
        ("unused", c_ushort),
        ("next_hop_mtu", c_ushort)
    ]

    def __new__(self, socket_buffer):
        return self.from_buffer_copy(socket_buffer)

    def __init__(self, socket_buffer):
        pass

# our IP Header
class IP(Structure):
    _fields_ = [
        ("ihl",  c_ubyte, 4),
        ("version", c_ubyte, 4),
        ("tos", c_ubyte),
        ("len", c_ushort),
        ("id", c_ushort),
        ("offset", c_ushort),
        ("ttl", c_ubyte),
        ("protocol_num", c_ubyte),
        ("sum", c_ushort),
        ("src", c_ulong),
        ("dst", c_ulong)
    ]

    def __new__(self, socket_buffer=None):
        return self.from_buffer_copy(socket_buffer)

    def __init__(self, socket_buffer=None):

        #self.__new__(socket_buffer)

        # map protocol constants to their names
        self.protocol_map = {1: "ICMP", 6: "TCP", 17: "UDP"}


        # human readable IP addresses
        self.src_address = socket.inet_ntoa(struct.pack("<L", self.src))
        self.dst_address = socket.inet_ntoa(struct.pack("<L", self.dst))

        # human readable protocol
        try:
            self.protocol = self.protocol_map[self.protocol_num]
        except:
            self.protocol = str(self.protocol_num)



# start sending packets
t = threading.Thread(target=udp_sender, args=(subnet, magic_message))
t.start()


# setting up socket
if os.name == "nt":
    socket_protocol = socket.IPPROTO_IP
else:
    socket_protocol = socket.IPPROTO_ICMP

sniffer = socket.socket(socket.AF_INET, socket.SOCK_RAW, socket_protocol)

sniffer.bind((host, 0))

sniffer.setsockopt(socket.IPPROTO_IP, socket.IP_HDRINCL, 1)

if os.name == "nt":
    socket.ioctl(socket.SIO_RCVALL, socket.RCVALL_ON)

try:
    while True:
        # read in the packet
        raw_buffer = sniffer.recvfrom(65212)[0]

        # create an ip header from the first 20 bytes of the buffer
        ip_header = IP(raw_buffer[0:32])

        # print out the protocol that was detected and the hosts
        #print "Protocol: %s %s -> %s" % (ip_header.protocol, ip_header.src_address, ip_header.dst_address)

        # if it's ICMP, we want it
        if ip_header.protocol == "ICMP":
            # calculate where our ICMP packet starts
            offset = ip_header.ihl * 4
            buf = raw_buffer[offset:offset + sizeof(ICMP)]

            # create our ICMP structure
            icmp_header = ICMP(buf)

            #print "ICMP -> Type: %d Code: %d Checksum %d" % (icmp_header.type, icmp_header.code, icmp_header.checksum)

            # now check for the TYPE 3 and CODE
            if icmp_header.code == 3 and icmp_header.type == 3:

                #making sure the ip is in our subnet
                if IPAddress(ip_header.src_address) in IPNetwork(subnet):
                    # checking if the header file contains our magic message
                    if raw_buffer[len(raw_buffer) - len(magic_message):] == magic_message:
                        print "Host Up: %s" % ip_header.src_address


# handle CTRL-C
except KeyboardInterrupt:
    if os.name == "nt":
        sniffer.ioctl(socket.SIO_RCVALL, socket.RCVALL_OFF)
