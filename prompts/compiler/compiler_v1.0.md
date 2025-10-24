# Compiler v1.0: Data Card Aggregation Template

<!-- Powered by BMAD Core -->

## Metadata

**Template Version:** v1.0
**Created:** 2025-10-23
**Compatible Models:** Claude Sonnet 3.5+, Claude Opus 3+
**Compatible Schema:** Compiled Dataset Schema v1.0
**Input Format:** MAestro Data Card Template v1.0
**Output Format:** CSV/TSV (UTF-8 encoded)

**Changelog:** See `prompts/compiler/CHANGELOG.md` for version history and updates.

---

## Purpose

This prompt template instructs an AI agent (typically Claude Code) to aggregate multiple MAestro data card markdown files into a unified, analysis-ready CSV/TSV dataset that conforms to the standardized schema defined in `docs/compiled-data-schema.md`.

The compiler transforms distributed markdown data cards (one per study) into tabular format suitable for meta-analysis in R, Python, Excel, SPSS, or other statistical software.

---

## Input Requirements

### Data Card Files

- **Location:** Typically stored in a project-specific `data_cards/` directory or provided as an explicit file list
- **Format:** Markdown files (.md) conforming to `templates/data_card.md` structure
- **Structure:**
  - YAML frontmatter containing metadata (study_id, authors, year, extraction info, quality scores)
  - Markdown body with tables containing extracted data points
  - Three-color source labels (🟢/🟡/🔴) for all data points
- **Minimum:** At least 1 data card; maximum recommended: 100 cards within single compilation run
- **Expected context usage:** ~2-5KB per data card (varies by extraction detail)

### Schema Reference

Always cross-reference `docs/compiled-data-schema.md` for:
- Required vs. optional column definitions
- Data types and formats
- Missing value conventions
- Three-color label preservation rules

---

## Step-by-Step Compilation Instructions

### Step 1: Load and Validate Input Data Cards

1. **Read all specified data card files** from the input directory or file list
   - Use Read tool to access each markdown file
   - Confirm files are accessible and properly formatted
   - Log any files that cannot be read or are empty

2. **Parse YAML frontmatter** for each data card
   - Extract metadata fields: `study_id`, `authors`, `year`, `extraction_date`, `extractor`, `microscope_version`, `claude_model`, `screening_decision`, `quality_scores`
   - Validate required fields are present: study_id, authors, year must not be empty
   - **Error handling:** If critical metadata is missing, flag the data card in your error log and note which fields are absent

3. **Parse markdown tables** containing extracted data
   - Identify tables in the markdown body (typically: Demographics, Study Design, Effect Sizes, Outcomes)
   - Extract rows containing effect size data, sample sizes, outcomes, and measurements
   - Preserve source labels (🟢/🟡/🔴) and evidence text alongside each data point
   - **Error handling:** If tables are malformed (inconsistent columns, missing delimiters), document the issue and attempt best-effort extraction or skip problematic rows

4. **Validate data card structure**
   - Confirm YAML frontmatter is well-formed (no syntax errors)
   - Confirm markdown tables use pipe-delimited format with headers
   - Check that extracted data points include source labels
   - **Error handling:** For structural violations, log specific line numbers or section names where issues occur

### Step 2: Map Data Cards to Compiled Schema

For each data card, extract and map fields to the compiled schema columns:

#### Required Columns (must be present in output)

