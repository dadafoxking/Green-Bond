#MatchIt
install.packages("MatchIt")
library("MatchIt")
install.packages("optmatch")
library(optmatch)
data("lalonde")

head(lalonde)

m.out0 <- matchit(treat ~ age + educ + race + married + 
                          nodegree + re74 + re75, data = lalonde,
                  method = NULL, distance = "glm")
summary(m.out0)

m.out1 <- matchit(treat ~ age + educ + race + married +
                          nodegree + re74 + re75, data = lalonde,
                  method = "nearest", distance = "glm")

plot(m.out1, type = "jitter", interactive = FALSE)
plot(m.out1, type = "qq", interactive = FALSE,
        which.xs = c("age", "married", "re75"))
summary(m.out1, un = FALSE)
plot(summary(m.out1))

m.out2 <- matchit(treat ~ age + educ + race + married + 
                          nodegree + re74 + re75, data = lalonde,
                  method = "full", distance = "glm", link = "probit")
m.out2
summary(m.out2, un = FALSE)
plot(summary(m.out2))

