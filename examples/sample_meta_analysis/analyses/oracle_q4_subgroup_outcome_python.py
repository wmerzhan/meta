#!/usr/bin/env python3
"""
Oracle Analysis: Question 4 - Subgroup Analysis by Outcome Type
Research Question: "Do effects differ by outcome_measure (different study outcomes)?"
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
print("ORACLE Q4: Subgroup Analysis by Outcome Type")
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
# HELPER FUNCTION FOR RANDOM-EFFECTS META-ANALYSIS
# ==============================================================================

def random_effects_analysis(effect_sizes, variances):
    """
    Perform random-effects meta-analysis using DerSimonian-Laird estimator
    Returns dictionary with pooled effect, CI, se, and other statistics
    """
    yi = np.array(effect_sizes)
    vi = np.array(variances)
    wi = 1 / vi
    k = len(yi)

    # Fixed-effect estimate (for calculating Q)
    pooled_fe = np.sum(wi * yi) / np.sum(wi)

    # Q-statistic
    Q_stat = np.sum(wi * (yi - pooled_fe)**2)
    df = k - 1

    # Between-study variance (DerSimonian-Laird)
    c_squared = np.sum(wi) - (np.sum(wi**2) / np.sum(wi))
    tau_squared = max(0, (Q_stat - df) / c_squared)

    # Random-effects weights and estimate
    wi_re = 1 / (vi + tau_squared)
    pooled_re = np.sum(wi_re * yi) / np.sum(wi_re)

    # Variance and SE of pooled estimate
    var_pooled = 1 / np.sum(wi_re)
    se_pooled = np.sqrt(var_pooled)

    # Z-statistic and p-value
    z_stat = pooled_re / se_pooled if se_pooled > 0 else 0
    p_value = 2 * (1 - stats.norm.cdf(abs(z_stat)))

    # 95% CI
    ci_lower = pooled_re - 1.96 * se_pooled
    ci_upper = pooled_re + 1.96 * se_pooled

    # I² statistic
    i_squared = max(0, ((Q_stat - df) / Q_stat) * 100) if Q_stat > 0 else 0

    return {
        'pooled': pooled_re,
        'se': se_pooled,
        'ci_lower': ci_lower,
        'ci_upper': ci_upper,
        'p_value': p_value,
        'tau2': tau_squared,
        'i2': i_squared,
        'Q': Q_stat,
        'k': k
    }

# ==============================================================================
# IDENTIFY OUTCOME TYPES AND PERFORM SUBGROUP ANALYSIS
# ==============================================================================

print("\n=== SUBGROUP ANALYSIS BY OUTCOME TYPE ===\n")

# Get unique outcome measures
outcomes = sorted(analysis_data['outcome_measure'].unique())

print("Outcomes identified in data:")
for i, outcome in enumerate(outcomes, 1):
    subset = analysis_data[analysis_data['outcome_measure'] == outcome]
    print(f"{i}. {outcome} (n={len(subset)})")

print()
print("=" * 80)
print("Subgroup Results:")
print("=" * 80)

# Store results for between-subgroup test
subgroup_results = {}

for outcome in outcomes:
    subset = analysis_data[analysis_data['outcome_measure'] == outcome]

    if len(subset) >= 1:
        result = random_effects_analysis(subset['yi'].values, subset['vi'].values)
        subgroup_results[outcome] = result

        print()
        print(f"Outcome: {outcome}")
        print(f"  N studies: {subset['study_id'].nunique()}")
        print(f"  N effect sizes: {len(subset)}")
        print(f"  Pooled Effect: {result['pooled']:.4f}")
        print(f"  95% CI: [{result['ci_lower']:.4f}, {result['ci_upper']:.4f}]")
        print(f"  SE: {result['se']:.4f}")
        print(f"  I²: {result['i2']:.2f}%")
        print(f"  p-value: {result['p_value']:.4e}")

# ==============================================================================
# BETWEEN-SUBGROUP HETEROGENEITY TEST
# ==============================================================================

print()
print("\n" + "=" * 80)
print("BETWEEN-SUBGROUP HETEROGENEITY TEST")
print("=" * 80)
print()

if len(outcomes) > 1:
    # Calculate overall pooled effect
    yi_all = analysis_data['yi'].values
    vi_all = analysis_data['vi'].values
    overall_result = random_effects_analysis(yi_all, vi_all)

    # Calculate Q_between (heterogeneity between subgroups)
    # Q_between = Q_total - Q_within (residual)
    wi_all = 1 / vi_all
    pooled_overall = overall_result['pooled']

    Q_total = np.sum(wi_all * (yi_all - pooled_overall)**2)

    # Calculate within-subgroup Q
    Q_within = 0
    for outcome in outcomes:
        subset = analysis_data[analysis_data['outcome_measure'] == outcome]
        yi_sub = subset['yi'].values
        vi_sub = subset['vi'].values
        wi_sub = 1 / vi_sub
        pooled_sub = subgroup_results[outcome]['pooled']
        Q_within += np.sum(wi_sub * (yi_sub - pooled_sub)**2)

    Q_between = Q_total - Q_within
    df_between = len(outcomes) - 1

    # P-value for Q_between (chi-square distribution)
    p_between = 1 - stats.chi2.cdf(Q_between, df_between) if df_between > 0 else np.nan

    print("Mixed-Effects Model (Outcome Type as Moderator):")
    print(f"  Q_between (test for subgroup differences): {Q_between:.4f}")
    print(f"  df: {df_between}")
    print(f"  p-value: {p_between:.4e}")
    print()

    if p_between < 0.05:
        print("✓ SIGNIFICANT difference between outcome types (p < 0.05)")
        print("  → Effects vary meaningfully by outcome measure")
    else:
        print("✓ No significant difference between outcome types (p >= 0.05)")
        print("  → Effect sizes consistent across outcomes")

    # Report residual heterogeneity (within subgroups)
    print()
    print("Residual heterogeneity (within subgroups):")
    print(f"  Q_within: {Q_within:.4f}")
    print(f"  I² (residual): {max(0, (Q_within - (len(yi_all) - len(outcomes))) / Q_within * 100) if Q_within > 0 else 0:.2f}%")
    print()

    print("INTERPRETATION:")
    print("─" * 80)
    print()
    if p_between < 0.05:
        print("The significant Q_between indicates that outcome type moderates the")
        print("effect sizes. Different outcome measures show meaningfully different")
        print("results, suggesting:")
        print("  • The intervention works differently depending on what is measured")
        print("  • Some outcomes are more responsive to the intervention")
        print("  • Consider reporting outcome-specific estimates separately")
    else:
        print("The non-significant Q_between suggests that outcome type does NOT")
        print("meaningfully moderate the effects. Despite variation across outcomes,")
        print("the overall conclusions remain consistent, indicating:")
        print("  • The intervention effect is relatively stable across different measures")
        print("  • The pooled estimate is robust across outcome types")
        print("  • Reporting a single pooled estimate is appropriate")

else:
    print("Only one outcome type identified in data.")
    print("Cannot perform between-subgroup comparison (requires ≥2 subgroups).")

# ==============================================================================
# FINAL CONCLUSION
# ==============================================================================

print()
print("=" * 80)
print("CONCLUSION:")
print("=" * 80)
print()
print("Review outcome-specific effects above to assess consistency.")
print("Consider: Are differences clinically meaningful?")
print()
if len(outcomes) > 1:
    if p_between < 0.05:
        print("If substantial variation exists, report outcome-specific estimates.")
    else:
        print("Effects are consistent across outcomes; pooled estimate is reliable.")
else:
    print("Consult additional subgroups or sensitivity analyses for robustness.")

print()
