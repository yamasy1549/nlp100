import sys
import pandas as pd

filename = "hightemp.txt"
df = pd.read_csv(filename, header=None, delimiter='\t',
        names=('pref', 'city', 'temp', 'date'))
df = df.sort_values(by='temp', ascending=False)
df.to_csv(sys.stdout, index=False, header=False, sep='\t')
