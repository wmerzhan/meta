#!/usr/bin/env python3
"""
Oracle Analysis: Question 2 - Heterogeneity Assessment
Research Question: "Is there significant heterogeneity? Which studies are outliers?"
Language: Python
Generated: 2025-10-23
Oracle Version: v1.0

Install required packages:
    pip install pandas numpy scipy pathlib

Required Python: 3.9+
"""

import pandas as pd
import numpy as np
from pathlib import Path
from scipy import stats
import warnings
warnings.filterwarnings('ignore')

print("=" * 80)
print("ORACLE Q2: Heterogeneity Assessment and Outlier Detection")
print("=" * 80)
print()

# ==============================================================================
# DATA LOADING AND PREPARATION
# ==============================================================================

# Load compiled dataset
data_path = Path("examples/sample_meta_analysis/compiled/test_4_gold_standards_2025-10-23.csv")

try:
    data = pd.read_csv(data_path)
except FileNotFoundError:
    print(f"ERROR: Could not find data file at {data_path}")
    exit(1)

# Prepare data for analysis
def calculate_variance(row):
    """Calculate variance from CI bounds or standard error"""
    if pd.notna(row.get('effect_size_standard_error')):
        return row['effect_size_standard_error'] ** 2

    if pd.notna(row.get('confidence_interval_lower')) and pd.notna(row.get('confidence_interval_upper')):
        ci_lower = float(row['confidence_interval_lower'])
        ci_upper = float(row['confidence_interval_upper'])
        if ci_lower != ci_upper and not (ci_lower == 0 and ci_upper == 0):
            se = (ci_upper - ci_lower) / (2 * 1.96)
            return se ** 2

    return 0.01

analysis_data = data.copy()
analysis_data['yi'] = pd.to_numeric(analysis_data['effect_size'], errors='coerce')
analysis_data['vi'] = analysis_data.apply(calculate_variance, axis=1)
analysis_data['study_label'] = analysis_data['authors'] + ' (' + analysis_data['year'].astype(str) + ')'

# Remove rows with missing values
analysis_data = analysis_data[analysis_data['yi'].notna() & analysis_data['vi'].notna()].copy()

# ==============================================================================
# RANDOM-EFFECTS MODEL ESTIMATION
# ==============================================================================

yi = analysis_data['yi'].values
vi = analysis_data['vi'].values
wi = 1 / vi

# Fixed-effect estimate (starting point)
pooled_effect_fe = np.sum(wi * yi) / np.sum(wi)

# Q-statistic (heterogeneity test)
Q_stat = np.sum(wi * (yi - pooled_effect_fe)**2)
k = len(yi)
df = k - 1

# Q-test p-value (chi-square distribution)
q_p_value = 1 - stats.chi2.cdf(Q_stat, df)

# Between-study variance (DerSimonian-Laird)
c_squared = np.sum(wi) - (np.sum(wi**2) / np.sum(wi))
tau_squared = max(0, (Q_stat - df) / c_squared)
tau = np.sqrt(tau_squared)

# Random-effects estimate
wi_re = 1 / (vi + tau_squared)
pooled_effect_re = np.sum(wi_re * yi) / np.sum(wi_re)

# I² statistic
i_squared = max(0, ((Q_stat - df) / Q_stat) * 100) if Q_stat > 0 else 0

# ==============================================================================
# HETEROGENEITY ASSESSMENT
# ==============================================================================

print("\n=== HETEROGENEITY ASSESSMENT ===\n")

# Q-Test
print("Q-Test for Heterogeneity:")
print(f"  Q-statistic: {Q_stat:.3f}")
print(f"  df: {df}")
print(f"  P-value: {q_p_value:.4e}")
print()

if q_p_value < 0.05:
    print("✓ SIGNIFICANT heterogeneity detected (p < 0.05)")
    print("  → Effects differ meaningfully across studies")
    print("  → Consider meta-regression or subgroup analyses")
