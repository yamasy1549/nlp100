import pandas as pd

df1 = pd.read_csv('col1.txt', header=None, delimiter='\t')
df2 = pd.read_csv('col2.txt', header=None, delimiter='\t')
merged_df = pd.concat([df1, df2], axis=1)
merged_df.to_csv('hightemp13.txt', index=False, header=False, sep='\t')
