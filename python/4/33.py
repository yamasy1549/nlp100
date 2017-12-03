from functions4 import *

for sentence in morphological():
    for word in sentence:
        if word["pos"] == "名詞" and word["pos1"] == "サ変接続":
            print(word["surface"])
