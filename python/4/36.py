from functions4 import *

freqs = word_freq(morphological())

for word, count in sorted(freqs.items(), key=lambda x:x[1], reverse=True):
    print(word, count)