| Column | Extraction Logic | Notes |
|--------|------------------|-------|
| `study_id` | YAML: `study_id` | Must be unique across dataset |
| `authors` | YAML: `authors` | Convert array to string if needed (e.g., "Smith J et al.") |
| `year` | YAML: `year` | Must be integer (YYYY format) |
| `sample_size` | Extract from Demographics table OR Effect Sizes table | Use total N; if multiple outcomes, may differ per row |
| `intervention` | Extract from Study Design table: "Intervention description" row | Canonicalize naming (e.g., "CA-CBT" vs "Culturally Adapted CBT") |
| `comparison` | Extract from Study Design table: "Control/comparison description" row | Common values: "placebo", "standard care", "wait list" |
| `outcome_measure` | Extract from Effect Sizes table: "Outcome" column OR Outcomes table | Human-readable label (e.g., "Pain reduction at 12 weeks") |
| `effect_size` | Extract from Effect Sizes table: "Value" column | Numeric value; for ratios, store as natural log (ln) |
| `effect_size_type` | Infer from effect size metric | Allowed: `continuous_mean_diff`, `continuous_smd`, `dichotomous_or`, `dichotomous_rr`, `dichotomous_hr`, `correlation`, `other` |
| `effect_size_metric` | Extract from Effect Sizes table: "Effect Size Type" column | Examples: `Cohen_d`, `Hedges_g`, `log_or`, `log_rr`, `log_hr`, `pearson_r` |
| `confidence_interval_lower` | Extract from Effect Sizes table: "95% CI Lower" column | Must match scale of effect_size (log-transformed if ratios) |
| `confidence_interval_upper` | Extract from Effect Sizes table: "95% CI Upper" column | Must match scale of effect_size (log-transformed if ratios) |
| `quality_score` | YAML: `quality_scores` -> aggregate or map to 0-1 scale | See Quality Score Mapping below |
| `source_color_label` | Extract from Effect Sizes table: "Source Label & Evidence" column | **Must preserve emoji exactly:** 🟢, 🟡, or 🔴 |
| `data_card_file` | Relative path to data card file | Example: `data_cards/nakashima_2003_cohort.md` |
| `extraction_date` | YAML: `extraction_date` | ISO 8601 format: YYYY-MM-DD |
| `extractor_name` | YAML: `extractor` | Name or identifier (e.g., "Microscope", "Analyst Name") |
| `compiler_version` | Fixed value: `compiler_v1.0` | Update if using newer compiler versions |

#### Optional Columns (include when available)

| Column | Extraction Logic | When to Include |
|--------|------------------|----------------|
| `treatment_n` | Extract from Demographics: "Intervention group (n)" | When per-arm sample sizes reported |
| `control_n` | Extract from Demographics: "Control group (n)" | When per-arm sample sizes reported |
| `effect_size_standard_error` | Extract from Effect Sizes table: "SE" column | When available; useful for meta-analysis weighting |
| `p_value` | Extract from Effect Sizes or Results tables | When reported alongside effect size |
| `evidence_reference` | Extract from "Source Label & Evidence" column | Page numbers, table/figure citations |
| `notes` | Extract from "Source Label & Evidence" OR Additional Notes section | Short free-text remarks about heterogeneity, adjustments, or quality |
| `imputed` | Infer from source label: TRUE if 🟡 (computed), FALSE if 🟢 | Boolean flag for calculated values |
| `outcome_timepoint` | Extract from Outcomes table: "Time Point" column | Follow-up window (e.g., "12_weeks", "posttest") |

**Important Notes:**

- **Multi-row studies:** If a data card reports multiple outcomes or timepoints, create one CSV row per outcome
- **Missing data:** Use empty string for unknown string fields, leave numeric cells blank (do not write "NA" or "NULL")
- **Effect size transformations:**
  - Dichotomous ratios (OR, RR, HR) must be stored as natural log (ln) in `effect_size` column
  - Confidence intervals must also be log-transformed to match
  - Set `effect_size_metric` to `log_or`, `log_rr`, or `log_hr` accordingly
- **Quality score mapping:**
  - If YAML `quality_scores` provides structured ratings (e.g., `overall_quality: "high"`), map to numeric:
    - `high` or `low risk` → 0.85
    - `medium` or `some concerns` → 0.60
    - `low` or `high risk` → 0.35
  - If numeric quality score already present (0-1 or 0-100), use directly (normalize to 0-1 if needed)

### Step 3: Preserve Three-Color Label Fidelity

**Critical Rule:** The three-color source labeling system is the foundation of data transparency and must be preserved exactly.

1. **Extract labels from source tables:**
   - Data cards always include "Source Label & Evidence" columns with 🟢/🟡/🔴 emoji at the start
   - Parse the label (first emoji in the cell) and preserve it in `source_color_label` column
   - Extract accompanying evidence text for `evidence_reference` or `notes` columns

2. **Label meanings:**
   - 🟢 **GREEN:** Direct quote/observation from paper (high fidelity)
   - 🟡 **YELLOW:** Computed/inferred value (moderate fidelity, shows calculation)
   - 🔴 **RED:** Uncertain/missing data (low fidelity, flags issue)

