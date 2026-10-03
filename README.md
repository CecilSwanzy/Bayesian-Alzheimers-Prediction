# Bayesian Logistic Regression and Hierarchical Modeling for Alzheimer's Disease Prediction

**Author:** Cecil Swanzy (Lead Modeler)

>  **Group Project:** This was completed in collaboration with Benalyn Chebet and Mariana Resendiz Chavez. I led the Bayesian modeling, Stan implementation, MCMC diagnostics, and uncertainty quantification.

---

## Overview

This project develops **Bayesian logistic regression models** to predict Alzheimer's disease (AD) diagnosis using data from **N = 2,149 patients**.

Two approaches compared:
1. **Baseline Bayesian Logistic Regression**
2. **Hierarchical Logistic Regression** (varying intercepts by ethnicity)

**Key strength:** Full posterior distributions provide uncertainty quantification for every prediction.

---

## Key Results

### Strongest Risk Factors

| Predictor | Log-Odds | 95% CI |
|-----------|----------|--------|
| **Memory Complaints** | 2.60 | [2.38, 2.81] |
| **Behavioral Problems** | 2.49 | [2.26, 2.72] |
| **Functional Assessment** | -0.45 | [-0.49, -0.42] |
| **ADL** | -0.42 | [-0.46, -0.39] |

### Model Comparison

| Metric | Baseline | Hierarchical |
|--------|----------|--------------|
| LOO-CV | -626.5 | -627.1 |
| WAIC | 1253.0 | 1254.2 |
| AUC | ≈ 0.86 | ≈ 0.86 |

**Conclusion:** Hierarchical model captures ethnicity variation (σ_α = 0.41) but does NOT improve predictive performance. The simpler model is preferred.

---

## Methodology

### Bayesian Models

**Baseline:**
logit(p_i) = α + Σ βⱼxᵢⱼ + Σ γₖzᵢₖ


**Hierarchical:**
logit(p_i) = μ_α + α_g[i] + Σ βⱼxᵢⱼ + Σ γₖzᵢₖ
α_g ~ N(0, σ_α)


### Priors
- `α ~ N(logit(0.354), 2)` — centered on empirical prevalence
- `β, γ ~ N(0, 1.5)` — weakly informative regularization
- `σ_α ~ Half-Normal(1)`

### Inference
- **Sampling:** Hamiltonian Monte Carlo (Stan) with 4 chains
- **Convergence:** R-hat ≈ 1.00 for all parameters
- **Comparison:** LOO-CV, WAIC

---

## Repository Structure
bayesian-alzheimers-prediction/
├── Bayesian Logistic Regression and Hierarchical Modeling for Alzheimer's Disease Prediction.pdf
├── Executive Summary Bayesian Project.pdf
├── LogisticAlzheimers.stan
└── README.md

Authors and Contributions

Cecil Swanzy (me)	Bayesian modeling, all R + Stan code, MCMC diagnostics, model comparison, methodology/results writing
Benalyn Chebet	Literature review, data preprocessing, editing
Mariana Resendiz Chavez	Literature review, data preprocessing, editing

Connect with Me
LinkedIn: www.linkedin.com/in/cecil-swanzy-191a60171

Email: mcskanty@gmail.com

GitHub: www.github.com/CecilSwanzy
