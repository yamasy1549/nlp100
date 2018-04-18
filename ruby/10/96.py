from util import *
import pickle

# nation
nations = {}

with open('../../data/nations.txt') as f:
    for line in f:
        nation = line.strip().replace(" ", "_")
        try:
            nations[nation] = vec(nation)
        except:
            next

with open('96.pickle', 'wb') as f:
    pickle.dump(nations, f)

t = []

with open('../../output/83-t.txt') as f:
    for line in f:
        t.append(line.split()[1])

# nationがx_svdの何番目にあるかのindex
t_index = []

for nation in nations.keys():
    t_index.append(t.index(nation))

with open('96-t_index.pickle', 'wb') as f:
    pickle.dump(t_index, f)
