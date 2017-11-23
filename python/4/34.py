from functions4 import *

for sentence in morphological():
    for gram in ngram(sentence, 3):
        first, second, third = gram
        if second["surface"] == "の" and first["pos"] == third["pos"] == "名詞":
            print(first["surface"] + second["surface"] + third["surface"])
