###############################################################################################
## A FREE AND OPEN-SOURCE FUTURE-PROOF PROTOCOL FOR EFFECTIVE UAV-BASED ARCHAEOLOGICAL RESEARCH
## KELSEY M. REESE AND SEAN FIELD
## PLOS ONE
## YEAR VOL(NUM): PGS-PGS
###############################################################################################

## EXAMPLE ANALYSIS ##

###############################################################################################
## ROOM ESTIMATES FROM ROOMBLOCK AREA
###############################################################################################

n.rooms.by.area <- base::floor((rgeos::gArea(roomblock.rubble) - rgeos::gArea(tower.rubble)) / avg.area.room.m2)
people.by.area <- base::floor((rgeos::gArea(roomblock.rubble) - rgeos::gArea(tower.rubble)) / avg.area.per.person)

###############################################################################################
## ROOM AND TOWER ESTIMATES FROM INTERPOLATED RASTER AND MASONRY VOLUME
###############################################################################################

# ## Interpolate DTM surface without architecture from sample site
# dtm.incomplete <- raster::mask(dtm,site.extent,inverse=T)
# dtm.interpolated <- fillDTM(dtm.incomplete)
# raster::writeRaster(dtm.interpolated,'/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-1')
# dtm.interpolated <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-1')
# 
# dtm.difference <- dtm - dtm.interpolated
# dtm.difference.na <- dtm.difference
# dtm.difference.na[dtm.difference.na < 0 ] <- NA
# dtm.incomplete <- raster::mask(dtm.interpolated,dtm.difference.na)
# # dtm.interpolated <- fillDTM(dtm.incomplete)
# gappedDEM.df <- data.frame(cbind(xyFromCell(dtm.incomplete,1:ncell(dtm.incomplete)),values(dtm.incomplete)))
# names(gappedDEM.df) <- c("x", "y", "ELEVATION")
# gappedDEM.df.known <- gappedDEM.df[!is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.df.unknown <- gappedDEM.df[is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.idw.model <- gstat(id = "ELEVATION", formula = ELEVATION ~ 1, locations = ~ x + y, data = gappedDEM.df.known, nmax = 7, set = list(idp = 0.5))
# gappedDEM.df.new <- predict(gappedDEM.idw.model, newdata = gappedDEM.df.unknown)
# gappedDEM.df.new$CELL <- cellFromXY(dtm.incomplete, as.matrix(gappedDEM.df.new[, 1:2]))
# gappedDEM.final <- dtm.incomplete
# gappedDEM.final[gappedDEM.df.new$CELL] <- gappedDEM.df.new$ELEVATION.pred
# dtm.interpolated <- gappedDEM.final
# raster::writeRaster(dtm.interpolated,'/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-2',overwrite=T)
# 
# dtm.interpolated <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-2')
# dtm.difference <- dtm - dtm.interpolated
# dtm.difference.na <- dtm.difference
# dtm.difference.na[dtm.difference.na < 0 ] <- NA
# dtm.incomplete <- raster::mask(dtm.interpolated,dtm.difference.na)
# # dtm.interpolated <- fillDTM(dtm.incomplete)
# gappedDEM.df <- data.frame(cbind(xyFromCell(dtm.incomplete,1:ncell(dtm.incomplete)),values(dtm.incomplete)))
# names(gappedDEM.df) <- c("x", "y", "ELEVATION")
# gappedDEM.df.known <- gappedDEM.df[!is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.df.unknown <- gappedDEM.df[is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.idw.model <- gstat(id = "ELEVATION", formula = ELEVATION ~ 1, locations = ~ x + y, data = gappedDEM.df.known, nmax = 7, set = list(idp = 0.5))
# gappedDEM.df.new <- predict(gappedDEM.idw.model, newdata = gappedDEM.df.unknown)
# gappedDEM.df.new$CELL <- cellFromXY(dtm.incomplete, as.matrix(gappedDEM.df.new[, 1:2]))
# gappedDEM.final <- dtm.incomplete
# gappedDEM.final[gappedDEM.df.new$CELL] <- gappedDEM.df.new$ELEVATION.pred
# dtm.interpolated <- gappedDEM.final
# raster::writeRaster(dtm.interpolated,'/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-3',overwrite=T)
# 
# dtm.interpolated <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-3')
# dtm.difference <- dtm - dtm.interpolated
# dtm.difference.na <- dtm.difference
# dtm.difference.na[dtm.difference.na < 0 ] <- NA
# dtm.incomplete <- raster::mask(dtm.interpolated,dtm.difference.na)
# # dtm.interpolated <- fillDTM(dtm.incomplete)
# gappedDEM.df <- data.frame(cbind(xyFromCell(dtm.incomplete,1:ncell(dtm.incomplete)),values(dtm.incomplete)))
# names(gappedDEM.df) <- c("x", "y", "ELEVATION")
# gappedDEM.df.known <- gappedDEM.df[!is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.df.unknown <- gappedDEM.df[is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.idw.model <- gstat(id = "ELEVATION", formula = ELEVATION ~ 1, locations = ~ x + y, data = gappedDEM.df.known, nmax = 7, set = list(idp = 0.5))
# gappedDEM.df.new <- predict(gappedDEM.idw.model, newdata = gappedDEM.df.unknown)
# gappedDEM.df.new$CELL <- cellFromXY(dtm.incomplete, as.matrix(gappedDEM.df.new[, 1:2]))
# gappedDEM.final <- dtm.incomplete
# gappedDEM.final[gappedDEM.df.new$CELL] <- gappedDEM.df.new$ELEVATION.pred
# dtm.interpolated <- gappedDEM.final
# raster::writeRaster(dtm.interpolated,'/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-4',overwrite=T)
# 
# dtm.interpolated <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-4')
# dtm.difference <- dtm - dtm.interpolated
# dtm.difference.na <- dtm.difference
# dtm.difference.na[dtm.difference.na < 0 ] <- NA
# dtm.incomplete <- raster::mask(dtm.interpolated,dtm.difference.na)
# # dtm.interpolated <- fillDTM(dtm.incomplete)
# gappedDEM.df <- data.frame(cbind(xyFromCell(dtm.incomplete,1:ncell(dtm.incomplete)),values(dtm.incomplete)))
# names(gappedDEM.df) <- c("x", "y", "ELEVATION")
# gappedDEM.df.known <- gappedDEM.df[!is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.df.unknown <- gappedDEM.df[is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.idw.model <- gstat(id = "ELEVATION", formula = ELEVATION ~ 1, locations = ~ x + y, data = gappedDEM.df.known, nmax = 7, set = list(idp = 0.5))
# gappedDEM.df.new <- predict(gappedDEM.idw.model, newdata = gappedDEM.df.unknown)
# gappedDEM.df.new$CELL <- cellFromXY(dtm.incomplete, as.matrix(gappedDEM.df.new[, 1:2]))
# gappedDEM.final <- dtm.incomplete
# gappedDEM.final[gappedDEM.df.new$CELL] <- gappedDEM.df.new$ELEVATION.pred
# dtm.interpolated <- gappedDEM.final
# raster::writeRaster(dtm.interpolated,'/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-5',overwrite=T)
# 
# dtm.interpolated <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-5')
# dtm.difference <- dtm - dtm.interpolated
# dtm.difference.na <- dtm.difference
# dtm.difference.na[dtm.difference.na < 0 ] <- NA
# dtm.incomplete <- raster::mask(dtm.interpolated,dtm.difference.na)
# # dtm.interpolated <- fillDTM(dtm.incomplete)
# gappedDEM.df <- data.frame(cbind(xyFromCell(dtm.incomplete,1:ncell(dtm.incomplete)),values(dtm.incomplete)))
# names(gappedDEM.df) <- c("x", "y", "ELEVATION")
# gappedDEM.df.known <- gappedDEM.df[!is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.df.unknown <- gappedDEM.df[is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.idw.model <- gstat(id = "ELEVATION", formula = ELEVATION ~ 1, locations = ~ x + y, data = gappedDEM.df.known, nmax = 7, set = list(idp = 0.5))
# gappedDEM.df.new <- predict(gappedDEM.idw.model, newdata = gappedDEM.df.unknown)
# gappedDEM.df.new$CELL <- cellFromXY(dtm.incomplete, as.matrix(gappedDEM.df.new[, 1:2]))
# gappedDEM.final <- dtm.incomplete
# gappedDEM.final[gappedDEM.df.new$CELL] <- gappedDEM.df.new$ELEVATION.pred
# dtm.interpolated <- gappedDEM.final
# raster::writeRaster(dtm.interpolated,'/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-6',overwrite=T)
# 
# dtm.interpolated <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-6')
# dtm.difference <- dtm - dtm.interpolated
# dtm.difference.na <- dtm.difference
# dtm.difference.na[dtm.difference.na < 0 ] <- NA
# dtm.incomplete <- raster::mask(dtm.interpolated,dtm.difference.na)
# # dtm.interpolated <- fillDTM(dtm.incomplete)
# gappedDEM.df <- data.frame(cbind(xyFromCell(dtm.incomplete,1:ncell(dtm.incomplete)),values(dtm.incomplete)))
# names(gappedDEM.df) <- c("x", "y", "ELEVATION")
# gappedDEM.df.known <- gappedDEM.df[!is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.df.unknown <- gappedDEM.df[is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.idw.model <- gstat(id = "ELEVATION", formula = ELEVATION ~ 1, locations = ~ x + y, data = gappedDEM.df.known, nmax = 7, set = list(idp = 0.5))
# gappedDEM.df.new <- predict(gappedDEM.idw.model, newdata = gappedDEM.df.unknown)
# gappedDEM.df.new$CELL <- cellFromXY(dtm.incomplete, as.matrix(gappedDEM.df.new[, 1:2]))
# gappedDEM.final <- dtm.incomplete
# gappedDEM.final[gappedDEM.df.new$CELL] <- gappedDEM.df.new$ELEVATION.pred
# dtm.interpolated <- gappedDEM.final
# raster::writeRaster(dtm.interpolated,'/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-7',overwrite=T)

