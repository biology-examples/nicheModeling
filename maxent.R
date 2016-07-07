## running maxent in R
# use ?maxent to check documentation for correct installation of maxent.jar

# load libraries
library(dismo)
library(fields)
library(maps)
library(rgdal)
library(raster)
library(maptools)
library(dplyr)
library(rJava)

# import occurrence data and convert to format required by maxent
both <- read.csv(file="taxaData/bothTaxa.csv")
diploid <- both %>%
  filter(cytotype=="2X")
diploid <- diploid[,c(3,2)]
tetraploid <- both %>%
  filter(cytotype=="4X")
tetraploid <- tetraploid[,c(3,2)]

# create stack of non-correlated layers (as determined by layerPrep.R)
predictors <- stack(alt, bio2, bio3, bio5, bio6, bio8, bio9, bio12, bio13, bio14, bio19) 
plot(predictors)

# run maxent for diploid (default parameters)
maxDip <- maxent(predictors, diploid)
maxDip # views results in browser window
response(maxDip) # show response curves for each layer
rDip <- predict(maxDip, predictors) # create model
plot(rDip)
points(diploid)

# run maxent for tetraploid (default parameters)
maxTetra <- maxent(predictors, tetraploid) # run with default parameters
maxTetra # views results in browser window
response(maxTetra) # show response curves for each layer
rTetra <- predict(maxTetra, predictors) # create model 
plot(rTetra)
points(tetraploid)

# more complicated maxent modeling
maxAdvanced1 <- maxent(predictors, tetraploid, args=c("randomseed=true", "replicatetype=crossvalidate", "replicates=640", "-J")) # takes much longer!
