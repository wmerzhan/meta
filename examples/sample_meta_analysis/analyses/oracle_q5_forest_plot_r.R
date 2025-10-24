# Oracle Analysis: Question 5 - Forest Plot Generation
# Research Question: "Generate a forest plot showing all studies and pooled effect"
# Language: R
# Generated: 2025-10-23
# Oracle Version: v1.0
# Compatible Models: Claude 3.5 Sonnet+, Claude Opus 3+

# ==============================================================================
# SETUP AND DATA LOADING
# ==============================================================================

# Install required packages (uncomment to run first time):
# install.packages(c("metafor", "readr", "dplyr", "ggplot2"))

library(metafor)  # Meta-analysis and forest plot
library(readr)    # CSV reading
library(dplyr)    # Data manipulation
library(ggplot2)  # Visualization

cat("\n")
cat("=" %s% rep("=", 70), "\n", sep = "")
cat("ORACLE Q5: Forest Plot Generation\n")
cat("=" %s% rep("=", 70), "\n\n", sep = "")
cat("Generating forest plot showing all studies and pooled effect...\n\n")

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
  filter(!is.na(yi), !is.na(vi)) %>%
  arrange(yi)  # Sort by effect size

# ==============================================================================
# COMPUTE RANDOM-EFFECTS POOLED ESTIMATE
# ==============================================================================

cat("Computing meta-analysis estimates...\n")

# Fit random-effects model
model_re <- rma(yi = yi, vi = vi, data = analysis_data, method = "DL", slab = study_label)

# Extract key statistics
k <- model_re$k  # Number of effect sizes
pooled_effect <- model_re$b[[1]]
pooled_se <- model_re$se
pooled_ci_lb <- model_re$ci.lb
pooled_ci_ub <- model_re$ci.ub
i_squared <- model_re$I2
Q_stat <- model_re$QE
Q_p <- model_re$QEp

cat(sprintf("  Total effect sizes: %d from %d studies\n", k, n_distinct(analysis_data$study_id)))
cat(sprintf("  Pooled Effect (RE): %.4f [%.4f, %.4f]\n", pooled_effect, pooled_ci_lb, pooled_ci_ub))
cat(sprintf("  I² Heterogeneity: %.2f%%\n\n", i_squared))

# ==============================================================================
# CREATE FOREST PLOT
# ==============================================================================

cat("Generating publication-quality forest plot...\n\n")

# Create PDF output
pdf("forest_plot_q5_r.pdf", width = 13, height = 9)

# Create forest plot with enhanced styling
forest(model_re,
       # Labels and titles
       slab = model_re$slab,
       mlab = sprintf("Pooled Effect (Random-Effects, I² = %.1f%%)", i_squared),
       main = "Forest Plot: Meta-Analysis of Compiled Studies",
       xlab = "Effect Size [95% CI]",

       # X-axis configuration
       xlim = c(-3, 3),

       # Additional study information columns
       ilab = cbind(
         "N" = analysis_data$sample_size,
         "Quality" = analysis_data$quality_score,
         "Label" = analysis_data$source_color_label
       ),
       ilab.xpos = c(-2.7, -2.4, -2.1),
       ilab.lab = c("N", "QA Score", "Quality"),

       # Visual styling
       cex = 0.8,        # Text size
       psize = 1,        # Point size (adjusted by weight)
       col = "darkblue", # Study polygon color
       border = NA,      # Remove borders

       # Ordering (by effect size for better visualization)
       order = order(analysis_data$effect_size),

       # Annotations
       annotate = TRUE,  # Show statistics
       digits = 3)       # Decimal places

# Add custom legend/annotations
text(-3, nrow(analysis_data) + 2.5,
     sprintf("Studies = %d | Pooled Effect = %.4f | Q = %.2f (p = %.3f) | τ² = %.4f",
             k, pooled_effect, Q_stat, Q_p, model_re$tau2),
     cex = 0.9, font = 2)

dev.off()

cat("✓ PDF forest plot saved to: forest_plot_q5_r.pdf\n\n")

# ==============================================================================
# CREATE PNG VERSION FOR WEB DISPLAY
# ==============================================================================

cat("Creating PNG version for web display...\n\n")

# Create PNG output
png("forest_plot_q5_r.png", width = 1300, height = 900, res = 100)

forest(model_re,
       slab = model_re$slab,
       mlab = sprintf("Pooled Effect (Random-Effects, I² = %.1f%%)", i_squared),
       main = "Forest Plot: Meta-Analysis of Compiled Studies",
       xlab = "Effect Size [95% CI]",
       xlim = c(-3, 3),

       ilab = cbind(
         "N" = analysis_data$sample_size,
         "Quality" = analysis_data$quality_score,
         "Label" = analysis_data$source_color_label
       ),
       ilab.xpos = c(-2.7, -2.4, -2.1),
       ilab.lab = c("N", "QA Score", "Quality"),

       cex = 0.8,
       psize = 1,
       col = "darkblue",
       border = NA,
       order = order(analysis_data$effect_size),
       annotate = TRUE,
       digits = 3)

