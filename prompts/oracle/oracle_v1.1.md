# Oracle v1.1: Statistical Analysis Code Generation Template

<!-- Powered by BMAD Core -->

**Version:** 1.1
**Created:** 2025-10-24
**Previous Version:** 1.0 (Oct 23, 2025)
**Status:** Post-beta refinement

## Key Improvements from v1.0

Based on beta testing feedback and real-world statistical analysis scenarios:

### Refinement 1: Enhanced Input Validation (NEW)
Added stricter validation of input datasets and research questions with more informative error messages.

### Refinement 2: Improved Code Comments & Pedagogical Value (ENHANCED)
Added more inline code comments explaining statistical concepts and assumptions for non-statistician users.

### Refinement 3: Better Handling of Special Cases (NEW)
Enhanced guidance for unusual data scenarios (very few studies, extreme heterogeneity, missing data patterns).

## Metadata

**Template Version:** v1.1
**Created:** 2025-10-24
**Compatible Models:** Claude 3.5 Sonnet+, Claude Opus 3+
**Compatible Schema:** Compiled Dataset Schema v1.0+
**Input Format:** CSV (from Compiler v1.0+ output)
**Output Format:** R script (.R) or Python script (.py)

**Changelog:** See `prompts/oracle/CHANGELOG.md` for version history and updates.

---

## Purpose

This prompt template instructs an AI agent to generate executable statistical analysis code for meta-analysis workflows. Oracle accepts natural language research questions (e.g., "What is the pooled effect size?", "Is there significant heterogeneity?") and compiled meta-analysis datasets, then produces fully functional R or Python code with inline pedagogical comments explaining statistical concepts.

The generated code is self-contained (includes library installation instructions) and produces interpretable results suitable for non-statistician researchers.

---

## Input Requirements

### Research Question

User provides a **natural language research question** specifying:
- **Question format:** Plain English question about the meta-analysis data (e.g., "Calculate the pooled effect size with 95% confidence interval")
- **Language preference:** Explicit request for R or Python output (e.g., "Generate R code" or "Generate Python code")
- **Optional analysis type:** Specific analysis requested (pooled effect, heterogeneity, subgroup, forest plot, or combination)

### Compiled Dataset (CSV)

Input file must conform to Compiled Dataset Schema v1.0 with:
- **Required columns:** study_id, authors, year, sample_size, effect_size, effect_size_type, effect_size_metric, confidence_interval_lower, confidence_interval_upper, quality_score, source_color_label
- **Optional columns:** treatment_n, control_n, effect_size_standard_error, p_value, evidence_reference, notes, outcome_timepoint
- **Format:** UTF-8 encoded CSV, one row per outcome per study
- **Data quality:** Effect sizes must be numeric; dichotomous ratios stored as log-transformed (ln)

### Example Input

```
Research Question: "Calculate the pooled effect size and test for heterogeneity using fixed and random effects models. Generate R code."

Compiled Dataset: /path/to/compiled_data.csv
```

---

## Step-by-Step Code Generation Instructions

### Step 1: Validate Input and Determine Analysis Type

1. **Parse research question:**
   - Identify the primary statistical objective (pooled effect, heterogeneity, subgroup, forest plot)
   - Extract language preference (R or Python) from explicit request
   - If language not specified, default to R (more commonly used in meta-analysis)
   - If analysis type unclear, infer from keywords:
     - "pooled effect" → Fixed and random effects models
     - "heterogeneity" → I² statistic and Q-test
     - "subgroup" → Stratified analysis by categorical variable
     - "forest plot" or "visualization" → Effect size plot with CIs
     - "sensitivity" or "quality" → Analysis by data quality flags (🟡/🔴)

2. **Validate compiled dataset (ENHANCED IN v1.1):**
   - Check CSV is readable and contains required columns
   - Verify effect_size column has numeric values (not "NA" or empty)
   - Confirm effect_size_type values are recognized (continuous_mean_diff, continuous_smd, dichotomous_or, dichotomous_rr, dichotomous_hr, correlation, other)
   - Note any missing confidence intervals or standard errors (may affect analysis options)
   - **NEW:** Flag special cases:
     - Very few studies (k < 5): Warn that random-effects estimates may be unstable
     - Extreme heterogeneity (I² > 90%): Recommend investigation of sources
     - Single arm per study (no comparison): Alert that effect direction interpretation needed
     - All effect sizes null (effect near 0): Confirm no publication bias suspected

3. **Assess data quality:**
   - Count rows with 🟡 (computed) and 🔴 (uncertain) labels
   - If >20% of data points have 🟡 or 🔴, flag for user: "Data quality mixed (xx% uncertain); recommend sensitivity analyses with 🟢 only"
   - Identify if quality_score column enables stratified sensitivity analysis
   - **NEW:** Flag if >50% red labels detected: "High proportion of uncertain data; results should be interpreted cautiously"

