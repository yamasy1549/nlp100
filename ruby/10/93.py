import sys

all_count = 0
accuracy_count = 0

arg = sys.argv[1]
filename = '../../output/92_' + arg + '.txt'

with open(filename) as f:
    for line in f:
        split_line = line.strip().split()
        word4, most_similar_word = split_line[3], split_line[4]
        if most_similar_word == -1: continue

        all_count += 1
        if word4 == most_similar_word:
            accuracy_count += 1

accuracy = accuracy_count / all_count
print(accuracy)
