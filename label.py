import sys

start = 0.6
go = 0.85
last = 1-go


lens = open("lengths.csv", "r")
for line in lens:
	lenr = line.split(',')

	sumDistance = 0
	numRates = 0
	sumRates = 0
	midStations = 0
	endStations = 0
	guess = 0
	file = open(lenr[0], 'r')
	for line in file:
		data = [float(d.strip()) for d in line.split(',')]
		sumDistance += int(data[0])
		if(data[1] != 0):
			numRates += 1
			sumRates += data[1]
			if(sumDistance >= start * float(lenr[1]) and sumDistance <= go * float(lenr[1])):
				midStations += 1
			if(sumDistance >= go * float(lenr[1])):
				endStations += 1
			if(midStations == 1 and guess == 0):
				guess = (numRates-1) * ((1-(go-start))/start)
	print(lenr[0] + ": ")
	print("  k =                " + str(midStations))
	print("  Best Guess:        " + str(guess))
	print("  Last " + str(round(last*100)) + "% Stations: " + str(endStations))
