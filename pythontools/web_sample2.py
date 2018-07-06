
import urllib2

headers = {}
headers['User-Agent'] = "GoogleBot"

request = urllib2.Request("http://spiderapps.net", headers=headers)

response = urllib2.urlopen(request)
print dir(response)

print response.readline()
#print response.read()

response.close()
