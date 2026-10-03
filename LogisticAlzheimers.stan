
// logistic_model.stan
data {
int<lower=1> N; // observations
int<lower=0> J; // X predictors
int<lower=0> K; // Z predictors
matrix[N, J] X; // matrix for beta_j
matrix[N, K] Z; // matrix for gamma_k
int<lower=0,upper=1> y[N]; // outcomes
real<lower=0,upper=1> p_prior_mean; // the p used in alpha
}

parameters {
real alpha; // intercept on logit scale
vector[J] beta; // coefficients for X
vector[K] gamma; // coefficients for Z
}

transformed parameters {
vector[N] pi;
pi = alpha + X * beta + Z * gamma; // linear predictor
}

model {
// Priors
alpha ˜ normal(p_prior_mean, 2);
beta ˜ normal(0, 1.5);
gamma ˜ normal(0, 1.5); 
// Likelihood
y ˜ bernoulli_logit(pi);
}

generated quantities {
vector[N] log_lik;
int y_rep[N];
for (n in 1:N) {
  log_lik[n] = bernoulli_logit_lpmf(y[n] | pi[n]);
y_rep[n] = bernoulli_logit_rng(pi[n]);
// posterior predictive draws
}
}

// hierarchical_model.stan
data {
int<lower=1> N; // observations
int<lower=1> J; // binary predictors
int<lower=1> K; // continuous predictors
int<lower=1> G; // ethnicity groups
int<lower=1, upper=G> group[N];
matrix[N, J] X; // binary predictors
matrix[N, K] Z; // continuous predictors
int<lower=0, upper=1> y[N]; // outcome
real<lower=0, upper=1> p_prior_mean;
}

parameters {
real mu_alpha; // global mean intercept
real<lower=0> sigma_alpha; // SD intercepts
vector[G] alpha_raw; // standardized ethnicity
vector[J] beta;
vector[K] gamma;
}

// binary predictor
// continuous predictor
transformed parameters {
vector[G] alpha;
}

model {
// Hyperpriors
mu_alpha ˜ normal(0, 2);
sigma_alpha ˜ normal(0, 1);
// Priors
alpha_raw ˜ normal(0, 1);
beta ˜ normal(0, 1.5);
gamma ˜ normal(0, 1.5);
// Likelihood
y ˜ bernoulli_logit(alpha[group] + X * beta +
Z * gamma);
}

generated quantities {
vector[N] log_lik;
int y_rep[N];
vector[N] pi;
for (n in 1:N) {
pi[n] = alpha[group[n]] + X[n] * beta +
Z[n] * gamma;
log_lik[n] = bernoulli_logit_lpmf(y[n] | pi[n]);
y_rep[n] = bernoulli_logit_rng(pi[n]);
}
}
  
