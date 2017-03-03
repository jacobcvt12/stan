// hierarchical logistic regression
data {
    int<lower=1> K;
    int<lower=1> G;
    int<lower=0> N;
    int<lower=0, upper=G> id[N];
    int<lower=0, upper=1> y[N];
    matrix[N, K] x;
}

parameters {
    real mu[K];
    real<lower=0> sigmamu[K];
    matrix[G, K] beta;
}

model {
    vector[N] x_beta;
    mu ~ normal(0, 3);
    sigmamu ~ chi_square(2);
    for (j in 1:K)
        for (i in  1:G)
            beta[i, j] ~ normal(mu[j], sigmamu[j]);
    for (i in 1:N)
        x_beta[i] = dot_product(x[i], beta[id[i]]);
        
    y ~ bernoulli_logit(x_beta);
}