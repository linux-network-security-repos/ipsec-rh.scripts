
import socket

host = "www.google.com"
port = 80

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect((host, port))

# sending data
client.send("GET / HTTP/1.1\r\nHost: google.com\r\n\r\n")

# receiving data
response = client.recv(4096)

# displaying data
print response
