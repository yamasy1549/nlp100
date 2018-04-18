from util import *

with open('../../data/combined.tab') as f:
    for line in f:
        word1, word2, _ = line.strip().split("\t")
        if word1 == "Word 1": continue
        try:
            sim = cossim(vec(word1), vec(word2))
            print(line.strip() + "\t" + str(sim))
        except:
            print(line.strip() + "\t" + str(-1))