# dtm.interpolated <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-7')
# dtm.difference <- dtm - dtm.interpolated
# dtm.difference.na <- dtm.difference
# dtm.difference.na[dtm.difference.na < 0 ] <- NA
# dtm.incomplete <- raster::mask(dtm.interpolated,dtm.difference.na)
# # dtm.interpolated <- fillDTM(dtm.incomplete)
# gappedDEM.df <- data.frame(cbind(xyFromCell(dtm.incomplete,1:ncell(dtm.incomplete)),values(dtm.incomplete)))
# names(gappedDEM.df) <- c("x", "y", "ELEVATION")
# gappedDEM.df.known <- gappedDEM.df[!is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.df.unknown <- gappedDEM.df[is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.idw.model <- gstat(id = "ELEVATION", formula = ELEVATION ~ 1, locations = ~ x + y, data = gappedDEM.df.known, nmax = 7, set = list(idp = 0.5))
# gappedDEM.df.new <- predict(gappedDEM.idw.model, newdata = gappedDEM.df.unknown)
# gappedDEM.df.new$CELL <- cellFromXY(dtm.incomplete, as.matrix(gappedDEM.df.new[, 1:2]))
# gappedDEM.final <- dtm.incomplete
# gappedDEM.final[gappedDEM.df.new$CELL] <- gappedDEM.df.new$ELEVATION.pred
# dtm.interpolated <- gappedDEM.final
# raster::writeRaster(dtm.interpolated,'/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-8',overwrite=T)
# 
# dtm.interpolated <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-8')
# dtm.difference <- dtm - dtm.interpolated
# dtm.difference.na <- dtm.difference
# dtm.difference.na[dtm.difference.na < 0 ] <- NA
# dtm.incomplete <- raster::mask(dtm.interpolated,dtm.difference.na)
# # dtm.interpolated <- fillDTM(dtm.incomplete)
# gappedDEM.df <- data.frame(cbind(xyFromCell(dtm.incomplete,1:ncell(dtm.incomplete)),values(dtm.incomplete)))
# names(gappedDEM.df) <- c("x", "y", "ELEVATION")
# gappedDEM.df.known <- gappedDEM.df[!is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.df.unknown <- gappedDEM.df[is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.idw.model <- gstat(id = "ELEVATION", formula = ELEVATION ~ 1, locations = ~ x + y, data = gappedDEM.df.known, nmax = 7, set = list(idp = 0.5))
# gappedDEM.df.new <- predict(gappedDEM.idw.model, newdata = gappedDEM.df.unknown)
# gappedDEM.df.new$CELL <- cellFromXY(dtm.incomplete, as.matrix(gappedDEM.df.new[, 1:2]))
# gappedDEM.final <- dtm.incomplete
# gappedDEM.final[gappedDEM.df.new$CELL] <- gappedDEM.df.new$ELEVATION.pred
# dtm.interpolated <- gappedDEM.final
# raster::writeRaster(dtm.interpolated,'/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-9',overwrite=T)
# 
# dtm.interpolated <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-iteration-9')
# dtm.difference <- dtm - dtm.interpolated
# dtm.difference.na <- dtm.difference
# dtm.difference.na[dtm.difference.na < 0 ] <- NA
# dtm.incomplete <- raster::mask(dtm.interpolated,dtm.difference.na)
# # dtm.interpolated <- fillDTM(dtm.incomplete)
# gappedDEM.df <- data.frame(cbind(xyFromCell(dtm.incomplete,1:ncell(dtm.incomplete)),values(dtm.incomplete)))
# names(gappedDEM.df) <- c("x", "y", "ELEVATION")
# gappedDEM.df.known <- gappedDEM.df[!is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.df.unknown <- gappedDEM.df[is.na(gappedDEM.df$ELEVATION), ]
# gappedDEM.idw.model <- gstat(id = "ELEVATION", formula = ELEVATION ~ 1, locations = ~ x + y, data = gappedDEM.df.known, nmax = 7, set = list(idp = 0.5))
# gappedDEM.df.new <- predict(gappedDEM.idw.model, newdata = gappedDEM.df.unknown)
# gappedDEM.df.new$CELL <- cellFromXY(dtm.incomplete, as.matrix(gappedDEM.df.new[, 1:2]))
# gappedDEM.final <- dtm.incomplete
# gappedDEM.final[gappedDEM.df.new$CELL] <- gappedDEM.df.new$ELEVATION.pred
# dtm.interpolated <- gappedDEM.final
# raster::writeRaster(dtm.interpolated,'/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-final',overwrite=T)
# 
dtm.interpolated <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-predicted-final')

