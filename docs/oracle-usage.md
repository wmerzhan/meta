# Oracle Usage Guide

**Version:** 1.0
**Last Updated:** 2025-10-23
**For:** MAestro Meta-analysis Framework

---

## Overview

The **Oracle** is an AI-assisted workflow that generates executable statistical analysis code for meta-analysis research questions. Given natural language research questions and a compiled meta-analysis dataset, Oracle produces fully functional R or Python code with inline pedagogical comments explaining statistical concepts.

**What it does:**
- Accepts natural language research questions (e.g., "What is the pooled effect size?")
- Analyzes your compiled CSV dataset (from Compiler v1.0)
- Generates R or Python scripts for common meta-analysis operations
- Includes inline comments explaining statistical formulas and interpretations
- Produces both code output AND plain-language results summaries
- Handles data quality flags (🟢/🟡/🔴) with sensitivity analysis recommendations

**When to use:**
- After compiling data cards into a CSV file (Compiler v1.0 output)
- Before beginning statistical analyses
- For generating reproducible, documented analysis code
- When you want pedagogical explanations of statistical methods

**Prerequisites:**
- Compiled dataset (CSV file) from Compiler v1.0
- Claude Code CLI or compatible AI environment
- Familiarity with `docs/compiled-data-schema.md` (expected input format)
- Basic understanding of meta-analysis concepts (optional but helpful)

---

## Quick Start

### 1. Prepare Your Compiled Dataset

Ensure you have:
- A CSV file from Compiler v1.0 (e.g., `compiled_data.csv`)
- All required columns: study_id, authors, year, effect_size, variance (or CI bounds)
- Data quality labels (🟢/🟡/🔴) in source_color_label column
- UTF-8 encoding with emoji support

**Example file structure:**
```
compiled/
├── compiled_data.csv  (your analysis dataset)
└── README.md          (metadata about compilation)
```

### 2. Open Claude Code

Launch Claude Code in your project directory:

```bash
cd /path/to/my_meta_analysis
claude
```

### 3. Request Analysis (Three Methods)

**Method A: Copy-paste the Oracle prompt**

Load and use the prompt template directly:

```
Please read and follow the instructions in prompts/oracle/oracle_v1.0.md

Research Question: "What is the pooled effect size with 95% confidence interval?"
Language: R
Input dataset: compiled/compiled_data.csv
```

**Method B: Use Claude Code directly**

```
/read prompts/oracle/oracle_v1.0.md

Please generate R code to answer this research question:
"Calculate the pooled effect size and test for heterogeneity using fixed and random effects models."

Use the dataset: examples/sample_meta_analysis/compiled/test_4_gold_standards_2025-10-23.csv
```

**Method C: Minimal request (Oracle infers structure)**

```
I have a compiled meta-analysis dataset: compiled/compiled_data.csv

Research question: "Do effects differ by study quality (🟢 vs 🟡 vs 🔴)?"

Generate Python code for subgroup analysis.
```

### 4. Execute the Generated Code

Claude Code will provide:
1. **R or Python script** (fully self-contained with library installation instructions)
2. **Console output** showing results
3. **Interpretation guidance** in plain language
4. **Visualization files** (optional: forest plots, etc.)

Copy the script to your project:
```bash
# Save the R code
cp oracle_analysis_q1.R analyses/oracle_q1_pooled_effect.R

# Or the Python code
cp oracle_analysis_q3.py analyses/oracle_q3_subgroup.py
```

### 5. Run and Validate Results

**In R:**
```bash
cd analyses/
Rscript oracle_q1_pooled_effect.R
```

**In Python:**
```bash
python oracle_q3_subgroup.py
```

**Review outputs:**
- Console results (effect sizes, p-values, interpretation)
- Generated graphics (forest plot PNG/PDF)
- Check interpretation matches your data expectations

---

## Common Research Questions and Examples

### Example 1: Basic Pooled Effect

**Question:** "What is the pooled effect size and 95% confidence interval?"

