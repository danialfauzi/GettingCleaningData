
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
xmlName(rootNode)
names(rootNode)
rootNode[[2]][[2]]
xmlSApply(rootNode,xmlValue)
xmlSApply(rootNode[[2]],xmlValue)
## http://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf
xpathSApply(rootNode,"//name", xmlValue) ## ga bisa
xpathSApply(rootNode,"//price",xmlValue); ## ga bisa

install.packages("xml2")
library(xml2);
xmlDoc <- read_xml(xData)
prices <- xml_find_all(xmlDoc,"//price")
head(prices)

name <- xml_find_all(xmlDoc,"//name")
head(name)

## ---

## Belum berhasil. Perbaikannya ada di https://github.com/lgreski/datasciencectacontent/blob/master/markdown/cleaningData-demystifyingHTMLParsing.md

install.packages("HTML")
library(htmltools)
library("RCurl")
library("XML")
fileUrl <- "https://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal = TRUE)

scores <- xpathSApply(doc, "//div[@class='score']",xmlValue);head(scores)
teams <- xpathSApply(doc, "//div[@class='game-info']",xmlValue);head(teams)

data <- htmlParse("http://www.espn.com/nfl/team/_/name/bal/baltimore-ravens")
readHTMLTable(data)[2]

fileUrl <- "http://www.espn.com/college-football/team/schedule/_/id/194"
xData <- getURL(fileUrl)
doc <- htmlTreeParse(xData, useInternalNodes = TRUE)
scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)
head(teams); head(scores)


fileUrl <- "http://www.espn.com/nfl/team/schedule/_/name/bal/baltimore-ravens"
xData <- getURL(fileUrl)
doc <- htmlTreeParse(fileUrl, useInternalNodes=FALSE)
scores <- xpathSApply(doc, "//div[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//div[@class='team-name']", xmlValue)
head(teams); head(scores)

fileUrl = "http://www.espn.com/nfl/team/schedule/_/name/bal/baltimore-ravens"
xData <- getURL(fileUrl)
doc <- htmlTreeParse(xData, useInternalNodes=TRUE)
scores <- xpathSApply(doc, "//div[@class='score']", xmlValue)

gameStatus <- c("//div[@class='game-status loss']","//div[@class='game-status win']")

result <- xpathSApply(doc, gameStatus, xmlValue)

opponent <- xpathSApply(doc,"//div[@class='team-name']", xmlValue)


library(rvest)
page <- read_html("http://www.espn.com/nfl/team/_/name/bal/baltimore-ravens")
ravens_html <- html_nodes(x = page, css = "div#main-container , footer, .standings a, .standings header, td")
html_text(ravens_html)

## --


## Berhasil

library(xml2)
suppressWarnings(dx<-read_xml("https://www.espn.com/nfl/team/_/name/bal/baltimore-ravens", as_html=TRUE))
teams<-as.character(xml_contents(xml_find_all(dx,"//div[@class='game-info']")))
scores<-as.character(xml_contents(xml_find_all(dx,"//div[@class='score']")))
head(teams)
head(scores)

##---

library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)

