data {
    int<lower=0> N;
    vector[N] y;
}

parameters {
    real alpha;
    real beta;
    real sigma;
}

model {
    // for (n in 2:N)
    //     y[n] ~ normal(alpha + beta * y[n-1], sigma);
    tail(y, N-1) ~ normal(alpha + beta * head(y, N-1), sigma);
}