### THESE ARE THE 5 R PACKAGES THAT MUST BE INSTALLED:

library(maptools)
library(raster)
library(rgdal)
library(sp)
library(Rcpp)

setwd("C:\\Users\\Asus\\Desktop\\data")

getwd()

load("redlist_practical.Rdata")


## IMPORT THE DATA
lu2005=raster("landuse_2005.tif")
plot(lu2005)
lu2012=raster("landuse_2012.tif")
plot(lu2012)
lu_fut=raster("lu_fut.tif")
plot(lu_fut)

save.image("redlist_practical.Rdata")

setwd("C:/Users/Asus/Desktop/data/species")


## SPECIES DISTRIBUTION MAPS

# readShapePoly : read a shapefile (polygon)


atefla=readShapePoly("a1209.shp")

plot(atefla)

x11(10,10)
plot(lu2012)
plot(atefla, add=T)

atefla.r=rasterize(atefla, lu2012, field=1)

plot(atefla.r)

# rasterize: transform a shape in a raster. In this case,
#create the species range in raster format
# you must specify a rastr to be used as "template"
# "field=1" means that the new raster is 1 when
#the species is present
atefla.r=rasterize(atefla, lu2012, field=1)
plot(atefla.r)

# import a table to be used as "reclass rule"
setwd("C:/Users/Asus/Desktop/data")
reclass=read.delim("reclass_atefla.txt")
reclass
# makes a reclass file, to be used for raster conversion

rcl=data.frame(reclass[,c(1,3)])  # select only columns 1 and 3 of the data frame
rcl

# and now reclassify the land use, to identify the suitable areas (across the whole Guyane)
suitability2012=reclassify(lu2012, rcl=rcl) 
plot(suitability2012)
plot(atefla, add=TRUE)


# the product with the species range is the suitable area within the species range
suit_2012_atefla=suitability2012*atefla.r

plot(suit_2012_atefla)
### calculate the suitable habitat in 2012
a=area(suit_2012_atefla)
zonal(a, suit_2012_atefla, "sum") ## calculate the area with unfavorable (0) and favorable (1) habitat


suitability2005=reclassify(lu2005, rcl=rcl)
suit_2005_atefla=suitability2005*atefla.r
### calculate the suitable habitat in 2005
a=area(suit_2005_atefla)
zonal(a, suit_2005_atefla, "sum") ## calculate the favorable area

suitability2012=reclassify(lu2012, rcl=rcl)
suit_2012_atefla=suitability2012*atefla.r
### calculate the suitable habitat in 2012
a=area(suit_2012_atefla)
zonal(a, suit_2012_atefla, "sum") ## calculate the favorable area


suitabilitylu_flut=reclassify(lu_flut, rcl=rcl)
suit_lu_flut_atefla=suitability2012*atefla.r
### calculate the suitable habitat in lu_flut
a=area(suit_lu_flut_atefla)
zonal(a, suit_lu_flut_atefla, "sum") ## calculate the favorable area

save.image("redlist_practical.Rdata")
setwd("C:/Users/Asus/Desktop/data/species")
hyps=readShapePoly("a3070.shp")
setwd("C:/Users/Asus/Desktop/data")
reclass=read.delim("reclass_hypsi.txt")
reclass

plot(hyps)

x11(10,10)
plot(lu2012)
plot(atefla, add=T)

atefla.r=rasterize(atefla, lu2012, field=1)


###########?? NEW SPECIES
Hyps=readShapePoly("a3070.shp")
hyps.r=rasterize(hyps, lu2012, field=1)
plot(hyps.r)
# import a table to be used as "reclass rule"

reclass=read.delim("reclass_SPECIESNAME.txt")
rcl=data.frame(reclass[,2:4])
suitability2012=reclassify(lu2012, rcl=rcl) 
plot(suitability2012)
# the product with the species range is the suitable area within the species range
suit_2012_SPECIESNAME=suitability2012*SPECIESNAME.r
plot(suit_2012_SPECIESNAME)
### calculate the suitable habitat in 2012
a=area(suit_2012_SPECIESNAME)
zonal(a, suit_2012_SPECIESNAME, "sum") ## calculate the area with unfavorable (0) and favorable (1) habitat
### 2005
suitability2005=reclassify(lu2005, rcl=rcl) 
suit_2005_SPECIESNAME=suitability2005*SPECIESNAME.r
plot(suit_2012_SPECIESNAME)
### calculate the suitable habitat in 2005
a=area(suit_2005_SPECIESNAME)
zonal(a, suit_2005_SPECIESNAME, "sum") ## calculate the area with unfavorable (0) and favorable (1) habitat

suitability_future=reclassify(lu.fut, rcl=rcl) 
suit_future_SPECIESNAME=suitability_future*SPECIESNAME.r
plot(suit_future_SPECIESNAME)
### calculate the suitable habitat in 2012
a=area(suit_future_SPECIESNAME)
zonal(a, suit_future_SPECIESNAME, "sum") ## calculate the area with unfavorable (0) and favorable (1) habitat
