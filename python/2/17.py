import pandas as pd

filename = "../../data/hightemp.txt"
df = pd.read_csv(filename, header=None, delimiter='\t')
prefs = df.iloc[:,0]

for pref in sorted(set(prefs)):
    print(pref)
