library(rstan)
setwd("~/learning/stan/")

set.seed(1)
b.true <- c(2, 4)
sigma.true <- 1
N <- 1000
M <- 1
x <- matrix(rnorm(N))
y <- rnorm(N, x * b.true[2] + b.true[1], sigma.true)
lm(y ~ x)

stan_data <- list(N=N, M=M, y=y, x=x)

fitted.model <- stan("lm.stan", data=stan_data, iter=5000, iter=2)