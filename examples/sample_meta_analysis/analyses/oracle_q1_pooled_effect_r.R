# Oracle Analysis: Question 1 - Pooled Effect Size Calculation
# Research Question: "What is the pooled effect size with 95% confidence interval?"
# Language: R
# Data Source: tests/validation/gold_standards/ (4 studies)
# Generated: 2025-10-23
# Oracle Version: v1.0
# Compatible Models: Claude 3.5 Sonnet+, Claude Opus 3+

# ==============================================================================
# SETUP AND DATA LOADING
# ==============================================================================

# Install required packages (uncomment to run first time):
# install.packages(c("metafor", "readr", "ggplot2", "dplyr"))

# Load libraries
library(metafor)  # Meta-analysis models and heterogeneity tests
library(readr)    # CSV reading with UTF-8 support
library(ggplot2)  # Visualization
library(dplyr)    # Data manipulation

# Load compiled dataset
# Update path as needed for your project
data <- read_csv("examples/sample_meta_analysis/compiled/test_4_gold_standards_2025-10-23.csv",
                 show_col_types = FALSE)

# Display basic information
cat("Dataset Summary:\n")
cat("  Total effect sizes:", nrow(data), "\n")
cat("  Unique studies:", n_distinct(data$study_id), "\n")
cat("  Date range:", min(data$year), "-", max(data$year), "\n\n")

# ==============================================================================
# STEP 1: DATA PREPARATION AND VALIDATION
# ==============================================================================

cat("STEP 1: Data Preparation\n")
cat("=======================\n\n")

# Create analysis dataset with required columns for meta-analysis
# metafor requires: yi (effect size) and vi (variance)

analysis_data <- data %>%
  mutate(
    # Effect sizes stored as-is (already log-transformed for ratios in compiled CSV)
    yi = effect_size,

    # Compute variance from confidence intervals or standard error
    # If SE available: var = SE²
    # If CI available: SE = (CI_upper - CI_lower) / (2 * 1.96), then var = SE²
    vi = if_else(
      !is.na(effect_size_standard_error),
      effect_size_standard_error^2,
      ((confidence_interval_upper - confidence_interval_lower) / (2 * 1.96))^2
    ),

    # Create study labels for forest plot
    study_label = paste0(authors, " (", year, ")"),

    # Classify data quality (for sensitivity analysis)
    data_quality = case_when(
      source_color_label == "🟢" ~ "direct",
      source_color_label == "🟡" ~ "computed",
      source_color_label == "🔴" ~ "uncertain",
      TRUE ~ "unknown"
    )
  ) %>%
  # Remove rows with missing effect size or variance
  filter(!is.na(yi), !is.na(vi))

cat("Prepared dataset:\n")
cat("  Total effect sizes available:", nrow(analysis_data), "\n")
cat("  Unique studies:", n_distinct(analysis_data$study_id), "\n")
cat("  Effect size range:", round(min(analysis_data$yi), 3), "to", round(max(analysis_data$yi), 3), "\n\n")

# ==============================================================================
# STEP 2: FIXED-EFFECT MODEL
# ==============================================================================

cat("STEP 2: Fixed-Effect Meta-Analysis\n")
cat("===================================\n\n")

# Fixed-effect model uses inverse variance weighting
# Assumes all studies estimate the same true effect
# Appropriate for: homogeneous study populations and methods

model_fe <- rma(yi = yi, vi = vi, data = analysis_data, method = "FE", slab = study_label)

# Print detailed results
print(model_fe)

cat("\n--- Fixed-Effect Summary ---\n")
cat("Pooled Effect Size:", round(model_fe$b[[1]], 4), "\n")
cat("95% CI: [", round(model_fe$ci.lb, 4), ",", round(model_fe$ci.ub, 4), "]\n")
cat("Standard Error:", round(model_fe$se, 4), "\n")
cat("Z-statistic:", round(model_fe$zval, 4), "\n")
cat("P-value:", format.pval(model_fe$pval), "\n\n")

# ==============================================================================
# STEP 3: RANDOM-EFFECTS MODEL
# ==============================================================================

cat("STEP 3: Random-Effects Meta-Analysis (DerSimonian-Laird)\n")
cat("========================================================\n\n")

# Random-effects model accounts for heterogeneity
# Assumes true effects vary across studies
# Uses DerSimonian-Laird estimator for between-study variance (tau²)
# Appropriate for: diverse populations, settings, or methods

model_re <- rma(yi = yi, vi = vi, data = analysis_data, method = "DL", slab = study_label)

# Print detailed results
print(model_re)

