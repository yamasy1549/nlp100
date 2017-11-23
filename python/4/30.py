from functions4 import *

for sentence in morphological():
    print()
    for word in sentence:
        print(word["surface"], word["base"], word["pos"], word["pos1"])
