## evaluating niche overlap between taxa

library(ecospat)
library(enmtools)
library(raster)
library(dismo)

# read in models (raster)
rDip <- raster("models/diploid.grd")
rTetra <- raster("models/tetraploid.grd")

## multi-variate climate space comparisons (non-model based overlap assessment)
# one-way ANOVA with Tukey's post-hoc

# PCA with varimax rotation and Kaiser criterion (eigenvalues greater than or equal to 1) when choosing factors to include in PCA

## assessing niche overlap
nicheOverlap(rDip, rTetra, stat='D', mask=TRUE, checkNegatives=TRUE) # D statistic
nicheOverlap(rDip, rTetra, stat='I', mask=TRUE, checkNegatives=TRUE) # I statistic
nicheEquivalency()