dtm.incomplete <- dtm.interpolated
dtm.incomplete[extent(site.extent),] <- NA

## Calculate difference between interpolated DTM and actual DTM
dtm.difference <- dtm - dtm.interpolated

## Crop the resulting difference raster to the site extent
dtm.difference.cropped <- raster::crop(dtm.difference,extent(site.extent))

## Use Spatial Polygon of roomblock rubble extent collected in the field to limit volume calculations
dtm.difference.roomblock <- raster::mask(dtm.difference.cropped,roomblock.rubble)

## Use tower Spatial Polygon collected in the field to remove tower rubble from roomblock volume calculation
dtm.difference.no.tower <- raster::mask(dtm.difference.roomblock,tower.rubble,inverse=T)

## Calculate total volume of roomblock rubble and estimated number of average-sized rooms
roomblock.rubble.height <- raster::getValues(dtm.difference.no.tower) 
rubble.volume.m3 <- raster::xres(dtm.difference.cropped) * raster::yres(dtm.difference.cropped) * base::sum(roomblock.rubble.height,na.rm=T)
n.rooms.by.volume <- base::floor(rubble.volume.m3 / ((avg.area.room.m2 + corners.of.rooms.m) * (avg.wall.thickness.m / 2))) 

###############################################################################################
## RECONSTRUCTING THE GREATHOUSE
###############################################################################################

