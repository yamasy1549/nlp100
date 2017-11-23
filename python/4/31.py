from functions4 import *

for sentence in morphological():
    for word in sentence:
        if word["pos"] == "動詞": print(word["surface"])
