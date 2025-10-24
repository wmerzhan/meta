#!/usr/bin/env python3
"""
Oracle Analysis: Question 1 - Pooled Effect Size Calculation
Research Question: "What is the pooled effect size with 95% confidence interval?"
Language: Python
Data Source: tests/validation/gold_standards/ (4 studies)
Generated: 2025-10-23
Oracle Version: v1.0
Compatible Models: Claude 3.5 Sonnet+, Claude Opus 3+

Install required packages:
    pip install pandas numpy scipy matplotlib pathlib

Required Python: 3.9+
"""

import pandas as pd
import numpy as np
from pathlib import Path
from scipy import stats
import matplotlib.pyplot as plt
import warnings
warnings.filterwarnings('ignore')

# ==============================================================================
# SETUP AND DATA LOADING
# ==============================================================================

print("=" * 80)
print("ORACLE Q1: Pooled Effect Size Calculation (Fixed-Effect & Random-Effects)")
print("=" * 80)
print()

# Load compiled dataset using pathlib for cross-platform paths
data_path = Path("examples/sample_meta_analysis/compiled/test_4_gold_standards_2025-10-23.csv")

try:
    data = pd.read_csv(data_path)
except FileNotFoundError:
    print(f"ERROR: Could not find data file at {data_path}")
    print("Please ensure the CSV file exists at the specified path.")
    exit(1)

# Display basic information
print("Dataset Summary:")
print(f"  Total effect sizes: {len(data)}")
print(f"  Unique studies: {data['study_id'].nunique()}")
print(f"  Date range: {data['year'].min()}-{data['year'].max()}")
print()

# ==============================================================================
# STEP 1: DATA PREPARATION AND VALIDATION
# ==============================================================================

print("STEP 1: Data Preparation")
print("=" * 80)
print()

# Create analysis dataset with required columns for meta-analysis
# Meta-analysis requires: yi (effect size) and vi (variance)

analysis_data = data.copy()

# Calculate variance from confidence intervals
# If CI available: SE = (CI_upper - CI_lower) / (2 * 1.96), then var = SE²
def calculate_variance(row):
    """Calculate variance from CI bounds or standard error"""
    # If standard error is available
    if pd.notna(row.get('effect_size_standard_error')):
        return row['effect_size_standard_error'] ** 2

    # If CI bounds available
    if pd.notna(row.get('confidence_interval_lower')) and pd.notna(row.get('confidence_interval_upper')):
        ci_lower = float(row['confidence_interval_lower'])
        ci_upper = float(row['confidence_interval_upper'])
        if ci_lower != ci_upper and not (ci_lower == 0 and ci_upper == 0):
            se = (ci_upper - ci_lower) / (2 * 1.96)
            return se ** 2

    # Default: use effect size uncertainty (conservative estimate)
    return 0.01

analysis_data['yi'] = pd.to_numeric(analysis_data['effect_size'], errors='coerce')
analysis_data['vi'] = analysis_data.apply(calculate_variance, axis=1)

# Create study labels for forest plot
analysis_data['study_label'] = analysis_data['authors'] + ' (' + analysis_data['year'].astype(str) + ')'

# Classify data quality
def classify_quality(label):
    """Map color emoji to quality classification"""
    if label == "🟢":
        return "direct"
    elif label == "🟡":
        return "computed"
    elif label == "🔴":
        return "uncertain"
    else:
        return "unknown"

analysis_data['data_quality'] = analysis_data['source_color_label'].apply(classify_quality)

# Remove rows with missing effect size or variance
analysis_data = analysis_data[analysis_data['yi'].notna() & analysis_data['vi'].notna()].copy()

print("Prepared dataset:")
print(f"  Total effect sizes available: {len(analysis_data)}")
print(f"  Unique studies: {analysis_data['study_id'].nunique()}")
print(f"  Effect size range: {analysis_data['yi'].min():.3f} to {analysis_data['yi'].max():.3f}")
print()

# ==============================================================================
# STEP 2: FIXED-EFFECT MODEL
# ==============================================================================

print("STEP 2: Fixed-Effect Meta-Analysis")
print("=" * 80)
print()

# Fixed-effect model using inverse variance weighting
# Assumes all studies estimate the same true effect

yi = analysis_data['yi'].values
vi = analysis_data['vi'].values
wi = 1 / vi  # Inverse variance weights

# Weighted mean (fixed-effect estimate)
pooled_effect_fe = np.sum(wi * yi) / np.sum(wi)

# Variance of pooled estimate
var_pooled_fe = 1 / np.sum(wi)
se_pooled_fe = np.sqrt(var_pooled_fe)