cat("\n--- Random-Effects Summary ---\n")
cat("Pooled Effect Size:", round(model_re$b[[1]], 4), "\n")
cat("95% CI: [", round(model_re$ci.lb, 4), ",", round(model_re$ci.ub, 4), "]\n")
cat("Standard Error:", round(model_re$se, 4), "\n")
cat("Z-statistic:", round(model_re$zval, 4), "\n")
cat("P-value:", format.pval(model_re$pval), "\n")
cat("\nBetween-Study Parameters:\n")
cat("  Tau² (variance of true effects):", round(model_re$tau2, 6), "\n")
cat("  Tau (SD of true effects):", round(sqrt(model_re$tau2), 4), "\n")

# ==============================================================================
# STEP 4: HETEROGENEITY ASSESSMENT
# ==============================================================================

cat("\n\nSTEP 4: Heterogeneity Assessment\n")
cat("=================================\n\n")

# Q-test: Chi-square test for heterogeneity
# H₀: All true effects are equal (homogeneous)
# Interpretation: Low p-value indicates heterogeneity present

cat("Q-Test for Heterogeneity (homogeneity test):\n")
cat("  Q-statistic:", round(model_re$QE, 4), "\n")
cat("  df (degrees of freedom):", model_re$k - 1, "\n")
cat("  P-value:", format.pval(model_re$QEp), "\n")

if (model_re$QEp < 0.05) {
  cat("  *** Significant heterogeneity detected (p < 0.05) ***\n")
  cat("  Interpretation: Effects differ significantly across studies\n")
} else {
  cat("  ✓ No significant heterogeneity (p ≥ 0.05)\n")
  cat("  Interpretation: Effects are relatively consistent across studies\n")
}

# I² statistic: percentage of variation due to heterogeneity
# I² = (Q - df) / Q * 100
# <25%: low | 25-50%: moderate | 50-75%: substantial | >75%: considerable

cat("\nI² Heterogeneity Index:\n")
cat("  I²:", round(model_re$I2, 2), "%\n")

if (model_re$I2 < 25) {
  het_interpretation <- "Low heterogeneity"
} else if (model_re$I2 < 50) {
  het_interpretation <- "Moderate heterogeneity"
} else if (model_re$I2 < 75) {
  het_interpretation <- "Substantial heterogeneity"
} else {
  het_interpretation <- "Considerable heterogeneity"
}

cat("  Interpretation:", het_interpretation, "\n")
cat("  Meaning: ", round(model_re$I2, 1), "% of variation is due to heterogeneity\n", sep = "")

# ==============================================================================
# STEP 5: DATA QUALITY ASSESSMENT
# ==============================================================================

cat("\n\nSTEP 5: Data Quality Assessment\n")
cat("===============================\n\n")

# Count data points by source quality label
quality_counts <- analysis_data %>%
  group_by(source_color_label) %>%
  summarise(
    Count = n(),
    Percentage = round(100 * n() / nrow(analysis_data), 1),
    .groups = "drop"
  ) %>%
  arrange(desc(Count))

cat("Data Quality Distribution (by source label):\n")
print(quality_counts)

total_uncertain <- sum(analysis_data$source_color_label %in% c("🟡", "🔴"))
pct_uncertain <- round(100 * total_uncertain / nrow(analysis_data), 1)

cat("\nTotal uncertain/computed data (🟡 + 🔴):", total_uncertain, "out of",
    nrow(analysis_data), "(" , pct_uncertain, "%)\n")

if (pct_uncertain > 20) {
  cat("⚠️  WARNING: Data quality mixed (>20% uncertain/computed)\n")
  cat("   Recommendation: Perform sensitivity analysis with 🟢 data only\n")
} else {
  cat("✓ Data quality good (<20% uncertain/computed)\n")
}

# ==============================================================================
# STEP 6: SENSITIVITY ANALYSIS - DATA QUALITY
# ==============================================================================

cat("\n\nSTEP 6: Sensitivity Analysis (Quality-Restricted)\n")
cat("==================================================\n\n")

# Restrict analysis to high-quality data only (🟢 labels)
quality_subset <- analysis_data %>% filter(source_color_label == "🟢")

if (nrow(quality_subset) > 1) {
  model_sensitive <- rma(yi = yi, vi = vi, data = quality_subset, method = "DL")

  cat("Sensitivity Model (🟢 data only):\n")
  cat("  Effect sizes included:", nrow(quality_subset), "(excluded:", nrow(analysis_data) - nrow(quality_subset), ")\n")
  cat("  Pooled Effect:", round(model_sensitive$b[[1]], 4), "\n")
  cat("  95% CI: [", round(model_sensitive$ci.lb, 4), ",", round(model_sensitive$ci.ub, 4), "]\n")
  cat("  I²:", round(model_sensitive$I2, 2), "%\n")

  # Compare sensitivity to main model
  effect_change <- abs((model_sensitive$b[[1]] - model_re$b[[1]]) / model_re$b[[1]]) * 100

  cat("\nComparison to Main Model:\n")
  cat("  Main model effect:", round(model_re$b[[1]], 4), "\n")
  cat("  Sensitive model effect:", round(model_sensitive$b[[1]], 4), "\n")
  cat("  Relative change:", round(effect_change, 1), "%\n")

  if (effect_change > 10) {
    cat("  ⚠️  Results sensitive to data quality (change > 10%)\n")
    cat("  Interpretation: Exclude uncertain data cautiously; results depend on data included\n")
  } else {
    cat("  ✓ Results robust to data quality (change < 10%)\n")
    cat("  Interpretation: Main conclusions stable even when excluding uncertain data\n")
  }
} else {
  cat("Insufficient 🟢 data for sensitivity analysis (n < 2)\n")
}

