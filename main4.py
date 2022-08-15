import xarray as xr
import numpy as np
import matplotlib.pyplot as plt
import cartopy.crs as ccrs
import cartopy.feature as cfeature
import geopandas as gpd
from metpy.units import units

import netCDF4 as nc
from osgeo import gdal
from pyproj import CRS
from mpl_toolkits.basemap import Basemap
sst = nc.Dataset("C:\\Users\\Szymon\\Desktop\\VOD PROJECT\\MTDCA_201504_201603_36km_V5.nc")
fn = 'C:\\Users\\Szymon\\Desktop\\VOD PROJECT\\MTDCA_201504_201603_36km_V5.nc'
ds=xr.open_dataset(fn)

# print(ds.keys())


vod = ds.VOD[0,:,:]

lats = ds.variables['lat'][:]
lons = ds.variables['lon'][:]
time = ds.variables['time'][:]
data_crs = ccrs.LambertAzimuthalEqualArea(central_latitude=90.0)
x, y = ds['VOD'].metpy.coordinates('x', 'y')
data_month = ds.isel(time=200)

fig, ax = plt.subplots(1, 1, figsize=(12, 8), subplot_kw={'projection': data_crs})
ax.coastlines()


levels = np.arange(0,11)
c = ax.contourf(x, y, data_month['VOD'], cmap='jet',transform = ccrs.PlateCarree())
# ax = plt.axes(projection=ccrs.LambertAzimuthalEqualArea())
# ax.set_global()
# vod = (ds.VOD.isel(time=250))
# vod.plot.contourf(ax=ax,extent=[-9000000., 9000000., -9000000., 9000000.], transform=ccrs.PlateCarree(), cmap='gist_rainbow',origin = "lower")

# p = vod.plot(transform=ccrs.PlateCarree(),  subplot_kws={'projection': ccrs.LambertAzimuthalEqualArea(central_latitude=90.0,central_longitude=-90)})

# ax.coastlines()


plt.show()