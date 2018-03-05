
import socket

host = "127.0.0.1"
port = 631

client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

# client connection and data request sent
client.sendto("LuxFerro", (host, port))

# Receiving data
data, addr = client.recvfrom(4096)

print data, addr