# ==============================================================================
# STEP 7: FOREST PLOT VISUALIZATION
# ==============================================================================

cat("\n\nSTEP 7: Forest Plot Generation\n")
cat("==============================\n\n")

# Create forest plot showing individual study effects and pooled estimate
# Study sizes reflect inverse variance weights (bigger = more weight)

pdf("forest_plot_q1.pdf", width = 11, height = 8)

forest(model_re,
       # Labels
       slab = model_re$slab,
       mlab = "Pooled Effect (Random-Effects)",

       # X-axis limits (adjust based on your effect size scale)
       xlim = c(-3, 3),

       # Additional columns: sample size and quality score
       ilab = cbind(
         analysis_data$sample_size,
         analysis_data$quality_score
       ),
       ilab.xpos = c(-2.5, -2.0),

       # Visual styling
       cex = 0.75,         # Text size
       psize = 1,          # Point size
       col = "darkblue",   # Polygon color

       # Ordering
       order = order(analysis_data$effect_size))

# Add legend
text(-3, nrow(analysis_data) + 2, "Study", pos = 4, font = 2, cex = 0.95)
text(3, nrow(analysis_data) + 2, "Effect Size [95% CI]", pos = 2, font = 2, cex = 0.95)

dev.off()

cat("✓ Forest plot saved to: forest_plot_q1.pdf\n")

# ==============================================================================
# STEP 8: FINAL SUMMARY AND INTERPRETATION
# ==============================================================================

cat("\n\nFINAL RESULTS SUMMARY\n")
cat("=====================\n\n")

cat("POOLED EFFECT SIZE ESTIMATES:\n")
cat("  Fixed-Effect Model:    ", round(model_fe$b[[1]], 4), " [", round(model_fe$ci.lb, 4), " to ", round(model_fe$ci.ub, 4), "]\n", sep = "")
cat("  Random-Effects Model:  ", round(model_re$b[[1]], 4), " [", round(model_re$ci.lb, 4), " to ", round(model_re$ci.ub, 4), "]\n\n", sep = "")

# Interpretation guidance
cat("INTERPRETATION:\n")

# Effect size magnitude
effect_magnitude <- function(d) {
  if (abs(d) < 0.2) return("negligible")
  if (abs(d) < 0.5) return("small")
  if (abs(d) < 0.8) return("medium")
  return("large")
}

magnitude <- effect_magnitude(model_re$b[[1]])
direction <- if_else(model_re$b[[1]] > 0, "positive", "negative")
significant <- if_else(model_re$ci.lb * model_re$ci.ub > 0, "YES", "NO")

cat("  Effect Size Magnitude:", magnitude, "\n")
cat("  Direction:", direction, "\n")
cat("  Statistically Significant (p < 0.05):", significant, "\n")
cat("  Heterogeneity Level:", het_interpretation, "\n")

if (model_re$QEp < 0.05) {
  cat("\nKEY FINDING: Significant heterogeneity detected.\n")
  cat("  → Consider subgroup analyses to explore sources of variation\n")
  cat("  → Random-effects model preferred over fixed-effect\n")
} else {
  cat("\nKEY FINDING: Effects consistent across studies (homogeneous).\n")
  cat("  → Fixed and random-effects models yield similar results\n")
  cat("  → Pooled effect is robust\n")
}

cat("\n\nCONCLUSION:\n")
if (model_re$ci.lb * model_re$ci.ub > 0) {
  cat("  The intervention has a statistically significant", direction, "effect.\n")
} else {
  cat("  The intervention effect is not statistically significantly different from zero.\n")
}

cat("  Pooled estimate:", round(model_re$b[[1]], 3),
    "[95% CI:", round(model_re$ci.lb, 3), "to", round(model_re$ci.ub, 3), "]\n")
cat("  Recommendation: Report both FE and RE estimates given I² level\n")

cat("\n\nNote: This analysis is provided for educational and exploratory purposes.\n")
cat("For publication, ensure statistical assumptions are validated and sensitivity\n")
cat("analyses are performed across key parameters.\n\n")