text(-3, nrow(analysis_data) + 2.5,
     sprintf("Studies = %d | Pooled Effect = %.4f | Q = %.2f (p = %.3f) | τ² = %.4f",
             k, pooled_effect, Q_stat, Q_p, model_re$tau2),
     cex = 0.9, font = 2)

dev.off()

cat("✓ PNG forest plot saved to: forest_plot_q5_r.png\n\n")

# ==============================================================================
# PRINT COMPREHENSIVE SUMMARY
# ==============================================================================

cat("=" %s% rep("=", 70), "\n", sep = "")
cat("FOREST PLOT SUMMARY\n")
cat("=" %s% rep("=", 70), "\n\n", sep = "")

cat("PLOT ELEMENTS INCLUDED:\n")
cat("  • Individual study effect sizes with 95% confidence intervals\n")
cat("  • Study sample sizes (N column)\n")
cat("  • Quality assessment scores (QA Score column)\n")
cat("  • Data quality labels (Quality column: 🟢/🟡/🔴)\n")
cat("  • Pooled random-effects estimate with 95% CI (diamond)\n")
cat("  • Vertical reference line at null effect (0)\n\n")

cat("KEY STATISTICS DISPLAYED:\n")
cat(sprintf("  Number of effect sizes (k): %d\n", k))
cat(sprintf("  Number of unique studies: %d\n", n_distinct(analysis_data$study_id)))
cat(sprintf("  Pooled Effect Size: %.4f\n", pooled_effect))
cat(sprintf("  95% Confidence Interval: [%.4f, %.4f]\n", pooled_ci_lb, pooled_ci_ub))
cat(sprintf("  Heterogeneity (I²): %.2f%%\n", i_squared))
cat(sprintf("  Q-statistic: %.4f (p = %.4f)\n", Q_stat, Q_p))
cat(sprintf("  Between-Study Variance (τ²): %.6f\n\n", model_re$tau2))

cat("INTERPRETATION GUIDE:\n")
cat("─────────────────────────────────────────────────────────────────────────\n")
cat("Element                    Meaning\n")
cat("─────────────────────────────────────────────────────────────────────────\n")
cat("Horizontal lines           95% confidence interval for each study\n")
cat("Point (square)            Individual study effect size\n")
cat("Point size                Statistical weight in analysis (larger = more weight)\n")
cat("Diamond (bottom)          Pooled random-effects estimate\n")
cat("Diamond width             95% CI of pooled effect\n")
cat("Vertical dashed line      Null effect (no difference)\n")
cat("─────────────────────────────────────────────────────────────────────────\n\n")

cat("WHAT TO LOOK FOR:\n")
cat("  1. Do individual study CIs overlap?\n")
cat("     → Yes = Consistent effects (low heterogeneity)\n")
cat("     → No = Varied effects (high heterogeneity)\n\n")

cat("  2. Does the pooled effect CI cross the null line (0)?\n")
cat("     → No = Statistically significant pooled effect\n")
cat("     → Yes = Non-significant pooled effect\n\n")

cat("  3. Are there obvious outliers?\n")
cat("     → Yes = Consider sensitivity analysis excluding outliers\n")
cat("     → No = Results are robust\n\n")

cat("  4. Are effect sizes homogeneous or heterogeneous?\n")
cat(sprintf("     → I² = %.2f%% is classified as ", i_squared))

het_class <- if_else(i_squared < 25, "LOW heterogeneity",
              if_else(i_squared < 50, "MODERATE heterogeneity",
              if_else(i_squared < 75, "SUBSTANTIAL heterogeneity",
              "CONSIDERABLE heterogeneity")))

cat(het_class, "\n\n", sep = "")

cat("STATISTICAL SIGNIFICANCE:\n")
significant <- if_else(pooled_ci_lb * pooled_ci_ub > 0, "YES", "NO")
cat(sprintf("  Pooled effect is statistically significant (p < 0.05): %s\n", significant))
cat(sprintf("  Heterogeneity is significant (Q p-value < 0.05): %s\n\n",
            if_else(Q_p < 0.05, "YES", "NO")))

cat("RECOMMENDATIONS:\n")
if (Q_p < 0.05) {
  cat("  ✓ Significant heterogeneity detected\n")
  cat("    → Consider subgroup or sensitivity analyses\n")
  cat("    → Random-effects model is appropriate\n")
} else {
  cat("  ✓ No significant heterogeneity\n")
  cat("    → Effects consistent across studies\n")
  cat("    → Fixed and random-effects models give similar results\n")
}

cat("\n\nFiles Generated:\n")
cat("  1. forest_plot_q5_r.pdf  — High-quality publication-ready PDF\n")
cat("  2. forest_plot_q5_r.png  — Web-friendly PNG image\n\n")

cat("These plots are suitable for publication and can be directly inserted\n")
cat("into manuscripts, presentations, or online documents.\n\n")
