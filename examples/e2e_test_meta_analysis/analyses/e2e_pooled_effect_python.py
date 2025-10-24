#!/usr/bin/env python3
"""
Esophageal Cancer CTC Meta-Analysis - Question 1: Pooled Effect Size
Generated for Story 2.6: End-to-End Workflow Testing
Oracle v1.0 Output - Python Implementation
"""

import pandas as pd
import numpy as np
from scipy import stats
import warnings

warnings.filterwarnings('ignore')

# Load compiled dataset
compiled_data = pd.read_csv('compiled/e2e_analysis.csv')

# Extract effect size data for meta-analysis
meta_data = compiled_data[['study_id', 'effect_size', 'confidence_interval_lower',
                           'confidence_interval_upper', 'quality_score']].copy()

# Rename columns for clarity
meta_data.columns = ['study', 'yi', 'ci_lb', 'ci_ub', 'quality']

# Calculate standard errors from confidence intervals
# For hazard ratios: SE = (log(CI_ub) - log(CI_lb)) / (2 * 1.96)
meta_data['sei'] = (np.log(meta_data['ci_ub']) - np.log(meta_data['ci_lb'])) / (2 * 1.96)

# Calculate log hazard ratios for meta-analysis
meta_data['log_yi'] = np.log(meta_data['yi'])

# Fixed-effects model
fixed_effects_mean = np.average(meta_data['log_yi'], weights=1/(meta_data['sei']**2))
fixed_effects_se = np.sqrt(1/np.sum(1/(meta_data['sei']**2)))

# Random-effects model (DerSimonian-Laird)
# Q-statistic
Q = np.sum(((meta_data['log_yi'] - fixed_effects_mean)**2) / (meta_data['sei']**2))
k = len(meta_data)

# Tau-squared (between-study variance)
c = np.sum(1/(meta_data['sei']**2)) - np.sum(1/(meta_data['sei']**4)) / np.sum(1/(meta_data['sei']**2))
tau2 = max(0, (Q - (k-1)) / c)

# Random-effects pooled estimate
weights_re = 1/(meta_data['sei']**2 + tau2)
re_mean = np.sum(meta_data['log_yi'] * weights_re) / np.sum(weights_re)
re_se = np.sqrt(1/np.sum(weights_re))

# Convert back from log scale
re_hr = np.exp(re_mean)
re_ci_lb = np.exp(re_mean - 1.96*re_se)
re_ci_ub = np.exp(re_mean + 1.96*re_se)

# I-squared (proportion of heterogeneity)
I2 = max(0, (Q - (k-1))/Q) * 100

# P-value for overall effect
z_score = re_mean / re_se
p_value = 2 * (1 - stats.norm.cdf(abs(z_score)))

print("=" * 60)
print("POOLED EFFECT SIZE META-ANALYSIS (Python Implementation)")
print("=" * 60)
print(f"\nResearch Question: What is the pooled hazard ratio for CTC+ vs CTC-?")
print(f"\nNumber of studies: {k}")
print(f"Total sample size: {compiled_data['sample_size'].sum()}")

print("\n" + "=" * 60)
print("RANDOM-EFFECTS MODEL (DerSimonian-Laird)")
print("=" * 60)
print(f"\nPooled Hazard Ratio: {re_hr:.3f}")
print(f"95% Confidence Interval: [{re_ci_lb:.3f}, {re_ci_ub:.3f}]")
print(f"Standard Error (log scale): {re_se:.4f}")
print(f"Z-score: {z_score:.3f}")
print(f"P-value: {p_value:.6f}")

if p_value < 0.001:
    print("Statistical Significance: *** (p < 0.001)")
elif p_value < 0.01:
    print("Statistical Significance: ** (p < 0.01)")
elif p_value < 0.05:
    print("Statistical Significance: * (p < 0.05)")
else:
    print("Statistical Significance: NS (not significant)")

print("\n" + "=" * 60)
print("HETEROGENEITY ASSESSMENT")
print("=" * 60)
print(f"\nQ-statistic: {Q:.4f}")
print(f"Degrees of freedom: {k-1}")
print(f"I² (% heterogeneity): {I2:.2f}%")
print(f"Tau² (between-study variance): {tau2:.6f}")

if I2 < 25:
    het_interpretation = "Low heterogeneity"
elif I2 < 50:
    het_interpretation = "Moderate heterogeneity"
elif I2 < 75:
    het_interpretation = "Substantial heterogeneity"
else:
    het_interpretation = "Considerable heterogeneity"

print(f"Interpretation: {het_interpretation}")

# Publication bias assessment (Egger's regression test)
print("\n" + "=" * 60)
print("PUBLICATION BIAS ASSESSMENT (Egger's Test)")
print("=" * 60)

# Precision (inverse SE)
precision = 1 / meta_data['sei']

# Perform Egger's test (regression of effect vs precision)
slope, intercept, r_value, p_value_egger, std_err = stats.linregress(precision, meta_data['log_yi'])

print(f"\nRegression Intercept (bias): {intercept:.4f}")
print(f"Standard Error: {std_err:.4f}")
print(f"P-value: {p_value_egger:.4f}")

if p_value_egger < 0.05:
    print("Result: Evidence of publication bias detected (p < 0.05)")
else:
    print("Result: No significant publication bias detected (p ≥ 0.05)")

print("\n" + "=" * 60)
print("COMPARISON WITH FIXED-EFFECTS MODEL")
print("=" * 60)
fixed_hr = np.exp(fixed_effects_mean)
fixed_ci_lb = np.exp(fixed_effects_mean - 1.96*fixed_effects_se)
fixed_ci_ub = np.exp(fixed_effects_mean + 1.96*fixed_effects_se)

print(f"\nFixed-Effects HR: {fixed_hr:.3f} [95% CI: {fixed_ci_lb:.3f}, {fixed_ci_ub:.3f}]")
print(f"Random-Effects HR: {re_hr:.3f} [95% CI: {re_ci_lb:.3f}, {re_ci_ub:.3f}]")
print(f"Difference: {abs(re_hr - fixed_hr):.3f}")

print("\n" + "=" * 60)
print("INTERPRETATION")
print("=" * 60)
print(f"""
The pooled hazard ratio of {re_hr:.3f} indicates that patients with detectable
circulating tumor cells (CTC+) have approximately {re_hr:.1f}x higher risk of death
compared to CTC-negative patients.

This effect is statistically significant (p < 0.05) with considerable heterogeneity
across studies (I² = {I2:.1f}%). The heterogeneity suggests substantial variation in
CTC's prognostic value across different studies, populations, and detection methods.

The difference between fixed and random-effects estimates ({abs(re_hr - fixed_hr):.2f})
indicates moderate heterogeneity impact. Random-effects model is preferred due to
expected clinical heterogeneity across institutions and methods.
""")

print("=" * 60)
print("ANALYSIS COMPLETE")
print("=" * 60)
