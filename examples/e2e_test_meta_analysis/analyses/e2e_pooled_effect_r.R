# Esophageal Cancer CTC Meta-Analysis - Question 1: Pooled Effect Size
# Generated for Story 2.6: End-to-End Workflow Testing
# Oracle v1.0 Output

# Required packages (install if needed):
# install.packages(c("metafor", "readr"))

library(metafor)
library(readr)

# Load compiled dataset
compiled_data <- read_csv("compiled/e2e_analysis.csv")

# Extract effect size data for meta-analysis
meta_data <- compiled_data %>%
  select(study_id, effect_size, confidence_interval_lower, confidence_interval_upper, quality_score) %>%
  rename(
    study = study_id,
    yi = effect_size,
    ci.lb = confidence_interval_lower,
    ci.ub = confidence_interval_upper
  )

# Calculate standard errors from confidence intervals
# For hazard ratios: SE = (log(CI.ub) - log(CI.lb)) / (2 * 1.96)
meta_data$sei <- (log(meta_data$ci.ub) - log(meta_data$ci.lb)) / (2 * 1.96)

# Meta-analysis using random-effects model (DerSimonian-Laird)
# Due to expected heterogeneity across studies
res <- rma(yi = meta_data$yi,
           sei = meta_data$sei,
           method = "DL",
           measure = "HR",
           slab = meta_data$study)

# Print results
cat("====== POOLED EFFECT SIZE META-ANALYSIS ======\n")
cat("Research Question: What is the pooled hazard ratio for CTC+ vs CTC- groups?\n\n")
print(res)

# Heterogeneity assessment
cat("\n====== HETEROGENEITY ASSESSMENT ======\n")
cat("I² =", res$I2, "% (proportion of heterogeneity not due to sampling error)\n")
cat("Q-statistic =", res$QE, "with p-value =", res$QEp, "\n")

# Publication bias assessment (Egger's regression test)
cat("\n====== PUBLICATION BIAS ASSESSMENT ======\n")
regtest_results <- regtest(res)
print(regtest_results)

# Save results to file
cat("\n====== ANALYSIS COMPLETE ======\n")
cat("Pooled Hazard Ratio for CTC detection in esophageal cancer: ", round(res$beta[1], 3), "\n")
cat("95% CI: [", round(res$ci.lb[1], 3), ", ", round(res$ci.ub[1], 3), "]\n")
cat("p-value: ", round(res$pval[1], 4), "\n\n")
