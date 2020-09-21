
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

## Berhasil
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
## Berhasil

## Berhasil
install.packages("data.table")
library(data.table)
DF = data.frame(x = rnorm(9), y =rep(c("a","b","c"), each = 3), z = rnorm(9))
head(DF,3)

DT = data.table(x = rnorm(9), y =rep(c("a","b","c"), each = 3), z = rnorm(9))
head(DT,3)

tables()

DT[2,]

DT[DT$y == "a",]

DT[c(2,3)]
DT[,c(2,3)]

{
  x = 1
  y = 2
}
k = {print(10); 5}
print(k)

DT[, list(mean(x),sum(z))]
DT[, table(y)]

DT[,w:=z^2]; head(DT); DT

DT[, m := {tmp <-  x+z; log2(tmp+5)}]; DT

DT[, a := x>0]; DT
DT[, b := mean(x+w), by = a]; DT

set.seed(123)
DT <- data.table(x = sample(letters[1:3], 1E5, TRUE))
DT[, .N, by = x]; DT

DT <- data.table(x = rep(c("a","b","c"), each = 100), y = rnorm(300))
setkey(DT, x)
DT['a']

DT1 <- data.table(x = c('a', 'a', 'b', 'dt1'), y = 1:4)
DT2 <- data.table(x = c('a', 'b', 'dt2'), z = 5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1, DT2)

big_df <- data.frame(x = rnorm(1E6), y = rnorm(1E6))
file <- tempfile()
write.table(big_df, file = file, row.names = FALSE, col.names = TRUE, sep = "\t", quote = FALSE)
system.time(fread(file))
system.time(read.table(file, header = TRUE, sep = "\t"))
## Berhasil

## Quizz 1
## Q1
library(data.table)
housing <- data.table::fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")

## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# VAL attribute says how much property is worth, .N is the number of rows
# VAL == 24 means more than $1,000,000
housing[VAL == 24, .N]

## Q3
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = paste0(getwd(), '/getdata%2Fdata%2FDATA.gov_NGAP.xlsx'), method = "curl")

dat <- xlsx::read.xlsx(file = "getdata%2Fdata%2FDATA.gov_NGAP.xlsx", sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

## Q4
# install.packages("XML")
library("XML")
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- XML::xmlTreeParse(sub("s", "", fileURL), useInternal = TRUE)
rootNode <- XML::xmlRoot(doc)

zipcodes <- XML::xpathSApply(rootNode, "//zipcode", XML::xmlValue)
xmlZipcodeDT <- data.table::data.table(zipcode = zipcodes)
xmlZipcodeDT[zipcode == "21231", .N]

## Q5
DT <- data.table::fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv")

# Answer (fastest):
system.time(DT[,mean(pwgtp15),by=SEX])

## https://rstudio-pubs-static.s3.amazonaws.com/398911_0a0d9db3ac174b10a0fb52069f98e172.html
## https://rpubs.com/Jerry_zhu/136168
