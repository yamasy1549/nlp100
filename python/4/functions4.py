import re
from collections import defaultdict

# mecab neko.txt -o neko.txt.mecab

def morphological(filename="../../data/neko.txt.mecab"):
    sentence_list = []
    sentence = []

    with open(filename) as lines:
        for line in lines:
            if line == "EOS\n":
                if len(sentence) > 0:
                    sentence_list.append(sentence)
                    sentence = []
            else:
                elements = re.split("[,\t]", line)
                word = {
                    "surface": elements[0],
                    "base": elements[7],
                    "pos": elements[1],
                    "pos1": elements[2]
                }
                sentence.append(word)
    return sentence_list

def ngram(s, n):
    return [s[i:i+n] for i in range(len(s)) if len(s) >= i+n]

def word_freq(sentences):
    freqs = defaultdict(int)

    for sentence in sentences:
        for word in sentence:
            surface = word["surface"]
            freqs[surface] += 1
    return freqs
