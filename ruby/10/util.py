import sys
import numpy as np
from scipy import io

model = {}
arg = sys.argv[1]

if arg == '85':
    j = 0
    vectors = io.loadmat('../9/85')['x_svd']
    with open('../../output/83-t.txt') as f:
        for line in f:
            word = line.strip().split()[1]
            model[word] = np.array([float(i) for i in vectors[j]])
            j += 1
elif arg == '90':
    with open('../../output/90.txt') as f:
        for line in f:
            split_line = line.strip().split()
            word, vector = "".join(split_line[:-300]), split_line[-300:]
            model[word] = np.array([float(i) for i in vector])

def vec(word):
    return model[word]

def cossim(vec_1, vec_2):
    numerator = np.dot(vec_1, vec_2)
    denominator = np.linalg.norm(vec_1) * np.linalg.norm(vec_2)
    if denominator == 0:
        return -1
    else:
        return numerator / denominator

def most_similar(base_vec, base_words, count):
    word_sims = {}

    for word, vector in model.items():
        if word in base_words: continue
        word_vec = vec(word)
        word_sims[word] = cossim(base_vec, word_vec)

    return sorted(word_sims.items(), key=lambda x:-x[1])[:count]
