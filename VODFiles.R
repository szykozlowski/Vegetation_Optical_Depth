# Szymon Kozlowski

# 8/3/2022

# VOD file stuff


# Gets working directory
getwd()


# Utilized libraries
library(ggplot2)
library(ncdf4)
library(raster) 

# Loads the NCDF file into the nc_file variable
nc_file <- nc_open('MTDCA_201504_201603_36km_V5.nc')

# Prints the nc_file, which has some useful data on the variables it contains
print(nc_file)

# Storing the longitude/latitude arrays into variables
lon <- ncvar_get(nc_file, "lon")
lat <- ncvar_get(nc_file, "lat")

# Loading the VOD Array, which is a 3D array containing the latitude, longitude, and time into a variable
VODARRAY <- ncvar_get(nc_file, "VOD")

# Honestly no clue what this does, but the code doesn't work without it
fillvalue <- ncatt_get(nc_file, "VOD", "_FillValue")
VODARRAY[VODARRAY == fillvalue$value] <- NA

# Gets a slice of the data at a certain time, (days since 04/2015 I think??)
VODARRAYSLICE <- VODARRAY[, , 365] 

# Creates a raster using the WGS85 map projection
r <- raster(t(VODARRAYSLICE), xmn=min(lon), xmx=max(lon), ymn=min(lat), ymx=max(lat), crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))

# Plots the raster
plot(r)

# Clear packages
detach("package:datasets", unload = TRUE)

# Clear plots
dev.off()


