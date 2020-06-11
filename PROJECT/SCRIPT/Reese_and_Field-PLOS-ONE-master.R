###############################################################################################
## A FREE AND OPEN-SOURCE FUTURE-PROOF PROTOCOL FOR EFFECTIVE UAV-BASED ARCHAEOLOGICAL RESEARCH
## KELSEY M. REESE AND SEAN FIELD
## PLOS ONE
## YEAR VOL(NUM): PGS-PGS
###############################################################################################

## MASTER ##

## Working directory
# setwd('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/')

## Create file structure
dir.create('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/figures',recursive=T)
dir.create('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results',recursive=T)
dir.create('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products',recursive=T)

## Functions for analysis
source('/Users/kmreese/Documents/PROJECTS/SOURCE/FUNCTIONS/polygonUTM_NAD83.R')
source('/Users/kmreese/Documents/PROJECTS/SOURCE/FUNCTIONS/fillDTM.R')
source('/Users/kmreese/Documents/PROJECTS/SOURCE/FUNCTIONS/visibility.R')

## Install and/or load packages
packages <-c('sp','grDevices','RColorBrewer','raster','scales','gstat','fields','spatialEco','rgeos','rasterVis','TeachingDemos')
for(p in packages) if(p %in% rownames(installed.packages()) == F) { install.packages(p) }
for(p in packages) suppressPackageStartupMessages(library(p,quietly=T,character.only=T))

## Set project universals
master.projection <- sp::CRS('+proj=utm +datum=NAD83 +zone=12')
nad27.projection <- sp::CRS('+proj=utm +datum=NAD27 +zone=12')
longlat.projection <- sp::CRS('+proj=longlat +datum=WGS84 +ellps=WGS84')
colors <- grDevices::colorRampPalette(c('black','white'))(10000)
heatcolors <- rev(grDevices::colorRampPalette(c(as.character(RColorBrewer::brewer.pal(11,'Spectral'))))(10000))

## Load all environment variables, run analyses, and produce figures from results
source('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/script/Reese_and_Field-PLOS-ONE-environment.R')
# source('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/script/Reese_and_Field-PLOS-ONE-analysis-dtm.R')
source('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/script/Reese_and_Field-PLOS-ONE-analysis-example.R')
# source('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/script/Reese_and_Field-PLOS-ONE-figures.R')