## Defining first- and second-story rubble contours
site.contour <- raster::rasterToContour(dtm.difference.cropped,nlevels=10)
lower.level.lines <- site.contour[which(site.contour$level == 0.5),]
upper.level.lines <- site.contour[which(site.contour$level == 1.0),]

lower.level.polygons <- sp::SpatialPolygons(lapply(1:length(lower.level.lines),function(i) sp::Polygons(lapply(coordinates(lower.level.lines)[[i]], function(y) sp::Polygon(y)), as.character(i))))
upper.level.polygons <- sp::SpatialPolygons(lapply(1:length(upper.level.lines),function(i) sp::Polygons(lapply(coordinates(upper.level.lines)[[i]], function(y) sp::Polygon(y)), as.character(i))))

raster::projection(lower.level.polygons) <- master.projection
raster::projection(upper.level.polygons) <- master.projection

upper.level.no.holes <- spatialEco::remove.holes(upper.level.polygons)
lower.level.no.holes <- spatialEco::remove.holes(lower.level.polygons)

###############################################################################################
## TOWER

## Calculate total extent of tower rubble based on combined in-field map and calculated contours, and estimate original standing height
tower.rubble.estimated.extent <- polygonUTM_NAD83(716311.15,716330,4129335.14,4129343.25,12)
upper.contour.and.estimated.extent <- rgeos::gIntersection(tower.rubble.estimated.extent,upper.level.no.holes)
upper.contour.and.mapped.extent <- rgeos::gUnion(upper.contour.and.estimated.extent,tower.rubble)
tower.mapped.and.contour <- polygonUTM_NAD83(716319,716330,ymin(upper.contour.and.mapped.extent),4129343.25,12)
lower.contour.and.estimated.extent <- rgeos::gIntersection(lower.level.no.holes,tower.mapped.and.contour)
total.tower.rubble <- rgeos::gUnion(lower.contour.and.estimated.extent,upper.contour.and.mapped.extent)

