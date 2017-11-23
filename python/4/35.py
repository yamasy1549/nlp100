from functions4 import *

long_nouns = []

for sentence in morphological():
    nouns = []

    for word in sentence:
        if word["pos"] == "名詞":
            nouns.append(word["surface"])
        else:
            if len(nouns) > len(long_nouns):
                long_nouns = nouns
            nouns = []

print(''.join(long_nouns))