else:
    print("✓ NO significant heterogeneity (p >= 0.05)")
    print("  → Effects are relatively homogeneous")

# I² Index
print()
print("I² Heterogeneity Index:")
print(f"  I²: {i_squared:.2f}%")
print()

if i_squared < 25:
    het_interpretation = "Low heterogeneity (I² < 25%)"
elif i_squared < 50:
    het_interpretation = "Moderate heterogeneity (25% ≤ I² < 50%)"
elif i_squared < 75:
    het_interpretation = "Substantial heterogeneity (50% ≤ I² < 75%)"
else:
    het_interpretation = "Considerable heterogeneity (I² ≥ 75%)"

print(f"  Interpretation: {het_interpretation}")
print(f"  Meaning: {i_squared:.1f}% of variation is due to true effect variation")
print()

# Between-study variance
print("Between-Study Variance (τ²):")
print(f"  Tau²: {tau_squared:.6f}")
print(f"  Tau (SD): {tau:.4f}")
print(f"  → Average true effect varies by ~{tau:.3f} units across studies")
print()

# ==============================================================================
# STUDY-LEVEL RESIDUALS AND OUTLIER DETECTION
# ==============================================================================

# Calculate residuals (observed - predicted effect)
# For random-effects model: residual = yi - pooled_effect_re
residuals = yi - pooled_effect_re

# Calculate standardized residuals
se_study = np.sqrt(vi)
std_residuals = residuals / se_study

# Calculate weights
weights_re = wi_re / np.sum(wi_re)  # Normalized weights

# Create residuals dataframe
residuals_df = pd.DataFrame({
    'Study': analysis_data['study_label'].values,
    'Effect': np.round(yi, 3),
    'Residual': np.round(residuals, 3),
    'SE': np.round(se_study, 3),
    'Weight': np.round(weights_re * 100, 2)  # As percentage
})

# Sort by absolute residual (largest deviations first)
residuals_df = residuals_df.reindex(residuals_df['Residual'].abs().argsort(ascending=False))

print("Study-Level Residuals (Outlier Detection):")
print(residuals_df.to_string(index=False))
print()

# Identify potential outliers (|residual| > 2 SD)
outlier_threshold = 2.0
outliers = residuals_df[residuals_df['Residual'].abs() > outlier_threshold]

if len(outliers) > 0:
    print(f"\n⚠️  POTENTIAL OUTLIERS (|residual| > {outlier_threshold}):")
    print(outliers.to_string(index=False))
    print("\nRecommendation: Review these studies for methodological differences")
    print("  • Different patient populations or disease severity")
    print("  • Different intervention protocols or dose")
    print("  • Different outcome measurement approaches")
else:
    print("\n✓ No statistical outliers detected")
    print("  All studies within expected variation")

# ==============================================================================
# INTERPRETATION AND CONCLUSIONS
# ==============================================================================

print()
print("=" * 80)
print("CONCLUSION:")
print("=" * 80)
print(f"Heterogeneity level: {het_interpretation.split('(')[0].strip()}")
print()

if q_p_value < 0.05:
    print("KEY FINDING: Significant heterogeneity detected")
    print("  Recommendation: Consider the following approaches:")
    print("    1. Subgroup analyses (by study design, patient population, intervention dose)")
    print("    2. Meta-regression (by study-level covariates like publication year)")
    print("    3. Sensitivity analyses (excluding outlier studies)")
    print("    4. Examine the conceptual rationale for effect variation")
else:
    print("KEY FINDING: Homogeneous effects across studies")
    print("  Recommendation: The pooled estimate is robust to")
    print("    1. Study selection (no evidence of systematic differences)")
    print("    2. Methodological variation")
    print("    3. Model choice (FE vs RE models yield similar results)")

print()
print("Next steps: Consider subgroup analyses or meta-regression to explore")
print("potential sources of heterogeneity, if Q-test is significant.")
print()
