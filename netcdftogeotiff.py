# Szymon Kozlowski
# 8/23/2022

# Import packages
# For some reason, rasterio only works if you import gdal from osgeo

from osgeo import gdal
import xarray as xr
import rasterio
from rasterio.plot import show
import rioxarray as rio

# Open the netcdf you want to convert
nc_file = xr.open_dataset('C:\\Users\\Szymon\\Desktop\\VOD PROJECT\\MTDCA_201504_201603_36km_V5.nc')

# The netcdf is now a raster in the variable vod
VOD = nc_file["VOD"]

# Depending on what you want to convert, only uncomment one of the next 2 lines of code

# If your netcdf file has a time variable, and you want one specific day,
# uncomment the next line and set the time to what you want

# VOD = VOD.isel(time = 1) # LINE TO UNCOMMENT!!!!!

# If your netcdf file has a time variable, and you want to get an average over a
# specific time period, uncomment the next line and set the time

VOD = VOD.resample(time = '1Y').mean(skipna= True) # LINE TO UNCOMMENT!!!!!

# If your netcdf does not have a time variable, leave both of the previous lines of code commented

# Setting geotiff x/y to the latitude/longitude
VOD = VOD.rio.set_spatial_dims(x_dim='lon', y_dim='lat')

# Adding the ease 2.0 projection
VOD.rio.write_crs("epsg:6933", inplace=True)

# Writing the raster to a file, change the name/directory if you would like
VOD.rio.to_raster(r"netcdftest.tiff")

# Opens the geotiff
image = rasterio.open("netcdftest.tiff")

# Plots the geotiff
show(image)
