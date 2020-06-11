###############################################################################################
## A FREE AND OPEN-SOURCE FUTURE-PROOF PROTOCOL FOR EFFECTIVE UAV-BASED ARCHAEOLOGICAL RESEARCH
## KELSEY M. REESE AND SEAN FIELD
## PLOS ONE
## YEAR VOL(NUM): PGS-PGS
###############################################################################################

## FIGURES ##

# Figure information - Start
zoomed.out.extent <- raster::extent(xmin(escarpment.boundary)-6136.1,xmax(escarpment.boundary)+6136.1,ymin(escarpment.boundary)-9529,ymax(escarpment.boundary)+9529)
zoomed.in.extent <- raster::extent(xmin(escarpment.boundary)-1136.1,xmax(escarpment.boundary)+1136.1,ymin(escarpment.boundary)-1529,ymax(escarpment.boundary)+1529)

zoomed.out.box <- polygonUTM_NAD83(xmin(zoomed.out.extent),xmax(zoomed.out.extent),ymin(zoomed.out.extent),ymax(zoomed.out.extent),12)

dem.utm.cropped.out <- raster::crop(dem.utm,extent(zoomed.out.extent))
dem.utm.cropped.out.slope <- raster::terrain(dem.utm.cropped.out,'slope')
dem.utm.cropped.out.aspect <- raster::terrain(dem.utm.cropped.out,'aspect')
dem.utm.cropped.out.hillshade <- raster::hillShade(dem.utm.cropped.out.slope,dem.utm.cropped.out.aspect)

dem.utm.cropped.in <- raster::crop(dem.utm,extent(zoomed.in.extent))
dem.utm.cropped.in.slope <- raster::terrain(dem.utm.cropped.in,'slope')
dem.utm.cropped.in.aspect <- raster::terrain(dem.utm.cropped.in,'aspect')
dem.utm.cropped.in.hillshade <- raster::hillShade(dem.utm.cropped.in.slope,dem.utm.cropped.in.aspect)

## Exact survey polygons used in DTM analysis
landcover.light <- rgdal::readOGR('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/',layer='uav1-flight-polygon')
landcover.medium <- rgdal::readOGR('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/',layer='uav2-flight-polygon')
landcover.heavy <- rgdal::readOGR('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/',layer='uav3-flight-polygon')
landcover.extreme <- rgdal::readOGR('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/',layer='uav4-flight-polygon')

landcover.light <- sp::spTransform(landcover.light,master.projection)
landcover.medium <- sp::spTransform(landcover.medium,master.projection)
landcover.heavy <- sp::spTransform(landcover.heavy,master.projection)
landcover.extreme <- sp::spTransform(landcover.extreme,master.projection)

# Figure information - End
##############################################################################################
# Figure 1 - Start
# Regional overview with Escarpment outline and Four Corners inset

grDevices::pdf('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/figures/Figure 1.pdf')
graphics::par(mfrow=c(1,1),bg=NA,mai=c(0.10,0.10,0.10,0.10),oma=c(0.5,0.5,0.5,0.5))

graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(dem.utm.cropped.out),xmax(dem.utm.cropped.out)),ylim=c(ymin(dem.utm.cropped.out),ymax(dem.utm.cropped.out)),xaxs="i",yaxs="i",axes=F,main='')
raster::plot(dem.utm.cropped.out.hillshade,col=colors,legend=F,add=T,axes=F)
raster::plot(dem.utm.cropped.out,col=scales::alpha(colors,alpha=0.40),add=T,axes=F,legend=F)
raster::plot(mvnp.boundary,col=scales::alpha('darkgreen',alpha=0.4),border=NA,add=T)
raster::plot(escarpment.boundary,col=NA,border='black',lwd=2,add=T)

## Four Corners inset and boundary of study region
TeachingDemos::subplot(raster::plot(state.boundaries,xlim=c(550000,900000),ylim=c(3700000,4650000),col='gray75',border='gray40'),x=xmin(dem.utm.cropped.out),y=ymax(dem.utm.cropped.out),size=c(1.5,1.5),vadj=1,hadj=0)
TeachingDemos::subplot(raster::plot(state.boundaries[which(state.boundaries$STATE_NAME == 'Utah'),],border='black',col='gray75'))
TeachingDemos::subplot(raster::plot(state.boundaries[which(state.boundaries$STATE_NAME == 'Colorado'),],border='black',col='gray75'))
TeachingDemos::subplot(raster::plot(state.boundaries[which(state.boundaries$STATE_NAME == 'New Mexico'),],border='black',col='gray75'))
TeachingDemos::subplot(raster::plot(state.boundaries[which(state.boundaries$STATE_NAME == 'Arizona'),],border='black',col='gray75'))

TeachingDemos::subplot(raster::plot(state.boundaries,xlim=c(550000,900000),ylim=c(3700000,4650000),col='gray75',border='gray40'),x=xmin(dem.utm.cropped.out),y=ymax(dem.utm.cropped.out),size=c(1.5,1.5),vadj=1,hadj=0)
TeachingDemos::subplot(raster::plot(zoomed.out.box,xlim=c(550000,900000),ylim=c(3700000,4650000)),x=xmin(dem.utm.cropped.out),y=ymax(dem.utm.cropped.out),size=c(1.5,1.5),vadj=1,hadj=0)
TeachingDemos::subplot(graphics::box(),x=xmin(dem.utm.cropped.out),y=ymax(dem.utm.cropped.out),size=c(1.5,1.5),vadj=1,hadj=0)

## Labels
graphics::text(726000,4126000,'Mesa Verde National Park',col='darkgreen')
graphics::text(xmin(dem.utm.cropped.out)+1500,ymax(dem.utm.cropped.out)-2500,'UT',cex=0.7,col='gray40')
graphics::text(xmin(dem.utm.cropped.out)+4250,ymax(dem.utm.cropped.out)-2500,'CO',cex=0.7,col='gray40')
graphics::text(xmin(dem.utm.cropped.out)+1500,ymax(dem.utm.cropped.out)-5000,'AZ',cex=0.7,col='gray40')
graphics::text(xmin(dem.utm.cropped.out)+4250,ymax(dem.utm.cropped.out)-5000,'NM',cex=0.7,col='gray40')

## Scale
graphics::segments(xmax(dem.utm.cropped.out)-13000,ymin(dem.utm.cropped.out)+1000,xmax(dem.utm.cropped.out)-3000,ymin(dem.utm.cropped.out)+1000,lwd=1.5)
graphics::segments(xmax(dem.utm.cropped.out)-13000,ymin(dem.utm.cropped.out)+1250,xmax(dem.utm.cropped.out)-13000,ymin(dem.utm.cropped.out)+750,lwd=1.5)
graphics::segments(xmax(dem.utm.cropped.out)-8000,ymin(dem.utm.cropped.out)+1250,xmax(dem.utm.cropped.out)-8000,ymin(dem.utm.cropped.out)+750,lwd=1.5)
graphics::segments(xmax(dem.utm.cropped.out)-3000,ymin(dem.utm.cropped.out)+1250,xmax(dem.utm.cropped.out)-3000,ymin(dem.utm.cropped.out)+750,lwd=1.5)
graphics::text(xmax(dem.utm.cropped.out)-12900,ymin(dem.utm.cropped.out)+975,'0',cex=0.7,pos=2)
graphics::text(xmax(dem.utm.cropped.out)-3100,ymin(dem.utm.cropped.out)+975,'10 km',cex=0.7,pos=4)

## North arrow
graphics::segments(xmax(dem.utm.cropped.out)-1000,ymin(dem.utm.cropped.out)+750,xmax(dem.utm.cropped.out)-1000,ymin(dem.utm.cropped.out)+4750,lwd=1.5)
graphics::segments(xmax(dem.utm.cropped.out)-1000,ymin(dem.utm.cropped.out)+4750,xmax(dem.utm.cropped.out)-1250,ymin(dem.utm.cropped.out)+3750,lwd=1.5)
graphics::text(xmax(dem.utm.cropped.out)-1000,ymin(dem.utm.cropped.out)+2750,'N')

graphics::box()

grDevices::dev.off()

# Figure 1 - End
##############################################################################################
##############################################################################################
# Figure 2 - Start
# Zoomed into Escarpment study area with four landcover boxes

grDevices::pdf('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/figures/Figure 2.pdf',height=4,width=6)
graphics::par(mfrow=c(1,1),bg=NA,mai=c(0.10,0.10,0.10,0.10),oma=c(0.5,0.5,0.5,0.5))

graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(dem.utm.cropped.in),xmax(dem.utm.cropped.in)),ylim=c(ymin(dem.utm.cropped.in),ymax(dem.utm.cropped.in)),xaxs="i",yaxs="i",axes=F,main='')
raster::plot(dem.utm.cropped.in.hillshade,col=colors,legend=F,add=T,axes=F)
raster::plot(dem.utm.cropped.in,col=scales::alpha(colors,alpha=0.40),add=T,axes=F,legend=F)
raster::plot(mvnp.boundary,col=scales::alpha('darkgreen',alpha=0.4),border=NA,add=T)

raster::plot(quartile.1,col=scales::alpha('green',alpha=0.5),border=NA,add=T)
raster::plot(quartile.2,col=scales::alpha('yellow',alpha=0.5),border=NA,add=T)
raster::plot(quartile.3,col=scales::alpha('orange',alpha=0.5),border=NA,add=T)
raster::plot(quartile.4,col=scales::alpha('red',alpha=0.5),border=NA,add=T)

