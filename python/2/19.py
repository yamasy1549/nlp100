from collections import defaultdict
import pandas as pd

filename = "hightemp.txt"
df = pd.read_csv(filename, header=None, delimiter='\t', names=('pref', 'city', 'temp', 'date'))
prefs = defaultdict(int)

for pref in df['pref']:
    prefs[pref] += 1

print(sorted(prefs.items(), key=lambda x:-x[1]))
