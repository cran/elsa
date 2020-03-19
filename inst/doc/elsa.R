## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----elsa, fig.width=5---------------------------------------------------
library(elsa)

file <- system.file('external/dem_example.grd',package='elsa') 

r <- raster(file) # reading a raster map (Dogital Elevation Model: DEM)

plot(r, main='DEM: a continuous raster map')

# ELSA statistic for the local distance of 2Km:
e <- elsa(r,d=2000,categorical=FALSE) 

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme

# Following is the map of ELSA, lower values represent higher local spatial autocorrelation
plot(e,col=cl, main='ELSA for the local distance of 2 Km')


# ELSA statistic for the local distance of 4Km:
e2 <- elsa(r,d=4000,categorical=FALSE) 

plot(e2,col=cl, main='ELSA for the local distance of 4 Km')
##################3
file <- system.file('external/lc_example.grd',package='elsa') 

lc <- raster(file)

plot(lc,main='Land cover: a categorical map')

elc <- elsa(lc, d=2000,categorical = T)

plot(elc, col=cl, main='ELSA')

## ----entrogram, fig.width=5----------------------------------------------


file <- system.file('external/dem_example.grd',package='elsa') 

r <- raster(file) # reading a raster map (Dogital Elevation Model: DEM)

plot(r, main='DEM: a continuous raster map')

en <- entrogram(r, width = 2000, cutoff = 15000)

plot(en)

#######
file <- system.file('external/lc_example.grd',package='elsa') 

lc <- raster(file)

plot(lc,main='Land cover: a categorical map')

en2 <- entrogram(lc, width = 2000, cutoff = 15000)

plot(en2)



## ----lisa, fig.width=5---------------------------------------------------

## LISAs can be used only for continuous data:
file <- system.file('external/dem_example.grd',package='elsa') 

r <- raster(file) # reading a raster map (Dogital Elevation Model: DEM)

plot(r, main='DEM: a continuous raster map')

# calculate Local Moran's I:
lisa.i <- lisa(r, d1=0,d2=2000,statistic='I')

plot(lisa.i,col=cl,main="Local Moran's I")


# calculate Local Geary's c:
lisa.c <- lisa(r, d1=0,d2=2000,statistic='c')

plot(lisa.c,col=cl,main="Local Geary's c")


# calculate Local G or G*:
lisa.g <- lisa(r, d1=0,d2=2000,statistic='g*')

plot(lisa.g,col=cl,main="Local G*")

# Calculate Variogram:

v <- Variogram(r, width = 2000, cutoff = 15000)

plot(v)

# Calculate Correlogram:
co <- correlogram(r, width = 2000, cutoff = 15000)

plot(co)

## ----global, fig.width=5-------------------------------------------------

file <- system.file('external/dem_example.grd',package='elsa')
r <- raster(file)

# Moran's I index:
moran(r, d1=0, d2=2000)

# Geary's c index:
geary(r, d1=0, d2=2000)

## ----dif2list, fig.width=5-----------------------------------------------

# imagine we have a categorical map including 4 classes (values 1:4), and the first two classes
# (i.e., 1 and 2) belong to the major class 1 (so can have legends of 11, 12, respectively), and
# the second two classes (i,e, 3 and 4) belong to the major class 2 (so can have legends of 21,
# and 22 respectively). Then we can construct the data.frame as:

d <- data.frame(g=c(1,2,3,4),leg=c(11,12,21,22))

d

# dif2list generates a list including 4 values each corresponding to each value (class in the map
#, i,e, 1:4). Each item then has a numeric vector containing a relative dissimilarity between the
# main class (the name of the item in the list) and the other classes. If one wants to change 
# the relative dissimilarity between two specific classes, then the list can easily be edited and
# used in the elsa function

dif2list(d)


