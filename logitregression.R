library(rstan)

# true parameters
beta.true <- c(-1, 4, 7, 3, -3)

# logistic function
logistic <- function(x)
    1 / (1 + exp(-x))

K <- 5
N <- 2000
x <- cbind(1, matrix(rnorm(N * (K-1)), ncol=K-1))
y <- rbinom(N, 1, logistic(x %*% beta.true))
fit.mle <- glm(y ~ x - 1, family=binomial)

stan_data <- list(K=K, N=N, x=x, y=y)

fit.stan <- stan("logitregression.stan", 
                 data=stan_data,
                 chains=2)
