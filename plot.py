import matplotlib.pyplot as plt
import numpy as np
import sys

freq = {}
path = []

file = open(sys.argv[1], 'r')
for line in file:
	data = [float(d.strip()) for d in line.split(',')]
	path.append(data[1])
	if data[1] != 0:
		freq[data[1]] = freq.get(data[1], 0) + 1

plt.bar(range(len(path)), path)
plt.title(sys.argv[1] + " Plot")
plt.ylabel('Gas Price')
plt.xlabel('Distance (Data Points)')
plt.show()