# Z-statistic and p-value
z_stat_fe = pooled_effect_fe / se_pooled_fe
p_val_fe = 2 * (1 - stats.norm.cdf(abs(z_stat_fe)))

# 95% Confidence interval
ci_lower_fe = pooled_effect_fe - 1.96 * se_pooled_fe
ci_upper_fe = pooled_effect_fe + 1.96 * se_pooled_fe

print("Fixed-Effect Summary:")
print(f"Pooled Effect Size: {pooled_effect_fe:.4f}")
print(f"95% CI: [{ci_lower_fe:.4f}, {ci_upper_fe:.4f}]")
print(f"Standard Error: {se_pooled_fe:.4f}")
print(f"Z-statistic: {z_stat_fe:.4f}")
print(f"P-value: {p_val_fe:.4e}")
print()

# ==============================================================================
# STEP 3: RANDOM-EFFECTS MODEL (DerSimonian-Laird)
# ==============================================================================

print("STEP 3: Random-Effects Meta-Analysis (DerSimonian-Laird)")
print("=" * 80)
print()

# Random-effects model accounts for heterogeneity
# Uses DerSimonian-Laird estimator for between-study variance (tau²)

k = len(yi)  # number of studies

# Calculate Q-statistic (homogeneity test)
Q_stat = np.sum(wi * (yi - pooled_effect_fe)**2)

# Degrees of freedom
df = k - 1

# Q-test p-value (chi-square distribution)
q_p_value = 1 - stats.chi2.cdf(Q_stat, df)

# Calculate tau² (between-study variance) using DerSimonian-Laird
c_squared = np.sum(wi) - (np.sum(wi**2) / np.sum(wi))
tau_squared = max(0, (Q_stat - df) / c_squared)  # Ensure non-negative

tau = np.sqrt(tau_squared)

# Random-effects weights
wi_re = 1 / (vi + tau_squared)

# Weighted mean (random-effects estimate)
pooled_effect_re = np.sum(wi_re * yi) / np.sum(wi_re)

# Variance of pooled RE estimate
var_pooled_re = 1 / np.sum(wi_re)
se_pooled_re = np.sqrt(var_pooled_re)

# Z-statistic and p-value
z_stat_re = pooled_effect_re / se_pooled_re
p_val_re = 2 * (1 - stats.norm.cdf(abs(z_stat_re)))

# 95% Confidence interval
ci_lower_re = pooled_effect_re - 1.96 * se_pooled_re
ci_upper_re = pooled_effect_re + 1.96 * se_pooled_re

print("Random-Effects Summary:")
print(f"Pooled Effect Size: {pooled_effect_re:.4f}")
print(f"95% CI: [{ci_lower_re:.4f}, {ci_upper_re:.4f}]")
print(f"Standard Error: {se_pooled_re:.4f}")
print(f"Z-statistic: {z_stat_re:.4f}")
print(f"P-value: {p_val_re:.4e}")
print()
print("Between-Study Parameters:")
print(f"  Tau² (variance of true effects): {tau_squared:.6f}")
print(f"  Tau (SD of true effects): {tau:.4f}")
print()

# ==============================================================================
# STEP 4: HETEROGENEITY ASSESSMENT
# ==============================================================================

print("STEP 4: Heterogeneity Assessment")
print("=" * 80)
print()

# Q-test: Chi-square test for heterogeneity
# H₀: All true effects are equal (homogeneous)
print("Q-Test for Heterogeneity (homogeneity test):")
print(f"  Q-statistic: {Q_stat:.4f}")
print(f"  df (degrees of freedom): {df}")
print(f"  P-value: {q_p_value:.4e}")

if q_p_value < 0.05:
    print("  *** Significant heterogeneity detected (p < 0.05) ***")
    print("  Interpretation: Effects differ significantly across studies")
else:
    print("  ✓ No significant heterogeneity (p ≥ 0.05)")
    print("  Interpretation: Effects are relatively consistent across studies")

# I² statistic: percentage of variation due to heterogeneity
# I² = (Q - df) / Q * 100
# <25%: low | 25-50%: moderate | 50-75%: substantial | >75%: considerable
i_squared = max(0, ((Q_stat - df) / Q_stat) * 100) if Q_stat > 0 else 0

print()
print("I² Heterogeneity Index:")
print(f"  I²: {i_squared:.2f}%")

if i_squared < 25:
    het_interpretation = "Low heterogeneity"
elif i_squared < 50:
    het_interpretation = "Moderate heterogeneity"
elif i_squared < 75:
    het_interpretation = "Substantial heterogeneity"
else:
    het_interpretation = "Considerable heterogeneity"

