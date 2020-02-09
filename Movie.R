df_genre <-read.delim(file.choose(), header = TRUE, sep = ";",dec = ";", col.names = c("Movie_TID","Genre","Year"))
df_actor <-read.delim(file.choose(), header = TRUE, sep = ";", dec = ";",col.names = c("Movie_TID","Actor"))

View(df_genre)
View(df_actor)
dim(df_actor)
dim(df_genre)
#install.packages("sets")
#library(sets)
movie_union <-merge(df_actor,df_genre, by="Movie_TID")
View(movie_union)
movie_union$Movie_TID <- NULL
#movie_union[c(-1),]

#if(sessionInfo()['basePkgs']=="dplyr" | sessionInfo()['otherPkgs']=="dplyr"){
  #detach(package:dplyr, unload=TRUE)
#}
install.packages("arules")
library(arules)




install.packages("stringr")
library(stringr)
#Detect the pattern
str_detect(movie_union$Actor, "\\?")

# Replace patters with 'NA'
movie_union$Actor= gsub("\\?", NA, movie_union$Actor)

#Remove NA rows
movie_union<-na.omit(movie_union)

View(movie_union)

movie_union$Movie_TID <- NULL
write.csv(movie_union, "transactions.csv", row.names = F)
trans <-  read.transactions("transactions.csv",format = 'basket', header = FALSE, sep = ';', skip=1)
View(trans)
str(trans)
class(trans)
inspect(head(trans, 10))


rules <- apriori(trans, parameter = list(support =0.00004, confidence = 0.05,target="rules"))
rules <- apriori(trans)
inspect(head(rules,5))





     
     