raster::plot(escarpment.boundary,col=NA,border='black',lwd=2,add=T)

raster::plot(landcover.light,col='green',border='black',add=T)
raster::plot(landcover.medium,col='yellow',border='black',add=T)
raster::plot(landcover.heavy,col='orange',border='black',add=T)
raster::plot(landcover.extreme,col='red',border='black',add=T)

graphics::legend('topleft',
                 legend=c('Light landcover','Medium landcover','Heavy landcover','Extreme landcover','Imaged landcover tile'),
                 fill=c(scales::alpha('green',alpha=0.5),scales::alpha('yellow',alpha=0.5),scales::alpha('orange',alpha=0.5),scales::alpha('red',alpha=0.5),NA),
                 cex=0.7,
                 y.intersp=0.9,
                 bty='o',
                 border=c(scales::alpha('green',alpha=0.5),scales::alpha('yellow',alpha=0.5),scales::alpha('orange',alpha=0.5),scales::alpha('red',alpha=0.5),'black'),
                 box.lwd=0.75,
                 box.col='black',
                 bg=alpha('gray80',alpha=0.7))

## Labels
graphics::text(726000,4126000,'Mesa Verde National Park',col='darkgreen')

## Scale
graphics::segments(xmax(dem.utm.cropped.in)-7000,ymin(dem.utm.cropped.in)+500,xmax(dem.utm.cropped.in)-2000,ymin(dem.utm.cropped.in)+500,lwd=1.5)
graphics::segments(xmax(dem.utm.cropped.in)-7000,ymin(dem.utm.cropped.in)+375,xmax(dem.utm.cropped.in)-7000,ymin(dem.utm.cropped.in)+625,lwd=1.5)
graphics::segments(xmax(dem.utm.cropped.in)-4500,ymin(dem.utm.cropped.in)+375,xmax(dem.utm.cropped.in)-4500,ymin(dem.utm.cropped.in)+625,lwd=1.5)
graphics::segments(xmax(dem.utm.cropped.in)-2000,ymin(dem.utm.cropped.in)+375,xmax(dem.utm.cropped.in)-2000,ymin(dem.utm.cropped.in)+625,lwd=1.5)
graphics::text(xmax(dem.utm.cropped.in)-6900,ymin(dem.utm.cropped.in)+490,'0',cex=0.7,pos=2)
graphics::text(xmax(dem.utm.cropped.in)-2100,ymin(dem.utm.cropped.in)+490,'5 km',cex=0.7,pos=4)

## North arrow
graphics::segments(xmax(dem.utm.cropped.in)-500,ymin(dem.utm.cropped.in)+375,xmax(dem.utm.cropped.in)-500,ymin(dem.utm.cropped.in)+2750,lwd=1.5)
graphics::segments(xmax(dem.utm.cropped.in)-500,ymin(dem.utm.cropped.in)+2750,xmax(dem.utm.cropped.in)-625,ymin(dem.utm.cropped.in)+2250,lwd=1.5)
graphics::text(xmax(dem.utm.cropped.in)-500,ymin(dem.utm.cropped.in)+1562.5,'N')

graphics::box()

grDevices::dev.off()

# Figure 2 - End
##############################################################################################
##############################################################################################
# Figure 3 - Start
# Sample comparison of OpenDroneMap versus Agisoft PhotoscanPro results at each flight height for sample tile: UAV 3
# Figure should be replicated for all flights and made available in the supplemental material

plot.extent <- raster::extent(landcover.heavy)
flight.color <- 'orange'

grDevices::pdf('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/figures/Figure 3.pdf',height=16,width=12)
graphics::par(mfrow=c(3,2),bg=NA,mai=c(0.00,0.50,0.50,0.00),oma=c(0.5,0.5,0.5,0.5))

## Plot 'a'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav3.20m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav3.20m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'a',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

mtext('20 m',side=2,line=1,cex=2)
mtext('OpenDroneMap',side=3,line=1,cex=2)

graphics::box(col=flight.color,lwd=5)

## Plot 'd'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(app.uav3.20m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(app.uav3.20m,col=alpha(heatcolors,alpha=0.50),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'d',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

mtext('Agisoft PhotoScan',side=3,line=1,cex=2)

graphics::box(col=flight.color,lwd=5)

## Plot 'b'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav3.35m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav3.35m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'b',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

mtext('35 m',side=2,line=1,cex=2)

graphics::box(col=flight.color,lwd=5)

## Plot 'e'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(app.uav3.35m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(app.uav3.35m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'e',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

graphics::box(col=flight.color,lwd=5)

## Plot 'c'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav3.50m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav3.50m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'c',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

mtext('50 m',side=2,line=1,cex=2)

graphics::box(col=flight.color,lwd=5)

## Plot 'f'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(app.uav3.50m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(app.uav3.50m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'f',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

graphics::box(col=flight.color,lwd=5)

grDevices::dev.off()

# Figure 3 - End
##############################################################################################
##############################################################################################
# Figure 4 - Start

tower.mapped <- raster::buffer(tower.points,width=tower.points$DIAMETER/2)

grDevices::pdf('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/figures/Figure 4.pdf',width=12,height=6)
graphics::par(mfrow=c(1,2),bg=NA,mai=c(0.10,0.10,0.10,0.10),oma=c(0.5,0.5,0.5,0.5))

graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(extent(dtm.difference.cropped)),xmax(extent(dtm.difference.cropped))),ylim=c(ymin(extent(dtm.difference.cropped)),ymax(extent(dtm.difference.cropped))),xaxs="i",yaxs="i",axes=F,main='')

graphics::text(xmin(extent(dtm.difference.cropped))+3,ymin(extent(dtm.difference.cropped))+3,'a',cex=3)
graphics::segments(xmax(extent(dtm.difference.cropped))-15,ymin(extent(dtm.difference.cropped))+1.5,xmax(extent(dtm.difference.cropped))-5,ymin(extent(dtm.difference.cropped))+1.5,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-15,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-15,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-10,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-10,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-5,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-5,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::text(xmax(extent(dtm.difference.cropped))-14.75,ymin(extent(dtm.difference.cropped))+1.5,'0',pos=2,cex=0.75)
graphics::text(xmax(extent(dtm.difference.cropped))-5.25,ymin(extent(dtm.difference.cropped))+1.5,'10 m',pos=4,cex=0.75)

graphics::segments(xmax(extent(dtm.difference.cropped))-1.5,ymin(extent(dtm.difference.cropped))+1.5,xmax(extent(dtm.difference.cropped))-1.5,ymin(extent(dtm.difference.cropped))+9.5,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-1.5,ymin(extent(dtm.difference.cropped))+9.5,xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+7.5,lwd=1)
graphics::text(xmax(extent(dtm.difference.cropped))-1.5,ymin(extent(dtm.difference.cropped))+5.5,'N',cex=1)

graphics::box()

graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(extent(dtm.difference.cropped)),xmax(extent(dtm.difference.cropped))),ylim=c(ymin(extent(dtm.difference.cropped)),ymax(extent(dtm.difference.cropped))),xaxs="i",yaxs="i",axes=F,main='')
raster::plot(dem.contours,col='gray',lwd=0.25,add=T)

raster::plot(roomblock.rubble,col=scales::alpha('gray',alpha=0.4),border='black',lwd=1,add=T)
raster::plot(tower.rubble,col=scales::alpha('gray',alpha=0.4),border='black',lty=4,lwd=1,add=T)
raster::plot(pitstructures,col='white',border='black',lty=2,lwd=0.75,add=T)
graphics::points(coordinates(pitstructure.points)[1,1],coordinates(pitstructure.points)[1,2],pch='d',col='black',lwd=0.75,cex=0.75)
graphics::points(coordinates(pitstructure.points)[2,1],coordinates(pitstructure.points)[2,2],pch='c',col='black',lwd=0.75,cex=0.75)
graphics::points(coordinates(pitstructure.points)[3,1],coordinates(pitstructure.points)[3,2],pch='b',col='black',lwd=0.75,cex=0.75)
graphics::points(coordinates(pitstructure.points)[4,1],coordinates(pitstructure.points)[4,2],pch='a',col='black',lwd=0.75,cex=0.75)
graphics::points(coordinates(pitstructure.points)[5,1],coordinates(pitstructure.points)[5,2],pch='e',col='black',lwd=0.75,cex=0.75)
raster::plot(tower.mapped,col='white',border='black',lty=3,lwd=0.75,add=T)
raster::plot(tower.points,pch='T',col='black',lwd=0.75,cex=0.75,add=T)

graphics::legend('topleft',
                 legend=c('Roomblock rubble','Tower rubble','Pitstructure','Tower','5-m contour'),
                 # fill=c(scales::alpha('gray',alpha=0.4),scales::alpha('gray',alpha=0.8),'white','white'),
                 lty=c(1,4,2,3,1),
                 cex=0.7,
                 y.intersp=0.9,
                 bty='o',
                 col=c('black','black','black','black','gray'),
                 box.lwd=0.75,
                 box.col='black',
                 bg='white')

