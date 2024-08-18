Methane and nitrous oxide concentrations at Baring Head

# Statistics NZ Tatauranga Aotearoa https://www.stats.govt.nz/indicators/greenhouse-gas-concentrations
# link to zip file 17/08/2024
download.file("https://www.stats.govt.nz/assets/Uploads/Environment-indicators-2023/Greenhouse-gas-concentrations/Download-data/greenhouse-gas-concentrations-data-to-2022.zip","greenhouse-gas-concentrations-data-to-2022.zip")

# unzip downloaded zip file
unzip("greenhouse-gas-concentrations-data-to-2022.zip")

# 4 unzipped files, I want 'greenhouse-gas-concentrations-monthly-2022.csv'

# read in the data file
ghgs <- read.csv("greenhouse-gas-concentrations-monthly-2022.csv")

str(ghgs) 
'data.frame':	5276 obs. of  6 variables:
 $ year                        : int  1972 1972 1972 1972 1973 1973 1973 1973 1973 1973 ...
 $ month                       : int  12 12 12 12 1 1 1 1 2 2 ...
 $ variable                    : chr  "carbon_dioxide" "carbon_dioxide" "carbon_dioxide" "carbon_dioxide" ...
 $ parameter                   : chr  "mean" "mean_fitted" "seasonal_adjusted_mean" "trend" ...
 $ greenhouse_gas_concentration: num  326 326 326 327 326 ...
 $ unit                        : chr  "ppm" "ppm" "ppm" "ppm" ...

table(ghgs[["variable"]]) 
carbon_dioxide        methane  nitrous_oxide 
          2404           1604           1268  
table(ghgs[["parameter"]]) 

                  mean            mean_fitted seasonal_adjusted_mean 
                  1319                   1319                   1319 
                 trend 
                  1319
# select only methane records
methane <- ghgs[ghgs[["variable"]]=="methane",]
str(methane) 
'data.frame':	1604 obs. of  6 variables:
 $ year                        : int  1989 1989 1989 1989 1989 1989 1989 1989 1989 1989 ...
 $ month                       : int  8 8 8 8 9 9 9 9 10 10 ...
 $ variable                    : chr  "methane" "methane" "methane" "methane" ...
 $ parameter                   : chr  "mean" "mean_fitted" "seasonal_adjusted_mean" "trend" ...
 $ greenhouse_gas_concentration: num  1659 1659 1650 1654 1662 ...
 $ unit                        : chr  "ppb" "ppb" "ppb" "ppb" ... 
meanfitmethane <- methane[methane[["parameter"]]=="mean_fitted",] 
str(meanfitmethane) 
'data.frame':	401 obs. of  6 variables:
 $ year                        : int  1989 1989 1989 1989 1989 1990 1990 1990 1990 1990 ...
 $ month                       : int  8 9 10 11 12 1 2 3 4 5 ...
 $ variable                    : chr  "methane" "methane" "methane" "methane" ...
 $ parameter                   : chr  "mean_fitted" "mean_fitted" "mean_fitted" "mean_fitted" ...
 $ greenhouse_gas_concentration: num  1659 1662 1668 1670 1664 ...
 $ unit                        : chr  "ppb" "ppb" "ppb" "ppb" ...

# add date column 
meanfitmethane[["date"]] = seq(as.Date('1989-08-31'), by = 'months', length = nrow(meanfitmethane)) 
str(meanfitmethane) 
'data.frame':	401 obs. of  7 variables:
 $ year                        : int  1989 1989 1989 1989 1989 1990 1990 1990 1990 1990 ...
 $ month                       : int  8 9 10 11 12 1 2 3 4 5 ...
 $ variable                    : chr  "methane" "methane" "methane" "methane" ...
 $ parameter                   : chr  "mean_fitted" "mean_fitted" "mean_fitted" "mean_fitted" ...
 $ greenhouse_gas_concentration: num  1659 1662 1668 1670 1664 ...
 $ unit                        : chr  "ppb" "ppb" "ppb" "ppb" ...
 $ date                        : Date, format: "1989-08-31" "1989-10-01" ...

tail(meanfitmethane) 
     year month variable   parameter greenhouse_gas_concentration unit
3986 2022     7  methane mean_fitted                       1873.8  ppb
3990 2022     8  methane mean_fitted                       1880.0  ppb
3994 2022     9  methane mean_fitted                       1880.0  ppb
3998 2022    10  methane mean_fitted                       1881.4  ppb
4002 2022    11  methane mean_fitted                       1874.2  ppb
4006 2022    12  methane mean_fitted                       1870.1  ppb
           date
3986 2022-07-31
3990 2022-08-31
3994 2022-10-01
3998 2022-10-31
4002 2022-12-01
4006 2022-12-31
# create a time series object for average monthly prices
weekts <- ts(weeklypricefilleddataframe[["price"]],frequency=52,start = c(2010,19))

