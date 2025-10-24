# Oracle Analysis: Question 3 - Subgroup Analysis by Data Quality
# Research Question: "Do effects differ by data quality (🟢 vs 🟡 vs 🔴)?"
# Language: R
# Generated: 2025-10-23
# Oracle Version: v1.0
# Compatible Models: Claude 3.5 Sonnet+, Claude Opus 3+

# ==============================================================================
# SETUP AND DATA LOADING
# ==============================================================================

# Install required packages (uncomment to run first time):
# install.packages(c("metafor", "readr", "dplyr"))

library(metafor)  # Meta-analysis models
library(readr)    # CSV reading
library(dplyr)    # Data manipulation

# Load compiled dataset
data <- read_csv("examples/sample_meta_analysis/compiled/test_4_gold_standards_2025-10-23.csv",
                 show_col_types = FALSE)

# Prepare analysis data
analysis_data <- data %>%
  mutate(
    yi = effect_size,
    vi = if_else(!is.na(effect_size_standard_error),
                 effect_size_standard_error^2,
                 ((confidence_interval_upper - confidence_interval_lower) / (2 * 1.96))^2),
    study_label = paste0(authors, " (", year, ")")
  ) %>%
  filter(!is.na(yi), !is.na(vi))

cat("\n")
cat("=" %s% rep("=", 70), "\n", sep = "")
cat("ORACLE Q3: Subgroup Analysis by Data Quality (🟢 vs 🟡 vs 🔴)\n")
cat("=" %s% rep("=", 70), "\n\n", sep = "")

# ==============================================================================
# IDENTIFY DATA QUALITY GROUPS AND PERFORM SUBGROUP ANALYSIS
# ==============================================================================

cat("Data Quality Distribution in Analysis:\n\n")

# Identify unique quality labels
quality_labels <- unique(analysis_data$source_color_label)
quality_counts <- table(analysis_data$source_color_label)

for (label in sort(names(quality_counts))) {
  count <- quality_counts[label]
  pct <- 100 * count / nrow(analysis_data)
  cat(sprintf("  %s: %d (%.1f%%)\n", label, count, pct))
}

cat("\n\nSubgroup Results by Data Quality:\n")
cat(rep("=", 70), "\n\n", sep = "")

# Store results for between-group comparisons
subgroup_models <- list()

for (label in sort(unique(analysis_data$source_color_label))) {
  subset <- analysis_data %>% filter(source_color_label == label)

  if (nrow(subset) >= 1) {
    # Fit random-effects model for this quality group
    model_sub <- rma(yi = yi, vi = vi, data = subset, method = "DL")
    subgroup_models[[as.character(label)]] <- model_sub

    # Quality description
    quality_desc <- case_when(
      label == "🟢" ~ "Direct (High Quality)",
      label == "🟡" ~ "Computed (Moderate Quality)",
      label == "🔴" ~ "Uncertain (Low Quality)",
      TRUE ~ "Unknown"
    )

    cat("\n")
    cat("Quality Label:", label, "—", quality_desc, "\n")
    cat("  N unique studies:", n_distinct(subset$study_id), "\n")
    cat("  N effect sizes:", nrow(subset), "\n")
    cat("  Pooled Effect:", round(model_sub$b[[1]], 4), "\n")
    cat("  95% CI: [", round(model_sub$ci.lb, 4), ",", round(model_sub$ci.ub, 4), "]\n", sep = "")
    cat("  Standard Error:", round(model_sub$se, 4), "\n")
    cat("  I²:", round(model_sub$I2, 2), "%\n")
    cat("  Q-test p-value:", format.pval(model_sub$QEp), "\n")
    cat("  Tau² (between-study variance):", round(model_sub$tau2, 6), "\n")
  }
}

# ==============================================================================
# BETWEEN-GROUP HETEROGENEITY TEST
# ==============================================================================

cat("\n\n")
cat("=" %s% rep("=", 70), "\n", sep = "")
cat("BETWEEN-GROUP HETEROGENEITY TEST\n")
cat("=" %s% rep("=", 70), "\n\n", sep = "")

# Test for moderation by quality label
if (length(unique(analysis_data$source_color_label)) > 1) {
  model_mixed <- rma(yi = yi, vi = vi, mods = ~ factor(source_color_label),
                     data = analysis_data, method = "DL")

  cat("Mixed-Effects Model (Data Quality as Moderator):\n")
  cat("  Q_between (test for quality group differences):", round(model_mixed$QM, 4), "\n")
  cat("  df:", model_mixed$p - 1, "\n")
  cat("  p-value:", format.pval(model_mixed$QMp), "\n\n")

  if (model_mixed$QMp < 0.05) {
    cat("✓ SIGNIFICANT difference between quality groups (p < 0.05)\n")
    cat("  → Data quality meaningfully affects results\n")
    cat("  → Recommendation: Perform sensitivity analyses using only 🟢 data\n")
  } else {
    cat("✓ No significant difference between quality groups (p >= 0.05)\n")
    cat("  → Results robust across data quality levels\n")
    cat("  → Recommendation: Pooled estimate is stable and reliable\n")
  }

  # Report residual heterogeneity
  cat("\nResidual heterogeneity (within quality groups):\n")
  cat("  Q_within:", round(model_mixed$QE, 4), "\n")
  cat("  I² (residual):", round(model_mixed$I2, 2), "%\n")

} else {
  cat("Only one quality level identified in data.\n")
  cat("Cannot perform between-group comparison.\n")
}