### Step 2: Generate R Code (if requested)

#### 2a. Package Setup and Data Loading

```r
# Install required packages (uncomment to run first time):
# install.packages(c("metafor", "readr", "ggplot2", "dplyr"))

# Load libraries
library(metafor)  # Meta-analysis models and heterogeneity tests
library(readr)    # CSV reading with UTF-8 support
library(ggplot2)  # Visualization
library(dplyr)    # Data manipulation

# Load compiled dataset
data <- read_csv("compiled_data.csv", show_col_types = FALSE)

# Display basic information
cat("Loaded", nrow(data), "effect sizes from", n_distinct(data$study_id), "studies\n")
```

#### 2b. Data Preparation and Effect Size Transformation

```r
# Prepare effect size data for meta-analysis
# Dichotomous ratios (OR, RR, HR) are stored as log-transformed in compiled CSV
# Continuous effect sizes (Cohen's d, Hedges' g) used directly

# Create analysis dataset with required columns:
# - effect_size (log-transformed for ratios, raw for continuous)
# - effect_size_var (variance for weighting; computed if not available)
# - study_id, authors, year (for identification and subgrouping)

analysis_data <- data %>%
  mutate(
    # For continuous measures: use effect size directly
    # For dichotomous: already log-transformed in compiled CSV
    yi = effect_size,

    # Compute variance if not provided; use inverse variance weighting
    # If confidence interval bounds available, estimate from CI width
    vi = if_else(
      !is.na(effect_size_standard_error),
      effect_size_standard_error^2,  # Variance = SE²
      ((confidence_interval_upper - confidence_interval_lower) / (2 * 1.96))^2  # Estimate from CI
    ),

    # Identify data quality concerns (flag for sensitivity analysis)
    data_quality = case_when(
      source_color_label == "🟢" ~ "direct",
      source_color_label == "🟡" ~ "computed",
      source_color_label == "🔴" ~ "uncertain",
      TRUE ~ "unknown"
    ),

    # Create study grouping variable
    study_label = paste(authors, year, sep = " (")
  ) %>%
  filter(!is.na(yi), !is.na(vi))  # Remove rows with missing ES or variance

cat("Analysis sample:", nrow(analysis_data), "effect sizes from",
    n_distinct(analysis_data$study_id), "studies\n")
```

#### 2c. Fixed-Effect Model

```r
# Fixed-effect model: assumes single true effect size across all studies
# Appropriate when: studies share common effect; minimal between-study heterogeneity
# Formula: β = Σ(w_i * y_i) / Σ(w_i), where w_i = 1/v_i (inverse variance weights)

model_fe <- rma(yi, vi, data = analysis_data, method = "FE", slab = study_label)

cat("\n=== FIXED-EFFECT MODEL ===\n")
print(model_fe)

# Extract pooled effect size and confidence interval
fe_summary <- data.frame(
  Model = "Fixed-Effect",
  Pooled_Effect = model_fe$b[[1]],
  Lower_CI = model_fe$ci.lb,
  Upper_CI = model_fe$ci.ub,
  Std_Error = model_fe$se,
  Z_Statistic = model_fe$zval,
  P_Value = model_fe$pval,
  Interpretation = interpret_effect(model_fe$b[[1]], model_fe$ci.lb, model_fe$ci.ub)
)
```

#### 2d. Random-Effects Model (DerSimonian-Laird)

```r
# Random-effects model: assumes heterogeneous true effects across studies
# Accounts for both within-study (sampling) and between-study (real differences) variance
# Method: DerSimonian-Laird tau² estimation (Q-based moment estimator)
# Appropriate when: studies differ in population, intervention, outcome measures

model_re <- rma(yi, vi, data = analysis_data, method = "DL", slab = study_label)

cat("\n=== RANDOM-EFFECTS MODEL (DerSimonian-Laird) ===\n")
print(model_re)

# Extract pooled effect and heterogeneity parameters
re_summary <- data.frame(
  Model = "Random-Effects (DL)",
  Pooled_Effect = model_re$b[[1]],
  Lower_CI = model_re$ci.lb,
  Upper_CI = model_re$ci.ub,
  Std_Error = model_re$se,
  Z_Statistic = model_re$zval,
  P_Value = model_re$pval,
  Between_Study_Var = model_re$tau2,  # τ²: variance of true effects
  Interpretation = interpret_effect(model_re$b[[1]], model_re$ci.lb, model_re$ci.ub)
)

# Combined summary
summary_table <- rbind(fe_summary, re_summary)
print(summary_table)
```

#### 2e. Heterogeneity Assessment