graphics::text(xmin(extent(dtm.difference.cropped))+3,ymin(extent(dtm.difference.cropped))+3,'b',cex=3)
graphics::segments(xmax(extent(dtm.difference.cropped))-15,ymin(extent(dtm.difference.cropped))+1.5,xmax(extent(dtm.difference.cropped))-5,ymin(extent(dtm.difference.cropped))+1.5,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-15,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-15,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-10,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-10,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-5,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-5,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::text(xmax(extent(dtm.difference.cropped))-14.75,ymin(extent(dtm.difference.cropped))+1.5,'0',pos=2,cex=0.75)
graphics::text(xmax(extent(dtm.difference.cropped))-5.25,ymin(extent(dtm.difference.cropped))+1.5,'10 m',pos=4,cex=0.75)

graphics::segments(xmax(extent(dtm.difference.cropped))-1.5,ymin(extent(dtm.difference.cropped))+1.5,xmax(extent(dtm.difference.cropped))-1.5,ymin(extent(dtm.difference.cropped))+9.5,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-1.5,ymin(extent(dtm.difference.cropped))+9.5,xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+7.5,lwd=1)
graphics::text(xmax(extent(dtm.difference.cropped))-1.5,ymin(extent(dtm.difference.cropped))+5.5,'N',cex=1)

graphics::box()

grDevices::dev.off()

# Figure 4 - End
##############################################################################################
##############################################################################################
# Figure 5 - Start

grDevices::pdf('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/figures/Figure 5.pdf',height=16,width=12)
graphics::par(mfrow=c(3,2),bg=NA,mai=c(0.10,0.10,0.10,0.10),oma=c(0.5,0.5,0.5,0.5))

## Plot 'a'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(extent(dem)),xmax(extent(dem))),ylim=c(ymin(extent(dem)),ymax(extent(dem))),xaxs="i",yaxs="i",axes=F,main='')
raster::plot(dem,col=heatcolors,legend=F,add=T)

graphics::text(xmin(extent(dem))+10,ymin(extent(dem))+10,'a',cex=4)
graphics::segments(xmax(extent(dem))-80,ymin(extent(dem))+5,xmax(extent(dem))-30,ymin(extent(dem))+5,lwd=2)
graphics::segments(xmax(extent(dem))-80,ymin(extent(dem))+7,xmax(extent(dem))-80,ymin(extent(dem))+3,lwd=2)
graphics::segments(xmax(extent(dem))-55,ymin(extent(dem))+7,xmax(extent(dem))-55,ymin(extent(dem))+3,lwd=2)
graphics::segments(xmax(extent(dem))-30,ymin(extent(dem))+7,xmax(extent(dem))-30,ymin(extent(dem))+3,lwd=2)
graphics::text(xmax(extent(dem))-80,ymin(extent(dem))+5,'0',pos=2)
graphics::text(xmax(extent(dem))-30,ymin(extent(dem))+5,'50 m',pos=4)

graphics::segments(xmax(extent(dem))-10,ymin(extent(dem))+5,xmax(extent(dem))-10,ymin(extent(dem))+35,lwd=2)
graphics::segments(xmax(extent(dem))-10,ymin(extent(dem))+35,xmax(extent(dem))-12,ymin(extent(dem))+31,lwd=2)
graphics::text(xmax(extent(dem))-10,ymin(extent(dem))+20,'N',cex=1.5)

graphics::box()

## Plot 'b'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(extent(dem)),xmax(extent(dem))),ylim=c(ymin(extent(dem)),ymax(extent(dem))),xaxs="i",yaxs="i",axes=F,main='')
raster::plot(dtm,col=heatcolors,legend=F,add=T)

graphics::text(xmin(extent(dem))+10,ymin(extent(dem))+10,'b',cex=4)
graphics::segments(xmax(extent(dem))-80,ymin(extent(dem))+5,xmax(extent(dem))-30,ymin(extent(dem))+5,lwd=2)
graphics::segments(xmax(extent(dem))-80,ymin(extent(dem))+7,xmax(extent(dem))-80,ymin(extent(dem))+3,lwd=2)
graphics::segments(xmax(extent(dem))-55,ymin(extent(dem))+7,xmax(extent(dem))-55,ymin(extent(dem))+3,lwd=2)
graphics::segments(xmax(extent(dem))-30,ymin(extent(dem))+7,xmax(extent(dem))-30,ymin(extent(dem))+3,lwd=2)
graphics::text(xmax(extent(dem))-80,ymin(extent(dem))+5,'0',pos=2)
graphics::text(xmax(extent(dem))-30,ymin(extent(dem))+5,'50 m',pos=4)

graphics::segments(xmax(extent(dem))-10,ymin(extent(dem))+5,xmax(extent(dem))-10,ymin(extent(dem))+35,lwd=2)
graphics::segments(xmax(extent(dem))-10,ymin(extent(dem))+35,xmax(extent(dem))-12,ymin(extent(dem))+31,lwd=2)
graphics::text(xmax(extent(dem))-10,ymin(extent(dem))+20,'N',cex=1.5)

graphics::box()

## Plot 'c'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(extent(dem)),xmax(extent(dem))),ylim=c(ymin(extent(dem)),ymax(extent(dem))),xaxs="i",yaxs="i",axes=F,main='')
raster::plot(dtm,col=heatcolors,legend=F,add=T)
raster::plot(roomblock.rubble,col=NA,border='black',lwd=0.5,add=T)
raster::plot(tower.rubble,col=NA,border='black',lwd=0.5,add=T)
raster::plot(pitstructures,col=NA,border='black',lwd=0.5,add=T)


graphics::text(xmin(extent(dem))+10,ymin(extent(dem))+10,'c',cex=4)
graphics::segments(xmax(extent(dem))-80,ymin(extent(dem))+5,xmax(extent(dem))-30,ymin(extent(dem))+5,lwd=2)
graphics::segments(xmax(extent(dem))-80,ymin(extent(dem))+7,xmax(extent(dem))-80,ymin(extent(dem))+3,lwd=2)
graphics::segments(xmax(extent(dem))-55,ymin(extent(dem))+7,xmax(extent(dem))-55,ymin(extent(dem))+3,lwd=2)
graphics::segments(xmax(extent(dem))-30,ymin(extent(dem))+7,xmax(extent(dem))-30,ymin(extent(dem))+3,lwd=2)
graphics::text(xmax(extent(dem))-80,ymin(extent(dem))+5,'0',pos=2)
graphics::text(xmax(extent(dem))-30,ymin(extent(dem))+5,'50 m',pos=4)

graphics::segments(xmax(extent(dem))-10,ymin(extent(dem))+5,xmax(extent(dem))-10,ymin(extent(dem))+35,lwd=2)
graphics::segments(xmax(extent(dem))-10,ymin(extent(dem))+35,xmax(extent(dem))-12,ymin(extent(dem))+31,lwd=2)
graphics::text(xmax(extent(dem))-10,ymin(extent(dem))+20,'N',cex=1.5)

graphics::box()

## Plot 'd'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(extent(dem)),xmax(extent(dem))),ylim=c(ymin(extent(dem)),ymax(extent(dem))),xaxs="i",yaxs="i",axes=F,main='')
raster::plot(dtm.incomplete,col=heatcolors,legend=F,add=T)

graphics::text(xmin(extent(dem))+10,ymin(extent(dem))+10,'d',cex=4)
graphics::segments(xmax(extent(dem))-80,ymin(extent(dem))+5,xmax(extent(dem))-30,ymin(extent(dem))+5,lwd=2)
graphics::segments(xmax(extent(dem))-80,ymin(extent(dem))+7,xmax(extent(dem))-80,ymin(extent(dem))+3,lwd=2)
graphics::segments(xmax(extent(dem))-55,ymin(extent(dem))+7,xmax(extent(dem))-55,ymin(extent(dem))+3,lwd=2)
graphics::segments(xmax(extent(dem))-30,ymin(extent(dem))+7,xmax(extent(dem))-30,ymin(extent(dem))+3,lwd=2)
graphics::text(xmax(extent(dem))-80,ymin(extent(dem))+5,'0',pos=2)
graphics::text(xmax(extent(dem))-30,ymin(extent(dem))+5,'50 m',pos=4)

graphics::segments(xmax(extent(dem))-10,ymin(extent(dem))+5,xmax(extent(dem))-10,ymin(extent(dem))+35,lwd=2)
graphics::segments(xmax(extent(dem))-10,ymin(extent(dem))+35,xmax(extent(dem))-12,ymin(extent(dem))+31,lwd=2)
graphics::text(xmax(extent(dem))-10,ymin(extent(dem))+20,'N',cex=1.5)

graphics::box()

## Plot 'e'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(extent(dem)),xmax(extent(dem))),ylim=c(ymin(extent(dem)),ymax(extent(dem))),xaxs="i",yaxs="i",axes=F,main='')
raster::plot(dtm.interpolated,col=heatcolors,legend=F,add=T)

graphics::text(xmin(extent(dem))+10,ymin(extent(dem))+10,'e',cex=4)
graphics::segments(xmax(extent(dem))-80,ymin(extent(dem))+5,xmax(extent(dem))-30,ymin(extent(dem))+5,lwd=2)
graphics::segments(xmax(extent(dem))-80,ymin(extent(dem))+7,xmax(extent(dem))-80,ymin(extent(dem))+3,lwd=2)
graphics::segments(xmax(extent(dem))-55,ymin(extent(dem))+7,xmax(extent(dem))-55,ymin(extent(dem))+3,lwd=2)
graphics::segments(xmax(extent(dem))-30,ymin(extent(dem))+7,xmax(extent(dem))-30,ymin(extent(dem))+3,lwd=2)
graphics::text(xmax(extent(dem))-80,ymin(extent(dem))+5,'0',pos=2)
graphics::text(xmax(extent(dem))-30,ymin(extent(dem))+5,'50 m',pos=4)

graphics::segments(xmax(extent(dem))-10,ymin(extent(dem))+5,xmax(extent(dem))-10,ymin(extent(dem))+35,lwd=2)
graphics::segments(xmax(extent(dem))-10,ymin(extent(dem))+35,xmax(extent(dem))-12,ymin(extent(dem))+31,lwd=2)
graphics::text(xmax(extent(dem))-10,ymin(extent(dem))+20,'N',cex=1.5)

graphics::box()

## Plot 'f'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(extent(dem)),xmax(extent(dem))),ylim=c(ymin(extent(dem)),ymax(extent(dem))),xaxs="i",yaxs="i",axes=F,main='')
raster::plot(dtm.difference,col=heatcolors,legend=F,add=T)

graphics::text(xmin(extent(dem))+10,ymin(extent(dem))+10,'f',cex=4)
graphics::segments(xmax(extent(dem))-80,ymin(extent(dem))+5,xmax(extent(dem))-30,ymin(extent(dem))+5,lwd=2)
graphics::segments(xmax(extent(dem))-80,ymin(extent(dem))+7,xmax(extent(dem))-80,ymin(extent(dem))+3,lwd=2)
graphics::segments(xmax(extent(dem))-55,ymin(extent(dem))+7,xmax(extent(dem))-55,ymin(extent(dem))+3,lwd=2)
graphics::segments(xmax(extent(dem))-30,ymin(extent(dem))+7,xmax(extent(dem))-30,ymin(extent(dem))+3,lwd=2)
graphics::text(xmax(extent(dem))-80,ymin(extent(dem))+5,'0',pos=2)
graphics::text(xmax(extent(dem))-30,ymin(extent(dem))+5,'50 m',pos=4)

graphics::segments(xmax(extent(dem))-10,ymin(extent(dem))+5,xmax(extent(dem))-10,ymin(extent(dem))+35,lwd=2)
graphics::segments(xmax(extent(dem))-10,ymin(extent(dem))+35,xmax(extent(dem))-12,ymin(extent(dem))+31,lwd=2)
graphics::text(xmax(extent(dem))-10,ymin(extent(dem))+20,'N',cex=1.5)

graphics::box()

grDevices::dev.off()

# Figure 5 - End
##############################################################################################
##############################################################################################
# Figure 6 - Start

tower.mapped <- raster::buffer(tower.points,width=tower.points$DIAMETER/2)

grDevices::pdf('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/figures/Figure 6.pdf')
graphics::par(mfrow=c(2,2),bg=NA,mai=c(0.10,0.10,0.10,0.10),oma=c(0.5,0.5,0.5,0.5))

## Plot 'a'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(extent(dtm.difference.cropped)),xmax(extent(dtm.difference.cropped))),ylim=c(ymin(extent(dtm.difference.cropped)),ymax(extent(dtm.difference.cropped))),xaxs="i",yaxs="i",axes=F,main='')
raster::plot(dtm.difference.cropped,col=heatcolors,legend=F,add=T)

graphics::text(xmin(extent(dtm.difference.cropped))+3,ymin(extent(dtm.difference.cropped))+3,'a',cex=2)
graphics::segments(xmax(extent(dtm.difference.cropped))-17,ymin(extent(dtm.difference.cropped))+1.5,xmax(extent(dtm.difference.cropped))-7,ymin(extent(dtm.difference.cropped))+1.5,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-17,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-17,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-12,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-12,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-7,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-7,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::text(xmax(extent(dtm.difference.cropped))-16.5,ymin(extent(dtm.difference.cropped))+1.5,'0',pos=2,cex=0.75)
graphics::text(xmax(extent(dtm.difference.cropped))-7.5,ymin(extent(dtm.difference.cropped))+1.5,'10 m',pos=4,cex=0.75)

graphics::segments(xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+1.5,xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+9.5,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+9.5,xmax(extent(dtm.difference.cropped))-2.5,ymin(extent(dtm.difference.cropped))+7.5,lwd=1)
graphics::text(xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+5.5,'N',cex=1)

graphics::box()

## Plot 'b'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(extent(dtm.difference.cropped)),xmax(extent(dtm.difference.cropped))),ylim=c(ymin(extent(dtm.difference.cropped)),ymax(extent(dtm.difference.cropped))),xaxs="i",yaxs="i",axes=F,main='')
raster::plot(dtm.difference.cropped,col=heatcolors,legend=F,add=T)
raster::plot(roomblock.rubble,add=T)
raster::plot(pitstructures,col=NA,border='black',lty=2,lwd=0.75,add=T)
graphics::points(coordinates(pitstructure.points)[1,1],coordinates(pitstructure.points)[1,2],pch='d',col='black',lwd=0.75,cex=0.75)
graphics::points(coordinates(pitstructure.points)[2,1],coordinates(pitstructure.points)[2,2],pch='c',col='black',lwd=0.75,cex=0.75)
graphics::points(coordinates(pitstructure.points)[3,1],coordinates(pitstructure.points)[3,2],pch='b',col='black',lwd=0.75,cex=0.75)
graphics::points(coordinates(pitstructure.points)[4,1],coordinates(pitstructure.points)[4,2],pch='a',col='black',lwd=0.75,cex=0.75)
graphics::points(coordinates(pitstructure.points)[5,1],coordinates(pitstructure.points)[5,2],pch='e',col='black',lwd=0.75,cex=0.75)
raster::plot(tower.rubble,col=NA,border='black',lty=4,lwd=0.75,add=T)
raster::plot(tower.mapped,col=NA,border='black',lty=3,lwd=0.75,add=T)
raster::plot(tower.points,pch='T',col='black',lwd=0.75,cex=0.75,add=T)

graphics::text(xmin(extent(dtm.difference.cropped))+3,ymin(extent(dtm.difference.cropped))+3,'b',cex=2)
graphics::segments(xmax(extent(dtm.difference.cropped))-17,ymin(extent(dtm.difference.cropped))+1.5,xmax(extent(dtm.difference.cropped))-7,ymin(extent(dtm.difference.cropped))+1.5,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-17,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-17,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-12,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-12,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-7,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-7,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::text(xmax(extent(dtm.difference.cropped))-16.5,ymin(extent(dtm.difference.cropped))+1.5,'0',pos=2,cex=0.75)
graphics::text(xmax(extent(dtm.difference.cropped))-7.5,ymin(extent(dtm.difference.cropped))+1.5,'10 m',pos=4,cex=0.75)

graphics::segments(xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+1.5,xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+9.5,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+9.5,xmax(extent(dtm.difference.cropped))-2.5,ymin(extent(dtm.difference.cropped))+7.5,lwd=1)
graphics::text(xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+5.5,'N',cex=1)

graphics::box()

## Plot 'c'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(extent(dtm.difference.cropped)),xmax(extent(dtm.difference.cropped))),ylim=c(ymin(extent(dtm.difference.cropped)),ymax(extent(dtm.difference.cropped))),xaxs="i",yaxs="i",axes=F,main='')
raster::plot(dtm.difference.cropped,col=heatcolors,legend=F,add=T)
raster::contour(dtm.difference.cropped,nlevels=10,add=T,axes=F,legend=F,labels='')

graphics::text(xmin(extent(dtm.difference.cropped))+3,ymin(extent(dtm.difference.cropped))+3,'c',cex=2)
graphics::segments(xmax(extent(dtm.difference.cropped))-17,ymin(extent(dtm.difference.cropped))+1.5,xmax(extent(dtm.difference.cropped))-7,ymin(extent(dtm.difference.cropped))+1.5,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-17,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-17,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-12,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-12,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-7,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-7,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::text(xmax(extent(dtm.difference.cropped))-16.5,ymin(extent(dtm.difference.cropped))+1.5,'0',pos=2,cex=0.75)
graphics::text(xmax(extent(dtm.difference.cropped))-7.5,ymin(extent(dtm.difference.cropped))+1.5,'10 m',pos=4,cex=0.75)

graphics::segments(xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+1.5,xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+9.5,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+9.5,xmax(extent(dtm.difference.cropped))-2.5,ymin(extent(dtm.difference.cropped))+7.5,lwd=1)
graphics::text(xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+5.5,'N',cex=1)

graphics::box()

## Plot 'd'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(extent(dtm.difference.cropped)),xmax(extent(dtm.difference.cropped))),ylim=c(ymin(extent(dtm.difference.cropped)),ymax(extent(dtm.difference.cropped))),xaxs="i",yaxs="i",axes=F,main='')
raster::plot(dtm.difference.cropped,col=heatcolors,legend=F,add=T)
raster::plot(lower.level.polygons,add=T,axes=F)
raster::plot(upper.level.polygons,add=T,axes=F)

graphics::text(xmin(extent(dtm.difference.cropped))+3,ymin(extent(dtm.difference.cropped))+3,'d',cex=2)
graphics::segments(xmax(extent(dtm.difference.cropped))-17,ymin(extent(dtm.difference.cropped))+1.5,xmax(extent(dtm.difference.cropped))-7,ymin(extent(dtm.difference.cropped))+1.5,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-17,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-17,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-12,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-12,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-7,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-7,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::text(xmax(extent(dtm.difference.cropped))-16.5,ymin(extent(dtm.difference.cropped))+1.5,'0',pos=2,cex=0.75)
graphics::text(xmax(extent(dtm.difference.cropped))-7.5,ymin(extent(dtm.difference.cropped))+1.5,'10 m',pos=4,cex=0.75)

graphics::segments(xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+1.5,xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+9.5,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+9.5,xmax(extent(dtm.difference.cropped))-2.5,ymin(extent(dtm.difference.cropped))+7.5,lwd=1)
graphics::text(xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+5.5,'N',cex=1)

graphics::box()

grDevices::dev.off()

# Figure 6 - End
##############################################################################################
##############################################################################################
# Figure 7 - Start

pitstructure.points$DIAMETER <- c(8,6,8,5,8)
pitstructures.estimated <- raster::buffer(pitstructure.points,width=(pitstructure.points$DIAMETER)/2)
tower <- raster::buffer(tower.points,width=(tower.points$DIAMETER)/2)

grDevices::pdf('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/figures/Figure 7.pdf')
graphics::par(mfrow=c(1,1),bg=NA,mai=c(0.10,0.10,0.10,0.10),oma=c(0.5,0.5,0.5,0.5))

graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(extent(dtm.difference.cropped)),xmax(extent(dtm.difference.cropped))),ylim=c(ymin(extent(dtm.difference.cropped)),ymax(extent(dtm.difference.cropped))),xaxs="i",yaxs="i",axes=F,main='')
raster::plot(dem.contours,col='gray',lwd=0.25,add=T)

raster::plot(lower.level.polygons,col=scales::alpha('gray',alpha=0.33),border='black',lwd=1,add=T)
raster::plot(upper.level.polygons,col=scales::alpha('gray',alpha=0.33),border='black',lwd=1,add=T)
raster::plot(total.tower.rubble,col=scales::alpha('gray',alpha=0.334),border='black',lty=4,lwd=1,add=T)
raster::plot(pitstructures.estimated,col=scales::alpha('white',alpha=0.75),border='black',lty=2,lwd=1,add=T)
graphics::points(coordinates(pitstructure.points)[1,1],coordinates(pitstructure.points)[1,2],pch='d',col='black',lwd=0.75,cex=0.75)
graphics::points(coordinates(pitstructure.points)[2,1],coordinates(pitstructure.points)[2,2],pch='c',col='black',lwd=0.75,cex=0.75)
graphics::points(coordinates(pitstructure.points)[3,1],coordinates(pitstructure.points)[3,2],pch='b',col='black',lwd=0.75,cex=0.75)
graphics::points(coordinates(pitstructure.points)[4,1],coordinates(pitstructure.points)[4,2],pch='a',col='black',lwd=0.75,cex=0.75)
graphics::points(coordinates(pitstructure.points)[5,1],coordinates(pitstructure.points)[5,2],pch='e',col='black',lwd=0.75,cex=0.75)

raster::plot(tower,col=scales::alpha('white',alpha=0.75),border='black',lty=3,lwd=0.75,add=T)
raster::plot(tower.points,pch='T',col='black',lwd=0.75,cex=0.75,add=T)

graphics::legend('topleft',
                 legend=c('Roomblock rubble','Tower rubble','Pitstructure','Tower','5-m contour'),
                 lty=c(1,4,2,3,1),
                 cex=0.7,
                 y.intersp=0.9,
                 bty='o',
                 col=c('black','black','black','black','gray'),
                 box.lwd=0.75,
                 box.col='black',
                 bg='white')

graphics::segments(xmax(extent(dtm.difference.cropped))-15,ymin(extent(dtm.difference.cropped))+1.5,xmax(extent(dtm.difference.cropped))-5,ymin(extent(dtm.difference.cropped))+1.5,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-15,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-15,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-10,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-10,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-5,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-5,ymin(extent(dtm.difference.cropped))+1.25,lwd=1)
graphics::text(xmax(extent(dtm.difference.cropped))-14.75,ymin(extent(dtm.difference.cropped))+1.5,'0',pos=2,cex=0.75)
graphics::text(xmax(extent(dtm.difference.cropped))-5.25,ymin(extent(dtm.difference.cropped))+1.5,'10 m',pos=4,cex=0.75)

graphics::segments(xmax(extent(dtm.difference.cropped))-1.5,ymin(extent(dtm.difference.cropped))+1.5,xmax(extent(dtm.difference.cropped))-1.5,ymin(extent(dtm.difference.cropped))+9.5,lwd=1)
graphics::segments(xmax(extent(dtm.difference.cropped))-1.5,ymin(extent(dtm.difference.cropped))+9.5,xmax(extent(dtm.difference.cropped))-2,ymin(extent(dtm.difference.cropped))+7.5,lwd=1)
graphics::text(xmax(extent(dtm.difference.cropped))-1.5,ymin(extent(dtm.difference.cropped))+5.5,'N',cex=1)

graphics::box()

grDevices::dev.off()

# Figure 7 - End
##############################################################################################
##############################################################################################
# Figure 8 - Start

visibility.1 <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/5MT01917-intervisibility-first')
visibility.2 <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/5MT01917-intervisibility-second')

visibility.plot.extent <- raster::extent(xmin(site.extent)-1250,xmax(site.extent)+1250,ymin(site.extent)-1750,ymax(site.extent)+750)
dem.utm.sample <- raster::crop(dem.utm,visibility.plot.extent)
dem.utm.slope <- raster::terrain(dem.utm.sample,'slope')
dem.utm.aspect <- raster::terrain(dem.utm.sample,'aspect')
dem.utm.hillshade <- raster::hillShade(dem.utm.slope,dem.utm.aspect,angle=15)

community.sites <- community.sites[which(community.sites$SITENUM_1 != '5MT01917'),]
  
visibility.1 <- raster::crop(visibility.1,visibility.plot.extent)
visibility.2 <- raster::crop(visibility.2,visibility.plot.extent)

grDevices::pdf('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/figures/Figure 8.pdf')
graphics::par(mfrow=c(1,1),bg=NA,mai=c(0.10,0.10,0.10,0.10),oma=c(0.5,0.5,0.5,0.5))

graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(extent(visibility.plot.extent)),xmax(extent(visibility.plot.extent))),ylim=c(ymin(extent(visibility.plot.extent)),ymax(extent(visibility.plot.extent))),xaxs="i",yaxs="i",axes=F,main='')
raster::plot(dem.utm.hillshade,col=colors,legend=F,add=T,axes=F)
raster::plot(dem.utm.sample,col=scales::alpha(colors,alpha=0.40),add=T,axes=F,legend=F)

raster::plot(visibility.2,col=scales::alpha('lightgreen',alpha=0.4),zlim=c(1,1),add=T,legend=F)
raster::plot(visibility.1,col=scales::alpha('darkgreen',alpha=0.4),zlim=c(1,1),add=T,legend=F)
raster::plot(dem.utm.hillshade,col=scales::alpha(colors,alpha=0.3),legend=F,add=T,axes=F)

graphics::points(community.sites,col='black',cex=0.5,pch=3)
graphics::points(datum,cex=0.5,pch=2,col='black')

graphics::legend('topleft',
                 legend=c('Example site','Community sites','First-story visibility','Second-story visibility'),
                 pch=c(2,3,15,15),
                 col=c('black','black',scales::alpha('darkgreen',alpha=0.4),scales::alpha('lightgreen',alpha=0.4)),
                 pt.cex=c(0.7,0.7,2,2),
                 y.intersp=0.9,
                 bty='o',
                 box.lwd=0.75,
                 box.col='black',
                 bg=alpha('gray80',alpha=0.7))

## Scale
graphics::segments(xmax(visibility.plot.extent)-750,ymin(visibility.plot.extent)+50,xmax(visibility.plot.extent)-250,ymin(visibility.plot.extent)+50,lwd=1.5)
graphics::segments(xmax(visibility.plot.extent)-750,ymin(visibility.plot.extent)+60,xmax(visibility.plot.extent)-750,ymin(visibility.plot.extent)+40,lwd=1.5)
graphics::segments(xmax(visibility.plot.extent)-500,ymin(visibility.plot.extent)+60,xmax(visibility.plot.extent)-500,ymin(visibility.plot.extent)+40,lwd=1.5)
graphics::segments(xmax(visibility.plot.extent)-250,ymin(visibility.plot.extent)+60,xmax(visibility.plot.extent)-250,ymin(visibility.plot.extent)+40,lwd=1.5)
graphics::text(xmax(visibility.plot.extent)-735,ymin(visibility.plot.extent)+45,'0',cex=0.7,pos=2)
graphics::text(xmax(visibility.plot.extent)-265,ymin(visibility.plot.extent)+45,'500 m',cex=0.7,pos=4)

## North arrow
graphics::segments(xmax(visibility.plot.extent)-60,ymin(visibility.plot.extent)+50,xmax(visibility.plot.extent)-60,ymin(visibility.plot.extent)+350,lwd=1.5)
graphics::segments(xmax(visibility.plot.extent)-60,ymin(visibility.plot.extent)+350,xmax(visibility.plot.extent)-80,ymin(visibility.plot.extent)+300,lwd=1.5)
graphics::text(xmax(visibility.plot.extent)-60,ymin(visibility.plot.extent)+200,'N')

graphics::box()

grDevices::dev.off()

# Figure 8 - End
##############################################################################################
##############################################################################################
# Figure 9 - Start

visibility.2 <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/5MT01917-intervisibility-second')
visibility.3 <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/spatial-products/5MT01917-intervisibility-tower')

visibility.plot.extent <- raster::extent(xmin(site.extent)-20000,xmax(site.extent)+15000,ymin(site.extent)-1750,ymax(site.extent)+36750)
dem.utm.sample <- raster::crop(dem.utm,visibility.plot.extent)
dem.utm.slope <- raster::terrain(dem.utm.sample,'slope')
dem.utm.aspect <- raster::terrain(dem.utm.sample,'aspect')
dem.utm.hillshade <- raster::hillShade(dem.utm.slope,dem.utm.aspect,angle=15)

visible.extent <- polygonUTM_NAD83(xmin(visibility.plot.extent),xmax(visibility.plot.extent),ymin(visibility.plot.extent),ymax(visibility.plot.extent),12)
visible.datums <- regional.sites[visible.extent,]

visibility.2 <- raster::crop(visibility.2,visibility.plot.extent)
visibility.3 <- raster::crop(visibility.3,visibility.plot.extent)

grDevices::pdf('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/figures/Figure 9.pdf')
graphics::par(mfrow=c(1,1),bg=NA,mai=c(0.10,0.10,0.10,0.10),oma=c(0.5,0.5,0.5,0.5))

graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(extent(visibility.plot.extent)),xmax(extent(visibility.plot.extent))),ylim=c(ymin(extent(visibility.plot.extent)),ymax(extent(visibility.plot.extent))),xaxs="i",yaxs="i",axes=F,main='')
raster::plot(dem.utm.hillshade,col=colors,legend=F,add=T,axes=F)
raster::plot(dem.utm.sample,col=scales::alpha(colors,alpha=0.40),add=T,axes=F,legend=F)

