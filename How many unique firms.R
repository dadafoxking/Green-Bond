library(tidyverse)
library(readxl)
Test2 <- read_excel("Test2.xlsx", col_types = c("text",
"text", "text", "numeric", "numeric",
"numeric", "text", "text", "skip", "skip",
"skip", "numeric"))

uniFirmInYear <- function(x){
        Test2$Ticker[Test2$Year==x] %>% 
                unique() %>% 
                length()
}
c <- 2015:2019
sapply(c, uniFirmInYear)