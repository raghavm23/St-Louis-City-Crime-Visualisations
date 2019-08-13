rm(list=ls())


library(rgdal)
library(readxl)
setwd('/Users/Raghav/Desktop/RxM/MSc DA/Semester 2/DV (H9DV)/DV Project/Data/')

nbd <- read_excel("neighbourhood codes.xlsx", col_names = TRUE)
nbd <- nbd[,-c(3)]
ucr <- read_excel("UCR Codes.xlsx", col_names = TRUE)

t1 <- read.csv("January2017.CSV", header = TRUE, sep = ",")
t2 <- read.csv("February2017.CSV", header = TRUE, sep = ",")
t3 <- read.csv("March2017.CSV", header = TRUE, sep = ",")
t4 <- read.csv("April2017.CSV", header = TRUE, sep = ",")
t5 <- read.csv("May2017.CSV", header = TRUE, sep = ",")
t6 <- read.csv("June2017.CSV", header = TRUE, sep = ",")
t7 <- read.csv("July2017.CSV", header = TRUE, sep = ",")
t8 <- read.csv("August2017.CSV", header = TRUE, sep = ",")
t9 <- read.csv("September2017.CSV", header = TRUE, sep = ",")
t10 <- read.csv("October2017.CSV", header = TRUE, sep = ",")
t11 <- read.csv("November2017.CSV", header = TRUE, sep = ",")
t12 <- read.csv("December2017.CSV", header = TRUE, sep = ",")
t13 <- read.csv("January2018.CSV", header = TRUE, sep = ",")
t14 <- read.csv("February2018.CSV", header = TRUE, sep = ",")
t15 <- read.csv("March2018.CSV", header = TRUE, sep = ",")
t16 <- read.csv("April2018.CSV", header = TRUE, sep = ",")
t17 <- read.csv("May2018.CSV", header = TRUE, sep = ",")
t18 <- read.csv("June2018.CSV", header = TRUE, sep = ",")
t19 <- read.csv("July2018.CSV", header = TRUE, sep = ",")
t20 <- read.csv("August2018.CSV", header = TRUE, sep = ",")
t21 <- read.csv("September2018.CSV", header = TRUE, sep = ",")
t22 <- read.csv("October2018.CSV", header = TRUE, sep = ",")
t23 <- read.csv("November2018.CSV", header = TRUE, sep = ",")
t24 <- read.csv("December2018.CSV", header = TRUE, sep = ",")
t25 <- read.csv("January2019.CSV", header = TRUE, sep = ",")
t26 <- read.csv("February2019.CSV", header = TRUE, sep = ",")
t27 <- read.csv("March2019.CSV", header = TRUE, sep = ",")
t28 <- read.csv("April2019.CSV", header = TRUE, sep = ",")
t29 <- read.csv("May2019.CSV", header = TRUE, sep = ",")
t30 <- read.csv("June2019.CSV", header = TRUE, sep = ",")

data_all <- rbind(t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19,t20,t21,t22,t23,t24,t25,t26,t27,t28,t29,t30)
rm(t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19,t20,t21,t22,t23,t24,t25,t26,t27,t28,t29,t30)

data_all$CrimeYear <- substr(data_all$CodedMonth,1,4)
data_all$CrimeMonth <- substr(data_all$CodedMonth,6,7)
data_all$CrimeYear <- as.numeric(data_all$CrimeYear)
data_all$CrimeMonth <- as.numeric(data_all$CrimeMonth)

months <- data.frame(month.name)
months$id <- c(01:12)

data_all <- merge(data_all, months, by.x = "CrimeMonth", by.y = "id")
data_all <- data_all[,-c(1,3)]
data_all <- data_all[,c(1,20,21,2:19)]

names(data_all)[3] <-  "CrimeMonth"

#mappings
xy <- data.frame(x=data_all$XCoord, y=data_all$YCoord)

#pj <- project(xy, proj4string, inverse=TRUE, degrees = TRUE)
#proj4string <- "+proj=utm +zone=16 +north +ellps=GRS80 +datum=NAD83 +units=ft +no_defs"

coordinates(xy) <- c('x', 'y')
proj4string(xy)=CRS("+init=esri:102696")
aaa <- spTransform(xy,CRS("+init=epsg:4326"))
final_coord <- aaa@coords
rm(aaa,xy)
final_coord <- as.data.frame(final_coord)

final_coord[data_all$XCoord == 0,] = c(0,0)

#lat lon coordinates generated
data_all <- cbind(data_all[,1:19],final_coord)

colnames(data_all)[21] <- 'lat'
colnames(data_all)[20] <- 'lon'
data_all <- data_all[,c(1:19,21,20)]

colnames(data_all)[15] <- 'Neighbourhood Number'


write.csv(data_all, file = "crimedata.csv", row.names = FALSE, col.names = TRUE)
write.csv(nbd, file = "nbd", row.names = FALSE, col.names = TRUE)
write.csv(data_all, file = "crimedata.csv", row.names = FALSE, col.names = TRUE)

#t1$Date.Crime.Coded <- as.character(t1$Date.Crime.Coded)
#t2 <- data.frame(do.call(rbind,strsplit(t1$Date.Crime.Coded, '/', fixed = TRUE)))
#colnames(t2) <- c("Month", "Day", "Year")
#t2$join <- paste(t2$Day,t2$Month,t2$Year, sep = '/')
