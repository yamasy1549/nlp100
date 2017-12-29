import sys
import pandas as pd

filename = "../../data/hightemp.txt"
df = pd.read_csv(filename, header=None, delimiter='\t',
        names=('pref', 'city', 'temp', 'date'))
df = df.sort_values(by=['temp', 'city'], ascending=False)
df.to_csv(sys.stdout, index=False, header=False, sep='\t')
