

import os
import Queue
import threading
import urllib2

threads = 20
target = "http://spiderapps.net"
directory = "/root/programming/python/EthicalHacking"
filters = ['.swp']
headers = {}
headers['User-Agent'] = ""

os.chdir(directory)

web_paths = Queue.Queue()

for r, d, f in os.walk('.'):
	for files in f:
		remote_path = "%s/%s" % (r, files)

		if remote_path.startswith('.'):
			remote_path = remote_path[1:]

		if os.path.splitext(files)[1] not in filters:
			web_paths.put(remote_path)


def test_remote():
	while not web_paths.empty():
		web_path = web_paths.get()

		url = "%s/%s" % (target, web_path)
		request = urllib2.Request(url, headers=headers)

		try:
			response = urllib2.urlopen(request)
			content = response.read()

			print "[%d] => %s " % (content.code, web_path)
			response.close()

		except urllib2.HTTPError as error:
			print "Failed %s"  % error.code
			pass

for i in range(threads):
	print "Spawning thread %d: " % (i + 1)
	thread = threading.Thread(target=test_remote)
	thread.start()
