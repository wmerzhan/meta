# Compiler Usage Guide

**Version:** 1.0
**Last Updated:** 2025-10-23
**For:** MAestro Meta-analysis Framework

---

## Overview

The **Compiler** is an AI-assisted workflow that aggregates multiple MAestro data card markdown files into a unified CSV/TSV dataset ready for meta-analysis in R, Python, Excel, or statistical software.

**What it does:**
- Reads data card markdown files (one per study)
- Extracts YAML metadata and markdown table data
- Transforms distributed data into standardized tabular format
- Preserves three-color source labels (🟢/🟡/🔴) for transparency
- Generates data quality summaries and error reports
- Outputs analysis-ready CSV/TSV files

**When to use:**
- After completing data extraction for multiple studies (typically 5-100 papers)
- Before beginning meta-analysis (to prepare analysis-ready dataset)
- When updating a dataset with new extractions or corrections

**Prerequisites:**
- Completed data cards (`.md` files) following `templates/data_card.md` structure
- Claude Code CLI or compatible AI environment
- Familiarity with `docs/compiled-data-schema.md` (output format)

---

## Quick Start

### 1. Prepare Your Data Cards

Ensure your data cards are:
- Stored in a dedicated directory (e.g., `data_cards/`)
- Named with descriptive identifiers (e.g., `nakashima_2003_cohort.md`)
- Complete with YAML frontmatter and markdown tables
- Labeled with 🟢/🟡/🔴 source labels for all extracted data

**Example directory structure:**
```
my_meta_analysis/
├── data_cards/
│   ├── smith_2020_rct.md
│   ├── jones_2019_cohort.md
│   ├── lee_2021_rct.md
│   └── ... (more data cards)
├── compiled/
│   └── (output CSV files will go here)
```

### 2. Open Claude Code

Launch Claude Code in your project directory:

```bash
cd /path/to/my_meta_analysis
claude
```

### 3. Load the Compiler Prompt

Copy and paste the full compiler prompt template into Claude Code:

```
Please read and follow the instructions in prompts/compiler/compiler_v1.0.md to compile my data cards.

Input directory: data_cards/
Output file: compiled/compiled_data_2025-10-23.csv
```

Alternatively, if using Claude Code directly in the repository:

```
/read prompts/compiler/compiler_v1.0.md

Now compile the data cards in data_cards/ and output to compiled/compiled_data.csv
```

### 4. Review Outputs

Claude Code will generate:
1. **CSV file** (`compiled/compiled_data.csv`) — your analysis-ready dataset
2. **Data quality summary** — label distribution, high-uncertainty studies, completeness metrics
3. **Error log** — any issues encountered during compilation

### 5. Validate and Use

- Open the CSV in Excel, R, or Python to verify correctness
- Review quality summary to identify studies needing re-extraction
- Address errors from error log before meta-analysis
- Proceed with statistical analysis using the compiled dataset

---

## Detailed Execution Workflows

### Workflow A: Manual Execution in Claude Code

**Best for:** One-time compilations, small-to-medium datasets (< 50 studies)

1. **Start Claude Code session:**
   ```bash
   cd /path/to/your/project
   claude
   ```

2. **Provide instructions:**
   ```
   I need to compile my data cards into a CSV file for meta-analysis.

   Please follow the instructions in prompts/compiler/compiler_v1.0.md.

   Input: data_cards/ directory
   Output: compiled/compiled_data_2025-10-23.csv

   Please include the data quality summary and error log.
   ```

3. **Claude Code will:**
   - Read the compiler prompt template
   - Read all data card files in `data_cards/`
   - Parse YAML and markdown tables
   - Map to standardized schema
   - Generate CSV output
   - Produce quality summary and error log

4. **Review outputs:**
   - Check `compiled/compiled_data_2025-10-23.csv` was created
   - Read quality summary in Claude's response
   - Review error log for issues
   - Spot-check a few rows against original data cards

### Workflow B: Batch Compilation (Large Datasets)

**Best for:** Large datasets (> 50 studies) that may exceed context limits