print(f"  Interpretation: {het_interpretation}")
print(f"  Meaning: {i_squared:.1f}% of variation is due to heterogeneity")
print()

# ==============================================================================
# STEP 5: DATA QUALITY ASSESSMENT
# ==============================================================================

print("STEP 5: Data Quality Assessment")
print("=" * 80)
print()

# Count data points by source quality label
quality_counts = analysis_data['source_color_label'].value_counts().sort_values(ascending=False)

print("Data Quality Distribution (by source label):")
for label, count in quality_counts.items():
    pct = 100 * count / len(analysis_data)
    print(f"  {label}: {count} ({pct:.1f}%)")

total_uncertain = len(analysis_data[analysis_data['source_color_label'].isin(['🟡', '🔴'])])
pct_uncertain = 100 * total_uncertain / len(analysis_data)

print()
print(f"Total uncertain/computed data (🟡 + 🔴): {total_uncertain} out of {len(analysis_data)} ({pct_uncertain:.1f}%)")

if pct_uncertain > 20:
    print("⚠️  WARNING: Data quality mixed (>20% uncertain/computed)")
    print("   Recommendation: Perform sensitivity analysis with 🟢 data only")
else:
    print("✓ Data quality good (<20% uncertain/computed)")

print()

# ==============================================================================
# STEP 6: SENSITIVITY ANALYSIS - DATA QUALITY
# ==============================================================================

print("STEP 6: Sensitivity Analysis (Quality-Restricted)")
print("=" * 80)
print()

# Restrict analysis to high-quality data only (🟢 labels)
quality_subset = analysis_data[analysis_data['source_color_label'] == '🟢']

if len(quality_subset) > 1:
    yi_sens = quality_subset['yi'].values
    vi_sens = quality_subset['vi'].values
    wi_sens_re = 1 / (vi_sens + tau_squared)

    # Sensitive RE estimate
    pooled_sens = np.sum(wi_sens_re * yi_sens) / np.sum(wi_sens_re)
    var_sens = 1 / np.sum(wi_sens_re)
    se_sens = np.sqrt(var_sens)
    ci_lower_sens = pooled_sens - 1.96 * se_sens
    ci_upper_sens = pooled_sens + 1.96 * se_sens

    # Calculate I² for sensitivity model
    Q_sens = np.sum(wi_sens_re * (yi_sens - pooled_sens)**2)
    i2_sens = max(0, ((Q_sens - (len(yi_sens)-1)) / Q_sens) * 100) if Q_sens > 0 else 0

    print("Sensitivity Model (🟢 data only):")
    print(f"  Effect sizes included: {len(quality_subset)} (excluded: {len(analysis_data) - len(quality_subset)})")
    print(f"  Pooled Effect: {pooled_sens:.4f}")
    print(f"  95% CI: [{ci_lower_sens:.4f}, {ci_upper_sens:.4f}]")
    print(f"  I²: {i2_sens:.2f}%")
    print()

    # Compare sensitivity to main model
    effect_change = abs((pooled_sens - pooled_effect_re) / pooled_effect_re) * 100 if pooled_effect_re != 0 else 0

    print("Comparison to Main Model:")
    print(f"  Main model effect: {pooled_effect_re:.4f}")
    print(f"  Sensitive model effect: {pooled_sens:.4f}")
    print(f"  Relative change: {effect_change:.1f}%")
    print()

    if effect_change > 10:
        print("  ⚠️  Results sensitive to data quality (change > 10%)")
        print("  Interpretation: Exclude uncertain data cautiously; results depend on data included")
    else:
        print("  ✓ Results robust to data quality (change < 10%)")
        print("  Interpretation: Main conclusions stable even when excluding uncertain data")
else:
    print("Insufficient 🟢 data for sensitivity analysis (n < 2)")

print()

# ==============================================================================
# STEP 7: FOREST PLOT VISUALIZATION
# ==============================================================================

print("STEP 7: Forest Plot Generation")
print("=" * 80)
print()

# Create forest plot showing individual study effects and pooled estimate
fig, ax = plt.subplots(figsize=(12, 8))

# Sort by effect size for better visualization
plot_data = analysis_data.sort_values('yi').reset_index(drop=True)
plot_yi = plot_data['yi'].values
plot_vi = plot_data['vi'].values
plot_se = np.sqrt(plot_vi)
plot_labels = plot_data['study_label'].values
plot_wi = 1 / plot_vi

# Y-positions
y_pos = np.arange(len(plot_yi), 0, -1)