```r
# Heterogeneity testing: evaluates whether observed variation exceeds sampling error
# Two complementary tests:

# Q-test: Chi-square test for heterogeneity
# H₀: All true effects are equal (homogeneous)
# High p-value (>0.05) → consistent effects; low p-value → heterogeneity present
# Note: Q-test has low power for small k and high power for large k; use with I²

q_test <- data.frame(
  Test = "Q-Test for Heterogeneity",
  Q_Statistic = model_re$QE,
  df = model_re$k - 1,
  P_Value = model_re$QEp,
  Interpretation = if_else(model_re$QEp < 0.05,
                            "Significant heterogeneity detected (p < 0.05)",
                            "No significant heterogeneity (p ≥ 0.05)")
)

# I² statistic: percentage of variation due to heterogeneity
# Formula: I² = max(0, (Q - df) / Q * 100)
# Interpretation:
#   I² < 25%: Low heterogeneity (consistent effects)
#   I² 25-50%: Moderate heterogeneity
#   I² 50-75%: Substantial heterogeneity
#   I² > 75%: Considerable heterogeneity (very inconsistent effects)

i_squared <- model_re$I2

hetero_summary <- data.frame(
  Heterogeneity_Metric = c("Q-Statistic", "I-Squared (%)"),
  Value = c(model_re$QE, i_squared),
  Interpretation = c(
    ifelse(model_re$QEp < 0.05, "Significant", "Not Significant"),
    interpret_i_squared(i_squared)
  )
)

cat("\n=== HETEROGENEITY ASSESSMENT ===\n")
print(hetero_summary)
cat("\nTau-squared (τ²):", model_re$tau2, "- Variance of true effects across studies")
```

#### 2f. Subgroup Analysis (if multiple subgroups detected)

```r
# Subgroup analysis: examines whether treatment effects differ by study characteristics
# Common grouping variables: study_quality, study_design, outcome_type, intervention_type

# Example: Analyze by data quality (🟢 vs 🟡 vs 🔴)
# This assesses robustness to data extraction certainty

subgroup_var <- "data_quality"  # Change as needed (quality_score, outcome_measure, etc.)

cat("\n=== SUBGROUP ANALYSIS BY", toupper(subgroup_var), "===\n")

for (subgroup in unique(analysis_data[[subgroup_var]])) {
  subset_data <- analysis_data %>% filter(.data[[subgroup_var]] == subgroup)

  if (nrow(subset_data) > 0) {
    model_sub <- rma(yi, vi, data = subset_data, method = "DL")

    cat("\nSubgroup:", subgroup, "\n")
    cat("  N studies:", n_distinct(subset_data$study_id), "\n")
    cat("  Pooled Effect [95% CI]:",
        round(model_sub$b[[1]], 3),
        "[", round(model_sub$ci.lb, 3), ",", round(model_sub$ci.ub, 3), "]\n")
    cat("  I²:", round(model_sub$I2, 1), "%\n")
  }
}

# Between-subgroup test (Q_between): evaluates if effects differ significantly across groups
model_subgroup <- rma(yi, vi, mods = ~ factor(analysis_data[[subgroup_var]]),
                      data = analysis_data, method = "DL")
cat("\nBetween-Subgroup Test (Q_between):\n")
cat("  Chi-square:", round(model_subgroup$QM, 3), "\n")
cat("  P-value:", format.pval(model_subgroup$QMp), "\n")
cat("  Interpretation:", if_else(model_subgroup$QMp < 0.05,
                                 "Subgroups differ significantly",
                                 "No significant difference between subgroups"), "\n")
```

#### 2g. Forest Plot Visualization

```r
# Forest plot: visual representation of effect sizes with confidence intervals
# Shows: study-specific effects, pooled effect, heterogeneity visually
# Interpretation: CIs not overlapping y=0 suggest significant individual effects

cairo_pdf("forest_plot.pdf", width = 10, height = 8)

forest(model_re,
       # Display options
       slab = model_re$slab,
       xlim = c(-3, 3),  # Adjust x-axis range as needed (effect scale)

       # Annotations
       mlab = "Pooled Effect (Random-Effects)",
       ilab = cbind(analysis_data$sample_size, analysis_data$quality_score),
       ilab.xpos = c(-2.5, -2.0),

       # Visual styling
       cex = 0.8,
       psize = 1,

       # Order by effect size
       order = analysis_data$effect_size)

# Add legend
text(-3, nrow(analysis_data) + 2, "Study", pos = 4, font = 2)
text(3, nrow(analysis_data) + 2, "Effect Size [95% CI]", pos = 2, font = 2)

dev.off()

cat("\nForest plot saved to: forest_plot.pdf\n")

# Interpretation guidance
cat("\n=== FOREST PLOT INTERPRETATION ===\n")
cat("• Each horizontal line represents one study's effect size and 95% CI\n")
cat("• Diamond at bottom shows pooled effect; width = 95% CI\n")
cat("• CIs not crossing vertical line (0) = significant individual effects\n")
cat("• Overlapping CIs suggest consistent effects (low heterogeneity)\n")
cat("• Spread-out CIs suggest varied effects (high heterogeneity)\n")
```

