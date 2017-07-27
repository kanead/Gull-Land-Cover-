#############################################################################################
##                  Code for running gull nutrient loading model                           ##
#############################################################################################

library(RNetLogo)
library(RColorBrewer)
library(hexbin)
library(gridExtra) 
library(spatstat)


NLStart("C:/Program Files (x86)/NetLogo 5.2.1")
nl.path <- "C:/Program Files (x86)/NetLogo 5.2.1"
model.path <- "/models/Sample Models/Biology/Gull Model Combined30km.nlogo"
NLLoadModel(paste(nl.path,model.path,sep=""))

NLCommand("set N-gulls 89") ## 
NLCommand("set N-urbanfoods 0") ##
NLCommand("set N-farmfoods 0") ##
NLCommand("set N-NoOceanfoods 100") ## 

nutrients <- list()
NLCommand("setup-ireland")
NLCommand("apply-food")
# run for N days:
for (day in 1:100) {
  NLCommand("repeat 68400 [go]") ## length of the day
  agent_set <- NLGetAgentSet(c("who", "xcor", "ycor"),
                             "nutrients")
  names(agent_set) <- c("who", "xcor", "ycor")
  agent_set$day = day
  nutrients[[day]] <- agent_set
}

nutrients<-do.call(rbind.data.frame, nutrients)
# setwd("C:/Users/akane/Desktop/Science/Manuscripts/Nutrients and Birds/data")
# write.csv(nutrients, file = "randomFood.csv")
# nutrientGraph <- read.csv("combinedFood.csv", header= T, sep = ",")

# the following removes nutrients that are close together which occurs at the colony
nutrientGraph<-nutrientGraph[!(abs(nutrientGraph[2] - nutrientGraph[3]) < 1),]

## Plotting Figures one at a time 
# setup the colours for the figure 
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
r <- rf(32)

hexbinplot(ycor~xcor, data=nutrientGraph, colramp=rf, main="Herring Gulls - Farm Food",xlab = "x coordinates", ylab="y coordinates", xlim = c(-10, 410))
plot(hexbin(nutrientGraph$xcor,nutrientGraph$ycor), colramp=rf, trans=log, inv=exp ,main="Herring Gulls - Farm Food",xlab = "", ylab="")

## https://baseballwithr.wordpress.com/2014/06/06/creating-hexbin-plots/
## Plotting all the Figures at once

my.colors <- function (n) {
  rev(heat.colors(n))
}

hexbinplot(ycor ~ xcor | as.factor(model), data=nutrientGraph, xbins = 20
           , panel = function(x,y, ...) {
           #  panel.baseball()
             panel.hexbinplot(x,y,  ...)
           }
           , xlim = c(-10, 410), ylim = c(-10, 410)
           , xlab = "x Coordinates"
           , ylab = "y coordinates"
           , colramp = my.colors, colorcut = seq(0, 1, length = 10)
                      )

## Nearest neighbour distance code 
meanNearNeigbDist <- function(x) {
  nndistxy<-nndist(x)
  meanNNDist<- mean(nndistxy)
  return(meanNNDist)
}

## apply the function to find mean nearest neighbour distance by model type
meannndistList<-by(nutrientGraph[, 2:3], nutrientGraph$model, meanNearNeigbDist)

## Close NetLogo 
NLQuit()

## Calculating Nutrient Loading 
Nconc <- 20.2 # Nitrogen conc. of faeces (mg g -1)
Pconc <- 18.3 # Phosphorus conc. of faeces (mg g -1)	
mass <- 0.53 # Mass of faeces in grams 
# coastal model 
no.CoastalFaeces <- 347771        
Nconc * mass * no.CoastalFaeces / 1000 # in grams
Pconc * mass * no.CoastalFaeces / 1000 # in grams
# city model 
no.CityFaeces <- 225
Nconc * mass * no.CityFaeces
Pconc * mass * no.CityFaeces


par(mfrow = c(1, 2))
# Plot gamma distribution for trip length 
g <- function(x) dgamma(x,3,0.3)
plot(g,xlim=c(0,45),main="Gamma (3, 0.3)", xlab="trip length (km)", ylab="probability density")

h <- function(x) dgamma(x,15,0.7)
plot(h,xlim=c(0,45),main="Gamma (15, 0.7)", xlab="trip length (km)", ylab="probability density")
