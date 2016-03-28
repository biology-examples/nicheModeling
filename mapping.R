## making maps

## load libraries
library(fields)

## load data
sp1 <- read.table(file="speciesData/species1.csv",  header=TRUE,  sep=",")
sp2 <- read.table(file="speciesData/species2.csv",  header=TRUE,  sep=",")

## quick and dirty plot on map (could also plot points first and add map)
US(xlim=c(-85,-77), ylim=c(26,37))
points(diploid$lon, diploid$lat, col='orange', pch=20)
points(tetraploid$lon, tetraploid$lat, col='red', pch=20)
