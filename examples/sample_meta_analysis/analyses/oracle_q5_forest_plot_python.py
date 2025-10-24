#!/usr/bin/env python3
"""
Oracle Analysis: Question 5 - Forest Plot Generation
Research Question: "Generate a forest plot showing all studies and pooled effect"
Language: Python with matplotlib
Generated: 2025-10-23
Oracle Version: v1.0
"""

import pandas as pd
import numpy as np
from scipy import stats
from pathlib import Path
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

# Load and prepare data
csv_path = Path("examples/sample_meta_analysis/compiled/test_4_gold_standards_2025-10-23.csv")
data = pd.read_csv(csv_path, encoding='utf-8')

print("Generating Forest Plot...")
print("=" * 60)

# Prepare analysis data
analysis_data = data.copy()
analysis_data['effect_size'] = pd.to_numeric(analysis_data['effect_size'])
analysis_data['variance'] = np.where(
    analysis_data['effect_size_standard_error'].notna(),
    analysis_data['effect_size_standard_error'] ** 2,
    ((analysis_data['confidence_interval_upper'] - analysis_data['confidence_interval_lower']) / (2 * 1.96)) ** 2
)
analysis_data = analysis_data.dropna(subset=['effect_size', 'variance'])
analysis_data = analysis_data.sort_values('effect_size')

# Compute random-effects pooled estimate
k = len(analysis_data)
weights = 1 / analysis_data['variance'].values
pooled_fe = np.sum(weights * analysis_data['effect_size'].values) / np.sum(weights)
residuals = analysis_data['effect_size'].values - pooled_fe
q_stat = np.sum(weights * residuals**2)

sum_w = np.sum(weights)
sum_w2 = np.sum(weights**2)
tau2 = max(0, (q_stat - (k - 1)) / (sum_w - sum_w2 / sum_w))

weights_re = 1 / (analysis_data['variance'].values + tau2)
pooled_re = np.sum(weights_re * analysis_data['effect_size'].values) / np.sum(weights_re)
se_re = np.sqrt(1 / np.sum(weights_re))

ci_lower_re = pooled_re - 1.96 * se_re
ci_upper_re = pooled_re + 1.96 * se_re

# Create figure
fig, ax = plt.subplots(figsize=(13, 8))

# Plot individual studies
y_positions = np.arange(len(analysis_data))
study_labels = [f"{row['authors'][:30]} ({int(row['year'])})"
                for _, row in analysis_data.iterrows()]

# Compute relative weights for point sizes
weights_normalized = weights_re / weights_re.max() * 100

for i, (idx, row) in enumerate(analysis_data.iterrows()):
    # Confidence interval line
    ci_lower = row['effect_size'] - 1.96 * np.sqrt(row['variance'])
    ci_upper = row['effect_size'] + 1.96 * np.sqrt(row['variance'])

    # Draw CI line
    ax.plot([ci_lower, ci_upper], [i, i], 'k-', linewidth=1.5, zorder=1)

    # Draw point estimate (size by weight)
    point_size = weights_normalized[i]
    color = 'darkgreen' if row['source_color_label'] == '🟢' else (
            'orange' if row['source_color_label'] == '🟡' else 'red')
    ax.scatter(row['effect_size'], i, s=point_size, c=color, zorder=3,
              edgecolors='black', linewidth=0.5)

# Add pooled effect (vertical lines)
ax.axvline(pooled_re, color='darkblue', linestyle='-', linewidth=2.5,
          label=f'Pooled Effect (RE): {pooled_re:.3f}', zorder=2)
ax.axvline(ci_lower_re, color='darkblue', linestyle='--', alpha=0.5, linewidth=1)
ax.axvline(ci_upper_re, color='darkblue', linestyle='--', alpha=0.5, linewidth=1)

# Add null effect line
ax.axvline(0, color='gray', linestyle=':', linewidth=1.5, alpha=0.7)

# Formatting
ax.set_yticks(y_positions)
ax.set_yticklabels(study_labels, fontsize=9)
ax.set_xlabel('Effect Size [95% CI]', fontsize=11, fontweight='bold')
ax.set_ylabel('Study', fontsize=11, fontweight='bold')
ax.set_title('Forest Plot: Meta-Analysis of Compiled Studies\nRandomEffects Model (DerSimonian-Laird)',
            fontsize=13, fontweight='bold')

# Add legend
green_patch = mpatches.Patch(color='darkgreen', label='🟢 Direct (High Quality)')
yellow_patch = mpatches.Patch(color='orange', label='🟡 Computed')
red_patch = mpatches.Patch(color='red', label='🔴 Uncertain (Low Quality)')
ax.legend(handles=[green_patch, yellow_patch, red_patch], loc='upper right')

# Grid
ax.grid(True, alpha=0.3, axis='x')
ax.set_axisbelow(True)

# Add text annotations
textstr = f'Studies: {k}\nPooled Effect: {pooled_re:.4f}\n95% CI: [{ci_lower_re:.4f}, {ci_upper_re:.4f}]\nI²: {max(0, (q_stat - (k-1)) / q_stat * 100):.1f}%'
props = dict(boxstyle='round', facecolor='wheat', alpha=0.8)
ax.text(0.02, 0.98, textstr, transform=ax.transAxes, fontsize=10,
       verticalalignment='top', bbox=props, family='monospace')

plt.tight_layout()

# Save figure
output_path = Path("forest_plot_q5.png")
plt.savefig(output_path, dpi=300, bbox_inches='tight')
print(f"✓ Forest plot saved to: {output_path}")

# Also save as PDF
pdf_path = Path("forest_plot_q5.pdf")
plt.savefig(pdf_path, dpi=300, bbox_inches='tight')
print(f"✓ PDF version saved to: {pdf_path}")

plt.show()

# Print interpretation
print("\n" + "=" * 60)
print("FOREST PLOT INTERPRETATION GUIDE")
print("=" * 60)
print("""
Element                Description
─────────────────────  ────────────────────────────────────────
Horizontal lines       95% confidence intervals for each study
Point (square/circle)  Study effect size (size ∝ weight)
🟢 Green points        Direct observations (high quality)
🟡 Orange points       Computed values (moderate quality)
🔴 Red points          Uncertain values (low quality)
Blue vertical line     Pooled effect estimate
Blue dashed lines      95% CI of pooled effect
Gray dotted line       Null effect (0 = no difference)

INTERPRETATION:
• CIs not crossing 0 → Statistically significant individual effects
• Overlapping CIs → Consistent effects (low heterogeneity)
• Spread-out CIs → Varied effects (high heterogeneity)
• Point size → Relative statistical weight in analysis

WHAT TO LOOK FOR:
1. Do individual study CIs overlap? (suggests consistency)
2. Does the pooled effect CI cross zero? (significance)
3. Are there obvious outliers or clusters?
4. Relative weight distribution (equity in influence?)
""")

print(f"\nPooled Effect Size: {pooled_re:.4f}")
print(f"95% Confidence Interval: [{ci_lower_re:.4f}, {ci_upper_re:.4f}]")
print(f"I² Heterogeneity: {max(0, (q_stat - (k-1)) / q_stat * 100):.1f}%")
print(f"Sample: {k} effect sizes from {analysis_data['study_id'].nunique()} studies")
