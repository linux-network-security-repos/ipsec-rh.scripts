
import socket
import threading

bind_host = "0.0.0.0"
bind_port = 8000

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind((bind_host, bind_port))

server.listen(5)

print "[+] Listening on %s:%d" % (bind_host, bind_port)

# defining client request handler
def handle_request(client_socket):
    request = client_socket.recv(1024)

    print "[-] Received: %s" % request

    client_socket.send("ACK!")
    print ""

    client_socket.close()


while True:
    client, addr = server.accept()
    print "[+] Accepted request from %s:%d" % (addr[0], addr[1])

    client_handler = threading.Thread(target=handle_request, args=(client,))
    client_handler.start()