**Code:** `examples/sample_meta_analysis/analyses/oracle_q1_pooled_effect_r.R`

**What you get:**
- Fixed-effect and random-effects pooled estimates
- Heterogeneity assessment (I², Q-test)
- Data quality breakdown
- Sensitivity analysis (comparing 🟢-only results)
- Detailed interpretation

**Research context:** Use this to answer: "Is the intervention effective?"

---

### Example 2: Heterogeneity Assessment

**Question:** "Is there significant heterogeneity? Which studies are outliers?"

**Code:** `examples/sample_meta_analysis/analyses/oracle_q2_heterogeneity_r.R`

**What you get:**
- Q-statistic and p-value
- I² heterogeneity index with interpretation
- Between-study variance (τ²)
- Study-level residuals (outlier detection)
- Recommendations for further analysis

**Research context:** Use this to determine if effects differ across studies

---

### Example 3: Subgroup Analysis by Data Quality

**Question:** "Do effects differ by data quality (🟢 vs 🟡 vs 🔴)?"

**Code:** `examples/sample_meta_analysis/analyses/oracle_q3_subgroup_quality_python.py`

**What you get:**
- Separate pooled effects for each data quality group
- Between-group heterogeneity test
- Data quality composition
- Sensitivity analysis interpretation

**Research context:** Use this to assess robustness to data extraction uncertainty

---

### Example 4: Subgroup Analysis by Study Characteristic

**Question:** "Do effects differ by outcome type / study design / risk of bias?"

**Code:** `examples/sample_meta_analysis/analyses/oracle_q4_subgroup_outcome_r.R`

**What you get:**
- Pooled estimates by subgroup
- Between-subgroup heterogeneity test (Q_between)
- Residual heterogeneity within groups
- Recommendations for interpretation

**Research context:** Use this to explore sources of variation

---

### Example 5: Forest Plot

**Question:** "Generate a forest plot showing all studies and the pooled effect."

**Code:** `examples/sample_meta_analysis/analyses/oracle_q5_forest_plot_python.py`

**What you get:**
- High-resolution forest plot (PNG, PDF)
- Individual study effect sizes with 95% CIs
- Pooled effect highlighted
- Study weighting visualization
- Interpretation guide

**Research context:** Use for visualizing results and publications

---

## Language Selection: R vs. Python

### Use R (metafor package) when:
- You prefer native statistical programming
- You need publication-quality forest plots
- Your team uses R for other analyses
- You want access to specialized meta-analysis extensions

**R is recommended for:**
- Standard meta-analyses with fixed/random effects
- Mixed-effects meta-regression
- Publication-ready graphics

### Use Python (numpy/scipy) when:
- You prefer Python or have Python infrastructure
- You want more flexible customization
- You're integrating with data science pipelines
- You prefer matplotlib visualization

**Python is recommended for:**
- Large-scale automated analyses
- Integration with machine learning workflows
- Custom visualization requirements

**Note:** Both produce identical statistical results; choice is preference and workflow.

---

## Configuration Options

### Research Question Formats

**Explicit specification:**
```
Question: "What is the pooled effect size?"
Language: R
Operation: Pooled effect calculation
```

**With moderator/subgroup:**
```
Question: "Do effects differ by quality_score (high vs. medium vs. low)?"
Language: Python
Operation: Subgroup analysis
```

**Combined analyses:**
```
Question: "Calculate pooled effect, assess heterogeneity, and generate forest plot"
Language: R
```

**Data quality focus:**
```
Question: "How sensitive are results to excluding uncertain (🟡/🔴) data?"
Language: Python
Operation: Sensitivity analysis
```

### Dataset Path Specification

**Relative path (recommended):**
```
Dataset: compiled/compiled_data.csv
```

**Absolute path:**
```
Dataset: /Users/researcher/analysis/compiled/dataset_v2.csv
```

**CSV with different encoding:**
```
Dataset: compiled/data_latin1.csv
Encoding: latin-1
```

