import pandas as pd

filename = "hightemp.txt"
df = pd.read_csv(filename, header=None, delimiter='\t')
df.iloc[:,0].to_csv('col1.txt', index=False, header=False)
df.iloc[:,1].to_csv('col2.txt', index=False, header=False)
