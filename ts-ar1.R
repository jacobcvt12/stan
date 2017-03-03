library(rstan)

# true paramaters
alpha <- 1.7
beta <- 0.9
sigma <- 0.2

set.seed(1)

N <- 10000
y <- rep(alpha + beta, N)
for (n in 2:N) {
    y[n] <- rnorm(1, alpha + beta * y[n-1], sigma)
}

ts.plot(y)
ar(y, order=1)

stan_data <- list(N=N, y=y)

fit <- stan("ts-ar1.stan", chains=2, data=stan_data)
