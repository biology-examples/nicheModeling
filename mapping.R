## making maps

## load libraries
library(fields)
library(dplyr)

## load data with taxa in different files
diploid <- read.csv(file="taxaData/taxa1.csv")
tetraploid <- read.csv(file="taxaData/taxa2.csv")

## load data with taxa in same files (does same thing as above, in different way)
both <- read.csv(file="taxaData/bothTaxa.csv")
diploid <- both %>%
  filter(cytotype=="2X")
tetraploid <- both %>%
  filter(cytotype=="4X")

## quick and dirty plot on map (could also plot points first and add map)
US(xlim=c(-85,-77), ylim=c(26,37))
points(diploid$lon, diploid$lat, col='orange', pch=20)
points(tetraploid$lon, tetraploid$lat, col='red', pch=20)
