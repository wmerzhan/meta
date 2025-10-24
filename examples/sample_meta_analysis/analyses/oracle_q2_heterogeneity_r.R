# Oracle Analysis: Question 2 - Heterogeneity Assessment
# Research Question: "Is there significant heterogeneity? Which studies are outliers?"
# Language: R
# Generated: 2025-10-23

library(metafor)
library(readr)
library(dplyr)

# Load and prepare data
data <- read_csv("examples/sample_meta_analysis/compiled/test_4_gold_standards_2025-10-23.csv",
                 show_col_types = FALSE)

analysis_data <- data %>%
  mutate(
    yi = effect_size,
    vi = if_else(!is.na(effect_size_standard_error),
                 effect_size_standard_error^2,
                 ((confidence_interval_upper - confidence_interval_lower) / (2 * 1.96))^2),
    study_label = paste0(authors, " (", year, ")")
  ) %>%
  filter(!is.na(yi), !is.na(vi))

# Fit random-effects model
model_re <- rma(yi = yi, vi = vi, data = analysis_data, method = "DL", slab = study_label)

cat("\n=== HETEROGENEITY ASSESSMENT ===\n\n")

# Q-Test
cat("Q-Test for Heterogeneity:\n")
cat("  Q-statistic:", round(model_re$QE, 3), "\n")
cat("  df:", model_re$k - 1, "\n")
cat("  P-value:", format.pval(model_re$QEp), "\n\n")

if (model_re$QEp < 0.05) {
  cat("✓ SIGNIFICANT heterogeneity detected (p < 0.05)\n")
  cat("  → Effects differ meaningfully across studies\n")
  cat("  → Consider meta-regression or subgroup analyses\n")
} else {
  cat("✓ NO significant heterogeneity (p >= 0.05)\n")
  cat("  → Effects are relatively homogeneous\n")
}

# I² Index
cat("\nI² Heterogeneity Index:\n")
cat("  I²:", round(model_re$I2, 2), "%\n")

if (model_re$I2 < 25) {
  cat("  Interpretation: Low heterogeneity (I² < 25%)\n")
} else if (model_re$I2 < 50) {
  cat("  Interpretation: Moderate heterogeneity (25% ≤ I² < 50%)\n")
} else if (model_re$I2 < 75) {
  cat("  Interpretation: Substantial heterogeneity (50% ≤ I² < 75%)\n")
} else {
  cat("  Interpretation: Considerable heterogeneity (I² ≥ 75%)\n")
}

cat("  Meaning:", round(model_re$I2, 1), "% of variation is due to true effect variation\n\n")

# Between-study variance
cat("Between-Study Variance (τ²):\n")
cat("  Tau²:", round(model_re$tau2, 6), "\n")
cat("  Tau (SD):", round(sqrt(model_re$tau2), 4), "\n")
cat("  → Average true effect varies by ~", round(sqrt(model_re$tau2), 3), "units across studies\n\n")

# Identify outliers (residuals > 2 SD from mean)
cat("Study-Level Residuals (Outlier Detection):\n")
residuals_df <- data.frame(
  Study = analysis_data$study_label,
  Effect = round(analysis_data$yi, 3),
  Residual = round(residuals(model_re), 3),
  SE = round(sqrt(analysis_data$vi), 3),
  Weight = round(weights(model_re), 2)
) %>%
  arrange(desc(abs(Residual)))

print(residuals_df)

# Identify potential outliers (|residual| > 2 SD)
outliers <- residuals_df %>% filter(abs(Residual) > 2)

if (nrow(outliers) > 0) {
  cat("\n⚠️  POTENTIAL OUTLIERS (|residual| > 2):\n")
  print(outliers)
  cat("\nRecommendation: Review these studies for methodological differences\n")
} else {
  cat("\n✓ No statistical outliers detected\n")
}

cat("\nCONCLUSION:\n")
cat("Heterogeneity level:", het_int <- ifelse(model_re$I2 < 25, "Low",
                              ifelse(model_re$I2 < 50, "Moderate",
                              ifelse(model_re$I2 < 75, "Substantial", "Considerable"))), "\n")
cat("Next steps: Consider subgroup analyses or meta-regression\n")
