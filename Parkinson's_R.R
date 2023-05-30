##Getting required libraries
library(GO.db)
library(GOstats)
library(topGO)
#File Read
df = read.csv("GSE8397-GSE125234.csv", header=TRUE)
df = df[,-1]
df
library(org.Hs.eg.db) 
library(AnnotationDbi)
#Mapping
df$ENTREZID = mapIds(org.Hs.eg.db,
                     key = df$Gene.symbol,
                     column = "ENTREZID",
                     keytype = "SYMBOL",
                     multiVals = "first")
head(df) 
#UP and DOWN genes selecting
sig_lfc = 3
selectGenesUp = unique(df[df$logFC>sig_lfc,"ENTREZID"])
selectGenesDown = unique(df[df$logFC<(-sig_lfc),"ENTREZID"])

univereseGenes = unique(df$ENTREZID) 
cutoff = 0.01 




#Gene Ontology (BIOLOGICAL PROCESS)
upParams = new("GOHyperGParams",
               geneIds= selectGenesUp,
              universeGeneIds = univereseGenes,
               annotation="org.Hs.eg.db",
               ontology="BP",
               pvalueCutoff=0.05,
               conditional=FALSE,
               testDirection="over")

downParams = new("GOHyperGParams",
               geneIds = selectGenesDown,
               universeGeneIds = univereseGenes,
               annotation="org.Hs.eg.db",
               ontology="BP",
               pvalueCutoff=0.05,
               conditional=FALSE,
               testDirection="over")

##Ontology=“MF” GO Molecular Function
upBP = hyperGTest(upParams)
summary(upBP)[1:10,]

downBP = hyperGTest(downParams)
summary(downBP)[1:10,]
#KEGG pathway analysis and visualization
library(pathview)
library(gage)
library(gagedata)
foldchanges =  df$logFC
names(foldchanges) = df$ENTREZID
head(foldchanges)
data("go.sets.hs")
data("go.subs.hs")

gobpsets = go.subs.hs[go.subs.hs$BP]
gobpsets = gage(exprs = foldchanges, gsets = gobpsets, same.dir=TRUE)
view(gobpsets)

data("kegg.sets.hs")
data("sigmet.idx.hs")
kegg.sets.hs = kegg.sets.hs[sigmet.idx.hs]

keggres = gage(exprs = foldchanges, gsets = kegg.sets.hs, same.dir =TRUE)
View(keggres$greater)

keggrespathways = data.frame(id = rownames(keggres$greater), keggres$greater) %>%
  tibble::as_tibble() %>%
  filter(row_number() <= 20) %>%
  .$id %>%
  as.character()
keggrespathways
keggresids =  substr(keggrespathways, start=1, stop= 8)


tmp = sapply(keggresids, function(pid) pathview(gene.data = foldchanges, pathway.id = pid, species = "hsa"))

install.packages("epiDisplay")
library(clusterProfiler)
up.kegg <- enrichKEGG(gene = selectGenesUp,
                      organism = 'hsa',
                      universe = univereseGenes,
                      pvalueCutoff = 0.05)
down.kegg <- enrichKEGG(gene = selectGenesDown,
                        organism = 'hsa',
                        universe = univereseGenes,
                        pvalueCutoff = 0.05)

dotplot(up.kegg, showCategory=20) + ggtitle("UP_KEGG")
dotplot(down.kegg, showCategory=20) + ggtitle("DOWN_KEGG")

#Gene Enrichment Analysis

library("ggnewscale")
library(enrichplot) 
library("GOSemSim") 
ego1 <- pairwise_termsim(up.kegg, method="JC", semData = NULL,showCategory = 20)
emapplot(ego1)
emapplot_cluster(ego1)
ego2 <- pairwise_termsim(down.kegg, method="JC", semData = NULL,showCategory = 20)
emapplot(ego2)
emapplot_cluster(ego2)







