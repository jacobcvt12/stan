library(rstan)

set.seed(1)

theta.true <- 0.4

N <- 217
y <- rbinom(N, 1, theta.true)

stan_data <- list(N=N, y=y)

fit <- stan("beta-binomial.stan", chains=2, data=stan_data)
