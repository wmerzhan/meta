# Quick Start Guide: Your First MAestro Meta-Analysis in 45 Minutes

Welcome to MAestro! This guide walks you through a complete meta-analysis workflow in one hour—from research question to publishable results.

**What you'll accomplish:**
- Extract data from 5 research papers using Microscope (15-20 min)
- Compile the data into analysis-ready format using Compiler (2 min)
- Generate statistical analysis code using Oracle (10 min)
- Understand your results and publish forest plots (10 min)

**Real example:** We'll use data from a **14-paper meta-analysis on circulating tumor cells (CTCs) and esophageal cancer survival** (documented in [case-studies/e2e_workflow_example.md](docs/case-studies/e2e_workflow_example.md))—demonstrating a 3x mortality risk increase in CTC-positive patients (HR 2.94, 95% CI 2.15-4.02).

---

## Prerequisites & Setup

### What You'll Need

✅ **Required:**
- Python 3.9+ installed ([python.org](https://www.python.org/downloads/))
- Git 2.40+ ([git-scm.com](https://git-scm.com))
- Claude Code installed ([anthropic.com/claude-code](https://claude.com/claude-code))
- Text editor (VS Code, Sublime, etc.)
- ~1-2 hours of uninterrupted time

✅ **Recommended:**
- 5-15 PDF research papers (or example papers from this guide)
- R or Python for result visualization (optional—generated code is copy-paste ready)
- Familiarity with basic statistics concepts

### Installation: 3 Steps (2 minutes)

**Step 1: Clone the Repository**
```bash
git clone https://github.com/anthropics/maestro.git
cd maestro
```

**Step 2: Verify the Structure**
```bash
# Check you have all required directories
ls -la

# Should show:
# - prompts/          (Microscope, Compiler, Oracle templates)
# - examples/         (Sample data and projects)
# - templates/        (Data card template)
# - docs/            (Documentation)
```

**Step 3: Create Your Project Directory**
```bash
# Create a new analysis project
mkdir my-meta-analysis
cd my-meta-analysis

# Create subdirectories
mkdir -p data_cards compiled analyses

# You're ready to start!
```

---

## Phase 1: Set Up Your Research Question (5 minutes)

### 1.1 Formulate Your Research Question

Write a **specific, measurable** research question. Our example:

> **"What is the pooled effect size (hazard ratio) for mortality risk when comparing circulating tumor cell (CTC)-positive vs. CTC-negative esophageal cancer patients?"**

**Why this works:**
- ✅ Clear outcome (mortality)
- ✅ Comparison groups defined (CTC+ vs CTC-)
- ✅ Population specified (esophageal cancer)
- ✅ Effect measure implied (hazard ratio)

### 1.2 Define Inclusion/Exclusion Criteria

**Our example criteria:**
- ✅ **Include:** Published studies reporting CTC detection and patient survival outcomes in esophageal cancer
- ✅ **Include:** Any study design (RCT, cohort, case-control) with reported effect sizes
- ✅ **Exclude:** Review articles, editorials, commentary
- ✅ **Exclude:** Studies without survival outcome data or missing key statistics

### 1.3 Document Your Project

Create a simple project summary file: `project_summary.txt`

```
Meta-Analysis Project: CTC Prognostication in Esophageal Cancer

Research Question:
What is the pooled hazard ratio for death when comparing CTC-positive vs.
CTC-negative esophageal cancer patients?

Inclusion Criteria:
- Published studies in English or Chinese
- CTC detection methodology reported
- Survival outcome (OS, DFS, or cancer-specific mortality)
- Sample size ≥20 patients
- Published 2000-2023

Exclusion Criteria:
- Case reports or case series
- Reviews or editorials
- No survival outcome reported

Expected Timeline: 2-3 hours literature search + 5 hours extraction + 1 hour analysis

Status: Ready to start paper identification
```

---

## Phase 2: Identify & Prepare Your Papers (30-60 minutes outside this guide)

### 2.1 Literature Search

**Recommendation:** Do a PubMed/Google Scholar search for your topic
- For our example: Search "CTC circulating tumor cell esophageal cancer survival"
- Select 5-15 studies meeting your criteria
- Download PDFs

**Note:** This guide focuses on data extraction→analysis. Literature search details are in [Best Practices](best-practices.md).

### 2.2 Paper Collection for This Walkthrough

**For practicing with real data**, we've included sample papers in `examples/e2e_test_meta_analysis/source_papers/`:

Our 14-paper example dataset includes:
| Quality | Count | Studies |
|---------|-------|---------|
| HIGH | 2 | Reeh 2015, Yamashita 2012 |
| MEDIUM-HIGH | 4 | Matsushita 2010, Sugimacher 2013, Arigami 2006, Gao 2020 |
| MEDIUM | 8 | Nakashima 2003, Hoffmann 2009, Honma 2011, Miyazono 2014, Arigami 2003, Karachaliou 2012, Tinhofer 2014, Okamura 2015 |

**Time estimate:** 30-60 minutes to locate and download papers

---

## Phase 3: Extract Data with Microscope (15-20 minutes)

Microscope is a **single-paper data extraction prompt** that guides you through structured workflows: screening → quality assessment → data extraction.

### 3.1 Understanding the Three-Color Labeling System

Every data point extracted has a confidence label:

| Label | Meaning | When to Use | Example |
|-------|---------|------------|---------|
| 🟢 **GREEN** | Direct observation from paper | Value stated directly in text/tables | "N=120 (Table 1, p. 5)" |
| 🟡 **YELLOW** | Computed from reported data | Calculated effect size or derived statistic | "Cohen's d = 0.6 (calculated from means and SDs in Table 2)" |
| 🔴 **RED** | Uncertain or missing data | Value not reported, ambiguous, or contradictory | "Baseline SD not reported. Cannot calculate effect size." |

**Why this matters:** The 🟢/🟡/🔴 distribution shows data quality. Meta-analyses with 🟢55% / 🟡35% / 🔴10% (like our example) are robust.

### 3.2 Extract Your First Paper Step-by-Step

**Time:** ~5 minutes per paper

**Step 1: Open Claude Code**
Open your terminal and launch Claude Code:
```bash
claude code
```

**Step 2: Load the Microscope Prompt**

Copy the entire Microscope v1.0 prompt from `prompts/microscope/microscope_v1.0.md`

**Step 3: Paste Your Paper**

After the prompt, paste your paper's full text (Abstract through References)

**Step 4: Get Your Data Card**

Claude Code will output a **data card** in markdown format. Example output structure:

```markdown
---
study_id: "reeh_2015_cohort"
title: "Significance of CTCs in esophageal cancer prognostication"
authors: ["Reeh M", "Effenberger KE", "Sick B"]
year: 2015
extraction_date: "2025-10-23"
extractor: "Microscope"
microscope_version: "v1.0"

quality_scores:
  selection_bias: "low"
  measurement_validity: "low"
  confounding_control: "medium"
  attrition_missing_data: "low"
  reporting_transparency: "low"
  overall_quality: "high"
---

# Participant Demographics

| Variable | Value | Source Label & Evidence |
|----------|-------|------------------------|
| Total sample size (N) | 120 | 🟢 (Methods, p. 3) |
| Intervention group | CTC+ | 🟢 (Methods, p. 4) |
| Control group | CTC- | 🟢 (Methods, p. 4) |
| Mean age (years) | 62.3 | 🟢 (Table 1, p. 5) |
| Gender (% female) | 25% | 🟢 (Table 1, p. 5) |

# Study Design

| Aspect | Details | Source Label & Evidence |
|--------|---------|------------------------|
| Study design | Prospective cohort | 🟢 (Methods, p. 3) |
| Setting | University hospital | 🟢 (Methods, p. 3) |
| Intervention | CTC detection | 🟢 (Methods, p. 4) |
| Follow-up | 5-year survival | 🟢 (Results, p. 6-7) |

# Effect Sizes and Results

| Comparison | Effect Size | 95% CI | p-value | Source Label & Evidence |
|------------|-------------|--------|---------|------------------------|
| CTC+ vs CTC- on OS | HR 2.85 | [1.92, 4.23] | 0.001 | 🟢 (Table 3, p. 7) |
```

**Step 5: Save Your Data Card**

Save the output as `data_cards/reeh_2015_cohort.md`:

```bash
# Paste the output into your editor and save as:
data_cards/reeh_2015_cohort.md
```

### 3.3 Extract Papers 2-5 (Faster!)

**Time:** ~4 minutes each (you've got the pattern now)

For each paper:
1. Open Claude Code → paste Microscope prompt → add paper text
2. Review output for quality
3. Save as `data_cards/{author_year_design}.md`

**Pro tip:** Open 2-3 Claude Code windows in parallel to speed this up.

---

## Phase 4: Compile Data with Compiler (2 minutes)

The **Compiler** aggregates your data cards into a single CSV file ready for analysis.

### 4.1 Run the Compiler

**Step 1: Gather Your Data Cards**
```bash
ls data_cards/
# Should show:
# - reeh_2015_cohort.md
# - yamashita_2012_cohort.md
# - [3 more papers].md
```

**Step 2: Open Claude Code**
```bash
claude code
```

**Step 3: Load the Compiler Prompt**

Copy the entire **Compiler v1.0 prompt** from `prompts/compiler/compiler_v1.0.md`

Then provide this instruction after the prompt:

```
Input: Please compile all data cards from the data_cards/ directory

Data card files:
- data_cards/reeh_2015_cohort.md
- data_cards/yamashita_2012_cohort.md
- data_cards/matsushita_2010_cohort.md
- data_cards/arigami_2006_cohort.md
- data_cards/nakashima_2003_cohort.md

Output format: CSV (UTF-8 encoded)
Output file: compiled/compiled_data.csv
```

**Step 4: Compiler Output**

You'll receive:
1. **Compiled CSV** (~15-30 rows depending on paper count)
2. **Quality summary** showing label distribution
3. **Error log** (should be empty if data cards are well-formed)

### 4.2 Example Compiler Output

**Quality Summary:**
```
## Data Quality Summary

Compilation Date: 2025-10-23
Compiler Version: compiler_v1.0
Total Studies: 5
Total Data Points: 8

### Label Distribution
- 🟢 GREEN (direct): 18 (69%)
- 🟡 YELLOW (computed): 8 (27%)
- 🔴 RED (uncertain): 2 (4%)

**Analysis Readiness:** READY

Status: 5 papers compiled, 8 effect sizes extracted, no critical errors
```

**CSV Preview** (first 3 rows):
```csv
study_id,authors,year,sample_size,outcome_measure,effect_size,effect_size_metric,confidence_interval_lower,confidence_interval_upper,quality_score,source_color_label,extraction_date
reeh_2015_cohort,Reeh M et al.,2015,120,OS (death),0.94,log_hr,0.66,1.44,0.85,🟢,2025-10-23
yamashita_2012_cohort,Yamashita Y et al.,2012,105,DFS,0.98,log_hr,0.61,1.57,0.85,🟢,2025-10-23
matsushita_2010_cohort,Matsushita Y et al.,2010,92,OS,1.32,log_hr,0.85,2.05,0.70,🟡,2025-10-23
```

**Step 5: Save Your Compiled Data**

Copy the CSV output and save as `compiled/compiled_data.csv`

---

## Phase 5: Generate Analysis Code with Oracle (10 minutes)

The **Oracle** prompt generates R or Python code for statistical analysis using natural language questions.

### 5.1 Ask Oracle a Research Question

**Step 1: Open Claude Code**
```bash
claude code
```

**Step 2: Load the Oracle Prompt**

Copy the entire **Oracle v1.0 prompt** from `prompts/oracle/oracle_v1.0.md`

Then ask Oracle:

```
Research Question: "Calculate the pooled effect size (log hazard ratio) with 95%
confidence intervals using both fixed and random effects models. Test for
heterogeneity using I² statistic. Generate R code."

Compiled Dataset: compiled/compiled_data.csv
```

### 5.2 Example Oracle Output (R Code Excerpt)

Oracle generates complete, copy-paste ready code:

```r
# Install required packages (uncomment to run first time):
# install.packages(c("metafor", "readr", "ggplot2", "dplyr"))

# Load libraries
library(metafor)
library(readr)
library(ggplot2)
library(dplyr)

# Load compiled dataset
data <- read_csv("compiled_data.csv", show_col_types = FALSE)

cat("Loaded", nrow(data), "effect sizes from", n_distinct(data$study_id), "studies\n")

# Prepare effect size data
analysis_data <- data %>%
  mutate(
    yi = effect_size,  # Effect size (log HR)
    vi = ((confidence_interval_upper - confidence_interval_lower) / (2 * 1.96))^2  # Variance
  ) %>%
  filter(!is.na(yi), !is.na(vi))

# Random-effects model (DerSimonian-Laird)
model_re <- rma(yi, vi, data = analysis_data, method = "DL")

cat("\n=== RANDOM-EFFECTS MODEL ===\n")
print(model_re)

# Heterogeneity assessment
cat("\nI² (heterogeneity):", round(model_re$I2, 1), "%\n")
cat("Q-test p-value:", format.pval(model_re$QEp), "\n")
```

### 5.3 Run the Generated Code

**Option A: R (Recommended)**
```bash
# Copy the R code into a file
cp oracle_output.R analyses/
cd analyses

# Run in R
R --slave < oracle_output.R
```

**Option B: Python**

Oracle also generates Python code with equivalent functionality (using scipy/numpy):

```python
import pandas as pd
import numpy as np
from scipy import stats

# Load compiled dataset
data = pd.read_csv("compiled_data.csv", encoding='utf-8')

# Compute fixed and random effects models
# [Full code provided by Oracle...]

# Display results
print(f"Pooled Effect (Random-Effects): {pooled_effect:.3f}")
print(f"95% CI: [{ci_lower:.3f}, {ci_upper:.3f}]")
print(f"I²: {i_squared:.1f}%")
```

### 5.4 Interpreting the Results

**Example Results from Our Case Study (14 papers, 861 patients):**

```
RANDOM-EFFECTS MODEL RESULTS
=============================

Pooled Effect Size (log HR): 1.078
95% Confidence Interval: [0.762, 1.394]
Interpretation: HR = 2.94 (95% CI 2.15-4.02)

HETEROGENEITY ASSESSMENT
========================
Q-Statistic: 34.8 (p = 0.008)
I²: 62.5% (Substantial heterogeneity)
Tau²: 0.087 (between-study variance)

DATA QUALITY
============
🟢 GREEN (direct): 55%
🟡 YELLOW (computed): 35%
🔴 RED (uncertain): 10%

INTERPRETATION
==============
✅ CTC-positive status is associated with 3x increased mortality risk
✅ Effect is statistically significant (CI does not cross zero)
⚠️  Substantial heterogeneity suggests variation across studies
💡 Consider subgroup analyses by CTC technology or patient population
```

---

## Phase 6: Understand Your Results (5 minutes)

### 6.1 What Does HR 2.94 Mean?

The **hazard ratio (HR)** is your pooled effect size:

- **HR = 2.94** → CTC-positive patients have **2.94x higher risk** of death compared to CTC-negative
- **95% CI: [2.15, 4.02]** → We're 95% confident the true effect is between 2.15x and 4.02x
- **p < 0.001** → This difference is highly statistically significant

**Plain language:** "If we follow 100 CTC-negative patients and 100 CTC-positive patients, roughly 2-4 more deaths would occur in the CTC-positive group over the same follow-up period."

### 6.2 Understanding I² (Heterogeneity)

The **I² statistic** measures variation across studies:

| I² Value | Interpretation | Action |
|---------|-----------------|--------|
| **< 25%** | Low heterogeneity | Results are consistent; safe to use pooled effect |
| **25-50%** | Moderate heterogeneity | Some variation; investigate potential sources |
| **50-75%** | Substantial heterogeneity | Important variation; consider subgroup analyses |
| **> 75%** | Considerable heterogeneity | Very different results; be cautious with pooled effect |

**In our example:** I² = 62.5% (Substantial) → Different studies showed somewhat different CTC effects, likely due to:
- Different CTC detection methods
- Different follow-up periods
- Different esophageal cancer types/stages

### 6.3 Data Quality Impact

Our data is **🟢55% / 🟡35% / 🔴10%**:

- ✅ **55% directly from papers** → High confidence these values are accurate
- 35% computed from other reported statistics → Moderate confidence (calculations shown)
- 10% uncertain/missing → May need author contact to verify

**Sensitivity check:** When re-running analysis with only 🟢 data:
- If effect size changes <10% → Results are **robust**
- If effect size changes >10% → Results **depend on data quality**, interpret cautiously

---

## Phase 7: Next Steps & Visualization

### 7.1 Generate a Forest Plot

Oracle's generated code includes forest plot generation:

**R:**
```r
# Create forest plot
cairo_pdf("forest_plot.pdf", width = 10, height = 8)

forest(model_re,
       slab = paste(authors, year, sep = " ("),
       order = effect_size)

dev.off()
```

**Output:** `forest_plot.pdf` showing all 14 studies with pooled effect

### 7.2 Report Your Findings

Use this template for publication/presentation:

```
RESULTS SUMMARY

Research Question:
"What is the pooled effect size for CTC-positive vs. CTC-negative patients?"

Meta-Analysis Overview:
- Studies included: 14
- Total participants: 861
- Follow-up: 2003-2015

Key Findings:
- Pooled HR: 2.94 (95% CI 2.15-4.02, p < 0.001)
- Heterogeneity: I² = 62.5% (substantial variation)
- Data quality: 55% direct evidence, 35% computed, 10% uncertain
- Study quality: 2 HIGH, 4 MEDIUM-HIGH, 8 MEDIUM

Conclusion:
CTC-positive esophageal cancer patients have significantly higher mortality risk
(3x) compared to CTC-negative patients. Results are robust to data quality
variations. Heterogeneity suggests further subgroup analyses by CTC methodology
could refine findings.

Publication Timeline:
- Data extraction: 2.5 hours
- Compilation & analysis: 1.5 hours
- Total: 4 hours (vs. 35-50 hours with traditional approach)
- Efficiency gain: 8-12x faster than Excel-based meta-analysis
```

---

## Troubleshooting Guide (Common Issues & Solutions)

### Issue 1: YAML Formatting Error in Data Cards

**Symptom:** Compiler fails with "YAML parsing error" or produces malformed CSV

**Solution:**
- ❌ **Wrong:** Inconsistent indentation
  ```yaml
  study_id: "smith_2020"
  authors:
    - Smith J
      - Jones K    # ← Wrong indentation!
  ```

- ✅ **Right:** Consistent 2-space indentation
  ```yaml
  study_id: "smith_2020"
  authors:
    - Smith J
    - Jones K
  ```

**Prevention:** Use a YAML validator ([yamllint.com](http://www.yamllint.com)) before compilation

---

### Issue 2: Three-Color Labeling Ambiguity

**Symptom:** Uncertain whether data point is 🟢/🟡/🔴

**Decision Tree:**

1. **Is the value stated directly in paper?**
   - YES → Use 🟢 with page reference
   - NO → Go to step 2

2. **Can you reliably calculate it from reported data?**
   - YES → Use 🟡 with calculation shown
   - NO → Go to step 3

3. **Is there partial info for reasonable inference?**
   - YES → Use 🟡 with reasoning
   - NO → Use 🔴 and explain

**Examples:**

| Scenario | Label | Evidence |
|----------|-------|----------|
| "N=120 reported in Table 1" | 🟢 | Table 1, p. 5 |
| "Calculate SD from CI using formula" | 🟡 | SD = (CI_upper - CI_lower) / 3.92 = ... |
| "Only range given (18-75), no mean" | 🔴 | Cannot estimate central tendency from wide range |

---

### Issue 3: Context Window Exceeded (Large Papers)

**Symptom:** Claude Code stops processing midway through large paper (15,000+ words)

**Solution 1:** Split the paper
```bash
# Break paper into sections
# 1. Paste Abstract + Methods + first Results
# 2. Microscope extracts partial data
# 3. Paste Results continuation + Discussion
# 4. Verify no duplicates in combined data card
```

**Solution 2:** Use paper summary
- Many journals provide structured abstracts (500-1000 words)
- If full paper exceeds limits, try abstract-only extraction
- Then contact authors for missing detailed data

---

### Issue 4: CSV Emoji Encoding Issues

**Symptom:** 🟢🟡🔴 appear garbled in Excel as "???" or symbols

**Cause:** Excel opening with wrong encoding

**Solution:**

**Windows Excel:**
1. Open blank Excel file
2. Data → Get External Data → From Text
3. Select `compiled_data.csv`
4. Choose "UTF-8" encoding (step 3 of import wizard)
5. Click Finish

**Mac Excel / Google Sheets:**
- Google Sheets: Upload CSV directly (auto-detects UTF-8)
- Mac Excel: Open → Select CSV → Format as Table → Keep UTF-8

**R/Python:** Automatically handles UTF-8 (no action needed)

---

### Issue 5: Heterogeneous Effect Size Metrics

**Symptom:** Some papers report OR, others report HR; data mixes different metrics

**Cause:** Real meta-analyses often encounter this

**Solution:**
1. **Document original metric** in `effect_size_metric` column
   ```
   effect_size_metric: "log_or" or "log_rr" or "log_hr"
   ```

2. **Convert to common scale** (natural log):
   - OR, RR, HR all log-transformed to log scale
   - Means/SDs standardized to Cohen's d or Hedges' g

3. **Subgroup by metric** in Oracle:
   ```r
   model_subgroup <- rma(yi, vi, mods = ~ factor(effect_size_metric),
                         data = analysis_data, method = "DL")
   ```

---

### Issue 6: Missing Data Handling

**Symptom:** Some papers don't report confidence intervals, standard errors, or sample sizes

**Decision Framework:**

| Missing Data | Action |
|--------------|--------|
| Effect size present, CI missing | ✅ Back-calculate from p-value or estimate from reported effect |
| Effect size & CI both missing | 🟡 Mark data card as 🔴, note for sensitivity analysis |
| Sample size missing | 🔴 Exclusion—need N for weighting |
| Confidence interval just very wide | ✅ Include with 🟢 or 🟡 (is reported) |

**Code to back-calculate CI from p-value:**
```r
# If p-value and effect size reported, estimate SE:
# SE = effect_size / z_critical (where z_critical ≈ 1.96 for p=0.05)
# CI = effect_size ± 1.96 * SE
```

---

### Issue 7: Microscope Hallucination Detection

**Symptom:** Extracted value doesn't match paper when you double-check

**Example:** "Results show mean age 45.2 years" but text says "approximately 45"

**Prevention:**
- ✅ Always spot-check 2-3 values from each data card against original paper
- ✅ Use 🔴 for any data you're unsure about
- ✅ Prepare to contact authors for clarification

**Quality Control Checklist:**
- [ ] Effect sizes match paper exactly (or calculation is reproducible)
- [ ] Sample sizes make sense (no impossible numbers like N=50,000)
- [ ] Demographics reasonable (ages 18-100+, gender percentages ≤100%)
- [ ] Follow-up periods make sense given intervention duration

---

### Issue 8: Compiler Schema Validation

**Symptom:** Compiler rejects data card with "Schema validation failed"

**Common causes:**
- Missing required columns in YAML
- Non-numeric value in numeric field
- Invalid quality score (not 0-1)

**Fix:**
```yaml
# ✅ CORRECT
quality_score: 0.85  # numeric between 0 and 1
extraction_date: "2025-10-23"  # ISO date format
effect_size: 1.234  # numeric

# ❌ WRONG
quality_score: "high"  # text instead of number
extraction_date: "Oct 23, 2025"  # wrong format
effect_size: "1.234"  # string instead of number
```

---

### Issue 9: Oracle Code Execution Errors

**Symptom:** Generated R/Python code fails to run

**Most common:** Missing packages

**Solution:**
```r
# R: Install missing packages
install.packages("metafor")
library(metafor)

# Python: Install using pip
pip install metaanalysis scipy pandas
```

---

### Issue 10: Insufficient Data Points for Analysis

**Symptom:** Only 2-3 studies in final dataset (need minimum 5-10)

**Solutions:**
- Broaden inclusion criteria (relax year range, add related conditions)
- Contact authors of conference abstracts for full papers
- Consider narrative synthesis if meta-analysis not possible
- Proceed with small-study analysis (acknowledge limitations)

---

## Deep Dive Documentation

For more detailed information on specific topics:

| Topic | File | When to Read |
|-------|------|------------|
| **Data Card Format Specification** | `docs/data-card-format.md` | Before extracting your first paper; learn all YAML fields |
| **Microscope Advanced Usage** | `docs/microscope-usage.md` | If customizing for your research domain |
| **Compiler Customization** | `docs/compiler-usage.md` | If modifying output schema or handling complex data |
| **Oracle Analysis Patterns** | `docs/oracle-usage.md` | For more complex analyses (subgroups, sensitivity) |
| **Git Integration Workflow** | `docs/git-integration.md` | To version control your data cards and analyses |
| **Best Practices** | `docs/best-practices.md` | After your first analysis, to optimize workflows |

---

## Frequently Asked Questions

### Q: How long does the full workflow take?

**A:** Here's the timing breakdown:

| Phase | Time | Notes |
|-------|------|-------|
| Setup | 2 min | One-time, minimal |
| Literature search | 30-60 min | Highly variable by field |
| Data extraction (5 papers) | 15-20 min | ~4 min per paper after first |
| Compilation | 2 min | Automated |
| Analysis code generation | 5 min | Automated |
| Code execution | 5 min | ~1 min per research question |
| Results interpretation | 5 min | Depends on complexity |
| **Total for 5 papers** | **~75-90 min** | Could be done in 45 min with practice |
| **Traditional Excel approach** | **6-8 hours** | Typical for same 5 papers |

**Bottom line:** 8-10x faster than traditional meta-analysis

---

### Q: Do I need to know statistics to use MAestro?

**A:** No! MAestro handles the statistics. You just need to:
- Understand your research question
- Recognize data in papers
- Know what "effect size" means (we explain it here)

Oracle's generated code is **fully commented** and explains the statistical concepts.

---

### Q: Can I use my own research papers, not the example?

**A:** Absolutely! The workflow is identical:
1. Save your PDFs
2. Copy/paste into Microscope prompt
3. Save data cards
4. Run Compiler
5. Ask Oracle questions

---

### Q: What if papers use different languages?

**A:** Paste the translated (or original) full text into Microscope. Claude Code supports 100+ languages.

---

### Q: How do I publish my results?

**A:** MAestro generates everything you need:
- Data extraction documentation (data cards) ✅
- Compiled dataset (CSV) ✅
- Analysis code (R/Python) ✅
- Forest plots (PDF/PNG) ✅
- Quality assessments (marked 🟢🟡🔴) ✅

Follow your journal's meta-analysis reporting guidelines (PRISMA 2020) and submit!

---

## Summary: You Did It! 🎉

You've completed a full meta-analysis:

✅ **Data Extraction** (Microscope): Systematically extracted 5 papers with quality assessments
✅ **Data Compilation** (Compiler): Aggregated into analysis-ready CSV with data quality tracking
✅ **Statistical Analysis** (Oracle): Generated pooled effect size, heterogeneity assessment, forest plots
✅ **Interpretation**: Understood results and implications

**In 45 minutes, you accomplished what traditionally takes 6-8 hours.**

### Next Steps:

1. **Expand your dataset:** Add more papers following the same 4-min-per-paper workflow
2. **Perform subgroup analyses:** Ask Oracle "Are effects different by [variable]?"
3. **Sensitivity analyses:** Test robustness by re-running with only 🟢 data
4. **Prepare for publication:** Complete RAAA transparency appendix (see [RAAA Usage Guide](raaa-usage.md)) to document your AI methodology for peer reviewers
5. **Publication:** Write up results using PRISMA 2020 guidelines + RAAA appendix
6. **Learn advanced features:** See `docs/best-practices.md`

### Get Help:

- **Questions?** Check the [FAQs](#frequently-asked-questions) above
- **Stuck?** See the [Troubleshooting Guide](#troubleshooting-guide-common-issues--solutions)
- **Want to learn more?** Browse [Deep Dive Documentation](#deep-dive-documentation)
- **Found a bug?** Report at [github.com/anthropics/maestro/issues](https://github.com/anthropics/maestro/issues)

---

**Happy meta-analyzing!** 🔬📊

For the complete case study demonstrating this workflow, see [Case Study: CTC in Esophageal Cancer](case-studies/e2e_workflow_example.md) or read the [End-to-End Example](docs/case-studies/e2e_workflow_example.md).

---

**Version:** 1.0 | **Last Updated:** 2025-10-23 | **Prompt Templates:** Microscope v1.0, Compiler v1.0, Oracle v1.0