# Plot individual studies with error bars (95% CI)
for i, (y, effect, se, label) in enumerate(zip(y_pos, plot_yi, plot_se, plot_labels)):
    ci_lower = effect - 1.96 * se
    ci_upper = effect + 1.96 * se

    # Color code by quality
    color = '#2E7D32' if plot_data.iloc[i]['source_color_label'] == '🟢' else '#FF9800'

    # Plot point estimate
    ax.plot(effect, y, 'o', markersize=8, color=color, zorder=3)

    # Plot confidence interval line
    ax.plot([ci_lower, ci_upper], [y, y], '-', linewidth=2, color=color, alpha=0.7)

    # Plot whiskers
    ax.plot([ci_lower, ci_lower], [y-0.1, y+0.1], '-', color=color, linewidth=1.5)
    ax.plot([ci_upper, ci_upper], [y-0.1, y+0.1], '-', color=color, linewidth=1.5)

# Plot pooled estimate (random-effects)
y_pooled = 0.5
ax.plot(pooled_effect_re, y_pooled, 's', markersize=12, color='darkblue', zorder=4, label='Pooled Effect (RE)')
ci_lower_plot = ci_lower_re - 1.96 * se_pooled_re
ci_upper_plot = ci_upper_re + 1.96 * se_pooled_re
ax.plot([ci_lower_plot, ci_upper_plot], [y_pooled, y_pooled], '-', linewidth=3, color='darkblue', alpha=0.8)

# Vertical reference line at null effect
ax.axvline(x=0, color='red', linestyle='--', linewidth=1.5, alpha=0.5, label='Null Effect')

# Formatting
ax.set_yticks(y_pos)
ax.set_yticklabels(plot_labels, fontsize=9)
ax.set_ylabel('Study', fontsize=11, fontweight='bold')
ax.set_xlabel('Effect Size [95% CI]', fontsize=11, fontweight='bold')
ax.set_title('Forest Plot: Pooled Effect Size with 95% Confidence Intervals\n(Random-Effects Model)',
             fontsize=12, fontweight='bold', pad=20)
ax.grid(axis='x', alpha=0.3)
ax.legend(loc='best', fontsize=10)

plt.tight_layout()
plt.savefig('forest_plot_q1_python.png', dpi=300, bbox_inches='tight')
print("✓ Forest plot saved to: forest_plot_q1_python.png")
print()

# ==============================================================================
# STEP 8: FINAL SUMMARY AND INTERPRETATION
# ==============================================================================

print()
print("FINAL RESULTS SUMMARY")
print("=" * 80)
print()

print("POOLED EFFECT SIZE ESTIMATES:")
print(f"  Fixed-Effect Model:    {pooled_effect_fe:.4f} [{ci_lower_fe:.4f} to {ci_upper_fe:.4f}]")
print(f"  Random-Effects Model:  {pooled_effect_re:.4f} [{ci_lower_re:.4f} to {ci_upper_re:.4f}]")
print()

# Interpretation guidance
print("INTERPRETATION:")

# Effect size magnitude
def effect_magnitude(d):
    d_abs = abs(d)
    if d_abs < 0.2:
        return "negligible"
    elif d_abs < 0.5:
        return "small"
    elif d_abs < 0.8:
        return "medium"
    else:
        return "large"

magnitude = effect_magnitude(pooled_effect_re)
direction = "positive" if pooled_effect_re > 0 else "negative"
significant = "YES" if (ci_lower_re * ci_upper_re) > 0 else "NO"

print(f"  Effect Size Magnitude: {magnitude}")
print(f"  Direction: {direction}")
print(f"  Statistically Significant (p < 0.05): {significant}")
print(f"  Heterogeneity Level: {het_interpretation}")
print()

if q_p_value < 0.05:
    print("KEY FINDING: Significant heterogeneity detected.")
    print("  → Consider subgroup analyses to explore sources of variation")
    print("  → Random-effects model preferred over fixed-effect")
else:
    print("KEY FINDING: Effects consistent across studies (homogeneous).")
    print("  → Fixed and random-effects models yield similar results")
    print("  → Pooled effect is robust")

print()
print("CONCLUSION:")
if (ci_lower_re * ci_upper_re) > 0:
    print(f"  The intervention has a statistically significant {direction} effect.")
else:
    print("  The intervention effect is not statistically significantly different from zero.")

print(f"  Pooled estimate: {pooled_effect_re:.3f} [95% CI: {ci_lower_re:.3f} to {ci_upper_re:.3f}]")
print("  Recommendation: Report both FE and RE estimates given I² level")

print()
print("Note: This analysis is provided for educational and exploratory purposes.")
print("For publication, ensure statistical assumptions are validated and sensitivity")
print("analyses are performed across key parameters.")
print()
