

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

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "../data/cameras.xlsx")
list.files("./data")
dateDownload <- date()

library(xlsx)
cameraData <- read.xlsx("../data/cameras.xlsx", sheetIndex = 1, header = TRUE)
head(cameraData)

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xml?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "../data/cameras.xml")
list.files("./data")
dateDownload <- date()

cameraData <- read.table("../data/cameras.tsv", sep = ";", header = TRUE)
head(cameraData)

library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal = TRUE)
doc <- xmlTreeParse(fileUrl)
rootNode <- xmlRoot(doc)
xmlName(rootNode)