raster::plot(visibility.3,col=scales::alpha('lightgreen',alpha=0.4),zlim=c(1,1),add=T,legend=F)
raster::plot(visibility.2,col=scales::alpha('darkgreen',alpha=0.4),zlim=c(1,1),add=T,legend=F)
raster::plot(dem.utm.hillshade,col=scales::alpha(colors,alpha=0.3),legend=F,add=T,axes=F)

graphics::points(visible.datums[c(2,4,6,8),],cex=0.5,pch=3,col='black')
graphics::points(visible.datums[c(1,3,5,7,12,13),],cex=0.5,pch=1,col='black')
graphics::points(datum,cex=0.5,pch=2,col='black')

graphics::legend('topleft',
                 legend=c('Example site','Intervisible greathouses','Non-visible greathouses','Multi-story visibility','Tower visibility'),
                 pch=c(2,3,1,15,15),
                 col=c('black','black','black',scales::alpha('darkgreen',alpha=0.4),scales::alpha('lightgreen',alpha=0.4)),
                 pt.cex=c(0.7,0.7,0.7,2,2),
                 y.intersp=0.9,
                 bty='o',
                 box.lwd=0.75,
                 box.col='black',
                 bg=alpha('gray80',alpha=0.7))

## Scale
graphics::segments(xmax(visibility.plot.extent)-14000,ymin(visibility.plot.extent)+1000,xmax(visibility.plot.extent)-4000,ymin(visibility.plot.extent)+1000,lwd=1.5)
graphics::segments(xmax(visibility.plot.extent)-14000,ymin(visibility.plot.extent)+1250,xmax(visibility.plot.extent)-14000,ymin(visibility.plot.extent)+750,lwd=1.5)
graphics::segments(xmax(visibility.plot.extent)-9000,ymin(visibility.plot.extent)+1250,xmax(visibility.plot.extent)-9000,ymin(visibility.plot.extent)+750,lwd=1.5)
graphics::segments(xmax(visibility.plot.extent)-4000,ymin(visibility.plot.extent)+1250,xmax(visibility.plot.extent)-4000,ymin(visibility.plot.extent)+750,lwd=1.5)
graphics::text(xmax(visibility.plot.extent)-13900,ymin(visibility.plot.extent)+975,'0',cex=0.7,pos=2)
graphics::text(xmax(visibility.plot.extent)-4100,ymin(visibility.plot.extent)+975,'10 km',cex=0.7,pos=4)



