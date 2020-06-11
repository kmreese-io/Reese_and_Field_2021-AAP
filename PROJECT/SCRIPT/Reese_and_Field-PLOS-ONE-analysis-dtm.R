###############################################################################################
## A FREE AND OPEN-SOURCE FUTURE-PROOF PROTOCOL FOR EFFECTIVE UAV-BASED ARCHAEOLOGICAL RESEARCH
## KELSEY M. REESE AND SEAN FIELD
## PLOS ONE
## YEAR VOL(NUM): PGS-PGS
###############################################################################################

## DTM ANALYSIS ##

###############################################################################################
## LOAD OBJECTS FOR UAV LANDCOVER ANALYSIS
###############################################################################################

## Landcover information
landcover.longlat <- raster::raster('/Users/kmreese/Documents/PROJECTS/DATABASE/SPATIAL/DEM/landcover_3-3/n36w108/NLCD2011_LC_N36W108.tif')
landcover.utm <- raster::projectRaster(landcover.longlat,crs=master.projection)
landcover <- raster::crop(landcover.utm,raster::extent(escarpment.boundary))

## UAV information
# 3 hectares = 0.03 km2 => 30000 m2 flight area
flight.area <- c(sqrt(30000),sqrt(30000)) # area that was used for collecting data shown in Reese and Field 2020

## Defining UAV flight polygons to use in DroneDeploy
grid.points <- sp::makegrid(escarpment.boundary,cellsize=flight.area)
spatial.grid <- sp::SpatialPoints(grid.points,proj4string=master.projection)
spatial.grid.survey <- sp::SpatialPixels(spatial.grid[escarpment.boundary,])
survey.polygons <- methods::as(spatial.grid.survey,'SpatialPolygons')

IDs <- base::sapply(slot(survey.polygons,'polygons'), function(x) slot(x,'ID'))
df <- base::data.frame(rep(0,length(IDs)),row.names=IDs)
uav.survey.polygons <- sp::SpatialPolygonsDataFrame(survey.polygons,df)

## Landcover within BLM-owned land
# Values: 31 (Barren Land); 52 (Shrub/Scrub); 71 (Grassland/Herbaceous); 81 (Pasture/Hay)

limiting.landcover <- landcover
limiting.landcover[limiting.landcover == 31] <- 4
limiting.landcover[limiting.landcover == 52] <- 3
limiting.landcover[limiting.landcover == 71] <- 2
limiting.landcover[limiting.landcover == 81] <- 1
limiting.landcover[limiting.landcover > 4] <- 0

## Calculate greatest landcover values per survey square
survey.square.values <- raster::extract(limiting.landcover,uav.survey.polygons)
survey.square.sum <- base::lapply(1:length(survey.square.values),FUN=function(x,...) {sum(survey.square.values[[x]])} )

## Add to SpatialPolygonDataFrame
uav.survey.polygons$landcover.value <- base::unlist(survey.square.sum)

## Survey quadrants
quartiles <- base::seq(min(uav.survey.polygons$landcover.value),max(uav.survey.polygons$landcover.value),(max(uav.survey.polygons$landcover.value)-min(uav.survey.polygons$landcover.value))/3)
quartile.1 <- uav.survey.polygons[which(uav.survey.polygons$landcover.value == quartiles[4] ),]
quartile.2 <- uav.survey.polygons[which(uav.survey.polygons$landcover.value == quartiles[3] ),]
quartile.3 <- uav.survey.polygons[which(uav.survey.polygons$landcover.value == quartiles[2] ),]
quartile.4 <- uav.survey.polygons[which(uav.survey.polygons$landcover.value == quartiles[1] ),]