---

## Step-by-Step Workflow

### Workflow A: Single Research Question

1. **Request Oracle analysis:**
   ```
   Research Question: "What is the pooled effect size?"
   Language: R
   Dataset: compiled/compiled_data.csv
   ```

2. **Claude Code generates:**
   - R script with complete code
   - Console output with results
   - Interpretation summary

3. **Copy script to project:**
   ```bash
   cp oracle_analysis.R analyses/q1_pooled_effect.R
   ```

4. **Run and review:**
   ```bash
   Rscript analyses/q1_pooled_effect.R
   ```

5. **Save outputs:**
   - Document effect size
   - Note heterogeneity findings
   - Archive script for reproducibility

### Workflow B: Multiple Research Questions

1. **Plan analyses:**
   - Q1: Pooled effect (R)
   - Q2: Heterogeneity (R)
   - Q3: Subgroup analysis (Python)
   - Q4: Sensitivity (R)

2. **Request sequentially:**
   ```
   Question 1: "What is the pooled effect size?"
   Language: R
   ```
   (Save, run, archive results)

   ```
   Question 2: "Is there significant heterogeneity?"
   Language: R
   ```
   (Save, run, archive results)

3. **Compare findings:**
   - Main analysis results
   - Sensitivity analysis variations
   - Identify key drivers

4. **Synthesize for publication:**
   - Write results section
   - Reference code versions
   - Include interpretation guidance

### Workflow C: Iterative Refinement

1. **Initial analysis:**
   ```
   Question: "Pooled effect calculation"
   Language: R
   ```

2. **Review results → Identify patterns**

3. **Ask follow-up:**
   ```
   The heterogeneity I² is very high (87%).
   Please perform subgroup analysis by outcome_measure
   to understand the source.
   ```

4. **Refine based on findings:**
   ```
   The outcome-specific effects suggest we should
   stratify analyses by outcome type. Please generate
   separate pooled effects for each outcome.
   ```

---

## Troubleshooting

### Issue: "File not found" or "Cannot read CSV"

**Cause:** Incorrect file path or encoding issue

**Solutions:**
1. Verify file exists and path is correct
2. Check encoding (must be UTF-8)
3. Use absolute path if relative fails

```bash
# Check file exists
ls -la compiled/compiled_data.csv

# Verify UTF-8 encoding
file compiled/compiled_data.csv
# Should show: "UTF-8 Unicode text"
```

### Issue: "Column not found in dataset"

**Cause:** Dataset missing expected columns

**Solution:** Verify dataset matches Compiled Data Schema v1.0

```bash
# Check columns
head -1 compiled/compiled_data.csv

# Should have at minimum:
# study_id, authors, year, effect_size, variance (or CI bounds)
```

### Issue: "Emoji labels not rendering"

**Cause:** Terminal or editor doesn't support UTF-8

**Solutions:**
- Set terminal encoding: `export LANG=en_US.UTF-8`
- Use a UTF-8 compatible editor (VS Code, Sublime, etc.)
- Explicitly request in code: `encoding='utf-8'`

### Issue: "Generated code won't run"

**Cause:** Missing R packages or Python libraries

**Solutions:**

**R:**
```r
# Run installation code at top of script
install.packages(c("metafor", "readr", "ggplot2", "dplyr"))
```

**Python:**
```bash
pip install pandas numpy scipy matplotlib
```

### Issue: "Results don't match my expectations"

**Cause:** Misunderstanding of data or analysis method

**Solutions:**
1. Review data quality summary from Compiler
2. Verify effect size scale and direction
3. Check for missing values or outliers
4. Ask clarifying question:
   ```
   The pooled effect is -0.23, which suggests
   intervention harms rather than helps.
   Should I verify the effect size direction?
   ```

---

## Data Quality Handling

### Understanding 🟢/🟡/🔴 Labels

**🟢 GREEN (Direct):**
- Data directly quoted or obviously extracted from paper
- Highest confidence for meta-analysis
- Use as primary analysis