#### 2h. Sensitivity Analysis (Data Quality)

```r
# Sensitivity analysis: assesses robustness by excluding uncertain data
# Rationale: 🟡 (computed) and 🔴 (uncertain) data may bias pooled effect
# If excluding these changes conclusions, results are sensitive to data quality

cat("\n=== SENSITIVITY ANALYSIS: DATA QUALITY IMPACT ===\n")

# Restrict to high-quality data only (🟢 labels)
quality_subset <- analysis_data %>% filter(source_color_label == "🟢")

if (nrow(quality_subset) > 1) {
  model_sensitive <- rma(yi, vi, data = quality_subset, method = "DL")

  cat("Sensitivity model (🟢 data only):\n")
  cat("  N effect sizes:", nrow(quality_subset), "\n")
  cat("  Pooled Effect:", round(model_sensitive$b[[1]], 3), "\n")
  cat("  95% CI: [", round(model_sensitive$ci.lb, 3), ",",
      round(model_sensitive$ci.ub, 3), "]\n")
  cat("  I²:", round(model_sensitive$I2, 1), "%\n")

  # Compare to main model
  effect_change <- abs((model_sensitive$b[[1]] - model_re$b[[1]]) / model_re$b[[1]]) * 100

  if (effect_change > 10) {
    cat("\n⚠️  WARNING: Effect size changed >10% when excluding uncertain data.\n")
    cat("  Main model effect:", round(model_re$b[[1]], 3), "\n")
    cat("  Sensitive model effect:", round(model_sensitive$b[[1]], 3), "\n")
    cat("  IMPLICATION: Results depend on data quality; be cautious in interpretation\n")
  } else {
    cat("\n✓ Results stable when excluding uncertain data.\n")
    cat("  Effect size change: ", round(effect_change, 1), "%\n")
  }
}
```

#### 2i. Results Interpretation

```r
# Helper function: interpret effect size magnitude
interpret_effect <- function(effect, ci_lower, ci_upper) {
  # Effect size interpretation depends on metric (Cohen's d, log-RR, etc.)
  # Adjust thresholds based on your effect_size_metric

  direction <- if_else(effect > 0, "positive", "negative")
  magnitude <- if_else(abs(effect) < 0.2, "small",
                       if_else(abs(effect) < 0.5, "small-to-medium",
                       if_else(abs(effect) < 0.8, "medium",
                       if_else(abs(effect) < 1.2, "large", "very large"))))
  significance <- if_else(ci_lower * ci_upper > 0, "significant", "not significant")

  return(paste0(magnitude, " ", direction, " (", significance, ")"))
}

# Helper function: interpret I² value
interpret_i_squared <- function(i_squared) {
  if (i_squared < 25) return("Low heterogeneity")
  if (i_squared < 50) return("Moderate heterogeneity")
  if (i_squared < 75) return("Substantial heterogeneity")
  return("Considerable heterogeneity")
}

# Generate final interpretation
cat("\n=== RESULTS INTERPRETATION ===\n")
cat("\nPooled Effect Size:", round(model_re$b[[1]], 3), "\n")
cat("95% Confidence Interval: [", round(model_re$ci.lb, 3), ",",
    round(model_re$ci.ub, 3), "]\n")
cat("Interpretation:", interpret_effect(model_re$b[[1]], model_re$ci.lb, model_re$ci.ub), "\n")

cat("\nHeterogeneity:\n")
cat("  Q-test p-value:", format.pval(model_re$QEp), "\n")
cat("  I² =", round(model_re$I2, 1), "% -", interpret_i_squared(model_re$I2), "\n")
cat("  Tau² (between-study variance):", round(model_re$tau2, 4), "\n")

cat("\nConclusion:\n")
if (model_re$ci.lb * model_re$ci.ub > 0) {
  direction <- if_else(model_re$b[[1]] > 0, "positive", "negative")
  cat("  The pooled effect is significantly", direction, "\n")
} else {
  cat("  The pooled effect is not significantly different from zero\n")
}

if (model_re$QEp < 0.05) {
  cat("  Substantial heterogeneity present; consider subgroup analyses\n")
}
```

---

### Step 3: Generate Python Code (if requested)

#### 3a. Package Setup and Data Loading

```python
# Install required packages (run once):
# pip install pandas numpy scipy matplotlib metaanalysis

import pandas as pd
import numpy as np
from scipy import stats
from pathlib import Path
import matplotlib.pyplot as plt
from metaanalysis import *  # Custom meta-analysis functions (see below)

# Load compiled dataset
csv_path = Path("compiled_data.csv")
data = pd.read_csv(csv_path, encoding='utf-8')

print(f"Loaded {len(data)} effect sizes from {data['study_id'].nunique()} studies")
```

#### 3b. Data Preparation

