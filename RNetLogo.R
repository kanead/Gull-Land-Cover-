library(RNetLogo)
library(RColorBrewer)
library(hexbin)

NLStart("C:/Program Files (x86)/NetLogo 5.2.1")
nl.path <- "C:/Program Files (x86)/NetLogo 5.2.1"
model.path <- "/models/Sample Models/Biology/Land Cover GIS grouped landcover.nlogo"
NLLoadModel(paste(nl.path,model.path,sep=""))


NLCommand("set N-gulls 20") ## 
NLCommand("set N-urbanfoods 0") ##
NLCommand("set N-farmfoods 0") ##
NLCommand("set N-NoOceanfoods 100") ## 



nutrients <- list()
NLCommand("setup-ireland")
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
# write.csv(nutrients, file = "farmGulls20Patch200x200.csv")
# nutrientsSub <- read.csv("randomGulls20Subset.csv", header= T, sep = ",")
rf <- colorRampPalette(rev(brewer.pal(11,'RdBu')))
r <- rf(32)



hexbinplot(ycor~xcor, data=nutrientsSub, colramp=rf, main="Herring Gulls - Random Food",xlab = "x coordinates", ylab="y coordinates", xlim = c(-22, 22))
plot(hexbin(nutrients$xcor,nutrients$ycor), legend = 0,colramp=rf, trans=log, inv=exp ,main="Herring Gulls - Urban Food",xlab = "x coordinates", ylab="y coordinates")