svg(filename="NZmethane-2019-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
#png("NZmethane-560by420.png", bg="white", width=560, height=420,pointsize = 14)
par(mar=c(2.7,3.3,1,1)+0.1)
plot(meanfitmethane[["date"]],meanfitmethane[["greenhouse_gas_concentration"]],tck=0.01,ylab=NA,axes=T,ann=T, type="l",lwd=2,las=1,col="#7570B3")
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
box(lwd=1)
mtext(side=1,line=-1.4,cex=1,"Data: Stats NZ Tatauranga Aotearoa \nhttps://www.stats.govt.nz/indicators/greenhouse-gas-concentrations")
mtext(side=3,cex=1.3, line=-1.8,expression(paste("Baring Head methane concentrations 1989 to 2022")) )
mtext(side=2,cex=1.1, line=-1.5,expression(paste("Parts per billion")))
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()

library(ggplot2) 

svg(filename ="BHD-methane-1989-2023-Ggplot.svg", width = 8, height = 6, pointsize = 12, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))  
ggplot(methane, aes(x = year, y = greenhouse_gas_concentration, group= parameter)) +  
geom_line(linewidth=1, aes (colour = parameter)) + 
theme_bw(base_size = 14) +
theme(legend.position = c(0.75,0.82),legend.title = element_text(NULL), plot.caption = element_text(hjust =.5), plot.title = element_text(size = 20,hjust =0.5)) +
labs(title="New Zealand methane emissions 1990 to 2023", caption="Data: Ministry of Business Innovation & Employment\nhttps://www.mbie.govt.nz/assets/Data-Files/Energy/Weekly-fuel-price-monitoring/weekly-table.csv") +   ylab("ppb") +  xlab("Year") +
theme(legend.title=element_blank()) 

annotate("text", x= max(datalong[["Year"]]), y = 0, size = 3, angle = 0, hjust = 1,vjust=1, label=R.version.string) +
annotate("text", x= min(datalong[["Year"]]), y =  3002, size = 3, angle = 0, hjust = 1,vjust=1, label="A") +
annotate("text", x= min(datalong[["Year"]]), y =  477, size = 3, angle = 0, hjust = 1,vjust=1, label="B") +
annotate("text", x= min(datalong[["Year"]]), y =  283, size = 3, angle = 0, hjust = 1,vjust=1, label="C") +
annotate("text", x= min(datalong[["Year"]]), y =  1.15, size = 3, angle = 0, hjust = 1,vjust=1, label="D")
#annotate("text", x= min(datalong[["Year"]]), y =  , size = 3, angle = 0, hjust = 1,vjust=1, label="E")
#annotate("text", x= min(datalong[["Year"]]), y =  3002, size = 3, angle = 0, hjust = 1,vjust=1, label="F")
dev.off() 

# change period end date column from character to date format 
state_data[["period_end"]] <- as.Date(state_data[["period_end"]]) 

str(state_data) 
'data.frame':	1443 obs. of  5 variables:
 $ period_start      : chr  "1989-08-01" "1989-09-01" "1989-10-01" "1989-11-01" ...
 $ period_end        : Date, format: "1989-08-31" "1989-09-30" ...
 $ concentration     : num  1659 1662 1668 1669 1664 ...
 $ gas               : chr  "Methane" "Methane" "Methane" "Methane" ...
 $ reference_standard: chr  "WMOX2004a" "WMOX2004a" "WMOX2004a" "WMOX2004a" ... 

table(state_data[["gas"]]) 
 Carbon dioxide Carbon monoxide         Methane   Nitrous oxide 
            565             232             365             281  
# select only methane records
methane <- state_data[state_data[["gas"]]=="Methane",]
# or via dplyr
methane <- filter(state_data, gas =="Methane")

str(methane)
'data.frame':	365 obs. of  5 variables:
 $ period_start      : chr  "1989-08-01" "1989-09-01" "1989-10-01" "1989-11-01" ...
 $ period_end        : Date, format: "1989-08-31" "1989-09-30" ...
 $ concentration     : num  1659 1662 1668 1669 1664 ...
 $ gas               : chr  "Methane" "Methane" "Methane" "Methane" ...
 $ reference_standard: chr  "WMOX2004a" "WMOX2004a" "WMOX2004a" "WMOX2004a" .. 
 
