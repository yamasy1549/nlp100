from functions4 import *

for sentence in morphological():
    for word in sentence:
        print(word["surface"], word["base"], word["pos"], word["pos1"])
    print()
