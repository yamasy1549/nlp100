from collections import defaultdict
import pandas as pd

filename = "../../data/hightemp.txt"
df = pd.read_csv(filename, header=None, delimiter='\t', names=('pref', 'city', 'temp', 'date'))
prefs = defaultdict(int)

for pref in df['pref']:
    prefs[pref] += 1

for pref, count in sorted(prefs.items(), key=lambda x:(-x[1], x[0])):
    print(pref, count)
