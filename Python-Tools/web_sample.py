

import urllib2

body = urllib2.urlopen("http://spiderapps.net")

print body.read()
