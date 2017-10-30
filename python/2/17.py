import pandas as pd

filename = "hightemp.txt"
df = pd.read_csv(filename, header=None, delimiter='\t')
prefs = df.iloc[:,0]
print(sorted(set(prefs)))