```python
# Prepare effect size data for meta-analysis
# Effect sizes expected: log-transformed for dichotomous ratios, raw for continuous

# Create analysis dataset
analysis_data = data.copy()

# Ensure numeric columns are proper type
analysis_data['effect_size'] = pd.to_numeric(analysis_data['effect_size'])

# Compute variance if not provided
# Use confidence interval width to estimate variance: SE = (CI_upper - CI_lower) / (2 * 1.96)
analysis_data['variance'] = np.where(
    analysis_data['effect_size_standard_error'].notna(),
    analysis_data['effect_size_standard_error'] ** 2,  # Variance = SE²
    ((analysis_data['confidence_interval_upper'] - analysis_data['confidence_interval_lower']) / (2 * 1.96)) ** 2
)

# Filter out rows with missing ES or variance
analysis_data = analysis_data.dropna(subset=['effect_size', 'variance'])

# Add data quality classification
analysis_data['data_quality'] = analysis_data['source_color_label'].map({
    '🟢': 'direct',
    '🟡': 'computed',
    '🔴': 'uncertain'
})

print(f"\nAnalysis sample: {len(analysis_data)} effect sizes from {analysis_data['study_id'].nunique()} studies")
```

#### 3c. Fixed-Effect Model

```python
# Fixed-effect model: inverse variance weighting
# Formula: β_FE = Σ(w_i * y_i) / Σ(w_i), where w_i = 1/v_i

def fixed_effect_meta(effect_sizes, variances):
    """
    Compute pooled effect using fixed-effect inverse variance weighting.

    Args:
        effect_sizes: array of individual effect sizes
        variances: array of individual variances

    Returns:
        dict with pooled_effect, se, ci_lower, ci_upper, z_stat, p_value
    """
    weights = 1 / variances

    # Weighted average (pooled effect)
    pooled_effect = np.sum(weights * effect_sizes) / np.sum(weights)

    # Standard error
    se = np.sqrt(1 / np.sum(weights))

    # 95% Confidence interval
    z_critical = 1.96
    ci_lower = pooled_effect - z_critical * se
    ci_upper = pooled_effect + z_critical * se

    # Z-statistic and p-value
    z_stat = pooled_effect / se
    p_value = 2 * (1 - stats.norm.cdf(abs(z_stat)))

    return {
        'pooled_effect': pooled_effect,
        'se': se,
        'ci_lower': ci_lower,
        'ci_upper': ci_upper,
        'z_stat': z_stat,
        'p_value': p_value
    }

# Compute fixed-effect model
fe_result = fixed_effect_meta(
    analysis_data['effect_size'].values,
    analysis_data['variance'].values
)

print("\n=== FIXED-EFFECT MODEL ===")
print(f"Pooled Effect: {fe_result['pooled_effect']:.3f}")
print(f"95% CI: [{fe_result['ci_lower']:.3f}, {fe_result['ci_upper']:.3f}]")
print(f"SE: {fe_result['se']:.3f}")
print(f"Z-statistic: {fe_result['z_stat']:.3f}, p-value: {fe_result['p_value']:.4f}")
```

#### 3d. Random-Effects Model (DerSimonian-Laird)

```python
def random_effects_meta_dl(effect_sizes, variances):
    """
    Compute pooled effect using random-effects model with DerSimonian-Laird tau² estimation.

    Args:
        effect_sizes: array of individual effect sizes
        variances: array of individual variances

    Returns:
        dict with pooled_effect, se, ci_lower, ci_upper, tau2, i_squared, q_stat, q_pval
    """
    k = len(effect_sizes)

    # Step 1: Compute fixed-effect result and Q-statistic
    fe_result = fixed_effect_meta(effect_sizes, variances)
    weights_fe = 1 / variances

    # Q-statistic (chi-square test for heterogeneity)
    residuals = effect_sizes - fe_result['pooled_effect']
    q_stat = np.sum(weights_fe * residuals ** 2)
    q_pval = 1 - stats.chi2.cdf(q_stat, k - 1)

    # Step 2: DerSimonian-Laird tau² estimation
    # tau² = (Q - (k - 1)) / (Σw_i - Σw_i² / Σw_i)
    sum_w = np.sum(weights_fe)
    sum_w2 = np.sum(weights_fe ** 2)

    denominator = sum_w - (sum_w2 / sum_w)
    tau2 = max(0, (q_stat - (k - 1)) / denominator)  # Ensure non-negative

    # Step 3: Compute RE-adjusted weights
    weights_re = 1 / (variances + tau2)

    # Pooled effect under random-effects model
    pooled_effect = np.sum(weights_re * effect_sizes) / np.sum(weights_re)
    se = np.sqrt(1 / np.sum(weights_re))

    # 95% Confidence interval
    z_critical = 1.96
    ci_lower = pooled_effect - z_critical * se
    ci_upper = pooled_effect + z_critical * se

    # Z-statistic and p-value
    z_stat = pooled_effect / se
    p_value = 2 * (1 - stats.norm.cdf(abs(z_stat)))

    # I² heterogeneity statistic
    i_squared = max(0, (q_stat - (k - 1)) / q_stat * 100) if q_stat > 0 else 0

    return {
        'pooled_effect': pooled_effect,
        'se': se,
        'ci_lower': ci_lower,
        'ci_upper': ci_upper,
        'z_stat': z_stat,
        'p_value': p_value,
        'tau2': tau2,
        'i_squared': i_squared,
        'q_stat': q_stat,
        'q_pval': q_pval
    }

# Compute random-effects model
re_result = random_effects_meta_dl(
    analysis_data['effect_size'].values,
    analysis_data['variance'].values
)

print("\n=== RANDOM-EFFECTS MODEL (DerSimonian-Laird) ===")
print(f"Pooled Effect: {re_result['pooled_effect']:.3f}")
print(f"95% CI: [{re_result['ci_lower']:.3f}, {re_result['ci_upper']:.3f}]")
print(f"SE: {re_result['se']:.3f}")
print(f"Z-statistic: {re_result['z_stat']:.3f}, p-value: {re_result['p_value']:.4f}")
print(f"\nTau²: {re_result['tau2']:.4f} (between-study variance)")
```

