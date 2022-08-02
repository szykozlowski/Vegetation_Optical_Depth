# Szymon Kozlowski
# 8/1/2022

# Import Readr Library
# Reader quickly loads the csv dataset
library(readr)

library(ggplot2)
library(dplyr)

# Checking if file exists
file.exists("Stem_TDR_VWC_gal.csv")

# Loading file
data <- read_csv("Stem_TDR_VWC_gal.csv")

# Storing dates (Only using 48 hours of data)
DATE1 <- as.Date("2017-05-01")
DATE2 <- as.Date("2017-05-02")

# Trimming data to only include previously stored dates
newData <- data[data$Timestamp >= DATE1 & data$Timestamp <= DATE2,]

# Using ggplot2 to graph the points for every plant, including a polynomial regression for the data
ggplot(newData, aes(x=Record, y=VWC)) + ggtitle("~48 Hours of VWC Measurements") +
  geom_point() +
  stat_smooth(method=lm, se=TRUE,formula = y ~ poly(x,40,raw=TRUE),color = "red")


# Graph for one shrub
newData1 <- newData[newData$Stem == 10,]
plot(newData1$Record,newData1$VWC)

# Removes holes from the dataset
data_complete <- newData[complete.cases(newData), ] 

# Using ggplot2 to graph the VWC of every shrub over a two day period
data_complete %>%
  ggplot(aes(x=Record, y=VWC, group=Stem, color = Stem)) +
  geom_line() 
#+ stat_smooth(method=lm, se=TRUE,formula = y ~ poly(x,5,raw=TRUE),color = "red")

# Clear packages
detach("package:datasets", unload = TRUE)

# Clear plots
dev.off()
