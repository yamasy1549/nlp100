import matplotlib.pyplot as plt
from functions4 import *

freqs = word_freq(morphological())
sorted_freqs = sorted(freqs.items(), key=lambda x:(-x[1], x[0]))

x = [word[1] for word in sorted_freqs]
plt.xscale('log')
plt.yscale('log')
plt.plot(x)
plt.show()
