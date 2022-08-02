# Szymon Kozlowski
# 8/1/2022

library(readr)
library(ggplot2)
library(dplyr)

# Gets the working directory, helpful when working with files
getwd()

# Command makes sure that the file exists
file.exists("Stem_TDR_VWC_gal.csv")

# Sent the data from the CSV file for shrubs in a specific region into a variable
data2 <- read_csv("Stem_TDR_VWC_gal.csv")

# Storing dates in variables.
DATE1 <- as.Date("2017-05-01")
DATE2 <- as.Date("2017-09-01")
newData <- data2[data2$Timestamp > DATE1 & data2$Timestamp < DATE2,]
plot(newData$Timestamp,newData$VWC)

# Averaging the data for every plant, every day of the year
newData4 <- aggregate(VWC ~ Timestamp, newData, mean)
plot(newData4$Timestamp,newData4$VWC)

# Using ggplot2 in order to create a smooth line with error bars.
newData4 %>%
ggplot(aes(x=Timestamp, y=VWC)) + ggtitle("Water Moisture Content of Shrubs at Galbraith Lake, Alaska")  + stat_smooth(method="loess", span=0.1, se=TRUE,  alpha=0.3) + theme_bw()

# Clear packages
detach("package:datasets", unload = TRUE)

# Clear plots
dev.off()



