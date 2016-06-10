#################################################################
## Editing Shapefiles for Nutrient Model                       ##
#################################################################
# load required libraries
library(maptools)
# for vector work; sp package will load with rgdal.
library(rgdal)  
# for metadata/attributes- vectors or rasters
library(raster) 
library(rgeos)
setwd("C:/Users/akane/Desktop/Science/Methods & Stats/GIS/RE__GIS_Data")
dir()
area <- readShapePoly("Corrine Land Use ITM Projection - Copy.shp", proj4string = CRS("+init=epsg:2157"))
radius <- readShapePoly("10km radius shape.shp",proj4string = CRS("+init=epsg:2157"))
plot(area, xlim = c(560000,600000), ylim = c(530000,580000), axes=TRUE) #, col = area$CODE_12)
plot(radius, add=T)


gullLoc<-data.frame(latitude=584503.3,longitude = 560164.5)

proj4string( gullLoc ) <- CRS( "+init=epsg:2157" )


mydf <- data.frame(longitude =-8.22465133, latitude=51.7935452)
xy <- mydf[,c(1,2)]
spdf <- SpatialPointsDataFrame(coords = xy, data = mydf, proj4string = CRS("+init=epsg:2157"))
points(spdf, bg='tomato2', pch=21, cex=3)



gullLocSp <- SpatialPolygonsDataFrame(gullLoc,proj4string = CRS("+init=epsg:2157"))
points(gullLoc, bg='tomato2', pch=21, cex=3)

gullLocSp <- spTransform( gullLoc, CRS( "+init=epsg:2157" ) ) 

coordinates( gullLoc ) <- c( gullLoc[,1],gullLoc[,2])


gBuffer(gullLoc)

pointsGull <- SpatialPoints(cbind(584503.3, 560164.5))
pbuf <- gBuffer(pointsGull, widt=20)
buf <- mask(raster, pbuf)
buffer <- trim(buf, pad=2)




summary(area)
levels(area$CODE_12)

library(marmap)

# load and plot a bathymetry
data(florida)
plot(florida, lwd = 0.2)
plot(florida, n = 1, lwd = 0.7, add = TRUE)

# add a point around which a buffer will be created
loc <- data.frame(-80, 26)
points(loc, pch = 19, col = "red")

# compute and print buffer
buf <- create.buffer(florida, loc, radius=1.5)
buf

# highlight isobath with the buffer and add outline
plot(buf, outline=FALSE, n = 10, col = 2, lwd=.4)
plot(buf, lwd = 0.7, fg = 2)