rgdal::writeOGR(as(total.tower.rubble,'SpatialPolygonsDataFrame'),'/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/',layer='5MT01917-tower',driver='ESRI Shapefile',overwrite=T)

dtm.difference.only.tower <- raster::mask(dtm.difference.cropped,total.tower.rubble)
tower.rubble.height <- raster::getValues(dtm.difference.only.tower) 
tower.volume.m3 <- raster::xres(dtm.difference.only.tower) * raster::yres(dtm.difference.only.tower) * base::sum(tower.rubble.height,na.rm=T)
tower.height.m <-  tower.volume.m3 / (pi * ((tower.diameter + (estimated.tower.thickness.m / 2))^2) - ((tower.diameter - (estimated.tower.thickness.m / 2))^2) )

###############################################################################################
## ROOMBLOCK

upper.level.no.tower <- rgeos::gDifference(upper.level.no.holes,total.tower.rubble)
lower.level.no.tower <- rgeos::gDifference(lower.level.no.holes,total.tower.rubble)

area.first.story <- rgeos::gArea(lower.level.no.tower)
area.second.story <- rgeos::gArea(upper.level.no.tower)

avg.area.site.rooms <- (area.first.story + area.second.story) / n.rooms.by.volume
people.by.volume <- base::floor((area.first.story + area.second.story) / avg.area.per.person)

rooms.first.story <- area.first.story / avg.area.room.m2
rooms.second.story <- area.second.story / avg.area.room.m2

rgdal::writeOGR(lower.level.no.holes,'/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/',layer='5MT01917-lower-level',driver='ESRI Shapefile',overwrite=T)
rgdal::writeOGR(upper.level.no.holes,'/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/',layer='5MT01917-upper-level',driver='ESRI Shapefile',overwrite=T)

## UPPER LEVEL
upper.level.rubble <- raster::mask(dtm.difference.cropped,upper.level.polygons)
upper.level.rubble.no.tower <- raster::mask(upper.level.rubble,total.tower.rubble,inverse=T)
upper.level.rubble.no.tower.m <- raster::getValues(upper.level.rubble.no.tower)
upper.level.rubble.no.tower.m[upper.level.rubble.no.tower.m < 0 ] <- NA
upper.level.rubble.no.tower.volume.m3 <- raster::xres(dtm.difference.cropped) * raster::yres(dtm.difference.cropped) * base::sum(upper.level.rubble.no.tower.m,na.rm=T)

upper.level.height.one.wall.m <- upper.level.rubble.no.tower.volume.m3 / ((avg.wall.thickness.m/2) * sqrt(avg.area.room.m2))
upper.level.height.one.room.m <- upper.level.height.one.wall.m / 4
upper.level.section.total.height.m <- upper.level.height.one.room.m / rooms.second.story

## LOWER LEVEL
lower.level.rubble <- raster::mask(dtm.difference.cropped,lower.level.polygons)
lower.level.rubble.no.upper <- raster::mask(lower.level.rubble,upper.level.polygons,inverse=T)
lower.level.rubble.no.upper.no.tower <- raster::mask(lower.level.rubble.no.upper,total.tower.rubble,inverse=T)
lower.level.rubble.no.upper.no.tower.m <- raster::getValues(lower.level.rubble.no.upper.no.tower) 
lower.level.rubble.no.upper.no.tower.m[lower.level.rubble.no.upper.no.tower.m < 0 ] <- NA
lower.level.no.upper.no.tower.volume.m3 <- raster::xres(dtm.difference.cropped) * raster::yres(dtm.difference.cropped) * base::sum(lower.level.rubble.no.upper.no.tower.m,na.rm=T)

lower.level.height.one.wall.m <- lower.level.no.upper.no.tower.volume.m3 / ((avg.wall.thickness.m/2) * sqrt(avg.area.room.m2))
lower.level.height.one.room.m <- lower.level.height.one.wall.m / 4
lower.level.section.total.height.m <- lower.level.height.one.room.m / rooms.first.story