## North arrow
graphics::segments(xmax(visibility.plot.extent)-1000,ymin(visibility.plot.extent)+750,xmax(visibility.plot.extent)-1000,ymin(visibility.plot.extent)+5500,lwd=1.5)
graphics::segments(xmax(visibility.plot.extent)-1000,ymin(visibility.plot.extent)+5500,xmax(visibility.plot.extent)-1250,ymin(visibility.plot.extent)+4500,lwd=1.5)
graphics::text(xmax(visibility.plot.extent)-1000,ymin(visibility.plot.extent)+2750,'N')

graphics::box()

grDevices::dev.off()

# Figure 9 - End
##############################################################################################
##############################################################################################
# Figure S1 - Start

## Load OpenDroneMap (ODM) digital terrain models
odm.uav1.20m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/OpenDroneMap/ODM_UAV1-20m.tif')
odm.uav1.35m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/OpenDroneMap/ODM_UAV1-35m.tif')
odm.uav1.50m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/OpenDroneMap/ODM_UAV1-50m.tif')

## Create hillshades for all ODM terrain models
odm.uav1.20m.slope <- raster::terrain(odm.uav1.20m,'slope')
odm.uav1.20m.aspect <- raster::terrain(odm.uav1.20m,'aspect')
odm.uav1.20m.hillshade <- raster::hillShade(odm.uav1.20m.slope,odm.uav1.20m.aspect,angle=15)
odm.uav1.35m.slope <- raster::terrain(odm.uav1.35m,'slope')
odm.uav1.35m.aspect <- raster::terrain(odm.uav1.35m,'aspect')
odm.uav1.35m.hillshade <- raster::hillShade(odm.uav1.35m.slope,odm.uav1.35m.aspect,angle=15)
odm.uav1.50m.slope <- raster::terrain(odm.uav1.50m,'slope')
odm.uav1.50m.aspect <- raster::terrain(odm.uav1.50m,'aspect')
odm.uav1.50m.hillshade <- raster::hillShade(odm.uav1.50m.slope,odm.uav1.50m.aspect,angle=15)


