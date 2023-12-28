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
