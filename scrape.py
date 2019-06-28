from bs4 import BeautifulSoup

raw = open('Trip1.html').read()
html = BeautifulSoup(raw, 'html.parser')
file = open('trip.csv', 'w')

for listItem in html.div.select('div'):
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