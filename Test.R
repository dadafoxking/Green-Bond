#How to covert
library(readxl)
Test <- read_excel("Test.xlsx")
View(Test)

data <- data.frame(company = rep("AAPL US EQUITY", 7), year = 2014:2020)

c <- names(Test)
c <- c[3:9]
factors <- Test$Factors
factors <- c("Year", factors)

testdata <- data.frame(Test[3:9])
colnames(testdata) <- NULL

testdata2 <- as.data.frame(t(Test[2:length(Test)]))
c <- testdata2[1,]
colnames(testdata2) <- c
testdata2 <- testdata2[-1,]
testdata2 <- cbind(testdata2, Year = rownames(testdata2))
rownames(testdata2) <- NULL