# ==============================================================================
# HIGH-QUALITY vs UNCERTAIN COMPARISON
# ==============================================================================

cat("\n\n")
cat("=" %s% rep("=", 70), "\n", sep = "")
cat("DIRECT (🟢) vs UNCERTAIN (🟡/🔴) COMPARISON\n")
cat("=" %s% rep("=", 70), "\n\n", sep = "")

green_data <- analysis_data %>% filter(source_color_label == "🟢")
uncertain_data <- analysis_data %>% filter(source_color_label %in% c("🟡", "🔴"))

if (nrow(green_data) > 0 && nrow(uncertain_data) > 0) {
  # Fit models
  model_green <- rma(yi = yi, vi = vi, data = green_data, method = "DL")
  model_uncertain <- rma(yi = yi, vi = vi, data = uncertain_data, method = "DL")

  cat("🟢 DIRECT (High-Quality) Data:\n")
  cat("  N effect sizes:", nrow(green_data), "\n")
  cat("  Pooled Effect:", round(model_green$b[[1]], 4), "\n")
  cat("  95% CI: [", round(model_green$ci.lb, 4), ",", round(model_green$ci.ub, 4), "]\n", sep = "")
  cat("  I²:", round(model_green$I2, 2), "%\n")
  cat("  p-value:", format.pval(model_green$pval), "\n\n")

  cat("🟡/🔴 UNCERTAIN (Low-Quality) Data:\n")
  cat("  N effect sizes:", nrow(uncertain_data), "\n")
  cat("  Pooled Effect:", round(model_uncertain$b[[1]], 4), "\n")
  cat("  95% CI: [", round(model_uncertain$ci.lb, 4), ",", round(model_uncertain$ci.ub, 4), "]\n", sep = "")
  cat("  I²:", round(model_uncertain$I2, 2), "%\n")
  cat("  p-value:", format.pval(model_uncertain$pval), "\n\n")

  # Test for significant difference
  effect_diff <- model_green$b[[1]] - model_uncertain$b[[1]]
  se_diff <- sqrt(model_green$se^2 + model_uncertain$se^2)
  z_diff <- effect_diff / se_diff
  p_diff <- 2 * (1 - pnorm(abs(z_diff)))

  cat("Comparison:\n")
  cat("  Difference in effects:", round(effect_diff, 4), "\n")
  cat("  Standard Error of difference:", round(se_diff, 4), "\n")
  cat("  Z-statistic:", round(z_diff, 4), "\n")
  cat("  P-value:", format.pval(p_diff), "\n\n")

  if (p_diff < 0.05) {
    cat("✓ SIGNIFICANT difference between groups (p < 0.05)\n")
    cat("  → Direct and uncertain data yield different estimates\n")
    cat("  → Data quality critically affects conclusions\n")
    cat("  → Recommend reporting quality-specific results\n")
  } else {
    cat("✓ No significant difference between groups (p >= 0.05)\n")
    cat("  → Direct and uncertain data yield consistent estimates\n")
    cat("  → Results are robust to data quality variations\n")
    cat("  → Pooled estimate across all data is reliable\n")
  }

} else {
  if (nrow(green_data) == 0) cat("⚠️  No 🟢 (high-quality) data available for comparison\n")
  if (nrow(uncertain_data) == 0) cat("⚠️  No 🟡/🔴 (low-quality) data available for comparison\n")
}

# ==============================================================================
# INTERPRETATION AND RECOMMENDATIONS
# ==============================================================================

cat("\n\n")
cat("=" %s% rep("=", 70), "\n", sep = "")
cat("INTERPRETATION AND RECOMMENDATIONS\n")
cat("=" %s% rep("=", 70), "\n\n", sep = "")

total_uncertain <- nrow(analysis_data %>% filter(source_color_label %in% c("🟡", "🔴")))
pct_uncertain <- 100 * total_uncertain / nrow(analysis_data)

cat(sprintf("Data Quality Summary: %.1f%% of data is uncertain (🟡 or 🔴)\n\n", pct_uncertain))

if (pct_uncertain > 20) {
  cat("⚠️  DATA QUALITY WARNING:\n")
  cat("  More than 20% of data is uncertain/computed.\n")
  cat("  Recommendations:\n")
  cat("    1. Present results separately by quality level (above)\n")
  cat("    2. Conduct sensitivity analysis using only 🟢 data\n")
  cat("    3. Discuss impact of data quality on conclusions\n")
  cat("    4. Consider weighting by quality in future analyses\n")
} else {
  cat("✓ DATA QUALITY ADEQUATE:\n")
  cat("  More than 80% of data is direct/reliable (🟢).\n")
  cat("  Recommendations:\n")
  cat("    1. Pooled estimate across all quality levels is reliable\n")
  cat("    2. Sensitivity analyses not critical but recommended\n")
  cat("    3. Results are robust to moderate data quality issues\n")
}

cat("\n\nNEXT STEPS:\n")
cat("  • If significant between-group differences found: Report quality-stratified estimates\n")
cat("  • If no differences found: Pooled estimate across all quality levels is appropriate\n")
cat("  • Consider conceptual reasons for any quality-related effect variation\n")
cat("  • Validate findings with sensitivity analysis (quality-restricted samples)\n\n")
