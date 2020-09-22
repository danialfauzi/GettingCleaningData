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




