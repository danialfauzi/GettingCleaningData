install.packages("RMySQL"); 
install.packages("DBI"); 
library(DBI)
library(RMySQL)

## Connecting and listing database
ucscDb <- dbConnect(MySQL(),user="genome", host = "genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb);
result

## Connecting to hg19 database and listing tables
hg19 <- dbConnect(MySQL(),user="genome", db="hg19",
                  host = "genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]

## Get dimensions of specific table 
dbListFields(hg19, "affyU133Plus2")
dbGetQuery(hg19, "select count(*) from affyU133Plus2")

## Read from the table
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

## Select special subset
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches) #query data yg sangat besar

affyMisSmall <- fetch(query, n =10); ## tapi yang diambil kecil saja utk contoh data
dbClearResult(query)
dim(affyMisSmall)

## Close the connection
dbDisconnect(hg19)

#### www.r-bloggers.com/mysql-and-r

## R HDF5 package
#######
#Use the following code
# Install BiocManager first
install.packages("BiocManager")
BiocManager::install()

#Bioconductor version 3.10 (BiocManager 1.30.10), R
#  3.6.3 (2020-02-29)
#Installing package(s) 'BiocVersion'
#trying URL 'https://bioconductor.org/packages/3.10/bioc/bin/macosx#/el-capitan/contrib/3.6/BiocVersion_3.10.1.tgz'
#Content type 'application/x-gzip' length 5574 bytes
#==================================================
#downloaded 5574 bytes

#Now install the "rhdf5"
BiocManager::install("rhdf5")

# The package is now intalled. Load it like every other library
library(rhdf5)
#######

created = h5createFile("example.h5")
created

created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/baa")
h5ls("example.h5")

A = matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5","foo/A")
B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5","foo/foobaa/B")
h5ls("example.h5")

## Quiz soal nomor 1. run di base R package and not R studio.
#install.packages("jsonlite")
#install.packages("httpuv")
#install.packages("httr")

library(jsonlite)
library(httpuv)
library(httr)

# Can be github, linkedin etc depending on application
oauth_endpoints("github")

# Change based on your appname, key, and secret 
myapp <- oauth_app("AyoGabung",
                   key = "3b5ab8823396ef70f00c",
                   secret = "275f63ec45fca76f8876b7e184ad3baf05888e34")

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

# Take action on http error
stop_for_status(req)

# Extract content from a request
json1 = content(req)

# Convert to a data.frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

# Subset data.frame
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"]

### Quiz soal nomor2
install.packages("sqldf")
library("sqldf")

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
f <- file.path(getwd(), "ss06pid.csv")
download.file(url, f)
# install.packages("data.table"); library(data.table)
acs <- data.table::data.table(read.csv(f)); 
query1 <- sqldf("select pwgtp1 from acs where AGEP < 50"); query1

## https://github.com/mGalarnyk/datasciencecoursera/blob/master/3_Getting_and_Cleaning_Data/quizzes/quiz2.md
## https://github.com/r-lib/httr/blob/master/demo/oauth2-github.r

## quizz soal nomor3
unique(acs$AGEP)
sqldf("select distinct AGEP from acs")

## quizz soal nomor 4
connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(connection)
close(connection)
c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))

## quizz soal nomor 5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
lines <- readLines(url, n = 10)
w <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
colNames <- c("filler", "week", "filler", "sstNino12", "filler", "sstaNino12", 
              "filler", "sstNino3", "filler", "sstaNino3", "filler", "sstNino34", "filler", 
              "sstaNino34", "filler", "sstNino4", "filler", "sstaNino4")
d <- read.fwf(url, w, header = FALSE, skip = 4, col.names = colNames)
d <- d[, grep("^[^filler]", names(d))]
sum(d[, 4])






