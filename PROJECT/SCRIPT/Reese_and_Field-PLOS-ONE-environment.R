###############################################################################################
## A FREE AND OPEN-SOURCE FUTURE-PROOF PROTOCOL FOR EFFECTIVE UAV-BASED ARCHAEOLOGICAL RESEARCH
## KELSEY M. REESE AND SEAN FIELD
## PLOS ONE
## YEAR VOL(NUM): PGS-PGS
###############################################################################################

## ENVIRONMENT ##

## Import spatial data
# dem.longlat <- raster::raster('/Users/kmreese/Documents/PROJECTS/DATABASE/SPATIAL/DEM/REGIONS/NORTH-ESCARPMENT/n38w109/grdn38w109_13/w001001.adf')
# raster::projection(dem.longlat) <- longlat.projection
# dem.utm <- raster::projectRaster(dem.longlat,crs=master.projection)
# raster::writeRaster(dem.utm,'/Users/kmreese/Documents/PROJECTS/DATABASE/SPATIAL/DEM/REGIONS/NORTH-ESCARPMENT/n38w109_13-utm',overwrite=T)
dem.utm <- raster::raster('/Users/kmreese/Documents/PROJECTS/DATABASE/SPATIAL/DEM/REGIONS/NORTHERN-SAN-JUAN/n38w109_13-utm')

dtm <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/dtm-example')
raster::projection(dtm) <- master.projection

dem <- raster::crop(dem.utm,raster::extent(dtm))
dem <- raster::resample(dem,dtm,'bilinear')

dem.contours <- rgdal::readOGR('/Users/kmreese/Documents/PROJECTS/DATABASE/SPATIAL/SHAPEFILES/CONTOURS',layer='ne-contours-5m')
raster::projection(dem.contours) <- master.projection

state.boundaries <- rgdal::readOGR('/Users/kmreese/Documents/PROJECTS/DATABASE/SPATIAL/SHAPEFILES/BOUNDARIES/states-united-states',layer='us-state-boundaries')
raster::projection(state.boundaries) <- master.projection
mvnp.boundary <- rgdal::readOGR('/Users/kmreese/Documents/PROJECTS/DATABASE/SPATIAL/SHAPEFILES/BOUNDARIES/boundaries-national-parks',layer='mv-np-boundary')
raster::projection(mvnp.boundary) <- master.projection
escarpment.boundary <- rgdal::readOGR('/Users/kmreese/Documents/PROJECTS/DATABASE/SPATIAL/SHAPEFILES/BOUNDARIES/boundaries-survey',layer='mvnes-total-survey-access-area')
raster::projection(escarpment.boundary) <- master.projection

datums <- rgdal::readOGR('/Users/kmreese/Documents/PROJECTS/DATABASE/SPATIAL/SHAPEFILES/NORTH-ESCARPMENT/mvnes-sites',layer='ne-sites')
raster::projection(datums) <- master.projection
community.sites <- datums[which(datums$PRIMARY == 'HABITATION' |  datums$PRIMARY == 'RESERVOIR' | datums$PRIMARY == 'GREATKIVA' | datums$PRIMARY == 'SPECIALTY'  | datums$PRIMARY == 'GREATHOUSE' | datums$PRIMARY == 'TOWER'),]
datum <- datums[which(datums$SITENUM_1 == '5MT01917' ),]

vepii <- rgdal::readOGR('/Users/kmreese/Documents/PROJECTS/DATABASE/SPATIAL/SHAPEFILES/VEPII-N',layer='vepii-nad83')
raster::projection(vepii) <- master.projection
# regional.sites <- vepii[which(vepii$rcrdtypd == 'Habitation' | vepii$rcrdtypd == 'Great Kiva' | vepii$rcrdtypd == 'Great House'  | vepii$rcrdtypd == 'Oversized pitstructure' | vepii$rcrdtypd == 'Multi-wall Structure' | vepii$rcrdtypd == 'Plaza' | vepii$rcrdtypd == 'Reservoir' | vepii$rcrdtypd == 'Tower-kiva'),]
regional.sites <- vepii[which(vepii$rcrdtypd == 'Great House'  | vepii$rcrdtypd == 'Tower-kiva'),]

roomblocks.all <- rgdal::readOGR('/Users/kmreese/Documents/PROJECTS/DATABASE/SPATIAL/SHAPEFILES/NORTH-ESCARPMENT/features-cultural',layer='ne-roomblocks')
raster::projection(roomblocks.all) <- master.projection
site <- roomblocks.all[which(roomblocks.all$SITENUM_1 == '5MT01917' ),]
site.extent <- polygonUTM_NAD83(xmin(site)-5,xmax(site)+5,ymin(site)-5,ymax(site)+5,12)
tower.rubble <- spatialEco::remove.holes(site[which(site$STORY == 'TOWER' ),])
roomblock.rubble <- spatialEco::remove.holes(site[which(site$STORY == 'FIRST' ),])

pitstructures.all <- rgdal::readOGR('/Users/kmreese/Documents/PROJECTS/DATABASE/SPATIAL/SHAPEFILES/NORTH-ESCARPMENT/features-cultural',layer='ne-pitstructures')
raster::projection(pitstructures.all) <- master.projection
pitstructure.points <- pitstructures.all[which(pitstructures.all$SITENUM_1 == '5MT01917' ),]
pitstructures <- raster::buffer(pitstructure.points,width=(pitstructure.points$DIAMETER)/2)

towers <- rgdal::readOGR('/Users/kmreese/Documents/PROJECTS/DATABASE/SPATIAL/SHAPEFILES/NORTH-ESCARPMENT/features-cultural',layer='ne-towers')
raster::projection(towers) <- master.projection
tower.points <- towers[which(towers$SITENUM_1 == '5MT01917' ),]
tower.diameter <- tower.points$DIAMETER

historic.pueblo.information <- utils::read.csv('/Users/kmreese/Documents/PROJECTS/DATABASE/TABLES/Dohm_1990.csv')

avg.area.room.m2 <- mean(c(5.8,8.7,5.1)) # averaged from values presented in Lipe 1989: Table 1, AD 1020--1300
corners.of.rooms.m <- 1.2192 # added to account for architecture in room corners, converted from feet presented in Martin 1936
avg.wall.thickness.m <- 0.5334 # average wall thickness, converted from feet presented in Martin 1936
reported.tower.thickness.m <- 0.9144 # tower wall thickness reported in Rohn 1977: 117 via O'Bryan 1950
estimated.tower.thickness.m <- mean(c(reported.tower.thickness.m,avg.wall.thickness.m)) # although not explicitly measured, exposed walls in the tower feature suggest the original walls were less than 'reported.tower.thickness.m' but greater than 'avg.wall.thickness.m'
avg.area.per.person <- mean(historic.pueblo.information$AREA_ROOFED_PER_PERSON) # an average of roofed area per person at historic Pueblos reported in Dohm 1990: Table 3



