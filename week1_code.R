
## yang ini bisa
if(!file.exists("data")) {
  dir.create("data")
}

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "../data/cameras.csv")
list.files("./data")
dateDownload <- date()

cameraData <- read.table("../data/cameras.csv", sep = ",", header = TRUE)
head(cameraData)

cameraData <- read.csv("../data/cameras.csv")
head(cameraData)

## -----

## yang ini ga bisa, krn ga ada file yg xlsx

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "../data/cameras.xlsx")
list.files("./data")
dateDownload <- date()

library(xlsx)
cameraData <- read.xlsx("../data/cameras.xlsx", sheetIndex = 1, header = TRUE)
head(cameraData)
## ---

## Ini bisa
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xml?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "../data/cameras.xml")
list.files("./data")
dateDownload <- date()
## --

## Belum tau bagaimana cara baca data XML
cameraData <- read.table("../data/cameras.xml", sep = ";", header = TRUE)
head(cameraData)

## --

## Ini Bisa
library(XML)
library(RCurl)
fileUrl <- "https://www.w3schools.com/xml/simple.xml"
xData <- getURL(fileUrl)
doc <- xmlTreeParse(xData)
## doc <- xmlTreeParse(fileUrl, useInternal = TRUE) ## Ga ada "useInternal
rootNode <- xmlRoot(doc)
## ini bisa

xmlName(rootNode)