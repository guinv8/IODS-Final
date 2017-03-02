library(Matrix)
library(ggplot2)
library(dplyr)
library(stringr)

setwd("C:/Users/Guilherme/Desktop/University of Helsinki/2016-2017/Period 2/Term 3/Open Data Science/IODS Final/IODS-Final")
#Reading the Data#

hd2 <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii2 <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Checking the Structure and Dimension of the Data#

str(hd2)
dim(hd2)
str(gii2)
dim(gii2)
colnames(hd2)
colnames(gii2)

#Changing the names of the HDI Columns#

colnames(hd2)[1] <- "HDI.Rank"
colnames(hd2)[2] <- "Country"
colnames(hd2)[3] <- "HDI"
colnames(hd2)[4] <- "Exp.Life"
colnames(hd2)[5] <- "Exp.Edu"
colnames(hd2)[6] <- "Mean.Years.Edu"
colnames(hd2)[7] <- "GNI"
colnames(hd2)[8] <- "GNI-HDI"
colnames(hd2)

colnames(gii2)[1] <- "GII.Rank"
colnames(gii2)[2] <- "Country"
colnames(gii2)[3] <- "GII"
colnames(gii2)[4] <- "Mat.Mort"
colnames(gii2)[5] <- "Adol.Birth"
colnames(gii2)[6] <- "Parl"
colnames(gii2)[7] <- "Female.Edu"
colnames(gii2)[8] <- "Male.Edu"
colnames(gii2)[9] <- "Female.Labor"
colnames(gii2)[10] <- "Male.Labor"
colnames(gii2)

#Joining the datasets#

join_dataset <- c("Country")


hdi2_gii2 <- inner_join(hd2, gii2, by= join_dataset, suffix= c(".hd2", ".gii2"))
colnames(hdi2_gii2)


write.csv(hdi2_gii2, file = "humanfinal.csv", row.names = FALSE)
human2 <- read.csv("humanfinal.csv", sep=",", header= T)
getwd()

#Transforming GNI into numeric#

human2$GNI <- str_replace(human2$GNI, pattern=",", replace ="") %>% as.numeric() 
str(human2$GNI)

#Removing NA Elements and excluding unecessary columns#

keep_columns <- c("Country","HDI", "Exp.Life", "Exp.Edu", "GNI", "Mat.Mort", "Adol.Birth", "Parl", "Female.Edu", "Male.Edu", "Female.Labor", "Male.Labor")
human2 <- dplyr::select(human2, one_of(keep_columns))
complete.cases(human)
data.frame(human2[-1], comp = complete.cases(human2))
human2_ <- filter(human2, complete.cases(human2))
summary(human2_)

#Choosing Observations from Latin America and the Caribbean#

human2_ <- human2_[c(36, 38, 50, 51, 53, 55, 58, 60, 62, 64, 67, 68, 75, 79, 86, 87, 89, 90, 91, 99, 101, 104, 107, 108, 111, 114, 135, 159),]
summary(human2_)
rownames(human2_)


#Removing contry as a column#
rownames(human2_) <- human2_$Country
human2_ <- dplyr::select(human2_, -Country)
str(human2_)
summary(human2_)
colnames(human2_)

#Saving the Dataset#

write.csv(human2_, file = "humanfinal.csv", row.names = TRUE)
human3_ <- read.csv("humanfinal.csv", sep=",", header= T)