#### 3e. Heterogeneity Assessment

```python
def interpret_i_squared(i_squared):
    """Interpret I² heterogeneity statistic"""
    if i_squared < 25:
        return "Low heterogeneity"
    elif i_squared < 50:
        return "Moderate heterogeneity"
    elif i_squared < 75:
        return "Substantial heterogeneity"
    else:
        return "Considerable heterogeneity"

print("\n=== HETEROGENEITY ASSESSMENT ===")
print(f"Q-Statistic: {re_result['q_stat']:.3f} (df = {len(analysis_data) - 1})")
print(f"Q p-value: {re_result['q_pval']:.4f}")
print(f"I²: {re_result['i_squared']:.1f}%")
print(f"Interpretation: {interpret_i_squared(re_result['i_squared'])}")

if re_result['q_pval'] < 0.05:
    print("\n⚠️  Significant heterogeneity detected (p < 0.05)")
    print("   Consider subgroup analyses to explore sources of variation")
else:
    print("\n✓ No significant heterogeneity (p ≥ 0.05)")
```

#### 3f. Subgroup Analysis

```python
# Subgroup analysis by data quality (🟢 vs 🟡 vs 🔴)
subgroup_var = 'data_quality'  # Change to other variables as needed

print(f"\n=== SUBGROUP ANALYSIS BY {subgroup_var.upper()} ===")

subgroup_results = {}

for subgroup in analysis_data[subgroup_var].unique():
    if pd.isna(subgroup):
        continue

    subset = analysis_data[analysis_data[subgroup_var] == subgroup]

    if len(subset) > 0:
        result = random_effects_meta_dl(
            subset['effect_size'].values,
            subset['variance'].values
        )

        subgroup_results[subgroup] = result

        print(f"\nSubgroup: {subgroup}")
        print(f"  N studies: {subset['study_id'].nunique()}")
        print(f"  Pooled Effect [95% CI]: {result['pooled_effect']:.3f} [{result['ci_lower']:.3f}, {result['ci_upper']:.3f}]")
        print(f"  I²: {result['i_squared']:.1f}%")

# Test for between-subgroup differences
# Using mixed-effects model: effect ~ subgroup
if len(subgroup_results) > 1:
    print(f"\n--- Between-Subgroup Heterogeneity Test ---")
    print("(Implement as separate mixed-effects model for production use)")
```

#### 3g. Forest Plot