1. **Split data cards into batches:**
   ```bash
   mkdir -p data_cards/batch_1 data_cards/batch_2 data_cards/batch_3
   # Move data cards into batches (20-30 cards each)
   ```

2. **Compile each batch separately:**
   ```
   Please compile data_cards/batch_1/ to compiled/compiled_data_batch_1.csv
   (Repeat for batch_2, batch_3, etc.)
   ```

3. **Merge batch outputs:**
   ```python
   import pandas as pd

   batch1 = pd.read_csv('compiled/compiled_data_batch_1.csv')
   batch2 = pd.read_csv('compiled/compiled_data_batch_2.csv')
   batch3 = pd.read_csv('compiled/compiled_data_batch_3.csv')

   merged = pd.concat([batch1, batch2, batch3], ignore_index=True)
   merged.to_csv('compiled/compiled_data_full.csv', index=False)
   ```

4. **Generate combined quality summary:**
   - Re-run quality calculations on merged dataset
   - Check for duplicate study_ids across batches

### Workflow C: Incremental Compilation (Adding New Studies)

**Best for:** Ongoing projects where new extractions are added regularly

1. **Initial compilation:**
   ```
   Compile data_cards/ to compiled/compiled_data_v1.csv
   ```

2. **After adding new data cards:**
   ```
   New data cards added:
   - garcia_2023_rct.md
   - patel_2022_cohort.md

   Please compile ALL data cards in data_cards/ to compiled/compiled_data_v2.csv
   ```

3. **Versioning strategy:**
   - Use datestamps: `compiled_data_2025-10-23.csv`, `compiled_data_2025-11-15.csv`
   - Or version numbers: `compiled_data_v1.csv`, `compiled_data_v2.csv`
   - Keep previous versions for reproducibility

---

## Configuration Options

### Input Directory Specification

**Default:** `data_cards/` (relative to project root)

**Custom directory:**
```
Input: examples/sample_meta_analysis/data_cards/
```

**Absolute path:**
```
Input: /Users/researcher/Documents/my_meta_analysis/data_cards/
```

**File list (specific cards):**
```
Input files:
- data_cards/smith_2020_rct.md
- data_cards/jones_2019_cohort.md
- data_cards/lee_2021_rct.md

(Useful for compiling only reviewed or finalized cards)
```

### Output Path Specification

**Default:** `compiled/compiled_data_YYYY-MM-DD.csv` (datestamped)

**Custom filename:**
```
Output: compiled/pain_meta_analysis_dataset.csv
```

**Different directory:**
```
Output: /Users/researcher/Dropbox/research/datasets/compiled_data.csv
```

**TSV format (tab-separated):**
```
Output: compiled/compiled_data.tsv
(Compiler will use tab delimiter for .tsv extension)
```

### Filtering Options

**Include only certain studies:**
```
Input: data_cards/
Filter: screening_decision == "include"
(Compiler will skip data cards with screening_decision: "exclude" in YAML)
```

**Exclude specific data cards:**
```
Input: data_cards/
Exclude:
- draft_extractions/
- deprecated/
```

### Schema Customization

**By default,** compiler follows `docs/compiled-data-schema.md` exactly.

**To add custom optional columns:**
```
Please include these additional optional columns:
- study_country (from demographics or methods)
- publication_type (journal article, dissertation, conference)
```

*(Note: Custom columns require manual mapping instructions)*

---

## Troubleshooting

### Issue: "File not found" or "Cannot read data card"

**Cause:** Incorrect file path or permissions

**Solutions:**
1. Verify directory path is correct (relative to project root or absolute)
2. Check file names for typos or special characters
3. Ensure data card files have `.md` extension
4. Verify read permissions: `ls -la data_cards/`

**Example:**
```bash
# Check files exist
ls data_cards/*.md

# Check permissions
chmod 644 data_cards/*.md
```

### Issue: "YAML parsing failed"

**Cause:** Malformed YAML frontmatter (syntax errors)

