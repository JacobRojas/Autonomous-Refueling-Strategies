import sys

totalSumDistance = 0
totalNumRates = 0
totalSumRates = 0

lens = open("lengths.csv", "w")

for i in range(1, len(sys.argv)):
	sumDistance = 0
	numRates = 0
	sumRates = 0
	file = open(sys.argv[i], 'r')
	for line in file:
		data = [float(d.strip()) for d in line.split(',')]
		sumDistance += int(data[0])
		if(data[1] != 0):
			numRates += 1
			sumRates += data[1]
	lens.write(sys.argv[i] + "," + str(sumDistance) + "\n")
	totalSumDistance += sumDistance
	totalNumRates += numRates
	totalSumRates += sumRates
	print(sys.argv[i] + ":")
	print("  # Gas Stations: " + str(numRates))
	print("  Highway Length: " + str(sumDistance))
	print("  Avg. Price: " + str(sumRates / numRates))
	print("  Density: " + str(numRates / sumDistance))
print("Total:")
print("  Avg. # Gas Stations: " + str(totalNumRates / (len(sys.argv) - 1)))
print("  Avg. Highway Length: " + str(totalSumDistance / (len(sys.argv) - 1)))
print("  Avg. Price: " + str(totalSumRates / totalNumRates))
print("  Density: " + str(totalNumRates / totalSumDistance))