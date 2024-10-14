
# Parkinson's Disease Gene Expression Analysis 🧠🧬

## Overview 📊
This project analyzes gene expression data related to Parkinson's Disease (PD). The aim is to identify significant genes associated with PD, understand their roles, and explore Gene Ontology (GO) terms to gain insights into biological processes impacted by PD.
![image](https://github.com/user-attachments/assets/c482ecb0-c225-42bf-8e2d-1c4ca5021f35)



## Dataset 📑
- **Source**: The dataset is sourced from the study ["Involvement of endocytosis and alternative splicing in the formation of the pathological process in Parkinson's Disease" published in *Biomed Res Int 2014* (PMID: 24804238)](https://pubmed.ncbi.nlm.nih.gov/24804238/). Dataset Download: [Gene Expression Omnibus (GEO)](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE54536)
- **Experiment Type**: Expression profiling by array.
- **Samples**: 10 samples from untreated patients with stage 1 PD.

## Key Steps 🔍
1. **Data Preprocessing**: The dataset includes a total of 47,231 genes, which were grouped to account for redundancy. 
2. **Statistical Analysis**: Performed the Benjamini-Hochberg test to correct p-values and identify significant genes.
3. **Gene Expression Visualization**: Created MA plots, volcano plots, and box plots to visualize gene expression differences between PD and non-PD samples.
4. **Gene Ontology Enrichment Analysis**: Analyzed enriched GO terms related to biological processes, cellular components, and molecular functions.

## Findings 📈
- **Top Upregulated Genes**: Identified genes that suggest heightened immune responses, involvement in inflammatory processes, and neuronal survival mechanisms.
- **Top Downregulated Genes**: Noted genes that indicate reduced neuronal plasticity and compromised cellular functions critical for neuronal health.
- **GO Terms**: Enriched terms highlight key biological processes impacted by PD, providing insights into potential therapeutic targets.

## Deployment 🌐
The results of this analysis have been deployed on **Vercel**, making it accessible for further exploration and visualization.

## Conclusion ✨
This analysis contributes to understanding the molecular underpinnings of Parkinson's Disease, showcasing significant gene alterations and their associated biological functions. The findings could inform future research and therapeutic strategies.