plot.extent <- raster::extent(landcover.light)
flight.color <- 'green'

grDevices::pdf('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/figures/Figure S1.pdf',height=16,width=12)
graphics::par(mfrow=c(3,2),bg=NA,mai=c(0.00,0.50,0.50,0.00),oma=c(0.5,0.5,0.5,0.5))

## Plot 'a'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav1.20m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav1.20m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'a',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

mtext('20 m',side=2,line=1,cex=2)
mtext('OpenDroneMap',side=3,line=1,cex=2)

graphics::box(col=flight.color,lwd=5)

## Plot 'd'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(app.uav1.20m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(app.uav1.20m,col=alpha(heatcolors,alpha=0.50),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'d',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

mtext('Agisoft PhotoScan',side=3,line=1,cex=2)

graphics::box(col=flight.color,lwd=5)

## Plot 'b'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav1.35m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav1.35m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'b',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

mtext('35 m',side=2,line=1,cex=2)

graphics::box(col=flight.color,lwd=5)

## Plot 'e'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(app.uav1.35m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(app.uav1.35m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'e',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

graphics::box(col=flight.color,lwd=5)

## Plot 'c'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav1.50m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav1.50m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'c',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

mtext('50 m',side=2,line=1,cex=2)

graphics::box(col=flight.color,lwd=5)

## Plot 'f'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(app.uav1.50m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(app.uav1.50m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'f',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

graphics::box(col=flight.color,lwd=5)

grDevices::dev.off()

# Figure S1 - End
##############################################################################################
##############################################################################################
# Figure S2 - Start

plot.extent <- raster::extent(landcover.medium)
flight.color <- 'yellow'

grDevices::pdf('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/figures/Figure S2.pdf',height=16,width=12)
graphics::par(mfrow=c(3,2),bg=NA,mai=c(0.00,0.50,0.50,0.00),oma=c(0.5,0.5,0.5,0.5))

## Plot 'a'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav2.20m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav2.20m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'a',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

mtext('20 m',side=2,line=1,cex=2)
mtext('OpenDroneMap',side=3,line=1,cex=2)

graphics::box(col=flight.color,lwd=5)

## Plot 'd'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(app.uav2.20m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(app.uav2.20m,col=alpha(heatcolors,alpha=0.50),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'d',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

mtext('Agisoft PhotoScan',side=3,line=1,cex=2)

graphics::box(col=flight.color,lwd=5)

## Plot 'b'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav2.35m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav2.35m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'b',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

mtext('35 m',side=2,line=1,cex=2)

graphics::box(col=flight.color,lwd=5)

## Plot 'e'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(app.uav2.35m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(app.uav2.35m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'e',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

graphics::box(col=flight.color,lwd=5)

## Plot 'c'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav2.50m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav2.50m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'c',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

mtext('50 m',side=2,line=1,cex=2)

graphics::box(col=flight.color,lwd=5)

## Plot 'f'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(app.uav2.50m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(app.uav2.50m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'f',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

graphics::box(col=flight.color,lwd=5)

grDevices::dev.off()

# Figure S2 - End
##############################################################################################
##############################################################################################
# Figure S3 - Start

plot.extent <- raster::extent(landcover.extreme)
flight.color <- 'red'

grDevices::pdf('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/figures/Figure S3.pdf',height=16,width=12)
graphics::par(mfrow=c(3,2),bg=NA,mai=c(0.00,0.50,0.50,0.00),oma=c(0.5,0.5,0.5,0.5))

## Plot 'a'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav4.20m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav4.20m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'a',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

mtext('20 m',side=2,line=1,cex=2)
mtext('OpenDroneMap',side=3,line=1,cex=2)

graphics::box(col=flight.color,lwd=5)