3. **Handle inconsistencies across data cards:**
   - If a study has multiple outcomes with different labels, each row gets its own label
   - If labels are missing from a data card (format violation), flag with 🔴 and note: "Label missing from source data card"
   - If labels conflict within the same data point (shouldn't happen in well-formed cards), document in error log

4. **Validation check:** After compilation, verify every row has a valid label (🟢, 🟡, or 🔴)

### Step 4: Generate Data Quality Summary

After compiling all data cards into rows, compute a **data quality summary** to guide meta-analysis decisions:

#### Quality Metrics to Calculate

1. **Label distribution:**
   - Count total data points: N_total
   - Count by label: N_green (🟢), N_yellow (🟡), N_red (🔴)
   - Calculate percentages:
     - `pct_green = (N_green / N_total) * 100`
     - `pct_yellow = (N_yellow / N_total) * 100`
     - `pct_red = (N_red / N_total) * 100`

2. **High 🔴 studies (re-extraction candidates):**
   - For each study (unique `study_id`), count 🔴-labeled data points
   - List studies where `pct_red > 30%` or `N_red >= 3` (adjust threshold based on project needs)
   - These are flagged as potential re-extraction targets due to high uncertainty

3. **Quality score distribution:**
   - Calculate mean, median, min, max of `quality_score` column
   - Identify studies in lowest quartile (may need quality sensitivity analysis)

4. **Missing data patterns:**
   - Count rows with missing required fields (effect_size, confidence intervals, sample_size)
   - List studies with incomplete effect size data (may be excluded from analysis)

5. **Heterogeneity indicators:**
   - Count unique `effect_size_type` values (mixing continuous and dichotomous requires subgroup analysis)
   - Count unique `outcome_measure` values (high diversity may indicate outcome reporting bias)

#### Quality Summary Output Format

Present the quality summary in markdown format immediately after compilation:

```markdown
## Data Quality Summary

**Compilation Date:** YYYY-MM-DD
**Compiler Version:** compiler_v1.0
**Total Studies:** [N]
**Total Data Points (rows):** [N]

### Label Distribution
- 🟢 GREEN (direct): [N] ([pct]%)
- 🟡 YELLOW (computed): [N] ([pct]%)
- 🔴 RED (uncertain): [N] ([pct]%)

### High Uncertainty Studies (Re-extraction Candidates)
| Study ID | 🔴 Count | 🔴 Percentage | Notes |
|----------|---------|--------------|-------|
| study_1 | X | XX% | [Brief issue description] |
| study_2 | X | XX% | [Brief issue description] |

**Recommendation:** Review flagged studies for potential re-extraction or exclusion.

### Quality Score Statistics
- Mean: [0.XX]
- Median: [0.XX]
- Range: [0.XX - 0.XX]
- Studies in lowest quartile (quality < [threshold]): [list study_ids]

### Data Completeness
- Complete effect size data (ES + CI): [N] / [Total] ([pct]%)
- Missing confidence intervals: [N]
- Missing standard errors: [N]
- Missing sample sizes: [N]

### Outcome Heterogeneity
- Effect size types: [list types, counts]
- Unique outcome measures: [N]
- Intervention types: [list top 3-5]

**Analysis Readiness:** [READY / NEEDS REVIEW / NOT READY]
```

### Step 5: Write Output CSV File

1. **Format specifications:**
   - **Delimiter:** Comma-separated (`,`) for .csv extension; tab-separated for .tsv
   - **Encoding:** UTF-8 (no BOM) to preserve emoji labels
   - **Header row:** Always include; column names must exactly match schema
   - **Line endings:** Unix-style (`\n`) preferred; tolerate `\r\n`
   - **Quoting:** Use double quotes for fields containing commas, newlines, or quotes

2. **Column order:** Follow schema exactly (see `docs/compiled-data-schema.md`)
   - Required columns first (study_id through compiler_version)
   - Optional columns after (treatment_n through outcome_timepoint)
   - Maintain consistent order across all compilations

3. **Missing value convention:**
   - Empty strings for missing text fields: `""`
   - Empty cells for missing numeric fields: `,,[next field]`
   - Do NOT write `NA`, `NULL`, `NaN`, or `None` — leave blank

4. **Write file:**
   - Default filename: `compiled_data_YYYY-MM-DD.csv` (datestamped)
   - Save to project `compiled/` directory or user-specified output path
   - Confirm write success and report final row count

5. **Validation:**
   - Check CSV is valid (no unclosed quotes, consistent column counts)
   - Verify emoji labels render correctly (UTF-8 encoding)
   - Spot-check 2-3 rows against source data cards for accuracy

### Step 6: Error Handling and Logging

Throughout compilation, maintain an **error log** documenting issues encountered:

#### Common Issues and Responses

| Issue | Detection | Response | Log Entry |
|-------|-----------|----------|-----------|
| **Missing YAML field** | Required field (study_id, authors, year) is empty or absent | Skip data card or use placeholder ("UNKNOWN") and flag | "Data card [filename]: Missing required field [field_name]" |
| **Malformed table** | Table rows don't match header columns, or pipe delimiters inconsistent | Attempt best-effort parsing; if fails, skip table | "Data card [filename]: Malformed table in section [section_name]" |
| **Missing source label** | "Source Label & Evidence" cell has no 🟢/🟡/🔴 emoji | Assign 🔴 and note "Label missing from source" | "Data card [filename]: Missing source label in [table_name], row [N]" |
| **Duplicate study_id** | Two data cards have identical study_id | Append suffix (_v2, _v3) or error and skip second instance | "Duplicate study_id detected: [study_id]; renamed to [study_id_v2]" |
| **Conflicting data** | Same study has multiple conflicting effect sizes for same outcome | Include all as separate rows; note in `notes` column | "Data card [filename]: Multiple effect sizes for [outcome]; included as separate rows" |
| **Invalid effect size** | Non-numeric value in effect size field | Leave field blank; flag in error log | "Data card [filename]: Invalid effect size '[value]' in [outcome]" |
| **CI bounds out of order** | Lower CI > Upper CI | Swap values and note correction | "Data card [filename]: CI bounds swapped for [outcome]" |
| **Format violations** | YAML syntax errors, markdown not parseable | Skip data card entirely; cannot extract safely | "Data card [filename]: YAML parsing failed; skipping file" |

#### Error Log Output

Present error log as markdown after compilation:

```markdown
## Compilation Error Log

**Total Errors:** [N]
**Total Warnings:** [N]
**Files Skipped:** [N]

### Critical Errors (File Skipped)
- [timestamp] [filename]: [description]

### Warnings (Partial Extraction)
- [timestamp] [filename]: [description]

### Data Quality Issues
- [timestamp] [filename]: [description]

**Action Required:** Review flagged files for manual correction or re-extraction.
```

---

## Context Window Management

When compiling large datasets (20+ data cards), be mindful of context window limits:

1. **Batch processing:** If total input exceeds ~80,000 tokens, consider:
   - Splitting compilation into batches (compile 20 cards at a time, append results)
   - Using compression techniques (summarize metadata, extract only effect size tables)

2. **Efficient reading:**
   - Read YAML frontmatter first to quickly validate study_id and screening_decision
   - Skip data cards with `screening_decision: "exclude"` to save context
   - Only read full markdown tables for included studies

3. **Progress tracking:**
   - Report progress every 10 data cards processed
   - Provide running counts of rows compiled, errors encountered
   - Allow user to interrupt and resume if needed

4. **Optimization tips:**
   - For very large compilations (100+ cards), recommend splitting input directory or using incremental compilation
   - Store intermediate results (parsed YAML metadata) to avoid re-reading files on errors
   - Use streaming write to output CSV (append rows incrementally rather than buffering all in memory)

**Tested Limit:** Compiler v1.0 is validated for 20-card compilations (~40KB context per batch). For larger datasets, use batching workflow described above.

---

## Validation Checklist

Before finalizing compilation, verify:

- [ ] All input data card files were read successfully (or failures logged)
- [ ] Output CSV has correct column headers matching schema exactly
- [ ] All rows have valid `study_id`, `authors`, `year` (required fields)
- [ ] `source_color_label` column contains only 🟢, 🟡, or 🔴 emoji (no text labels)
- [ ] Effect size columns are numeric (or empty for missing data)
- [ ] Dichotomous ratios are log-transformed (check `effect_size_metric` values)
- [ ] Quality score values are in valid range (0-1 scale)
- [ ] Dates are ISO 8601 format (YYYY-MM-DD)
- [ ] `compiler_version` column populated correctly (compiler_v1.0)
- [ ] Data quality summary generated and includes label distribution
- [ ] High 🔴 studies identified and flagged for review
- [ ] Error log generated (even if empty) documenting any issues
- [ ] Output file encoding is UTF-8 (emoji render correctly)
- [ ] Row count matches expected number (1 row per outcome per study)

---

## Example Usage Workflow

**Scenario:** Compile 15 data cards from `examples/sample_meta_analysis/data_cards/` into `examples/sample_meta_analysis/compiled/compiled_data.csv`

### Execution Steps:

1. **User provides input:**
   ```
   Input directory: examples/sample_meta_analysis/data_cards/
   Output file: examples/sample_meta_analysis/compiled/compiled_data.csv
   ```

2. **Claude Code execution:**
   - Read all .md files in input directory
   - Parse YAML and markdown tables per Step 1-2 above
   - Map extracted data to schema columns
   - Preserve 🟢/🟡/🔴 labels
   - Generate quality summary per Step 4
   - Write CSV output per Step 5
   - Generate error log per Step 6

3. **Output provided to user:**
   - `compiled_data.csv` file with [N] rows
   - Data quality summary (markdown)
   - Compilation error log (markdown)
   - Success message: "Compilation complete. [N] data cards processed, [N] rows generated."

4. **Post-compilation validation:**
   - User reviews quality summary and error log
   - User tests CSV import in R (`readr::read_csv()`) or Python (`pandas.read_csv()`)
   - User addresses any flagged high-🔴 studies before meta-analysis

---

## Schema Version Compatibility

**This prompt template (v1.0) is compatible with:**

- Compiled Dataset Schema v1.0 (`docs/compiled-data-schema.md`)
- Data Card Template v1.0 (`templates/data_card.md`)
- Microscope Prompt v1.0+ output

**Breaking changes (require new compiler version):**

- New required columns in schema
- Changes to three-color label system
- Changes to effect size transformation rules (e.g., different log base)

**Non-breaking changes (can be handled in v1.0):**

- Adding optional columns (append to end of CSV)
- New quality score mappings (document in changelog)
- Additional error handling patterns

---

## Maintenance and Updates

**Version Control:**

- This prompt template is versioned semantically (v1.0, v1.1, v2.0)
- All changes must be documented in `prompts/compiler/CHANGELOG.md`
- Cross-reference schema versions to ensure compatibility

**When to Update:**

- Schema changes in `docs/compiled-data-schema.md`
- New data card template fields in `templates/data_card.md`
- User feedback on error handling or edge cases
- Performance optimizations for larger datasets

**Update Process:**

1. Create new versioned file (e.g., `compiler_v1.1.md`)
2. Document changes in CHANGELOG.md
3. Update `compiler_version` column value in output
4. Re-run validation tests with sample data cards
5. Update `docs/compiler-usage.md` with any new instructions

---

## Related Documentation

- **Schema Reference:** `docs/compiled-data-schema.md` — Column definitions, data types, constraints
- **Data Card Format:** `templates/data_card.md` — Input structure and three-color labeling rules
- **Usage Guide:** `docs/compiler-usage.md` — Step-by-step instructions for manual execution
- **Quality Checklist:** `modules/generic/generic_quality_checklist.md` — Quality score interpretation
- **Validation Tests:** `tests/validation/test_compiled_schema_io.py` — Automated CSV compatibility checks

---

## Support and Troubleshooting

**Common Issues:**

- **"File not found" errors:** Verify data card paths are relative to project root or provide absolute paths
- **Emoji labels not rendering:** Confirm output encoding is UTF-8 (no BOM); check terminal/editor supports emoji
- **Pandas/R import failures:** Validate CSV structure (no unclosed quotes); verify column names match schema exactly
- **Context window exceeded:** Use batch processing for >20 data cards; compile incrementally

**Getting Help:**

- Review `docs/compiler-usage.md` for detailed usage guidance
- Check CHANGELOG for known issues and workarounds
- Consult project documentation or team lead for project-specific conventions

---

**End of Compiler v1.0 Template**
