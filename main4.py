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


# print(ds)
vod = ds.VOD[0,:,:]

lats = ds.variables['lat'][:]
lons = ds.variables['lon'][:]
time = ds.variables['time'][:]
data_crs = ccrs.LambertAzimuthalEqualArea(central_latitude=90.0,central_longitude=-90)

x, y = ds['VOD'].metpy.coordinates('x', 'y')
data_month = ds.isel(time=300)
data_month2 = ds.isel(time=301)
data_month3 = ds.isel(time=302)
data_month4 = ds.isel(time=303)

monthly_data = ds.resample(time = '1D').mean(skipna= True)
monthly_data2 = ds.resample(time = '1W').mean(skipna= True)
monthly_data3 = ds.resample(time = '1M').mean(skipna= True)
monthly_data4 = ds.resample(time = '1Y').mean(skipna= True)


monthly_data = monthly_data.isel(time=1)
monthly_data2 = monthly_data2.isel(time=1)
monthly_data3 = monthly_data3.isel(time=1)
monthly_data4 = monthly_data4.isel(time=1)
# print(data_month['VOD'])

fig, ax = plt.subplots(2, 2, figsize=(24, 16), subplot_kw={'projection': data_crs})
ax[0][0].set_global()
ax[0][0].coastlines()
ax[0][1].coastlines()
ax[1][0].coastlines()
ax[1][1].coastlines()

ax[0][0].title.set_text('One Day')
ax[0][1].title.set_text('One Week')
ax[1][0].title.set_text('One Month')
ax[1][1].title.set_text('One Year')

levels = np.arange(0,11)
c = ax[0][0].contourf(x, y, monthly_data['VOD'], cmap='jet',transform = ccrs.PlateCarree())
c = ax[0][1].contourf(x, y, monthly_data2['VOD'], cmap='jet',transform = ccrs.PlateCarree())
c = ax[1][0].contourf(x, y, monthly_data3['VOD'], cmap='jet',transform = ccrs.PlateCarree())
c = ax[1][1].contourf(x, y, monthly_data4['VOD'], cmap='jet',transform =ccrs.PlateCarree() )

# ax = plt.axes(projection=ccrs.LambertAzimuthalEqualArea())
# ax.set_global()
# vod = (ds.VOD.isel(time=250))
# vod.plot.contourf(ax=ax,extent=[-9000000., 9000000., -9000000., 9000000.], transform=ccrs.PlateCarree(), cmap='gist_rainbow',origin = "lower")

# p = vod.plot(transform=ccrs.PlateCarree(),  subplot_kws={'projection': ccrs.LambertAzimuthalEqualArea(central_latitude=90.0,central_longitude=-90)})

# ax.coastlines()

fig.colorbar(c,ax=ax)
plt.show()