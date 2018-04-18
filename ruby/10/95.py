import sys

human = {}
model = {}
human_lanking = []
model_lanking = []

arg = sys.argv[1]
filename = '../../output/94_' + arg + '.txt'

with open(filename) as f:
    for line in f:
        word1, word2, human_value, model_value = line.strip().split("\t")
        human[word1, word2] = float(human_value)
        model[word1, word2] = float(model_value)

for key, _ in sorted(human.items(), key=lambda x:-x[1]):
    human_lanking.append(key)
for key, _ in sorted(model.items(), key=lambda x:-x[1]):
    model_lanking.append(key)

n = len(human)
d = 0
for key, value in human.items():
    d += pow(model_lanking.index(key) - human_lanking.index(key), 2)

rho = 1 - (6 * d) / (pow(n, 3) - n)
print(rho)
