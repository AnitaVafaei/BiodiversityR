# BiodiversityR
Preserving Biodiversity: An Integrated Approach Using R and the IUCN Red List for Rhinella Granulosa species



# Biodiversity Project README

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

## Import Data

```R
lu2005 = raster("landuse_2005.tif")
lu2012 = raster("landuse_2012.tif")
lu_fut = raster("lu_fut.tif")
renelosa = readShapePoly("a3070.shp")
