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
