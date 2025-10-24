#!/usr/bin/env python3
"""
Forest Plot Generator for CTC Meta-Analysis
Generates publication-ready forest plot PNG from compiled dataset
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from pathlib import Path

# Load compiled dataset
compiled_data = pd.read_csv('compiled/e2e_analysis.csv')

# Sort by effect size for visual clarity
plot_data = compiled_data.sort_values('effect_size').reset_index(drop=True)

# Prepare figure
fig, ax = plt.subplots(figsize=(12, 10))

# Plot each study
y_positions = np.arange(len(plot_data))

for i, row in plot_data.iterrows():
    hr = row['effect_size']
    ci_lb = row['confidence_interval_lower']
    ci_ub = row['confidence_interval_upper']

    # Color code by quality
    if row['quality_score'] == 'high':
        color = '#2ecc71'  # Green
        marker_size = 150
    elif row['quality_score'] == 'medium_high':
        color = '#3498db'  # Blue
        marker_size = 120
    else:  # medium
        color = '#f39c12'  # Orange
        marker_size = 100

    # Plot confidence interval line
    ax.plot([ci_lb, ci_ub], [i, i], color=color, linewidth=2, alpha=0.7)

    # Plot point estimate
    ax.scatter(hr, i, s=marker_size, color=color, marker='D',
               edgecolors='black', linewidths=1.5, zorder=3)

    # Add study label
    ax.text(-0.5, i, row['study_id'].replace('_cohort', ''),
            fontsize=9, ha='right', va='center')

    # Add effect size text
    ax.text(ci_ub + 0.3, i, f"{hr:.2f}", fontsize=8, va='center')

# Add vertical line at null effect (HR=1.0)
ax.axvline(x=1.0, color='red', linestyle='--', linewidth=2,
           label='Null Effect (HR=1.0)', alpha=0.5)

# Add pooled effect line
pooled_hr = compiled_data['effect_size'].mean()
ax.axvline(x=pooled_hr, color='darkred', linestyle='-', linewidth=3,
           label=f'Pooled Effect (HR={pooled_hr:.2f})', alpha=0.7)

# Formatting
ax.set_yticks(y_positions)
ax.set_yticklabels([])  # Hide y-axis numbers
ax.set_xlabel('Hazard Ratio (log scale)', fontsize=12, fontweight='bold')
ax.set_title('Forest Plot: CTC Detection and Overall Survival in Esophageal Cancer\nMeta-Analysis of 14 Studies',
             fontsize=14, fontweight='bold', pad=20)

# Set x-axis to log scale
ax.set_xscale('log')
ax.set_xlim(0.1, 12)

# Add grid
ax.grid(True, axis='x', alpha=0.3, linestyle='--')

# Legend
ax.legend(loc='lower right', fontsize=11)

# Quality color legend
from matplotlib.patches import Patch
legend_elements = [
    Patch(facecolor='#2ecc71', edgecolor='black', label='HIGH Quality'),
    Patch(facecolor='#3498db', edgecolor='black', label='MEDIUM-HIGH Quality'),
    Patch(facecolor='#f39c12', edgecolor='black', label='MEDIUM Quality')
]
ax.legend(handles=legend_elements, loc='upper left', fontsize=10, title='Study Quality')

plt.tight_layout()

# Save figure
output_path = Path('analyses/forest_plot_pooled_effect.png')
output_path.parent.mkdir(parents=True, exist_ok=True)
plt.savefig(output_path, dpi=300, bbox_inches='tight')
print(f"Forest plot saved to: {output_path}")

# Also save as PDF for publication
pdf_path = output_path.with_suffix('.pdf')
plt.savefig(pdf_path, bbox_inches='tight')
print(f"Forest plot (PDF) saved to: {pdf_path}")

plt.close()

print("\n" + "="*60)
print("FOREST PLOT GENERATION COMPLETE")
print("="*60)
print(f"Studies plotted: {len(plot_data)}")
print(f"Pooled HR: {pooled_hr:.3f}")
print(f"Output formats: PNG, PDF")
