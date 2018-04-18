from util import *

with open('../../output2/92_85.txt', 'w') as output_f:
    with open('../../output/91.txt') as f:
        for line in f:
            words = line.strip()
            word1, word2, word3, _ = words.split()
            try:
                base_vec = vec(word2) - vec(word1) + vec(word3)
                for word, sim in most_similar(base_vec, [word1, word2, word3], 1):
                    output_f.write(" ".join([words, word, str(sim)]) + "\n")
            except:
                output_f.write(" ".join([words, '-1']) + "\n")
