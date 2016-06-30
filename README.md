# nicheModeling

Scripts for creating maps and performing niche modeling using R.

The general workflow is as follows:
* `mapping.R`: importing taxon occurrence data into R, creating maps, creating custom shapefiles
* `layerPrep.R`: masking/clipping BioClim layers, looking for correlations between layers
* `maxent.R`: creating niche models using occurrence data and climate layers
* `nicheOverlap.R`: assessing whether niche models for different taxa are distinct from each other

There are a number of files and directories that are downloaded or created during this analysis. Users should download the [BioClim layers](http://www.worldclim.org/current) and store them in a convenient place (note the paths for using these layers may need to be changed).
