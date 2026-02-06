# Mixture of Experts Framework for Parkinson's UPDRS Prediction

## Overview

This repository presents a journal-extended framework for predicting
**motor_UPDRS** and **total_UPDRS** scores using a Mixture of Experts
(MoE) architecture. The study extends a previously accepted IEEE
conference work by introducing adaptive expert weighting and a learnable
gating mechanism to dynamically select the most appropriate predictive
model for each datapoint.

------------------------------------------------------------------------

## Problem Statement

Accurate estimation of Unified Parkinson's Disease Rating Scale (UPDRS)
scores from biomedical voice measurements remains a challenging
nonlinear regression problem. Traditional single-model approaches often
fail to capture heterogeneous data distributions.

This work proposes a Mixture of Experts approach to: - Improve
predictive accuracy - Introduce adaptive model specialization - Increase
interpretability of ensemble behavior

------------------------------------------------------------------------

## Dataset

-   Parkinson's Telemonitoring Dataset
-   Targets:
    -   motor_UPDRS
    -   total_UPDRS
-   Features:
    -   Biomedical voice measurements (after preprocessing and scaling)

All dataset splits are frozen to ensure reproducibility.

------------------------------------------------------------------------

## Methodology

### 1. Expert Models (Frozen)

Four heterogeneous experts were trained independently:

-   Neural Network (PyTorch, Optuna tuned)
-   Random Forest (Optuna tuned)
-   Ridge Regression
-   Elastic Net (Multi-task)

Each expert predicts scaled targets.

------------------------------------------------------------------------

### 2. Gating Network

A lightweight neural network learns per-sample expert weights:

-   Separate weighting for motor and total targets
-   Softmax normalization ensures convex combination
-   Entropy regularization encourages diversity

The final MoE prediction is:

MoE(x) = Σ w_i(x) \* Expert_i(x)

------------------------------------------------------------------------

### 3. Training Strategy

-   StandardScaler applied to features
-   Target scaling preserved internally
-   Train / Validation / Test split fixed
-   Optuna for hyperparameter optimization
-   Early stopping for stability

------------------------------------------------------------------------

## Results

Final MoE Performance (Test Set):

-   R² ≈ 0.91
-   RMSE ≈ 2.8
-   MAE ≈ 1.98

The gating mechanism learned dominant reliance on Random Forest while
maintaining non-zero contribution from linear experts, demonstrating
adaptive specialization.

------------------------------------------------------------------------

## Contributions

-   Adaptive Mixture of Experts architecture for biomedical regression
-   Target-specific gating weights
-   Statistical validation and residual analysis
-   Interpretability through expert weight analysis

------------------------------------------------------------------------

## Reproducibility

All preprocessing artifacts are saved:

-   Feature scaler
-   Target scaler
-   Frozen dataset splits
-   Expert model checkpoints

------------------------------------------------------------------------

## Future Work

-   Longitudinal modeling of UPDRS progression
-   Patient-specific gating adaptation
-   Temporal architectures (RNN/Transformer)
-   Clinical validation on external datasets

------------------------------------------------------------------------

## Citation

If this repository contributes to your work, please cite the extended
journal submission (under preparation).

------------------------------------------------------------------------

Generated on: 2026-02-06 17:16:35
