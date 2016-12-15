#################################################################################################
## Visual Acuity of Gulls 
#################################################################################################
library(aspace)

AL<-c(16.542, 20.71,28.14)
VA<-10 ^ (1.42 * log10(AL) - 0.11)
VA ## Herring Gull has a visual acuity of 41.72487 cycles per metre 
## The allometry and scaling of the size of vertebrate eyes
## Howland et al. 2004
## Herring Gull weight in kg: 0.5350, axial length in mm: 16.542

# Herring Gull 
target<-0.1
distance<-250
target/distance
atan_d(target/distance) # degrees per cycle 
# To get cycles per degree, divide one by that number.
1/atan_d(target/distance) # cycles per degree


#################################################################################################
## Visual Acuity of Scavengers 
#################################################################################################
# https://petavoxel.wordpress.com/2010/02/26/cycles-per-degree/
# https://sites.oxy.edu/clint/physio/article/topographyofphotoreceptorsandretinalganglioncellsinthespottedhyena.pdf
# paper gives a measure of 8.4 cycles/deg. for a Spotted Hyena
library(aspace)
AL<-c(28.14,25.4,20.71) # Axial length Lappet, spotted hyena, AWBV
10^(1.42*log10(AL)-0.11)
target<-0.0139 # cycle width, the width of your "cycle" (one black line and the white gap).
distance<-36 # distance to target point where you'll find it impossible to see the white gap between the lines. 
target/distance
atan_d(0.0003861111) # degrees per cycle 
# To get cycles per degree, divide one by that number.
1/atan_d(0.0003861111) # cycles per degree

# Lappet-faced Vulture test
target<-2
distance<-10178
target/distance
atan_d(0.0001965023) # degrees per cycle 
# To get cycles per degree, divide one by that number.
1/atan_d(0.0001965023) # cycles per degree

# African white-backed Vulture test
target<-2
distance<-6594
target/distance
atan_d(0.000303306) # degrees per cycle 
# To get cycles per degree, divide one by that number.
1/atan_d(0.000303306) # cycles per degree

# Spotted hyena
target<-2.2
distance<-1100
target/distance
atan_d(0.002) # degrees per cycle 
# To get cycles per degree, divide one by that number.
1/atan_d(0.002) # cycles per degree

# Herring Gull 
target<-1
distance<-1000
target/distance
atan_d(0.001) # degrees per cycle 
# To get cycles per degree, divide one by that number.
1/atan_d(0.001) # cycles per degree

