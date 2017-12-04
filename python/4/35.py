from functions4 import *

long_nouns = []

for sentence in morphological():
    nouns = []

    for word in sentence:
        if word["pos"] == "名詞":
            nouns.append(word["surface"])
        else:
            if len(nouns) > 1:
                long_nouns.append(nouns)
            nouns = []

for nouns in long_nouns:
    print("".join(nouns))
