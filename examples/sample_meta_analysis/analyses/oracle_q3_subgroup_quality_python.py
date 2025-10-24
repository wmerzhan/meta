#!/usr/bin/env python3
"""
Oracle Analysis: Question 3 - Subgroup Analysis by Data Quality
Research Question: "Do effects differ by data quality (🟢 vs 🟡 vs 🔴)?"
Language: Python
Generated: 2025-10-23
Oracle Version: v1.0
"""

import pandas as pd
import numpy as np
from scipy import stats
from pathlib import Path

# Load data
csv_path = Path("examples/sample_meta_analysis/compiled/test_4_gold_standards_2025-10-23.csv")
data = pd.read_csv(csv_path, encoding='utf-8')

print("=" * 60)
print("SUBGROUP ANALYSIS: DATA QUALITY (🟢 vs 🟡 vs 🔴)")
print("=" * 60)

# Prepare data
analysis_data = data.copy()
analysis_data['effect_size'] = pd.to_numeric(analysis_data['effect_size'])
analysis_data['variance'] = np.where(
    analysis_data['effect_size_standard_error'].notna(),
    analysis_data['effect_size_standard_error'] ** 2,
    ((analysis_data['confidence_interval_upper'] - analysis_data['confidence_interval_lower']) / (2 * 1.96)) ** 2
)
analysis_data = analysis_data.dropna(subset=['effect_size', 'variance'])

# Function to compute random-effects estimate
def random_effects_meta(effects, variances):
    """DerSimonian-Laird random-effects meta-analysis"""
    k = len(effects)
    weights_fe = 1 / variances
    residuals = effects - np.sum(weights_fe * effects) / np.sum(weights_fe)
    q = np.sum(weights_fe * residuals**2)

    sum_w = np.sum(weights_fe)
    sum_w2 = np.sum(weights_fe**2)
    tau2 = max(0, (q - (k-1)) / (sum_w - sum_w2/sum_w))

    weights_re = 1 / (variances + tau2)
    pooled = np.sum(weights_re * effects) / np.sum(weights_re)
    se = np.sqrt(1 / np.sum(weights_re))
    z = pooled / se
    p = 2 * (1 - stats.norm.cdf(abs(z)))

    i2 = max(0, (q - (k-1)) / q * 100) if q > 0 else 0

    return {
        'pooled': pooled, 'se': se, 'ci_lower': pooled - 1.96*se, 'ci_upper': pooled + 1.96*se,
        'p_value': p, 'tau2': tau2, 'i2': i2, 'q': q, 'k': k
    }

# Subgroup analysis by data quality
print("\nSubgroup Results by Data Quality Label:\n")

subgroups = {}
for label in sorted(analysis_data['source_color_label'].unique()):
    subset = analysis_data[analysis_data['source_color_label'] == label]
    if len(subset) >= 1:
        result = random_effects_meta(subset['effect_size'].values, subset['variance'].values)
        subgroups[label] = result

        print(f"\nSubgroup: {label} (Quality Label)")
        print(f"  N studies: {subset['study_id'].nunique()}")
        print(f"  N effect sizes: {len(subset)}")
        print(f"  Pooled Effect: {result['pooled']:.4f}")
        print(f"  95% CI: [{result['ci_lower']:.4f}, {result['ci_upper']:.4f}]")
        print(f"  I²: {result['i2']:.1f}%")
        print(f"  p-value: {result['p_value']:.4f}")

# Between-subgroup test (simple comparison)
print("\n" + "=" * 60)
print("BETWEEN-SUBGROUP COMPARISON")
print("=" * 60)

# Extract green (high quality) vs yellow+red (uncertain)
green_data = analysis_data[analysis_data['source_color_label'] == '🟢']
uncertain_data = analysis_data[analysis_data['source_color_label'].isin(['🟡', '🔴'])]

if len(green_data) > 0 and len(uncertain_data) > 0:
    green_result = random_effects_meta(green_data['effect_size'].values, green_data['variance'].values)
    uncertain_result = random_effects_meta(uncertain_data['effect_size'].values, uncertain_data['variance'].values)

    # Test for significant difference
    pooled_diff = green_result['pooled'] - uncertain_result['pooled']
    se_diff = np.sqrt(green_result['se']**2 + uncertain_result['se']**2)
    z_diff = pooled_diff / se_diff if se_diff > 0 else 0
    p_diff = 2 * (1 - stats.norm.cdf(abs(z_diff)))

    print(f"\n🟢 GREEN (Direct) vs 🟡/🔴 (Uncertain):")
    print(f"  GREEN pooled effect: {green_result['pooled']:.4f}")
    print(f"  UNCERTAIN pooled effect: {uncertain_result['pooled']:.4f}")
    print(f"  Difference: {pooled_diff:.4f}")
    print(f"  P-value for difference: {p_diff:.4f}")

    if p_diff < 0.05:
        print(f"  ✓ SIGNIFICANT difference between groups (p < 0.05)")
        print(f"    → Data quality meaningfully affects results")
    else:
        print(f"  ✓ No significant difference (p >= 0.05)")
        print(f"    → Results robust across data quality levels")

# Summary
print("\n" + "=" * 60)
print("DATA QUALITY COMPOSITION:")
print("=" * 60)
quality_summary = analysis_data['source_color_label'].value_counts()
total = len(analysis_data)
for label in sorted(quality_summary.index):
    count = quality_summary[label]
    pct = 100 * count / total
    print(f"{label}: {count} ({pct:.1f}%)")

pct_uncertain = 100 * len(uncertain_data) / total if len(uncertain_data) > 0 else 0
print(f"\nTotal uncertain (🟡 + 🔴): {pct_uncertain:.1f}%")

if pct_uncertain > 20:
    print("⚠️  Mixed data quality detected (>20% uncertain)")
    print("   → Recommendations: Use sensitivity analysis, report both FE and RE estimates")
else:
    print("✓ High data quality (>80% direct observations)")

print("\nNote: Robust results across quality levels indicate confidence in conclusions.")