**🟡 YELLOW (Computed):**
- Value calculated (e.g., effect size from raw data)
- Moderate confidence; shows calculation steps
- Include in main analysis; flag in sensitivity

**🔴 RED (Uncertain):**
- Data missing, unclear, or inferred
- Low confidence; requires careful interpretation
- Consider sensitivity analysis excluding this data

### Interpreting Quality-Stratified Results

When Oracle provides results by quality level, interpret as follows:

**If effects are CONSISTENT across quality levels:**
```
→ Results are robust
→ Use main analysis confidently
→ Data quality is not a major concern
```

**If effects DIFFER across quality levels:**
```
→ Results are sensitive to data quality
→ Use with caution; acknowledge limitation
→ Consider publication of both estimates
→ Investigate reasons for differences
```

**Decision thresholds:**
- **Small difference** (<10% change in effect): Robust
- **Moderate difference** (10-30% change): Somewhat sensitive
- **Large difference** (>30% change): Highly sensitive

### Sensitivity Analysis Recommendations

Oracle will flag datasets where >20% of data are uncertain (🟡 + 🔴).

**Recommended action:**
1. Run main analysis with all data
2. Run sensitivity analysis excluding uncertain data
3. Compare results
4. Report both in results section

Example reporting:
> "In a sensitivity analysis restricted to directly extracted data (🟢 labels only), the pooled effect remained consistent (OR=1.42, 95% CI 1.21-1.67), suggesting our findings are robust to data extraction methodology."

---

## Output Interpretation Guide

### Pooled Effect Size

**What it means:**
- Average treatment effect across all studies
- Weighted by study precision (inverse variance)
- Represents typical magnitude of effect

**How to interpret magnitude:**

| Metric Type | Small | Medium | Large |
|-----------|--------|--------|-------|
| Cohen's d | 0.2 | 0.5 | 0.8 |
| Odds Ratio | 1.2 | 1.5 | 2.0+ |
| Risk Ratio | 1.1 | 1.3 | 1.5+ |
| Correlation | 0.1 | 0.3 | 0.5 |

### Heterogeneity Assessment

**I² interpretation:**
- **I² < 25%:** Low heterogeneity (consistent effects)
- **25% ≤ I² < 50%:** Moderate heterogeneity
- **50% ≤ I² < 75%:** Substantial heterogeneity
- **I² ≥ 75%:** Considerable heterogeneity (highly inconsistent)

**Q-test p-value:**
- **p < 0.05:** Significant heterogeneity (effects differ)
- **p ≥ 0.05:** No significant heterogeneity (effects similar)

**What to do:**
- **Low heterogeneity:** Report fixed-effect estimates
- **High heterogeneity:** Report random-effects; explore causes

### Confidence Intervals

**Interpretation:**
- 95% CI that doesn't cross zero = statistically significant effect
- Narrow CI = precise estimate (good)
- Wide CI = uncertain estimate (limited data/precision)
- CI reflects both effect size and study precision

---

## Best Practices

### 1. Save and Version Your Code

```bash
analyses/
├── oracle_q1_pooled_effect_r_v1.R   (initial)
├── oracle_q1_pooled_effect_r_v2.R   (refined)
└── oracle_q2_heterogeneity_r.R      (new question)
```

Benefits:
- Reproducibility
- Ability to revisit analysis steps
- Documentation of analytical evolution

### 2. Document Your Analysis Plan

Before requesting analyses, document:
- Primary research questions
- Secondary subgroup hypotheses
- Sensitivity analyses planned
- Expected effect size direction

Example:
```
## Analysis Plan

### Primary Question
What is the overall pooled effect of cognitive therapy on depression symptoms?

### Secondary Questions
1. Is effect size moderated by intervention intensity?
2. Do effects differ by patient age group?
3. Is effect robust to excluding low-quality studies?

### Sensitivity Analyses
- Exclude 🔴 uncertain data
- Restrict to RCTs only
- Exclude studies >10 years old
```