## Plot 'd'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(app.uav4.20m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(app.uav4.20m,col=alpha(heatcolors,alpha=0.50),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'d',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

mtext('Agisoft PhotoScan',side=3,line=1,cex=2)

graphics::box(col=flight.color,lwd=5)

## Plot 'b'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav4.35m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav4.35m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'b',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

mtext('35 m',side=2,line=1,cex=2)

graphics::box(col=flight.color,lwd=5)

## Plot 'e'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(app.uav4.35m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(app.uav4.35m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'e',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

graphics::box(col=flight.color,lwd=5)

## Plot 'c'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav4.50m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav4.50m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'c',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

mtext('50 m',side=2,line=1,cex=2)

graphics::box(col=flight.color,lwd=5)

## Plot 'f'
graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(app.uav4.50m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(app.uav4.50m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'f',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

graphics::box(col=flight.color,lwd=5)

grDevices::dev.off()

# Figure S3 - End
##############################################################################################
##############################################################################################
# Figure S4 - Start

pitstructures.all.buffer <- raster::buffer(pitstructures.all,width=(pitstructures.all$DIAMETER)/2)

grDevices::pdf('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/figures/Figure S4.pdf',height=20,width=10)
graphics::par(mfrow=c(4,2),bg=NA,mai=c(0.05,0.05,0.05,0.05),oma=c(0.5,0.5,0.5,0.5))

## 'a' Landcover context #1: DTM model
plot.extent <- raster::extent(landcover.light)
flight.color <- 'green'

graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav1.50m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav1.50m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'a',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

graphics::box(col=flight.color,lwd=5)

## 'b' Landcover context #1: DTM model with survey polygons
plot.extent <- raster::extent(landcover.light)
flight.color <- 'green'

graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav1.50m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav1.50m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

raster::plot(roomblocks.all,col=NA,border='black',lwd=1,add=T)
raster::plot(pitstructures.all.buffer,col=NA,border='black',lty=2,lwd=1,add=T)
graphics::points(coordinates(pitstructures.all),pch=3,cex=0.25)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'b',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

graphics::box(col=flight.color,lwd=5)

## 'c' Landcover context #2: DTM model
plot.extent <- raster::extent(landcover.medium)
flight.color <- 'yellow'

graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav2.50m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav2.50m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'c',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

graphics::box(col=flight.color,lwd=5)

## 'd' Landcover context #2: DTM model with survey polygons
plot.extent <- raster::extent(landcover.medium)
flight.color <- 'yellow'

graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav2.50m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav2.50m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

raster::plot(roomblocks.all,col=NA,border='black',lwd=1,add=T)
raster::plot(pitstructures.all.buffer,col=NA,border='black',lty=2,lwd=1,add=T)
graphics::points(coordinates(pitstructures.all),pch=3,cex=0.25)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'d',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

graphics::box(col=flight.color,lwd=5)

## 'e' Landcover context #3: DTM model
plot.extent <- raster::extent(landcover.heavy)
flight.color <- 'orange'

graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav3.50m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav3.50m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'e',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

graphics::box(col=flight.color,lwd=5)

## 'f' Landcover context #3: DTM model with survey polygons
plot.extent <- raster::extent(landcover.heavy)
flight.color <- 'orange'

graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav3.50m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav3.50m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

raster::plot(roomblocks.all,col=NA,border='black',lwd=1,add=T)
raster::plot(pitstructures.all.buffer,col=NA,border='black',lty=2,lwd=1,add=T)
graphics::points(coordinates(pitstructures.all),pch=3,cex=0.25)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'f',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

graphics::box(col=flight.color,lwd=5)

## 'g' Landcover context #4: DTM model
plot.extent <- raster::extent(landcover.extreme)
flight.color <- 'red'

graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav4.50m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav4.50m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'g',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

graphics::box(col=flight.color,lwd=5)

## 'h' Landcover context #4: DTM model with survey polygons
plot.extent <- raster::extent(landcover.extreme)
flight.color <- 'red'

graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(plot.extent),xmax(plot.extent)),ylim=c(ymin(plot.extent),ymax(plot.extent)),xaxs="i",yaxs="i",axes=F,main='')
plot(odm.uav4.50m.hillshade,col=colors,legend=F,add=T,axes=F)
plot(odm.uav4.50m,col=alpha(heatcolors,alpha=0.40),add=T,axes=F,legend=F)

raster::plot(roomblocks.all,col=NA,border='black',lwd=1,add=T)
raster::plot(pitstructures.all.buffer,col=NA,border='black',lty=2,lwd=1,add=T)
graphics::points(coordinates(pitstructures.all),pch=3,cex=0.25)

graphics::text(xmin(plot.extent)+10,ymin(plot.extent)+14,'h',cex=4)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+5,xmax(plot.extent)-20,ymin(plot.extent)+5,lwd=2)
graphics::segments(xmax(plot.extent)-70,ymin(plot.extent)+7,xmax(plot.extent)-70,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-45,ymin(plot.extent)+7,xmax(plot.extent)-45,ymin(plot.extent)+3,lwd=2)
graphics::segments(xmax(plot.extent)-20,ymin(plot.extent)+7,xmax(plot.extent)-20,ymin(plot.extent)+3,lwd=2)
graphics::text(xmax(plot.extent)-70,ymin(plot.extent)+5,'0',pos=2)
graphics::text(xmax(plot.extent)-20,ymin(plot.extent)+5,'50 m',pos=4)

graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+5,xmax(plot.extent)-6,ymin(plot.extent)+35,lwd=2)
graphics::segments(xmax(plot.extent)-6,ymin(plot.extent)+35,xmax(plot.extent)-7,ymin(plot.extent)+31,lwd=2)
graphics::text(xmax(plot.extent)-6,ymin(plot.extent)+20,'N',cex=1.5)

graphics::box(col=flight.color,lwd=5)

dev.off()

# Figure S4 - End
##############################################################################################

