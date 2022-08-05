library(ggplot2)
library(ncdf4)
library(raster) 
library(terra)
library(stringr)
library(rgdal)
library(sp)
library(sf)
library(dplyr)
library(spData)
library(spDataLarge)
nc_file <- nc_open('MTDCA_201504_201603_36km_V5.nc')
r <- raster("MTDCA_201504_201603_36km_V5.nc",varname = "VOD")
lon <- ncvar_get(nc_file, "lon")
lat <- ncvar_get(nc_file, "lat")
t <- ncvar_get(nc_file, "time")



fillvalue <- ncatt_get(nc_file, "VOD", "_FillValue")
VODARRAY[VODARRAY == fillvalue$value] <- NA

VODARRAY <- ncvar_get(nc_file, "VOD")
VODARRAYSLICE <- VODARRAY[, , 360] 
dim(VODARRAYSLICE)

r <- raster(t(VODARRAYSLICE), xmn=min(lon), xmx=max(lon), ymn=min(lat), ymx=max(lat),crs = CRS("+proj=laea +lat_0=90 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs"))
crs(r) <- "EPSG:6931"
crs(r) <- "EPSG:2002"
crs(r,proj = TRUE)
plot(r)
projection(r)
p1 <- projectRaster(r, crs="+init=EPSG:6931")
plot(p1)
r <- projectRaster(r,crs="+init=EPSG:6931")
geo_proj = "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"
