[![License](https://img.shields.io/badge/license-MIT%202-blue)](LICENSE)

[![](https://badgen.net/badge/MIT/License/blue?icon=instgrame)]()
[![](https://badgen.net/badge/Biodiversity/R/blue?icon=instgrame)]()
[![](https://badgen.net/badge/Rhinella/Granulosa/blue?icon=instgrame)]()

[![https://github.com/Saeidhoseinipour/NMTFcoclust](https://badgen.net/badge/NMTF/Coclust/pink?icon=instgrame)](https://github.com/Saeidhoseinipour/NMTFcoclust/tree/master/Models)
[![https://github.com/Saeidhoseinipour/NMTFcoclust](https://badgen.net/badge/Original/Paper/yellow?icon=instgrame)](https://www.sciencedirect.com/science/article/abs/pii/S095741742301182X?via%3Dihub)
[![Supplementary material](https://badgen.net/badge/Supplementary/material/orange?icon=instgrame)](https://ars.els-cdn.com/content/image/1-s2.0-S095741742301182X-mmc1.pdf)
[![https://github.com/Saeidhoseinipour/NMTFcoclust](https://badgen.net/badge/Purchase/PDF/brown?icon=instgrame)](https://www.sciencedirect.com/getaccess/pii/S095741742301182X/purchase)
[![https://github.com/Saeidhoseinipour/NMTFcoclust](https://badgen.net/badge/Presentation/Video/green?icon=instgrame)](https://www.sciencedirect.com/getaccess/pii/S095741742301182X/purchase)
[![https://github.com/Saeidhoseinipour/NMTFcoclust/blob/master/Models/NMTFcoclust_OPNMTF_alpha.py](https://badgen.net/badge/OPNMTF/Coclust/pink?icon=instgrame)](https://github.com/Saeidhoseinipour/NMTFcoclust/blob/master/Models/NMTFcoclust_OPNMTF_alpha.py)
[![https://github.com/Saeidhoseinipour/NMTFcoclust/blob/master/Models/NMTFcoclust_OPNMTF_alpha.py](https://badgen.net/badge/ACM/Digital_Library/black?icon=instgrame)](https://dl.acm.org/doi/10.1016/j.eswa.2023.120680)
[![https://github.com/Saeidhoseinipour/NMTFcoclust/blob/master/Models/NMTFcoclust_OPNMTF_alpha.py](https://badgen.net/badge/SSRN/Prereview/blue?icon=instgrame)](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4416222)
[![https://github.com/Saeidhoseinipour/NMTFcoclust/blob/master/Models/NMTFcoclust_OPNMTF_alpha.py](https://badgen.net/badge/X/Mol/blue?icon=instgrame)](https://www.x-mol.net/paper/article/1665507162148552704)
[![https://github.com/Saeidhoseinipour/NMTFcoclust/blob/master/Models/NMTFcoclust_OPNMTF_alpha.py](https://badgen.net/badge/PlumX/Metrics/green?icon=instgrame)](https://plu.mx/plum/a/?doi=10.1016/j.eswa.2023.120680&theme=plum-sciencedirect-theme&hideUsage=true)
 [![https://github.com/Saeidhoseinipour/NMTFcoclust/blob/master/Models/NMTFcoclust_OPNMTF_alpha.py](https://badgen.net/badge/Colab/WS/red?icon=instgrame)](https://colab.ws/articles/10.1016/j.eswa.2023.120680)
 [![https://github.com/Saeidhoseinipour/NMTFcoclust/blob/master/Models/NMTFcoclust_OPNMTF_alpha.py](https://badgen.net/badge/Prereview/PDF/pink?icon=instgrame)](https://github.com/Saeidhoseinipour/NMTFcoclust/blob/master/SSRN-id4416222_Prereview_OPNMTF.pdf)



# BiodiversityR
Preserving Biodiversity: An Integrated Approach Using R and the IUCN Red List for Rhinella Granulosa species


## Overview
This R code is part of a biodiversity project and aims to assess habitat suitability for different species based on land-use data. The code involves loading spatial data, rasterizing species range shapes, reclassifying land-use, and calculating suitable habitats.

## Setup
```R
setwd("C:/Users/Asus/Desktop/biodiversityproject1")
load("redlist_practical.Rdata")
library(maptools)
library(raster)
library(rgdal)
library(sp)
library(Rcpp)
```
## Data Import

```R
lu2005 = raster("landuse_2005.tif")
lu2012 = raster("landuse_2012.tif")
lu_fut = raster("lu_fut.tif")
renelosa = readShapePoly("a3070.shp")
```

## Exploring Data

```R
plot(lu2005)
plot(lu2012)
plot(lu_fut)
plot(renelosa)
plot(renelosa, add = TRUE)
```

## Rasterizing Species Range

```R
renelosa.r = rasterize(renelosa, lu2012, field = 1)
plot(renelosa.r)
```

## Reclassification

```R
reclass = read.delim("reclass_renelosa.txt")
rcl = data.frame(reclass[, c(1, 3)])
suitability2012 = reclassify(lu2012, rcl = rcl)
plot(suitability2012)
```

## Calculating Suitable Habitat

```R
suit_2012_renelosa = suitability2012 * renelosa.r
plot(suit_2012_renelosa)
a = area(suit_2012_renelosa)
zonal(a, suit_2012_renelosa, "sum")
```

## Saving Progress
```R
save.image("redlist_practical.Rdata")
```

## New Species Analysis

```R
renelosa = readShapePoly("a3070.shp")
renelosa.r = rasterize(renelosa, lu2012, field = 1)
reclass = read.delim("reclass_renelosa.txt")
rcl = data.frame(reclass[, 2:3])
suitability2012 = reclassify(lu2012, rcl = rcl)
suit_2012_SPECIESNAME = suitability2012 * SPECIESNAME.r  # replace SPECIESNAME with the actual species name
plot(suit_2012_SPECIESNAME)
a = area(suit_2012_SPECIESNAME)
zonal(a, suit_2012_SPECIESNAME, "sum")
```
Repeat the above steps for 2005 and future projections.

## Future Suitability
```R
suitability_future = reclassify(lu.fut, rcl = rcl)
suit_future_SPECIESNAME = suitability_future * SPECIESNAME.r  # replace SPECIESNAME with the actual species name
plot(suit_future_SPECIESNAME)
```

## Additional Steps

```R
save.image("redlist_practical.Rdata")
```
- This code can be used as a guide for analyzing habitat suitability for multiple species in different time periods.

- Please note that I made a few assumptions, such as the existence of a variable `SPECIESNAME.r` which needs to be replaced with the actual rasterized species range data. Make sure to replace placeholders like `SPECIESNAME` with the correct names in your data.