# odm.uav1.20m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/OpenDroneMap/ODM_UAV1-20m.tif')
# odm.uav1.35m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/OpenDroneMap/ODM_UAV1-35m.tif')
# odm.uav1.50m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/OpenDroneMap/ODM_UAV1-50m.tif')
# 
# odm.uav2.20m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/OpenDroneMap/ODM_UAV2-20m.tif')
# odm.uav2.35m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/OpenDroneMap/ODM_UAV2-35m.tif')
# odm.uav2.50m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/OpenDroneMap/ODM_UAV2-50m.tif')
# 
# odm.uav3.20m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/OpenDroneMap/ODM_UAV3-20m.tif')
# odm.uav3.35m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/OpenDroneMap/ODM_UAV3-35m.tif')
# odm.uav3.50m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/OpenDroneMap/ODM_UAV3-50m.tif')
# 
# odm.uav4.20m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/OpenDroneMap/ODM_UAV4-20m.tif')
# odm.uav4.35m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/OpenDroneMap/ODM_UAV4-35m.tif')
# odm.uav4.50m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/OpenDroneMap/ODM_UAV4-50m.tif')
# 
# odm.uav1.20m.slope <- raster::terrain(odm.uav1.20m,'slope')
# odm.uav1.20m.aspect <- raster::terrain(odm.uav1.20m,'aspect')
# odm.uav1.20m.hillshade <- raster::hillShade(odm.uav1.20m.slope,odm.uav1.20m.aspect,angle=15)
# odm.uav1.35m.slope <- raster::terrain(odm.uav1.35m,'slope')
# odm.uav1.35m.aspect <- raster::terrain(odm.uav1.35m,'aspect')
# odm.uav1.35m.hillshade <- raster::hillShade(odm.uav1.35m.slope,odm.uav1.35m.aspect,angle=15)
# odm.uav1.50m.slope <- raster::terrain(odm.uav1.50m,'slope')
# odm.uav1.50m.aspect <- raster::terrain(odm.uav1.50m,'aspect')
# odm.uav1.50m.hillshade <- raster::hillShade(odm.uav1.50m.slope,odm.uav1.50m.aspect,angle=15)
# 
# odm.uav2.20m.slope <- raster::terrain(odm.uav2.20m,'slope')
# odm.uav2.20m.aspect <- raster::terrain(odm.uav2.20m,'aspect')
# odm.uav2.20m.hillshade <- raster::hillShade(odm.uav2.20m.slope,odm.uav2.20m.aspect,angle=15)
# odm.uav2.35m.slope <- raster::terrain(odm.uav2.35m,'slope')
# odm.uav2.35m.aspect <- raster::terrain(odm.uav2.35m,'aspect')
# odm.uav2.35m.hillshade <- raster::hillShade(odm.uav2.35m.slope,odm.uav2.35m.aspect,angle=15)
# odm.uav2.50m.slope <- raster::terrain(odm.uav2.50m,'slope')
# odm.uav2.50m.aspect <- raster::terrain(odm.uav2.50m,'aspect')
# odm.uav2.50m.hillshade <- raster::hillShade(odm.uav2.50m.slope,odm.uav2.50m.aspect,angle=15)
# 
# odm.uav3.20m.slope <- raster::terrain(odm.uav3.20m,'slope')
# odm.uav3.20m.aspect <- raster::terrain(odm.uav3.20m,'aspect')
# odm.uav3.20m.hillshade <- raster::hillShade(odm.uav3.20m.slope,odm.uav3.20m.aspect,angle=15)
# odm.uav3.35m.slope <- raster::terrain(odm.uav3.35m,'slope')
# odm.uav3.35m.aspect <- raster::terrain(odm.uav3.35m,'aspect')
# odm.uav3.35m.hillshade <- raster::hillShade(odm.uav3.35m.slope,odm.uav3.35m.aspect,angle=15)
# odm.uav3.50m.slope <- raster::terrain(odm.uav3.50m,'slope')
# odm.uav3.50m.aspect <- raster::terrain(odm.uav3.50m,'aspect')
# odm.uav3.50m.hillshade <- raster::hillShade(odm.uav3.50m.slope,odm.uav3.50m.aspect,angle=15)
# 
# odm.uav4.20m.slope <- raster::terrain(odm.uav4.20m,'slope')
# odm.uav4.20m.aspect <- raster::terrain(odm.uav4.20m,'aspect')
# odm.uav4.20m.hillshade <- raster::hillShade(odm.uav4.20m.slope,odm.uav4.20m.aspect,angle=15)
# odm.uav4.35m.slope <- raster::terrain(odm.uav4.35m,'slope')
# odm.uav4.35m.aspect <- raster::terrain(odm.uav4.35m,'aspect')
# odm.uav4.35m.hillshade <- raster::hillShade(odm.uav4.35m.slope,odm.uav4.35m.aspect,angle=15)
# odm.uav4.50m.slope <- raster::terrain(odm.uav4.50m,'slope')
# odm.uav4.50m.aspect <- raster::terrain(odm.uav4.50m,'aspect')
# odm.uav4.50m.hillshade <- raster::hillShade(odm.uav4.50m.slope,odm.uav4.50m.aspect,angle=15)
# 
# ## Load Agisoft Photoscan Pro (APP) digital terrain models
# app.uav1.20m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/AgisoftPhotoscanPro/APP_UAV1-20m.tif')
# app.uav1.35m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/AgisoftPhotoscanPro/APP_UAV1-35m.tif')
# app.uav1.50m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/AgisoftPhotoscanPro/APP_UAV1-50m.tif')
# 
# app.uav2.20m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/AgisoftPhotoscanPro/APP_UAV2-20m.tif')
# app.uav2.35m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/AgisoftPhotoscanPro/APP_UAV2-35m.tif')
# app.uav2.50m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/AgisoftPhotoscanPro/APP_UAV2-50m.tif')
# 
# app.uav3.20m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/AgisoftPhotoscanPro/APP_UAV3-20m.tif')
# app.uav3.35m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/AgisoftPhotoscanPro/APP_UAV3-35m.tif')
# app.uav3.50m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/AgisoftPhotoscanPro/APP_UAV3-50m.tif')
# 
# app.uav4.20m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/AgisoftPhotoscanPro/APP_UAV4-20m.tif')
# app.uav4.35m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/AgisoftPhotoscanPro/APP_UAV4-35m.tif')
# app.uav4.50m <- raster::raster('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/results/AgisoftPhotoscanPro/APP_UAV4-50m.tif')
# 
# ## Create hillshades for all APP terrain models
# app.uav1.20m.slope <- raster::terrain(app.uav1.20m,'slope')
# app.uav1.20m.aspect <- raster::terrain(app.uav1.20m,'aspect')
# app.uav1.20m.hillshade <- raster::hillShade(app.uav1.20m.slope,app.uav1.20m.aspect,angle=15)
# app.uav1.35m.slope <- raster::terrain(app.uav1.35m,'slope')
# app.uav1.35m.aspect <- raster::terrain(app.uav1.35m,'aspect')
# app.uav1.35m.hillshade <- raster::hillShade(app.uav1.35m.slope,app.uav1.35m.aspect,angle=15)
# app.uav1.50m.slope <- raster::terrain(app.uav1.50m,'slope')
# app.uav1.50m.aspect <- raster::terrain(app.uav1.50m,'aspect')
# app.uav1.50m.hillshade <- raster::hillShade(app.uav1.50m.slope,app.uav1.50m.aspect,angle=15)
# 
# app.uav2.20m.slope <- raster::terrain(app.uav2.20m,'slope')
# app.uav2.20m.aspect <- raster::terrain(app.uav2.20m,'aspect')
# app.uav2.20m.hillshade <- raster::hillShade(app.uav2.20m.slope,app.uav2.20m.aspect,angle=15)
# app.uav2.35m.slope <- raster::terrain(app.uav2.35m,'slope')
# app.uav2.35m.aspect <- raster::terrain(app.uav2.35m,'aspect')
# app.uav2.35m.hillshade <- raster::hillShade(app.uav2.35m.slope,app.uav2.35m.aspect,angle=15)
# app.uav2.50m.slope <- raster::terrain(app.uav2.50m,'slope')
# app.uav2.50m.aspect <- raster::terrain(app.uav2.50m,'aspect')
# app.uav2.50m.hillshade <- raster::hillShade(app.uav2.50m.slope,app.uav2.50m.aspect,angle=15)
# 
# app.uav3.20m.slope <- raster::terrain(app.uav3.20m,'slope')
# app.uav3.20m.aspect <- raster::terrain(app.uav3.20m,'aspect')
# app.uav3.20m.hillshade <- raster::hillShade(app.uav3.20m.slope,app.uav3.20m.aspect,angle=15)
# app.uav3.35m.slope <- raster::terrain(app.uav3.35m,'slope')
# app.uav3.35m.aspect <- raster::terrain(app.uav3.35m,'aspect')
# app.uav3.35m.hillshade <- raster::hillShade(app.uav3.35m.slope,app.uav3.35m.aspect,angle=15)
# app.uav3.50m.slope <- raster::terrain(app.uav3.50m,'slope')
# app.uav3.50m.aspect <- raster::terrain(app.uav3.50m,'aspect')
# app.uav3.50m.hillshade <- raster::hillShade(app.uav3.50m.slope,app.uav3.50m.aspect,angle=15)
# 
# app.uav4.20m.slope <- raster::terrain(app.uav4.20m,'slope')
# app.uav4.20m.aspect <- raster::terrain(app.uav4.20m,'aspect')
# app.uav4.20m.hillshade <- raster::hillShade(app.uav4.20m.slope,app.uav4.20m.aspect,angle=15)
# app.uav4.35m.slope <- raster::terrain(app.uav4.35m,'slope')
# app.uav4.35m.aspect <- raster::terrain(app.uav4.35m,'aspect')
# app.uav4.35m.hillshade <- raster::hillShade(app.uav4.35m.slope,app.uav4.35m.aspect,angle=15)
# app.uav4.50m.slope <- raster::terrain(app.uav4.50m,'slope')
# app.uav4.50m.aspect <- raster::terrain(app.uav4.50m,'aspect')
# app.uav4.50m.hillshade <- raster::hillShade(app.uav4.50m.slope,app.uav4.50m.aspect,angle=15)


# grDevices::pdf('/Users/kmreese/Documents/PROJECTS/CURRENT/Reese_and_Field-PLOS-ONE/output/figures/Figure_EX.pdf')
# graphics::par(mfrow=c(1,1),bg=NA,mai=c(0.10,0.10,0.10,0.10),oma=c(0.5,0.5,0.5,0.5))
# 
# graphics::plot(1,type="n",xlab='',ylab='',xlim=c(xmin(extent(dtm.difference.cropped)),xmax(extent(dtm.difference.cropped))),ylim=c(ymin(extent(dtm.difference.cropped)),ymax(extent(dtm.difference.cropped))),xaxs="i",yaxs="i",axes=F,main='')
# raster::plot(dtm.difference.cropped,col=heatcolors,legend=F,add=T)
# raster::contour(dtm.difference.cropped,nlevels=5,add=T,axes=F,legend=F,labels='')
# 
# graphics::segments(xmax(extent(dtm.difference.cropped))-16,ymin(extent(dtm.difference.cropped))+1.5,xmax(extent(dtm.difference.cropped))-6,ymin(extent(dtm.difference.cropped))+1.5,lwd=2)
# graphics::segments(xmax(extent(dtm.difference.cropped))-16,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-16,ymin(extent(dtm.difference.cropped))+1.25,lwd=2)
# graphics::segments(xmax(extent(dtm.difference.cropped))-11,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-11,ymin(extent(dtm.difference.cropped))+1.25,lwd=2)
# graphics::segments(xmax(extent(dtm.difference.cropped))-6,ymin(extent(dtm.difference.cropped))+1.75,xmax(extent(dtm.difference.cropped))-6,ymin(extent(dtm.difference.cropped))+1.25,lwd=2)
# graphics::text(xmax(extent(dtm.difference.cropped))-16,ymin(extent(dtm.difference.cropped))+1.5,'0',pos=2)
# graphics::text(xmax(extent(dtm.difference.cropped))-6,ymin(extent(dtm.difference.cropped))+1.5,'10 m',pos=4)
# 
# graphics::segments(xmax(extent(dtm.difference.cropped))-1.5,ymin(extent(dtm.difference.cropped))+1.5,xmax(extent(dtm.difference.cropped))-1.5,ymin(extent(dtm.difference.cropped))+6.5,lwd=2)
# graphics::segments(xmax(extent(dtm.difference.cropped))-1.5,ymin(extent(dtm.difference.cropped))+6.5,xmax(extent(dtm.difference.cropped))-1.25,ymin(extent(dtm.difference.cropped))+5.5,lwd=2)
# graphics::text(xmax(extent(dtm.difference.cropped))-1.5,ymin(extent(dtm.difference.cropped))+3.75,'N',cex=1)
# 
# graphics::box()
# 
# grDevices::dev.off()