**Solutions:**
1. Open the data card in a text editor
2. Check for:
   - Missing opening `---` or closing `---` delimiters
   - Incorrect indentation (use spaces, not tabs)
   - Unquoted strings containing special characters (`:`, `#`, `@`)
   - Missing colons after field names
3. Validate YAML syntax: https://www.yamllint.com/

**Example fix:**
```yaml
# INCORRECT
title: Randomized trial: effects of exercise

# CORRECT
title: "Randomized trial: effects of exercise"
```

### Issue: "Missing required field: study_id"

**Cause:** Data card YAML missing critical metadata

**Solutions:**
1. Open the flagged data card
2. Verify YAML frontmatter includes: `study_id`, `authors`, `year`
3. Add missing fields:
   ```yaml
   study_id: "smith_2020_rct"
   authors: ["Smith J", "Johnson A"]
   year: 2020
   ```

### Issue: "Emoji labels not rendering in CSV"

**Cause:** Encoding issue or software incompatibility

**Solutions:**
1. **Verify encoding:** CSV must be UTF-8 (no BOM)
   ```bash
   file compiled/compiled_data.csv
   # Should show: UTF-8 Unicode text
   ```

2. **Open in compatible software:**
   - Excel (Mac): UTF-8 supported by default
   - Excel (Windows): Use "Data > From Text/CSV" and select UTF-8 encoding
   - Google Sheets: Upload with UTF-8 encoding (auto-detected)
   - R: `read_csv()` from `readr` package handles UTF-8 correctly
   - Python: `pd.read_csv(..., encoding='utf-8')`

3. **Re-export if needed:**
   ```python
   import pandas as pd
   df = pd.read_csv('compiled_data.csv', encoding='utf-8')
   df.to_csv('compiled_data_utf8.csv', index=False, encoding='utf-8')
   ```

### Issue: "Duplicate study_id detected"

**Cause:** Two data cards have identical study_id values

**Solutions:**
1. Check if truly duplicates (same paper extracted twice) → Keep best version, delete other
2. If different papers with same ID → Rename one with unique identifier:
   ```yaml
   # Change from:
   study_id: "smith_2020_rct"

   # To:
   study_id: "smith_2020_rct_cohort1"  # Or smith_2020a, smith_2020_study1, etc.
   ```

### Issue: "Effect size value is non-numeric"

**Cause:** Data card contains text or placeholder in effect size field

**Solutions:**
1. Open the flagged data card
2. Find Effect Sizes table, check "Value" column
3. Replace placeholders with actual numeric values:
   ```markdown
   # INCORRECT
   | Outcome | Value | ...
   | Pain reduction | Not reported | ...

   # CORRECT (if truly missing)
   | Outcome | Value | ...
   | Pain reduction | | ...  (leave blank)
   ```
4. If effect size cannot be calculated, leave field empty (will be blank in CSV)

### Issue: "Confidence interval bounds out of order"

**Cause:** Lower CI > Upper CI (data entry error)

**Solutions:**
1. Check original paper for correct CI bounds
2. Verify calculation if 🟡 (computed) label
3. Correct values in data card:
   ```markdown
   # INCORRECT
   | ... | CI Lower | CI Upper | ...
   | ... | 0.82 | 0.23 | ...

   # CORRECT
   | ... | CI Lower | CI Upper | ...
   | ... | 0.23 | 0.82 | ...
   ```

### Issue: "Context window exceeded"

**Cause:** Too many data cards to process in a single compilation

**Solutions:**
1. Use **Workflow B: Batch Compilation** (see above)
2. Split data cards into batches of 20-30 files
3. Compile each batch separately
4. Merge outputs using pandas or R
5. For very large projects (100+ studies), consider scripting the compiler workflow

### Issue: "Table formatting error in data card"

**Cause:** Markdown table has inconsistent columns or malformed pipes

**Solutions:**
1. Open flagged data card in markdown editor
2. Check that all table rows have same number of pipe delimiters `|`
3. Ensure table has header row and separator row:
   ```markdown
   # CORRECT
   | Column 1 | Column 2 | Column 3 |
   |----------|----------|----------|
   | Value 1  | Value 2  | Value 3  |

   # INCORRECT (missing separator)
   | Column 1 | Column 2 |
   | Value 1  | Value 2  |
   ```
