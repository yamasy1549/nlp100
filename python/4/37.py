import matplotlib.pyplot as plt
from functions4 import *

freqs = word_freq(morphological())
sorted_freqs = sorted(freqs.items(), key=lambda x:x[1], reverse=True)

x = range(10)
y = [word[1] for word in sorted_freqs[:10]]
labels = [word[0] for word in sorted_freqs[:10]]
plt.bar(x, y, tick_label=labels)
plt.show()
