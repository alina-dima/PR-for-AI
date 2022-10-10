import pandas as pd
import os

df = pd.read_csv(os.path.join("..","Data-PR-As2","Genes","data.csv"))
print(df.describe())