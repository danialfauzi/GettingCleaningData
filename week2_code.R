install.packages("RMySQL"); library(RMySQL)
install.packages("DBI"); library(DBI)
ucscDb <- dbConnect(MySQL(),user="genome", host = "genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb);
result