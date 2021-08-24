# The FOSS UAV Protocol
A companion document for **A Methodological Framework for Free and Open-source UAV-based Archaeological Research** published in *Advances in Archaeological Practice* and written by [Kelsey M. Reese and Sean Field (2021)](https://www.cambridge.org/core/journals/advances-in-archaeological-practice/latest-issue).

*************************************************************
# Pre-field Process

## Installing Software and Defining an Area of Interest

Each line presented below is a separate line of code that should be run individually in Terminal. Wait for each process to complete before starting the next. This process assumes that none of the required frameworks, dependencies, or software needed for this protocol have been previously installed on your project computer. If you do not wish to re-install something that you already have on your computer, you can either update it to the most recent version as shown in the 'Updating' section, or skip that portion of the process.

Please note that the entirety of the following code is intended to run within Terminal. Both bash and R commands can be run from the Terminal command line and the process is shown assuming you are using only one interface. Using other user interfaces such as R Studio is certainly reasonable, but that process is not explicitly described here.

An example dataset is provided, below, to follow along with the provided example code. Please note that the download is approximately 850 mb, so it may take a few minutes depending on your download speeds.

The following installation and analysis was tested on a clean installation of MacOS Big Sur 11.5.1 on August 1, 2021 using the following versions:  
* Docker 20.10.7
* Docker Machine 0.16.2
* Git 2.32.0_1
* Python 3.9.6
* gdal 3.3.1_2
* proj 8.1.0
* libgit2 1.1.1
* udunits 2.2.27.6_1
* R 4.1.0

### Installation

Open the Terminal application on your MacOS device (Applications > Utilities > Terminal).

Install Homebrew (for more information: https://www.brew.sh). Homebrew is a file manager for MacOS that will install and organize all frameworks and software in a single place on your computer, making it easier to update, replace, and remove programs as needed.

To install Homebrew, enter the following line in Terminal and press 'Return.' Follow all prompts to enter your password. And wait for the process to complete.
```{r, engine = 'bash', eval = FALSE}
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install Docker and then Docker Machine (required for OpenDroneMap).
```{r, engine = 'bash', eval = FALSE}
brew install docker docker-machine
```

Install Git, Python, and GDAL and other dependencies. If you are using MacOS Catalina, installing only ```git```, ```python```, and ```gdal``` is sufficient.
```{r, engine = 'bash', eval = FALSE}
brew install git python gdal proj libgit2 udunits
```

Install OpenDroneMap (although this tool is free and open-source, please consider contributing to the creators at https://www.opendronemap.org).
```{r, engine = 'bash', eval = FALSE}
git clone https://github.com/OpenDroneMap/OpenDroneMap.git
```

Install R.
```{r, engine = 'bash', eval = FALSE}
brew install r
```

Open R from within the Terminal interface.
```{r, engine = 'bash', eval = FALSE}
R
```

Define package repository.
```{r, eval = FALSE}
repository  <-  base::getOption('repos')
repository['CRAN']  <-  'http://cran.us.r-project.org'
base::options(repos=repository)
```

Install all required packages for the project.
```{r, eval = FALSE}
utils::install.packages(c('devtools','sp','rgdal','raster','rgeos','FedData'))
```

Leave the R environment within Terminal.
```{r, eval = FALSE}
base::quit()
```

The software required to run the FOSS UAV Protocol is now installed. If you wish to update any of these installations in the future, please refer to the following section. Otherwise, move to 'Defining an Area of Interest.'

### Updating

The most up-to-date versions of each software package can be installed (if available) each time the FOSS UAV Protocol is run to ensure compatibility with the newest technology and access to the most advanced features.

Update each software and framework with Homebrew.
```{r, engine = 'bash', eval = FALSE}
brew upgrade docker docker-machine git python gdal proj libgit2 udunits r
```

Update OpenDroneMap with Github.
```{r, engine = 'bash', eval = FALSE}
git clone https://github.com/OpenDroneMap/OpenDroneMap.git
```

Open R from within the Terminal interface.
```{r, engine = 'bash', eval = FALSE}
R
```

Define package repository.
```{r, eval = FALSE}
repository  <-  base::getOption('repos')
repository['CRAN']  <-  'http://cran.us.r-project.org'
base::options(repos=repository)
```

Check required packages for updates.
```{r, eval = FALSE}
utils::update.packages(c('sp','rgdal','raster','rgeos','FedData'),ask=F)
```

Leave the R environment within Terminal.
```{r, eval = FALSE}
base::quit()
```

## Defining an Area of Interest
Create a working directory for the project, navigate to that directory, and download example-data for the project. Please not that the download is approximately 850 mb and may take several minutes depending on your download speeds.
```{r, engine = 'bash', eval = FALSE}
mkdir -p Documents/FOSS-UAV-Protocol
cd ~/Documents/FOSS-UAV-Protocol/
git clone https://github.com/kmreese-io/Reese_and_Field_2021-AAP
```

Open R within Terminal.
```{r, engine = 'bash', eval = FALSE}
R
```

Call all required packages for the project.
```{r, eval = FALSE}
library('sp');library('rgdal');library('raster');library('rgeos');library('FedData')
```

Set the working directory for your project.
```{r, eval = FALSE}
base::setwd('./Documents/FOSS-UAV-Protocol/Reese_and_Field_2021-AAP/example-data/')
```

Define the ```master.projection```. The ```master.projection``` will be unique to your project, so please fill in the correct projection system, if necessary.
```{r, eval = FALSE}
master.projection <- sp::CRS('+proj=utm +datum=NAD83 +zone=12')
```

Load the shapefile of the study area from the example-data into the R environment within Terminal and define the projection system.
```{r, eval = FALSE}
study.area <- rgdal::readOGR('./',layer='study_area_shapefile')
raster::projection(study.area) <- master.projection
```

## Defining Flight Parameters and Polygons

Define a conservative estimate of the UAV battery life you have available to you. If you are using DroneDeploy in the field, the UAV will automatically return to its launch location when the battery is running low, so this number can be flexible.
```{r, eval = FALSE}
flight.time.minutes <- 15
```

Calculate the grid of imagery collection tiles.
```{r, eval = FALSE}
hectares.per.battery <- flight.time.minutes / 2.25
flight.area <- c(sqrt(hectares.per.battery*10000),sqrt(hectares.per.battery*10000))
```

Define UAV flight polygons to use in DroneDeploy.
```{r, eval = FALSE}
grid.points <- sp::makegrid(study.area,cellsize=flight.area)
spatial.grid <- sp::SpatialPoints(grid.points,proj4string=master.projection)
spatial.grid.survey <- sp::SpatialPixels(spatial.grid[study.area,])
survey.polygons <- methods::as(spatial.grid.survey,'SpatialPolygons')
IDs <- base::sapply(slot(survey.polygons,'polygons'), function(x) slot(x,'ID'))
df <- base::data.frame(rep(0,length(IDs)),row.names=IDs)
UAV.polygons <- sp::SpatialPolygonsDataFrame(survey.polygons,df)
```

## Calculating Landcover Contexts

Import National Land Cover Database (provided in the example-data, otherwise please refer to https://www.mrlc.gov/viewer/ for data downloads), crop by extent of the study area and transform to ```master.projection```.
```{r, eval = FALSE}
nlcd.2019 <- raster::raster('./landcover/NLCD_gAI1d9GkPzPC2lNKnF2o/NLCD_2019_Land_Cover_L48_20210604_gAI1d9GkPzPC2lNKnF2o.tiff')
study.area.reprojected <- sp::spTransform(study.area,nlcd.2019@crs)
landcover <- raster::crop(nlcd.2019,polygon_from_extent(study.area.reprojected))
landcover <- raster::projectRaster(landcover,crs=master.projection,method='ngb')
```

Define values for landcover within your study area. Example values are shown from the Mesa Verde North Escarpment, ranking types of landcover within the study area from most- to least-barren. A key for each landcover value is provided in the downloaded file and named 'NLCD Land Cover.gif.'

Values: 31 (Barren Land); 52 (Shrub/Scrub); 71 (Grassland/Herbaceous); 81 (Pasture/Hay)
```{r, eval = FALSE}
limiting.landcover <- landcover
limiting.landcover[limiting.landcover == 31] <- 4
limiting.landcover[limiting.landcover == 52] <- 3
limiting.landcover[limiting.landcover == 71] <- 2
limiting.landcover[limiting.landcover == 81] <- 1
limiting.landcover[limiting.landcover > 4] <- 0
```

Calculate greatest landcover values per ```UAV.polygons```.
```{r, eval = FALSE}
survey.square.values <- raster::extract(limiting.landcover,UAV.polygons)
survey.square.sum <- base::lapply(1:length(survey.square.values),FUN=function(x,...) {sum(survey.square.values[[x]])} )
```

Add landcover values to ```UAV.polygons``` and remove any areas with unassigned landcover values.
```{r, eval = FALSE}
UAV.polygons$landcover.value <- base::unlist(survey.square.sum)
UAV.polygons <- UAV.polygons[which(!is.na(UAV.polygons$landcover.value)),]
```

Define quartiles in dataset for light, medium, heavy, and extreme landcover tiles
```{r, eval = FALSE}
quartiles <- seq(min(UAV.polygons$landcover.value),max(UAV.polygons$landcover.value),(max(UAV.polygons$landcover.value)-min(UAV.polygons$landcover.value))/3)
```

## Creating Flight Polygons

Write all polygons with assigned landcover values to a shapefile to help plan what are likely to be the most productive flights. Opening this layer in QGIS, for example, and changing the colorscale of each polygon by value is a great way to quickly assess how effective the FOSS UAV Protocol may be in a particular area.
```{r, eval = FALSE}
rgdal::writeOGR(UAV.polygons,'./',layer='UAV_survey_polygons',driver='ESRI Shapefile')
```

Polygons that look promising for UAV-based image collection can then be saved and exported to the controller in many different ways. The examples below provide a way to export polygons by landcover classification, by specific polygon, and by coordinates.

### Example: Exporting polygons based on landcover classification

Light landcover contexts.
```{r, eval = FALSE}
landcover.light <- UAV.polygons[which(UAV.polygons$landcover.value > quartiles[3] & UAV.polygons$landcover.value <= quartiles[4]),]
rgdal::writeOGR(landcover.light,'./',layer='landcover_light',driver='ESRI Shapefile')
```

Medium landcover contexts.
```{r, eval = FALSE}
landcover.medium <- UAV.polygons[which(UAV.polygons$landcover.value > quartiles[2] & UAV.polygons$landcover.value <= quartiles[3]),]
rgdal::writeOGR(landcover.medium,'./',layer='landcover_medium',driver='ESRI Shapefile')
```

Heavy landcover contexts.
```{r, eval = FALSE}
landcover.heavy <- UAV.polygons[which(UAV.polygons$landcover.value > quartiles[1] & UAV.polygons$landcover.value <= quartiles[2]),]
rgdal::writeOGR(landcover.heavy,'./',layer='landcover_heavy',driver='ESRI Shapefile')
```

Extreme landcover contexts.
```{r, eval = FALSE}
landcover.extreme <- UAV.polygons[which(UAV.polygons$landcover.value <= quartiles[1]),]
rgdal::writeOGR(landcover.extreme,'./',layer='landcover_extreme',driver='ESRI Shapefile')
```

### Example: Exporting a specific polygon

Define the index of the specific polygon you would like to export, and export that one polygon. The code below is using the example of '225', but that number should be replaced with the desired index of the polygon you would like to export. Identifying the polygon index can easily be done through QGIS, for example, by selecting the 'Info' option in the menu bar and clicking on the desired polygon.
```{r, eval = FALSE}
index <- 225
rgdal::writeOGR(UAV.polygons[index,],'./',layer='UAV_survey_polygons',driver='ESRI Shapefile')
```

### Example: Exporting polygons by site coordinates

Enter in the coordinates of your desired flight (especially helpful if you are interested in flying a specific site or area of interest), then identify the polygon with those coordinates and export a shapefile. The example-data includes the polygon exported using this example.
```{r, eval = FALSE}
example.coordinates <- as.data.frame(NA,nrow=1,ncol=2)
coordinates(example.coordinates) <- cbind(716238.6,4129435.2)
projection(example.coordinates) <- master.projection
polygon.coordinates <- UAV.polygons[example.coordinates,]
rgdal::writeOGR(polygon.coordinates,'./',layer='polygon_coordinates',driver='ESRI Shapefile')
```

## Before Going Into the Field

Download a photo collection application to your UAV remote that is compatible with the available UAV. Potential applications include: DroneDeploy (https://support.dronedeploy.com/docs/recommended-and-supported-drones); Pix4D (https://support.pix4d.com/hc/en-us/articles/203991609-Supported-drones-cameras-and-controllers); Copterus (https://www.copterus.app). NOTE: Pix4D does not provide equal support for iOS and Android devices on all of their compatible UAVs, nor is flight-planning supported on iOS devices.

Other applications are available, but please check:

* The photo collection application is compatible with the UAV and iOS or Android remote and allows for pre-flight planning by importing a polygon of the flight area
* The application allows for the image files to be downloaded to your computer after data collection is completed in the field

Import each flight polygon to the remote - check specific instructions for your device to complete this step.

Import each polygon to the application and set up desired flight parameters. The example shown for the FOSS UAV Protocol uses default flight settings in the DroneDeploy application.

Please refer to the application's website for specific instructions for its use in the field.

*************************************************************
# In-field Process

## Collecting Images

Arrive at the selected polygon in the field and move to the highest elevation within the polygon.

Set up the UAV for flight, start DroneDeploy, and launch the UAV via the desired DroneDeploy flight plan.

Wait for each image collection process to finish. The UAV will automatically return to its launch position when it is either getting too low on battery or when it is done collecting all images in the flight plan.

#### Pro Tip
At the beginning of each flight DroneDeploy will take one image, facing forward, before leaving the ground. To make it easier to identify which images belong to which flight, especially when making multiple flights per day, it is handy to have a small dry-erase board on-hand to write identifying information about the flight, which can be easily recognized later to make sure all images for a collection area are later used in the terrain model.

*************************************************************
# Post-field Process

## Producing a Digital Terrain Model

Open Terminal and create a folder within your project directory called 'images'.
```{r, engine = 'bash', eval = FALSE}
cd ~/Documents/FOSS-UAV-Protocol/Reese_and_Field_2021-AAP/example-data
mkdir images
```

Place orthophoto images of one flight into the 'images' folder within project path.

Start Docker within Terminal.
```{r, engine = 'bash', eval = FALSE}
open -a docker
```

Once Docker is running, go to Preferences > Advanced and increase the CPUs, Memory, and Swap.

Run OpenDroneMap to produce the highest-resolution terrain model possible based on the input images.
```{r, engine = 'bash', eval = FALSE}
docker run -ti --rm -v ~/Documents/FOSS-UAV-Protocol:/datasets/code opendronemap/odm --project-path /datasets --dtm --dem-resolution 0.0001 --time --skip-3dmodel
```

### Results
The final Digital Terrain Model (DTM) will be available in '~/Documents/FOSS-UAV-Protocol/odm_dem/dtm.tif'

Please note that the code provided uses mostly default parameters, but OpenDroneMap offers a multitude of runtime options: https://github.com/OpenDroneMap/ODM/wiki/Run-Time-Parameters


*************************************************************