4. Use markdown preview to verify table renders correctly

### Issue: "Missing source labels in compiled output"

**Cause:** Data card tables missing 🟢/🟡/🔴 emoji in "Source Label & Evidence" columns

**Solutions:**
1. Review flagged data cards
2. Add source labels to ALL extracted data points:
   ```markdown
   | Variable | Value | Source Label & Evidence |
   |----------|-------|------------------------|
   | Sample size | 120 | 🟢 (p. 5, Methods section, line 3) |
   ```
3. If original data truly missing, use 🔴:
   ```markdown
   | Sample size | | 🔴 Sample size not reported in paper |
   ```

---

## Quality Summary Interpretation

After compilation, Claude Code provides a **Data Quality Summary**. Here's how to interpret and act on it:

### Label Distribution

```
🟢 GREEN (direct): 45 (62%)
🟡 YELLOW (computed): 18 (25%)
🔴 RED (uncertain): 10 (13%)
```

**Interpretation:**
- **> 60% 🟢:** Excellent — most data directly extracted
- **40-60% 🟢:** Good — mix of direct and computed data
- **< 40% 🟢:** Concerning — high proportion of inferred/uncertain data
- **> 20% 🔴:** High uncertainty — review flagged studies

**Action:**
- If 🔴 > 20%, consider re-extracting high-uncertainty studies
- Document label distribution in meta-analysis methods section
- Plan sensitivity analyses excluding 🔴 data if substantial

### High Uncertainty Studies

```
| Study ID | 🔴 Count | 🔴 Percentage | Notes |
|----------|---------|--------------|-------|
| garcia_2018_rct | 5 | 71% | Missing CIs and effect sizes |
| patel_2017_cohort | 3 | 50% | Sample sizes unclear |
```

**Action:**
1. **Review flagged studies:** Manually inspect data cards and original papers
2. **Options:**
   - Re-extract with more careful reading
   - Contact authors for missing data
   - Exclude from meta-analysis (document in PRISMA flow)
   - Include but conduct sensitivity analysis
3. **Document decisions:** Note exclusions or adjustments in methods

### Quality Score Statistics

```
Mean: 0.68
Median: 0.70
Range: 0.35 - 0.85
Studies in lowest quartile (quality < 0.55): smith_2015_quasi, lee_2016_cohort
```

**Action:**
- Plan subgroup analysis by quality score (high vs. medium vs. low)
- Consider sensitivity analysis excluding lowest-quality studies
- Report quality distribution in meta-analysis results

### Data Completeness

```
Complete effect size data (ES + CI): 65 / 73 (89%)
Missing confidence intervals: 8
Missing standard errors: 15
Missing sample sizes: 2
```

**Action:**
- **Missing CIs:** Attempt to calculate from SE or p-values (if possible)
- **Missing SE:** Calculate from CIs: `SE = (Upper CI - Lower CI) / (2 × 1.96)`
- **Missing sample sizes:** Critical for weighting — re-check papers or exclude
- Document imputation methods if applied

### Outcome Heterogeneity

```
Effect size types: continuous_smd (45), dichotomous_or (20), correlation (8)
Unique outcome measures: 12
```

**Action:**
- **Mixed effect types:** Plan separate meta-analyses by type (continuous, dichotomous, correlation)
- **Many outcome measures:** Check for outcome reporting bias; consider outcome category subgroups
- Document heterogeneity handling in methods

---

## Best Practices

### 1. Compile Regularly During Extraction

Don't wait until all extractions are complete. Compile after every 5-10 data cards to:
- Catch formatting errors early
- Validate schema compliance
- Identify extraction patterns or issues

### 2. Version Control Your Compilations

Keep dated versions of compiled datasets:
```
compiled/
├── compiled_data_2025-10-23_initial.csv
├── compiled_data_2025-11-05_updated.csv
└── compiled_data_2025-11-20_final.csv
```

Benefits:
- Reproducibility
- Ability to compare versions
- Rollback if errors introduced

