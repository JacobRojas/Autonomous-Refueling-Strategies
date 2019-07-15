import matplotlib.pyplot as plt
import numpy as np
import sys

freq = {}

file = open(sys.argv[1], 'r')
for line in file:
	data = [float(d.strip()) for d in line.split(',')]
	if data[1] != 0:
		freq[data[1]] = freq.get(data[1], 0) + 1

y_pos = np.arange(len(freq))
keys, values = zip(*sorted(freq.items()))
plt.bar(y_pos, values, align='center', alpha=0.5)
plt.xticks(y_pos, keys)
plt.title(sys.argv[1] + " Histogram")
plt.ylabel('Number of Stations')
plt.xlabel('Gas Price')
plt.show()