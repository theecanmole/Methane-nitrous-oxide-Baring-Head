Methane and nitrous oxide concentrations at Baring Head

# Statistics NZ Tatauranga Aotearoa https://www.stats.govt.nz/indicators/greenhouse-gas-concentrations
# go to 'Download' click through and 'Download all data' and right click copy link

download.file("https://statisticsnz.shinyapps.io/ghg_concentrations_oct20/_w_d5223dbc/session/b3dde967ab0df32633f7977e7728c693/download/download?w=d5223dbc","download?w=d5223dbc")
trying URL 'https://statisticsnz.shinyapps.io/ghg_concentrations_oct20/_w_d5223dbc/session/b3dde967ab0df32633f7977e7728c693/download/download?w=d5223dbc'
Content type 'application/zip' length 9903 bytes
==================================================
downloaded 9903 bytes

# unzip downloaded zip file
unzip("download?w=d5223dbc")

# unzipped file is 'state_data.csv'

# read in the data file
state_data <- read.csv("state_data.csv")

str(state_data) 
'data.frame':	1443 obs. of  5 variables:
 $ period_start      : chr  "1989-08-01" "1989-09-01" "1989-10-01" "1989-11-01" ...
 $ period_end        : chr  "1989-08-31" "1989-09-30" "1989-10-31" "1989-11-30" ...
 $ concentration     : num  1659 1662 1668 1669 1664 ...
 $ gas               : chr  "Methane" "Methane" "Methane" "Methane" ...
 $ reference_standard: chr  "WMOX2004a" "WMOX2004a" "WMOX2004a" "WMOX2004a" ... 

# chnage period end date column from character to date format 
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
nitrousoxide <- state_data[state_data[["gas"]]=="Nitrous oxide",]
str(nitrousoxide) 
'data.frame':	281 obs. of  5 variables:
 $ period_start      : chr  "1996-08-01" "1996-09-01" "1996-10-01" "1996-11-01" ...
 $ period_end        : Date, format: "1996-08-31" "1996-09-30" ...
 $ concentration     : num  311 NA 311 311 311 ...
 $ gas               : chr  "Nitrous oxide" "Nitrous oxide" "Nitrous oxide" "Nitrous oxide" ...
 $ reference_standard: chr  "NOAA2006a" "NOAA2006a" "NOAA2006a" "NOAA2006a" ... 
 
cats=c(1,1,1,1,1,1)
barplot(matrix(cats),col=rainbow(6),axes=F)
?rainbow

svg(filename="NZnitrousoxide-2019-720by540.svg", width = 8, height = 6, pointsize = 14, onefile = FALSE, family = "sans", bg = "white", antialias = c("default", "none", "gray", "subpixel"))
#png("NZnitrousoxide-2019-560by420.png", bg="white", width=560, height=420,pointsize = 14)
# ,ylim=c(0,33), xlim=c(1989,2017)
#jpeg(filename = "NZnitrousoxide-2021-560by420.jpeg", width = 640, height = 480, units = "px", pointsize = 16, quality = 100)
#jpeg(filename = "NZnitrousoxide-2021-640by640.jpeg", width = 640, height = 640, units = "px", pointsize = 16, quality = 100)
par(mar=c(2.7,3.3,1,1)+0.1)
plot(nitrousoxide[["period_end"]],nitrousoxide[["concentration"]],tck=0.01,ylab=NA,axes=T,ann=T, type="p",lwd=2,las=1,col="#5035D2") # Purple Heart
box(lwd=1)
mtext(side=1,line=-1.4,cex=1,"Data: Stats NZ Tatauranga Aotearoa \nhttps://www.stats.govt.nz/indicators/greenhouse-gas-concentrations")
mtext(side=3,cex=1.3, line=-1.8,expression(paste("Baring Head nitrous oxide concentrations 1996 to 2019")) )
mtext(side=2,cex=1.1, line=-1.5,expression(paste("Parts per billion")))
mtext(side=4,cex=0.75, line=0.05,R.version.string)
dev.off()