```python
# Create forest plot visualization
fig, ax = plt.subplots(figsize=(12, 8))

# Sort by effect size for visualization
plot_data = analysis_data.sort_values('effect_size')

# Plot individual study effects (with 95% CIs)
for i, (idx, row) in enumerate(plot_data.iterrows()):
    se = np.sqrt(row['variance'])
    ci_lower = row['effect_size'] - 1.96 * se
    ci_upper = row['effect_size'] + 1.96 * se

    # Plot confidence interval line
    ax.plot([ci_lower, ci_upper], [i, i], 'k-', linewidth=1)

    # Plot point estimate (sized by inverse variance weight)
    weight = 1 / row['variance']
    size = (weight / (1/plot_data['variance']).max()) * 100
    ax.scatter(row['effect_size'], i, s=size, c='black', zorder=3)

# Plot pooled effect (random-effects)
ax.axvline(re_result['pooled_effect'], color='red', linestyle='-', linewidth=2,
           label=f"Pooled Effect (RE): {re_result['pooled_effect']:.3f}")
ax.axvline(re_result['ci_lower'], color='red', linestyle='--', alpha=0.5)
ax.axvline(re_result['ci_upper'], color='red', linestyle='--', alpha=0.5)

# Plot null effect (no effect = 0)
ax.axvline(0, color='gray', linestyle=':', linewidth=1, alpha=0.7)

# Formatting
ax.set_yticks(range(len(plot_data)))
ax.set_yticklabels([f"{row['authors']} ({int(row['year'])})"
                      for _, row in plot_data.iterrows()], fontsize=9)
ax.set_xlabel('Effect Size [95% CI]', fontsize=11)
ax.set_ylabel('Study', fontsize=11)
ax.set_title('Forest Plot: Meta-Analysis Results', fontsize=13, fontweight='bold')
ax.legend()
ax.grid(True, alpha=0.3, axis='x')

plt.tight_layout()
plt.savefig('forest_plot.png', dpi=300, bbox_inches='tight')
print("\nForest plot saved to: forest_plot.png")
plt.show()

# Interpretation
print("\n=== FOREST PLOT INTERPRETATION ===")
print("• Each horizontal line: one study's effect size and 95% CI")
print("• Point size: relative weight in meta-analysis (larger = more weight)")
print("• Red diamond: pooled effect; red dashed lines: pooled effect CI")
print("• Gray dotted line: null effect (0 = no difference)")
print("• CIs not crossing zero: statistically significant individual effect")
```

#### 3h. Sensitivity Analysis

```python
# Sensitivity analysis: restrict to high-quality data only (🟢)
quality_subset = analysis_data[analysis_data['source_color_label'] == '🟢']

if len(quality_subset) > 1:
    print("\n=== SENSITIVITY ANALYSIS: DATA QUALITY IMPACT ===")

    sensitive_result = random_effects_meta_dl(
        quality_subset['effect_size'].values,
        quality_subset['variance'].values
    )

    print(f"Sensitivity model (🟢 data only):")
    print(f"  N effect sizes: {len(quality_subset)}")
    print(f"  Pooled Effect: {sensitive_result['pooled_effect']:.3f}")
    print(f"  95% CI: [{sensitive_result['ci_lower']:.3f}, {sensitive_result['ci_upper']:.3f}]")
    print(f"  I²: {sensitive_result['i_squared']:.1f}%")

    # Compare to main model
    effect_change = abs((sensitive_result['pooled_effect'] - re_result['pooled_effect'])
                        / re_result['pooled_effect']) * 100

    if effect_change > 10:
        print(f"\n⚠️  WARNING: Effect size changed {effect_change:.1f}% when excluding uncertain data")
        print(f"  Main model: {re_result['pooled_effect']:.3f}")
        print(f"  Sensitive model: {sensitive_result['pooled_effect']:.3f}")
        print("  IMPLICATION: Results depend on data quality; interpret cautiously")
    else:
        print(f"\n✓ Results stable when excluding uncertain data (change: {effect_change:.1f}%)")
```

#### 3i. Results Interpretation

```python
def interpret_effect_size(effect, ci_lower, ci_upper):
    """Generate interpretation string for effect size"""
    direction = "positive" if effect > 0 else "negative"

    magnitude = "small"
    if abs(effect) >= 0.2:
        magnitude = "small-to-medium"
    if abs(effect) >= 0.5:
        magnitude = "medium"
    if abs(effect) >= 0.8:
        magnitude = "large"
    if abs(effect) >= 1.2:
        magnitude = "very large"

    # Check if CI crosses zero (significance)
    significance = "significant" if ci_lower * ci_upper > 0 else "not significant"

    return f"{magnitude} {direction} ({significance})"

print("\n=== RESULTS INTERPRETATION ===")
print(f"\nPooled Effect Size: {re_result['pooled_effect']:.3f}")
print(f"95% Confidence Interval: [{re_result['ci_lower']:.3f}, {re_result['ci_upper']:.3f}]")
print(f"Interpretation: {interpret_effect_size(re_result['pooled_effect'], re_result['ci_lower'], re_result['ci_upper'])}")

print(f"\nHeterogeneity:")
print(f"  Q-test p-value: {re_result['q_pval']:.4f}")
print(f"  I² = {re_result['i_squared']:.1f}% - {interpret_i_squared(re_result['i_squared'])}")
print(f"  Tau² = {re_result['tau2']:.4f} (between-study variance)")

print("\nConclusion:")
if re_result['ci_lower'] * re_result['ci_upper'] > 0:
    direction = "positive" if re_result['pooled_effect'] > 0 else "negative"
    print(f"  The pooled effect is significantly {direction}")
else:
    print("  The pooled effect is not significantly different from zero")

if re_result['q_pval'] < 0.05:
    print("  Substantial heterogeneity present; subgroup analyses recommended")
```

---

### Step 4: Data Quality Handling

Regardless of programming language, implement these data quality flags:

