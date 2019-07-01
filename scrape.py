import sys
from bs4 import BeautifulSoup

source = 'Trip1.html'
if(len(sys.argv) == 2):
	source = 'Trip' + sys.argv[1] + '.html'
else:
	print('usage: ' + sys.argv[0] + ' [Trip num]')
	quit()

raw = open(source).read()
html = BeautifulSoup(raw, 'html.parser')
file = open('trip.csv', 'w')

html = html.find(id="steps")

for listItem in html.select('div'):
	if 'row' in listItem['class']:
		if listItem.a == None:
			for d in listItem.div.div.select('div'):
				if 'stationInfo' in d['class']:
					#print(d.b.text)
					file.write("1,0\n")
		else:
			for d in listItem.a.div.div.select('div'):
				if 'fuelPrice' in d['class']:
					#print([x.strip() for x in d.text.split('\n') if x][0])
					file.write('1,' + [x.strip() for x in d.text.split('\n') if x][0] + '\n')