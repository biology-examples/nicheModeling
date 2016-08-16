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

# create directory for saving models later
dir.create("models")

## import occurrence data and convert to format required by maxent
both <- read.csv(file="taxaData/bothTaxa.csv")
diploid <- both %>%
  filter(cytotype=="2X")
diploid <- diploid[,c(3,2)]
tetraploid <- both %>%
  filter(cytotype=="4X")
tetraploid <- tetraploid[,c(3,2)]

## create stack of non-correlated layers (as determined by layerPrep.R)
predictors <- stack(alt, bio2, bio3, bio5, bio6, bio8, bio9, bio12, bio13, bio14, bio19) 
# plot each layer individually
plot(predictors)

## basic bioclim modeling 
# extract layer data for each point
dipPts <- extract(predictors, diploid)
# create bioclim model
dipBC <- bioclim(dipPts)
# predict bioclim model
dipBCpredict <- predict(predictors, dipBC)
# plot bioclim model
plot(dipBCpredict)

## Default maxent modeling
# run maxent for diploid (default parameters for dismo)
maxDip <- maxent(predictors, diploid)
maxDip # views results in browser window
response(maxDip) # show response curves for each layer
rDip <- predict(maxDip, predictors) # create model
plot(rDip) # plot predictive model
points(diploid) # add points to predictive model
writeRaster(rDip, "models/diploid.grd")

# run maxent for tetraploid (default parameters for dismo)
maxTetra <- maxent(predictors, tetraploid) 
maxTetra 
response(maxTetra) 
rTetra <- predict(maxTetra, predictors) 
plot(rTetra)
points(tetraploid)
writeRaster(rTetra, "models/tetraploid.grd")

## Advanced modeling
# maxent with jackknife, random seed, and response curves, followed by cross-validation
maxDipAdv <- maxent(
  x=predictors,
  p=diploid,
  removeDuplicates=TRUE,
  nbg=10000,
  args=c(
    'randomseed=true', #default=false
    'threads=2', #default=1
    'responsecurves=true', #default=false
    'jackknife=true' #default=false
  )
)
# perform cross-validation of maxent model
