import sys
from bs4 import BeautifulSoup

for i in range(1, len(sys.argv)):
	file = open(sys.argv[i], 'r+')
	if(file.readline().find("DOCTYPE") == -1):
		continue
	file.seek(0, 0)
	raw = file.read()
	html = BeautifulSoup(raw, 'html.parser')
	start = html.find(id="tripRouteFrom").div.text
	stop = html.find(id="tripRouteTo").div.text
	file.seek(0, 0)
	file.write("<!-- " + start + " to " + stop + " with " + "0.5 0.5 1" + " -->\n" + raw)