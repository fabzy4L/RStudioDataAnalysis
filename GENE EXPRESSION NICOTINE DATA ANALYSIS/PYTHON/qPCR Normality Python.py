import scipy as sp, pandas as pd, numpy as np, matplotlib as plt
df = pd.read_csv("/Users/f4L/Library/Containers/com.microsoft.Excel/Data/Desktop/RStudioDataAnalysis/GENE EXPRESSION NICOTINE DATA ANALYSIS/qPCR all values - qPCR.csv")
CERKL =  df["CERKL"]
CHRNA10 =df["CHRNA10"]
FA2H =df["FA2H"]
SMYD1 =df["SMYD1"]
CLIC4 =df["CLIC4"]
COL4A1 =df["COL4A1"]
FAM189A1 =df["FAM189A1"]
PTGDR =df["PTGDR"]
SDCCAG8 =df["SDCCAG8"]
TF =df["TF"]


#print(df.columns.values.tolist())

Genes = ['CERKL', 'CHRNA10', 'FA2H', 'SMYD1', 'CLIC4', 'COL4A1', 'FAM189A1', 'PTGDR', 'SDCCAG8', 'TF']
#Returns: statistic: The test statistic & p-value: The p-value for the hypothesis test.

#DX_shapiro = sp.stats.shapiro(DX)

CERKL_shapiro = sp.stats.shapiro(CERKL)
CHRNA10_shapiro = sp.stats.shapiro(CHRNA10)
FA2H_shapiro = sp.stats.shapiro(FA2H)
SMYD1_shapiro = sp.stats.shapiro(SMYD1)
CLIC4_shapiro = sp.stats.shapiro(CLIC4)
COL4A1_shapiro = sp.stats.shapiro(COL4A1)
FAM189A1_shapiro = sp.stats.shapiro(FAM189A1)
PTGDR_shapiro = sp.stats.shapiro(PTGDR)
SDCCAG8_shapiro = sp.stats.shapiro(SDCCAG8)
TF_shapiro = sp.stats.shapiro(TF)

#cols = pd.DataFrame([Genes])
df_t = pd.DataFrame([CERKL_shapiro,CHRNA10_shapiro, FA2H_shapiro,SMYD1_shapiro,CLIC4_shapiro,COL4A1_shapiro,FAM189A1_shapiro,PTGDR_shapiro,SDCCAG8_shapiro,TF_shapiro])
df_t['Genes'] = Genes
print(df_t)
#df_t.to_csv('/Users/f4L/Documents/GitHub/RStudioDataAnalysis/GENE EXPRESSION NICOTINE DATA ANALYSIS/PYTHON/GeneStatistics2.csv')
