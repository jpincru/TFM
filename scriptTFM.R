
## Cargar librerías para que funcionen los gráficos

library("ggplot2")
library("ggbeeswarm")
library("ggsignif")


##Figura 4. Distribución de cepas 

distrcepas <- ggplot(data, aes(x=data$Genes_Antibiotic_Resistance)) + geom_histogram(binwidth=1,color="black",
fill="Orange") +labs(x="Nº de Genes de Resistencia",y="Nº de Cepas") + theme(text = element_text(size=14))
distrcepas

##Graficos de comparación de grupos 
##Figura 5.  Gráfico de diferencia en genes de resistencia entre grupos 1 y 2 de cepas 

groups_1_2_difference <- ggplot(data, aes(x=data$Group,
y=data$Genes_Antibiotic_Resistance)) + geom_violin(fill=rainbow(1024),alpha = .3,outlier.shape = 20, outlier.colour = "red",
outlier.size = 4) + geom_boxplot(fill = rainbow(2), alpha = .3,
outlier.shape = 20, outlier.colour = "red", outlier.size = 4,width=0.5) + theme_bw() +labs(x="Grupos",
y="Nº de Genes de Resistencia") +theme(text = element_text(size=20))+ geom_signif(comparisons = list(c("group1","group2")),
map_signif_level=TRUE, margin_top = 0.02)



## Figura 6. scatterplot grupos

qp<- qplot(data$CRISPR_arrays, data$Genes_Antibiotic_Resistance, data = data, color = data$Group) + geom_quasirandom() +labs(x="Nº de Arrays", y="Genes de resistencia", color="Grupos") 

qp + theme(text = element_text(size=20))

# Figura 7. boxplot de subgrupos cas

violin + geom_boxplot(fill = rainbow(6), alpha = .3, outlier.shape = 20,
outlier.colour = "red", outlier.size = 4,
width=0.2)+theme(axis.text.x = element_text(angle = 15, hjust = 1, colour= "black",
face="bold")) + theme(text = element_text(size=14)) + geom_signif(comparisons = list(c("G1 con Cas9 y otros","G1 sin Cas")),
map_signif_level=TRUE, margin_top = 0.01) + geom_signif(comparisons = list(c("Cas9 only","G1 con Cas9 y otros")),
map_signif_level=TRUE, margin_top = 0.01) + geom_signif(comparisons = list(c("G1 Cas sin Cas9","G1 con Cas9 y otros")),
map_signif_level=TRUE, margin_top = 0.08) + geom_signif(comparisons = list(c("Grupo 2","G1 con Cas9 y otros")),
map_signif_level=TRUE, margin_top = 0.18) + geom_signif(comparisons = list(c("Grupo 2","G1 Cas sin Cas9")),
map_signif_level=TRUE, margin_top = 0.24) + geom_signif(comparisons = list(c("Grupo 2","G1 sin Cas")),
map_signif_level=TRUE, margin_top = 0.12) + geom_signif(comparisons = list(c("Grupo 2","Cas9 only")),
map_signif_level=TRUE, margin_top = 0.30) + geom_signif(comparisons = list(c("Grupo 2","Unknown only")),
map_signif_level=TRUE, margin_top = 0.18) 

#Figura 8. lugar de aislamiento

#Para comprobar homocedasticidad se hace bartlett.test sobre cada par de grupos a comparar

#Ejemplo:
#a <- data$Genes_Antibiotic_Resistance[data$Isol.Source.4=="Blood"]
#b <- data$Genes_Antibiotic_Resistance[data$Isol.Source.4=="Perianal"]
#bartlett.test(list(a,b))

#si presentan varianzas iguales (p-value >0.05) se puede aplicar geom_signif, la cual utiliza wilcox.test como test estadístico
# *** = 0.001 ** = 0.01 *=0.05

isolationplot + theme(axis.text.x = element_text(angle = 15, hjust = 1, colour= "black", face="bold")) + geom_signif(comparisons = list(c("Blood","Respiratory airways")),
map_signif_level=TRUE, margin_top = 0.01) + geom_signif(comparisons = list(c("Perianal","Respiratory airways")),
map_signif_level=TRUE, margin_top = 0.15) + geom_signif(comparisons = list(c("Perianal","Skin and soft tissues")),
map_signif_level=TRUE, margin_top = 0.07) + geom_signif(comparisons = list(c("Inert surfaces","Respiratory airways")),
map_signif_level=TRUE, margin_top = 0.25) + geom_signif(comparisons = list(c("Inert surfaces","Urinary tract")),
map_signif_level=TRUE, margin_top = 0.35) + geom_signif(comparisons = list(c("Perianal","Urinary tract")),
map_signif_level=TRUE, margin_top = 0.20) + geom_signif(comparisons = list(c("Blood","Perianal")),
map_signif_level=TRUE, margin_top = 0.07) + theme(text = element_text(size=14))