library(readr)
library(dplyr)
library(rstan)

setwd("~/learning/stan/")

d <- read_csv("https://raw.githubusercontent.com/johnmyleswhite/IntertemporalChoiceHeuristics/master/data/choices.csv") %>% 
    filter(!is.na(LaterOptionChosen)) %>% 
    left_join(data_frame(Subject=unique(d$Subject), 
                         id=seq_len(length(unique(d$Subject))))) 

K <- 5
G <- length(unique(d$Subject))
N <- nrow(d)
id <- d$id
y <- d$LaterOptionChosen
x <- cbind(1, as.matrix(d[, c(4, 5, 7, 9)]))

stan_data <- list(K=K, G=G, N=N, id=id, y=y, x=x)

set.seed(1)

fitted.model <- stan("hlogitregression.stan", 
                     data=stan_data, chains=2)