### 3. Validate Results Before Interpretation

Always check:
- ✓ Sample sizes are correct (match compiled dataset)
- ✓ Effect sizes seem plausible (check direction)
- ✓ Heterogeneity level makes sense (explore if high)
- ✓ Data quality is adequate for conclusions

### 4. Report Analyses Transparently

In your methods section, document:
- Oracle version used
- Research questions asked
- Language (R/Python) selected
- Code availability (GitHub repo)
- Any modifications to generated code

Example:
> "Statistical analyses were performed using MAestro Oracle v1.0, which generated R scripts for meta-analysis using the metafor package. Primary analysis specified random-effects pooled estimates, heterogeneity assessment via I² and Q-test, and sensitivity analyses excluding data with high extraction uncertainty..."

### 5. Archive Generated Code

Save all Oracle-generated code in your project:

```bash
# Create analysis archive
mkdir -p analyses/archive
cp oracle_*.R analyses/archive/
cp oracle_*.py analyses/archive/

# Version with git
git add analyses/oracle_*.R
git commit -m "Add Oracle-generated statistical analysis scripts"
```

---

## Advanced Usage

### Custom Moderator Variables

Request subgroup analyses for variables in your dataset:

```
My compiled dataset has a column called "intervention_intensity"
with values "low", "medium", "high".

Question: "Do effect sizes differ by intervention_intensity?"
Language: R
Operation: Subgroup analysis by custom moderator
```

### Combining Multiple Analysis Types

```
Question: "Generate a comprehensive analysis including:
1. Pooled effect (FE and RE models)
2. Heterogeneity assessment
3. Subgroup analysis by quality_score
4. Sensitivity analysis excluding 🔴 data
5. Forest plot visualization"

Language: R
```

### Meta-Regression (Continuous Moderators)

For continuous variables (year, sample size, effect size magnitude):

```
Question: "Does effect size change over publication year?
Please perform meta-regression with year as predictor."
Language: R
```

---

## Related Documentation

- **Oracle Prompt Template:** `prompts/oracle/oracle_v1.0.md` — Full technical specification
- **Compiled Data Schema:** `docs/compiled-data-schema.md` — Expected input format
- **Compiler Guide:** `docs/compiler-usage.md` — How to create datasets for Oracle
- **Example Analyses:** `examples/sample_meta_analysis/analyses/` — Sample generated code
- **Coding Standards:** `docs/architecture/coding-standards.md` — Best practices

---

## Frequently Asked Questions

**Q: Can I edit the generated code?**
A: Yes! The code is fully editable. For reproducibility, save modified versions with _modified suffix (e.g., `oracle_q1_modified.R`).

**Q: What if I don't understand the statistical output?**
A: Oracle includes pedagogical comments in the code. Review the interpretation section at the end of the script for plain-language explanation.

**Q: How do I report this in a publication?**
A: Reference the Oracle template version and describe the methods. Include: "Meta-analyses were conducted in R using inverse variance weighting with random-effects models (DerSimonian-Laird τ² estimation)."

**Q: Can I use this for Bayesian meta-analysis?**
A: Oracle v1.0 focuses on frequentist methods. For Bayesian analyses, request custom code or wait for Oracle v2.0.

**Q: What if my effect sizes are in different scales?**
A: Oracle handles standardized effect sizes (Cohen's d, log-OR, log-RR). See Compiler output for effect_size_metric to understand your scale.

---

## Support and Getting Help

**Troubleshooting:**
1. Check this guide for your issue
2. Review error output from generated code
3. Consult `prompts/oracle/oracle_v1.0.md` for technical details
4. Review example code in `examples/sample_meta_analysis/analyses/`

**Advanced questions:**
- Refer to metafor R package documentation: https://www.metafor-project.org/
- Consult meta-analysis methodology textbooks
- Ask your statistical advisor for specialized questions

---

**End of Oracle Usage Guide**
