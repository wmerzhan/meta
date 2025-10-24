# Oracle Analysis: Question 4 - Subgroup Analysis by Outcome Type
# Research Question: "Do effects differ by outcome_measure (different study outcomes)?"
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

cat("\n=== SUBGROUP ANALYSIS BY OUTCOME TYPE ===\n\n")

# Identify outcome types
outcomes <- unique(analysis_data$outcome_measure)
cat("Outcomes identified in data:\n")
for (i in seq_along(outcomes)) {
  subset <- analysis_data %>% filter(outcome_measure == outcomes[i])
  cat(i, ".", outcomes[i], " (n=", nrow(subset), ")\n", sep = "")
}

# Fit subgroup models
cat("\n\nSubgroup Results:\n")
cat(rep("=", 60), "\n", sep = "")

for (outcome in outcomes) {
  subset <- analysis_data %>% filter(outcome_measure == outcome)

  if (nrow(subset) >= 1) {
    model_sub <- rma(yi = yi, vi = vi, data = subset, method = "DL")

    cat("\nOutcome:", outcome, "\n")
    cat("  N studies:", n_distinct(subset$study_id), "\n")
    cat("  N effect sizes:", nrow(subset), "\n")
    cat("  Pooled Effect:", round(model_sub$b[[1]], 4), "\n")
    cat("  95% CI: [", round(model_sub$ci.lb, 4), ",", round(model_sub$ci.ub, 4), "]\n", sep = "")
    cat("  SE:", round(model_sub$se, 4), "\n")
    cat("  I²:", round(model_sub$I2, 2), "%\n")
    cat("  p-value:", format.pval(model_sub$pval), "\n")
  }
}

# Test for between-subgroup differences (moderation effect)
cat("\n\n" + rep("=", 60) + "\n", sep = "")
cat("BETWEEN-SUBGROUP HETEROGENEITY TEST\n")
cat(rep("=", 60) + "\n\n", sep = "")

# Fit mixed-effects model (subgroup as moderator)
if (length(outcomes) > 1) {
  model_mixed <- rma(yi = yi, vi = vi, mods = ~ factor(outcome_measure),
                     data = analysis_data, method = "DL")

  cat("Mixed-Effects Model (Outcome Type as Moderator):\n")
  cat("  Q_between (test for subgroup differences):", round(model_mixed$QM, 4), "\n")
  cat("  df:", model_mixed$p - 1, "\n")
  cat("  p-value:", format.pval(model_mixed$QMp), "\n\n")

  if (model_mixed$QMp < 0.05) {
    cat("✓ SIGNIFICANT difference between outcome types (p < 0.05)\n")
    cat("  → Effects vary meaningfully by outcome measure\n")
  } else {
    cat("✓ No significant difference between outcome types (p >= 0.05)\n")
    cat("  → Effect sizes consistent across outcomes\n")
  }

  # Report residual heterogeneity (within subgroups)
  cat("\nResidual heterogeneity (within subgroups):\n")
  cat("  Q_within:", round(model_mixed$QE, 4), "\n")
  cat("  I² (residual):", round(model_mixed$I2, 2), "%\n")
}

cat("\n\nCONCLUSION:\n")
cat("Review outcome-specific effects above to assess consistency.\n")
cat("Consider: Are differences clinically meaningful?\n")
cat("If substantial variation exists, report outcome-specific estimates.\n")
