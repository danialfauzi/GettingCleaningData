
## Subsetting dan Sorting
set.seed(13435)
X <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), "var3" = sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)]=NA
X

X[(X$var1 <= 3 & X$var3 > 11),]
X[(X$var1 <= 3 | X$var3 > 15),]

X[which(X$var2 > 8),]
sort(X$var1)
sort(X$var1,decreasing = TRUE)
sort(X$var2, na.last = TRUE) ##Meletakkan NA pada akhir
sort(X$var2, na.last = FALSE) ##Meletakkan NA pada awal
X[order(X$var1),] ##Mengurutkan var 1
X[order(X$var1,X$var3),] ##Mengurutkan var 1

install.packages("plyr")
library(plyr)
arrange(X,var1) #Sorting berdasarkan var 1
arrange(X,desc(var1)) #Sorting berdasarkan var 1
X$var4 <- rnorm(5) #Menambahkan var4 di kolom baru
X
Y <- cbind(X,rnorm(5)) #menambahkan kolom baru dg menggunakancbin
Y

## Summarizing Data
if(!file.exists("./data")){
  dir.create("./data")  
}
if(!file.exists("./data/restaurants.csv")){
  fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
  download.file(fileUrl, destfile="./data/restaurants.csv", method="curl")
}
restData <- read.csv("./data/restaurants.csv")
head(restData,n = 3)
tail(restData,n=3)

#Make Summary
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm=T)
quantile(restData$councilDistrict, probs=c(0.5,0.75,0.9))
table(restData$zipCode, useNA="ifany")
table(restData$councilDistrict, restData$zipCode)

## Check for missing values
sum(is.na(restData$councilDistrict)) # count of NAs in a column
any(is.na(restData$councilDistrict)) # TRUE if there is at least one NA in column
all(restData$councilDistrict > 0) # TRUE if every value in column > 0 (will spot negative value)

#Row and column sums
colSums(is.na(restData)) # get count of missing values per column
all(colSums(is.na(restData))==0) # TRUE if none of the columns have any NAs
any(is.na(restData))

#Values with specific characteristics
table(restData$zipCode %in% c("21212")) # determine number of restaurants in 21212

## sumber syntax https://rstudio-pubs-static.s3.amazonaws.com/16910_2cab1cfecbf44c23a6bcea3df002493a.html


