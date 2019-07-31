import sys
from bs4 import BeautifulSoup

for i in range(1, len(sys.argv)):
	try:
		file = open(sys.argv[i].split('.')[0] + '.csv', 'x')
	except FileExistsError:
		print("Skipping " + sys.argv[i].split('.')[0] + '.csv')
		continue

	raw = open(sys.argv[i]).read()
	html = BeautifulSoup(raw, 'html.parser')
	html = html.find(id="steps")

	distance = 1

	for listItem in html.select('div'):
		if 'row' in listItem['class']:
			if listItem.a == None:
				for d in listItem.div.div.select('div'):
					if 'stationInfo' in d['class']:
						#print(d.b.text)
						distance += 1
			else:
				for d in listItem.a.div.div.select('div'):
					if 'fuelPrice' in d['class']:
						#print([x.strip() for x in d.text.split('\n') if x][0])
						if(distance > 70):
							print(sys.argv[i])
						file.write(str(distance) + ',' + [x.strip() for x in d.text.split('\n') if x][0] + '\n')
						distance = 1
	if(distance > 1):
		file.write(str(distance - 1) + ',0\n')
