### THESE ARE THE 5 R PACKAGES THAT MUST BE INSTALLED:

library(maptools)
library(raster)
library(rgdal)
library(sp)
library(Rcpp)

setwd("C:/Lyrgus/D O C/lezioni/biodiversity dynamics/redlist_data/data")
setwd("C:\Lyrgus\D O C\lezioni\biodiversity dynamics\redlist_data\data")  ## WITH MAC...
setwd("C:/Users/Asus/Desktop/biodiversityproject1")
load("redlist_practical.Rdata")


## IMPORT THE DATA
lu2005=raster("landuse_2005.tif")
plot(lu2005)
lu2012=raster("landuse_2012.tif")
lu_fut=raster("lu_fut.tif")
plot(lu_fut)

save.image("redlist_practical.Rdata")

setwd("C:/Users/Asus/Desktop/biodiversityproject1/species")



### SPECIES DISTRIBUTION MAPS

# readShapePoly : read a shapefile (polygon)


renelosa=readShapePoly("a3070.shp")

plot(renelosa)

plot(lu2012)
plot(renelosa, add=T)

renelosa.r=rasterize(renelosa, lu2012, field=1)

plot(renelosa.r)

# rasterize: transform a shape in a raster. In this case,
#create the species range in raster format
# you must specify a rastr to be used as "template"
# "field=1" means that the new raster is 1 when
#the species is present
renelosa.r=rasterize(renelosa, lu2012, field=1)
plot(renelosa.r)

# import a table to be used as "reclass rule"
reclass=read.delim("reclass_renelosa.txt")
reclass
# makes a reclass file, to be used for raster conversion

rcl=data.frame(reclass[,c(1,3)])  # select only columns 1 and 3 of the data frame
rcl

# and now reclassify the land use, to identify the suitable areas (across the whole Guyane)
suitability2012=reclassify(lu2012, rcl=rcl) 
plot(suitability2012)
plot(renelosa, add=TRUE)


# the product with the species range is the suitable area within the species range
suit_2012_renelosa=suitability2012*renelosa.r

plot(suit_2012_renelosa)
### calculate the suitable habitat in 2012
a=area(suit_2012_renelosa)
zonal(a, suit_2012_renelosa, "sum") ## calculate the area with unfavorable (0) and favorable (1) habitat



suitability2005=reclassify(lu2005, rcl=rcl)
suit_2005_renelosa=suitability2005*renelosa.r
### calculate the suitable habitat in 2005
a=area(suit_2005_renelosa)
zonal(a, suit_2005_renelosa, "sum") ## calculate the favorable area


save.image("redlist_practical.Rdata")


###########?? NEW SPECIES
renelosa=readShapePoly("a3070.shp")
renelosa.r=rasterize(renelosa, lu2012, field=1)
plot(renelosa.r)
# import a table to be used as "reclass rule"
reclass=read.delim("reclass_renelosa.txt")
rcl=data.frame(reclass[,2:3])
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