### 3. Validate Before Analysis

**Always validate compiled CSV before meta-analysis:**

In R:
```r
library(readr)
library(dplyr)

data <- read_csv("compiled/compiled_data.csv")

# Check structure
glimpse(data)

# Verify label integrity
unique(data$source_color_label)  # Should be: 🟢, 🟡, 🔴

# Check for missing effect sizes
sum(is.na(data$effect_size))

# Verify effect size types
table(data$effect_size_type)
```

In Python:
```python
import pandas as pd

data = pd.read_csv('compiled/compiled_data.csv', encoding='utf-8')

# Check structure
data.info()

# Verify label integrity
print(data['source_color_label'].unique())  # Should be: 🟢, 🟡, 🔴

# Check for missing effect sizes
print(data['effect_size'].isna().sum())

# Verify effect size types
print(data['effect_size_type'].value_counts())
```

### 4. Document Compilation Parameters

In your meta-analysis protocol or methods, document:
- Compiler version used (e.g., `compiler_v1.0`)
- Compilation date
- Input directory and file count
- Any exclusions or filters applied
- Quality summary findings
- Error handling decisions

Example:
> "Data compilation was performed using MAestro Compiler v1.0 on 2025-10-23. A total of 42 data cards were compiled from the `data_cards/` directory, resulting in 68 effect size entries. Data quality summary indicated 67% green-labeled (directly extracted) data, 22% yellow-labeled (computed), and 11% red-labeled (uncertain). Three studies with >40% red-labeled data were flagged for review..."

### 5. Backup Original Data Cards

Before any modifications or re-compilations:
```bash
cp -r data_cards/ data_cards_backup_2025-10-23/
```

This allows recovery if errors occur during re-extraction or editing.

---

## Advanced Usage

### Custom Column Mapping

If your project needs additional fields not in the standard schema:

```
Please compile with these custom optional columns:

- funding_source: Extract from "Funding" section if present
- country: Extract from "Study Design" table, "Setting" row
- risk_of_bias_domain_1: Extract from quality_scores YAML field

Add these after the standard optional columns.
```

**Note:** Custom columns require you to provide extraction logic.

### Selective Compilation (Filtering)

Compile only specific subsets:

```
Please compile only data cards where:
- screening_decision == "include" (skip excluded studies)
- quality_scores.overall_quality != "low" (exclude low-quality)
- year >= 2010 (recent studies only)

Input: data_cards/
Output: compiled/compiled_data_recent_highquality.csv
```

### Merging With Existing Datasets

If you have a previous compilation and new data cards:

```
I have:
1. Existing dataset: compiled/compiled_data_v1.csv (50 studies)
2. New data cards: data_cards/new_extractions/ (8 studies)

Please:
1. Compile new_extractions/ to a temporary CSV
2. Merge with compiled_data_v1.csv (checking for duplicate study_ids)
3. Output: compiled/compiled_data_v2.csv
```

---

## Related Documentation

- **Compiler Prompt Template:** `prompts/compiler/compiler_v1.0.md` — Full technical specification
- **Schema Reference:** `docs/compiled-data-schema.md` — Column definitions and data types
- **Data Card Template:** `templates/data_card.md` — Input format specification
- **Validation Tests:** `tests/validation/test_compiled_schema_io.py` — Automated CSV compatibility checks

---

## Support

**Common questions:**
- "How do I know if my data cards are ready to compile?" → Check validation checklist at bottom of each data card; ensure all required YAML fields present and tables have source labels
- "Can I edit the CSV after compilation?" → Yes, but document all manual edits for reproducibility; consider editing source data cards instead and re-compiling
- "What if I need to add a study after compilation?" → Either re-compile all data cards (recommended) or manually add rows to CSV (ensure schema compliance)

**Getting help:**
- Review this guide and `prompts/compiler/compiler_v1.0.md`
- Check error log generated by compiler for specific issues
- Consult project team or lead for project-specific conventions
- Refer to example compilations in `examples/sample_meta_analysis/compiled/`

---

**End of Compiler Usage Guide**
