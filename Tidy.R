library(data.table)
library(dplyr)
library(readxl)
Test1 <- read_excel("Test1.xlsx", col_types = c("text",
"text", "numeric", "numeric", "numeric",
"numeric", "numeric", "numeric", "numeric"))

data.table(Test1)
as.factor(Test1$Firmnames)
Test1 <- cbind(Test1, c(as.factor(Test1$Firmnames)))
names(Test1)[10] <- "Code"
data <- data.frame()
#split(Test1, "Green Insreument Indicator")

for (i in 1:26){
        testdata <- subset(Test1, Code == i)
        testdata <- as.data.frame(t(testdata[2:9]))
        c <- testdata[1,]
        colnames(testdata) <- c
        testdata <- testdata[,-3]
        testdata <- testdata[-1,]
        testdata <- cbind(testdata, Year = rownames(testdata))
        rownames(testdata) <- NULL
        testdata <- cbind(testdata, Code = i)
        data <- rbind(testdata, data)
}

firmlist <- rep(unique(Test1$Firmnames), 7)
Code <- c(as.factor(firmlist))
firmlist <- as.data.frame(firmlist)
firmlist <- cbind(firmlist, Code)
names(firmlist) <- c("Firmnames", "Code")
firmlist <- arrange(firmlist, Code)

matchdata <- merge(firmlist, data)
matchdata <- unique(matchdata)
matchdata <- arrange(matchdata, Firmnames, Year)
matchdata3 <- data.frame()

#s <- split(matchdata, matchdata$Code)
#for(i in s){
#        if(s$i$Year)
#        }
#}
#
matchdata2 <- rbind(c(rep(NA, 12)),subset(matchdata, Code==i))
matchdata2 <- matchdata2[-length(matchdata2),]
matchdata2 <- subset(matchdata2, select = c(-Code, -Firmnames, -Year))
colnames(matchdata2) <- c(paste(colnames(matchdata2), "bf", sep = "_"))
matchdata3 <- rbind(matchdata2, matchdata3)

matchdata <- cbind(matchdata, matchdata3)
matchdata <- matchdata[-(3:11)]
write.csv(matchdata, file = "matchdata.csv")

matchdata2 <- rbind(c(rep(NA, 12)),matchdata)
matchdata2 <- matchdata2[-length(matchdata2),]
matchdata2 <- subset(matchdata2, select = c(-Code, -Firmnames, -Year))
colnames(matchdata2) <- c(paste(colnames(matchdata2), "bf", sep = "_"))
matchdata <- cbind(matchdata, matchdata2)
matchdata <- matchdata[-(3:11)]
write.csv(matchdata, file = "matchdata.csv")

matchdata[-1]

library(readxl)
Test2 <- read_excel("Test2.xlsx", sheet = "工作表2")

Test2 <- read_excel("Test2.xlsx", col_types = c("skip",
                                                "skip", "text", "numeric", "numeric",
                                                "numeric", "text", "text", "text", "text",
                                                "text", "numeric"), na = "NA")

bdata <- unique(merge(firmlist, Test2))

rdata <- merge(matchdata, bdata, by = c("Firmnames", "Year"))
x <- 2:12
for(i in x){
        rdata[,i] <- as.numeric(rdata[,i])
}
rdata <- rdata[complete.cases(rdata),]
#rdata <- cbind(rdata, Year_Pscore = rdata[,2]-1)
write.csv(rdata, file = "rdata.csv")