# Szymon Kozlowski

# 8/05/2022


# Most of these are useless
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

# Open the netCDF using the ncdf4 package 
nc_file <- nc_open('MTDCA_201504_201603_36km_V5.nc')

# This line doesn't work
r <- raster("MTDCA_201504_201603_36km_V5.nc",varname = "VOD")

# Extracting the longitude/latitude/time variables from the netCDF
lon <- ncvar_get(nc_file, "lon")
lat <- ncvar_get(nc_file, "lat")
t <- ncvar_get(nc_file, "time")

# Turning fill values into 'NA'
fillvalue <- ncatt_get(nc_file, "VOD", "_FillValue")
VODARRAY[VODARRAY == fillvalue$value] <- NA

# Getting the 3d array of time/lon/lat into a variable
VODARRAY <- ncvar_get(nc_file, "VOD")

# Getting a specific day of the array
VODARRAYSLICE <- VODARRAY[, , 360] 
dim(VODARRAYSLICE)

# Throwing a day of lon/lat data into a raster, and attempting to project it
r <- raster(t(VODARRAYSLICE), xmn=min(lon), xmx=max(lon), ymn=min(lat), ymx=max(lat),crs = CRS("+proj=laea +lat_0=90 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs"))

# Futile attempts of getting the projection to work
crs(r) <- "EPSG:6931"
crs(r,proj = TRUE)
projection(r)
p1 <- projectRaster(r, crs="+init=EPSG:6931")
plot(p1)
r <- projectRaster(r,crs="+init=EPSG:6931")
geo_proj = "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"

# Plotting the raster
plot(r)

# Clear packages
detach("package:datasets", unload = TRUE)

# Clear plots
dev.off()