```
1. **Assess composition:**
   - Count 🟢 (direct) data points: High fidelity; trust completely
   - Count 🟡 (computed) data points: Moderate fidelity; show calculation steps
   - Count 🔴 (uncertain) data points: Low fidelity; flag and recommend sensitivity analysis

2. **Flag mixed-quality datasets:**
   - If >20% of data points are 🟡 or 🔴:
     Report: "⚠️  Data quality mixed (XX% uncertain/computed). Recommend sensitivity analysis."
   - Provide sensitivity analysis code that re-runs analysis with 🟢 only

3. **Interpret quality-stratified results:**
   - If main analysis effect differs >10% from 🟢-only analysis:
     Conclude: "Results depend on data quality; interpret cautiously"
   - Otherwise: "Results robust to data quality variation"
```

---

### Step 5: Interpretation Format

For each research question, generate output in this format:

```
## Question: [User's Natural Language Question]

### Analysis Summary
- **Analysis Type:** [Pooled effect / Heterogeneity / Subgroup / Forest plot]
- **Data:** [N studies, N effect sizes, timeframe if applicable]
- **Method:** [Fixed-effect / Random-effects with DL tau²]

### Main Results
- **Pooled Effect Size:** [Value]
- **95% Confidence Interval:** [Lower - Upper]
- **Interpretation:** [magnitude direction significance] based on [effect_size_metric]

### Heterogeneity
- **Q-Statistic:** [Value] (p = [Value])
- **I² Heterogeneity:** [Value]% ([Interpretation])
- **Between-Study Variance (τ²):** [Value]

### Data Quality Assessment
- **Green (🟢) Data:** [N] ([%]%) - Direct observations
- **Yellow (🟡) Data:** [N] ([%]%) - Computed values
- **Red (🔴) Data:** [N] ([%]%) - Uncertain values

### Key Findings
1. [Main pooled effect interpretation]
2. [Heterogeneity assessment]
3. [Subgroup differences if applicable]
4. [Data quality impact if relevant]

### Recommendations
1. [Action based on heterogeneity]
2. [Sensitivity analyses to perform]
3. [Additional considerations]

### Code Availability
[Mention that full R/Python code is provided above for reproduction and publication]
```

---

## Output Structure

The generated code should:

1. **Be self-contained:** Include all necessary imports/libraries and installation instructions
2. **Handle missing data gracefully:** Document assumptions and limitations
3. **Include pedagogical comments:** Explain statistical concepts for learning users
4. **Produce multiple outputs:**
   - Console output with results and interpretation
   - CSV file with study-level effect sizes and weights (optional)
   - PNG/PDF visualization (forest plot, etc.)
   - R script or Python script for reproducibility
5. **Be cross-platform compatible:**
   - R: Use relative paths only, `readr::read_csv()` for UTF-8 support
   - Python: Use `pathlib.Path` for file operations, not `os.path`

---

## Common Analysis Patterns

### Pattern 1: Simple Pooled Effect
**User Question:** "What is the pooled effect size?"
**Output:** Fixed and random-effects models, I² assessment, confidence intervals

### Pattern 2: Heterogeneity Exploration
**User Question:** "Is there significant heterogeneity? Why?"
**Output:** Q-test, I² statistic, subgroup analysis suggestions

### Pattern 3: Subgroup Analysis
**User Question:** "Do effects differ by study quality?"
**Output:** Separate pooled effects per subgroup, between-subgroup test

### Pattern 4: Visualization
**User Question:** "Generate a forest plot"
**Output:** Forest plot PNG/PDF showing all studies and pooled effect

### Pattern 5: Sensitivity
**User Question:** "How sensitive are results to data quality?"
**Output:** Main analysis, analysis with 🟢 only, comparison

---

## Schema Compatibility

**This prompt template (v1.1) is compatible with:**
- Compiled Dataset Schema v1.0+ (`docs/compiled-data-schema.md`)
- Compiler v1.0+ output
- Data Card Template v1.0+ format
- Microscope v1.0+ (including v1.1 with multi-arm trial flagging)

---

## Related Documentation

- **Compiled Data Schema:** `docs/compiled-data-schema.md`
- **Compiler v1.1 Guide:** `docs/compiler-usage.md`
- **Oracle Usage Guide:** `docs/oracle-usage.md` (to be created)
- **Multi-Arm Trial Guidance:** See Microscope v1.1 multi-arm section for proper handling of complex studies

---

## Version Notes

**v1.1 Enhancements:**
- Enhanced input validation with warnings for special cases (very few studies, extreme heterogeneity)
- Improved code comments for better pedagogical value
- Better handling of data quality extremes (>50% red labels)
- Added notes on multi-arm trial compatibility

---

**End of Oracle v1.1 Template**

*Version 1.1 Created: 2025-10-24*
*Changes from v1.0: Enhanced validation, improved code comments, special case handling*
*Based on beta feedback from Story 3.5 statistical analysis scenarios*