svg(filename="NZmethane-2019-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
#png("NZmethane-2019-560by420.png", bg="white", width=560, height=420,pointsize = 14)
# ,ylim=c(0,33), xlim=c(1989,2017)
#jpeg(filename = "NZmethane-2021-560by420.jpeg", width = 640, height = 480, units = "px", pointsize = 16, quality = 100)
#jpeg(filename = "NZmethane-2021-640by640.jpeg", width = 640, height = 640, units = "px", pointsize = 16, quality = 100)
par(mar=c(2.7,3.3,1,1)+0.1)
plot(methane[["period_end"]],methane[["concentration"]],tck=0.01,ylab=NA,axes=T,ann=T, type="l",lwd=2,las=1,col="#7570B3")
box(lwd=1)
mtext(side=1,line=-1.4,cex=1,"Data: Stats NZ Tatauranga Aotearoa \nhttps://www.stats.govt.nz/indicators/greenhouse-gas-concentrations")
mtext(side=3,cex=1.3, line=-1.8,expression(paste("Baring Head Methane concentrations 1989 to 2019")) )
mtext(side=2,cex=1.1, line=-1.5,expression(paste("Parts per billion")))
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()
            
# select only Nitrous oxide records
nitrousoxide <- ghgs[ghgs[["variable"]]=="nitrous_oxide",]

str(nitrousoxide) 
'data.frame':	1268 obs. of  6 variables:
 $ year                        : int  1996 1996 1996 1996 1996 1996 1996 1996 1996 1996 ...
 $ month                       : int  8 8 8 8 9 9 9 9 10 10 ...
 $ variable                    : chr  "nitrous_oxide" "nitrous_oxide" "nitrous_oxide" "nitrous_oxide" ...
 $ parameter                   : chr  "mean" "mean_fitted" "seasonal_adjusted_mean" "trend" ...
 $ greenhouse_gas_concentration: num  311 311 311 311 NA ...
 $ unit                        : chr  "ppb" "ppb" "ppb" "ppb" ... 
meann2o <- nitrousoxide[nitrousoxide[["parameter"]]=="mean",] 
str(meann2o) 
'data.frame':	317 obs. of  6 variables:
 $ year                        : int  1996 1996 1996 1996 1996 1997 1997 1997 1997 1997 ...
 $ month                       : int  8 9 10 11 12 1 2 3 4 5 ...
 $ variable                    : chr  "nitrous_oxide" "nitrous_oxide" "nitrous_oxide" "nitrous_oxide" ...
 $ parameter                   : chr  "mean" "mean" "mean" "mean" ...
 $ greenhouse_gas_concentration: num  311 NA 311 311 311 ...
 $ unit                        : chr  "ppb" "ppb" "ppb" "ppb" ... 
# create a time series object for monthly prices
meann2ots <- ts(meann2o[["greenhouse_gas_concentration"]],frequency=12,start = c(1996,8)) 
meann2ots
       Jan   Feb   Mar   Apr   May   Jun   Jul   Aug   Sep   Oct   Nov   Dec
1996                                           310.8    NA 311.1 310.9 311.3
1997    NA    NA 311.4 311.3 312.4 311.3 311.9 312.2 312.4 312.8 312.8 312.8
1998 313.2 312.5 312.6 312.7 312.4 312.7 313.3 312.8 313.0 313.0 313.0 313.2 

meanfitn2o <- nitrousoxide[nitrousoxide[["parameter"]]=="mean_fitted",] 
head(meanfitn2o) 
     year month      variable   parameter greenhouse_gas_concentration unit
4010 1996     8 nitrous_oxide mean_fitted                        310.8  ppb
4014 1996     9 nitrous_oxide mean_fitted                        311.0  ppb
4018 1996    10 nitrous_oxide mean_fitted                        311.1  ppb
4022 1996    11 nitrous_oxide mean_fitted                        310.9  ppb
4026 1996    12 nitrous_oxide mean_fitted                        311.3  ppb
4030 1997     1 nitrous_oxide mean_fitted                        311.4  ppb 

# create a time series object for monthly prices
meanfitn2ots <- ts(meanfitn2o[["greenhouse_gas_concentration"]],frequency=12,start = c(1996,8)) 
str(meanfitn2ots) 
Time-Series [1:317] from 1997 to 2023: 311 311 311 311 311 ... 

#'data.frame':	281 obs. of  5 variables:
 $ period_start      : chr  "1996-08-01" "1996-09-01" "1996-10-01" "1996-11-01" ...
 $ period_end        : Date, format: "1996-08-31" "1996-09-30" ...
 $ concentration     : num  311 NA 311 311 311 ...
 $ gas               : chr  "Nitrous oxide" "Nitrous oxide" "Nitrous oxide" "Nitrous oxide" ...
 $ reference_standard: chr  "NOAA2006a" "NOAA2006a" "NOAA2006a" "NOAA2006a" ... 
 
svg(filename="NZnitrousoxide-2019-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
#png("NZnitrousoxide-2019-560by420.png", bg="white", width=560, height=420,pointsize = 14)
par(mar=c(2.7,3.3,1,1)+0.1)
plot(meanfitn2ots,tck=0.01,ylab=NA,axes=T,ann=T, type="l",lwd=1,las=1,col="#5035D2") # Purple Heart
grid(col="darkgray",lwd=1)
axis(side=4, tck=0.01, las=0,tick=TRUE,labels = FALSE)
box(lwd=1)
mtext(side=1,line=-1.4,cex=1,"Data: Stats NZ Tatauranga Aotearoa \nhttps://www.stats.govt.nz/indicators/greenhouse-gas-concentrations")
mtext(side=3,cex=1.3, line=-1.8,expression(paste("Baring Head nitrous oxide concentrations 1996 to 2022")) )
mtext(side=2,cex=1.1, line=-1.5,expression(paste("Parts per billion")))
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()
