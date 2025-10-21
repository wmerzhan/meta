# Data Card Format Specification

**Version:** 1.0
**Last Updated:** 2025-10-20
**Status:** Active Specification

---

## Table of Contents

1. [Format Rationale](#format-rationale)
2. [YAML Field Definitions](#yaml-field-definitions)
3. [Markdown Table Conventions](#markdown-table-conventions)
4. [Three-Color Labeling Rules](#three-color-labeling-rules)
5. [Compiler Compatibility](#compiler-compatibility)
6. [Validation Checklist](#validation-checklist)
7. [Examples and Edge Cases](#examples-and-edge-cases)
8. [FAQ](#faq)

---

## Format Rationale

### Why Markdown for Research Data?

The MAestro data card format uses **Markdown with YAML frontmatter** as the storage format for extracted research data. This design decision is grounded in the specific needs of meta-analysis researchers and the academic transparency goals of the MAestro project.

#### Key Advantages

**1. Git-Compatible Version Control**

Markdown is plain text, making it ideal for version control systems like Git. Researchers can:
- Track every change to extracted data over time
- See exactly who modified what data and when
- Revert to previous versions if extraction errors are discovered
- Collaborate on data extraction with merge conflict resolution
- Create branches for different extraction approaches or sensitivity analyses

**2. Human-Readable and Editable**

Unlike binary formats (Excel, SPSS) or complex structured formats (XML), markdown is:
- Readable without specialized software
- Editable in any text editor
- Understandable at a glance when viewing raw files
- Accessible to researchers without programming experience
- Preserves formatting and structure in a lightweight format

**3. Academic Transparency and Reproducibility**

The format supports MAestro's core mission of academic credibility:
- **Transparent extraction**: Every data point's source is visible inline
- **Audit trail**: Git history provides complete extraction provenance
- **Reproducible**: Data cards can be shared with collaborators or published
- **Citation-friendly**: Each data point links back to specific pages in source papers

**4. No Database Lock-In**

The "Data Card Microservice Architecture" (see architecture documentation) treats the **filesystem as the primary data store**:
- Each data card is an independent, self-contained file
- No database server required in MVP phase
- Easy backup: copy files
- Easy sharing: send files via email or cloud storage
- Platform-independent: works on Windows, macOS, Linux

**5. Future-Proof Format**

Markdown has been stable since 2004. Data cards will remain:
- Readable decades from now
- Compatible with future tools
- Parseable by standard libraries (PyYAML, python-markdown)
- Exportable to other formats (CSV, JSON, Excel) via Compiler tool

#### Design Principles

1. **Atomic Units**: Each data card represents one research paper, creating modular, independent data units
2. **Self-Documenting**: Inline source labels and evidence make data cards self-explanatory
3. **Flexible Structure**: Standard tables for common data types, but customizable for discipline-specific needs
4. **Compiler-Ready**: Format designed for automated aggregation in CROS phase

---

## YAML Field Definitions

The YAML frontmatter (metadata block at top of file) contains structured information about the study and extraction process. YAML is a human-readable data serialization format that's easy to parse programmatically.

### Required Fields

#### `study_id`

- **Type**: String
- **Required**: Yes
- **Purpose**: Unique identifier for this study within your project
- **Format**: Lowercase, underscore-separated, descriptive
- **Examples**:
  - `"johnson_2023_cbt_anxiety"`
  - `"smith_2022_rct_depression"`
  - `"rodriguez_2021_cohort_cardiovascular"`
- **Validation**: Must be unique across all data cards in project
- **Usage**: Used as primary key for compilation and analysis; recommended for filename (`{study_id}.md`)

#### `title`

- **Type**: String
- **Required**: Yes
- **Purpose**: Full title of the research paper
- **Format**: Exact title from paper (copy-paste recommended)
- **Example**: `"Efficacy of Internet-Delivered Cognitive Behavioral Therapy for Generalized Anxiety Disorder: A Randomized Controlled Trial"`
- **Usage**: Display in reports, citation generation, literature identification

#### `authors`

- **Type**: List of Strings (YAML array)
- **Required**: Yes
- **Purpose**: List of paper authors
- **Format**: `["LastName FirstInitial", "LastName FirstInitial", ...]`
- **Example**: `["Johnson MW", "Chen L", "Rodriguez-Garcia P"]`
- **Usage**: Citation generation, authorship tracking, duplicate detection

#### `year`

- **Type**: Integer
- **Required**: Yes
- **Purpose**: Publication year
- **Format**: Four-digit year (YYYY)
- **Example**: `2023`
- **Validation**: Must be positive integer; typically 1900-present
- **Usage**: Temporal analysis, citation formatting, sorting

#### `extraction_date`

- **Type**: DateTime String
- **Required**: Yes
- **Purpose**: When data extraction was performed
- **Format**: ISO 8601 datetime: `YYYY-MM-DDTHH:MM:SSZ`
- **Example**: `"2025-10-20T14:30:00Z"`
- **Usage**: Audit trail, version tracking, extraction timeline analysis
- **Note**: Use UTC timezone (Z suffix)

#### `extractor`

- **Type**: String
- **Required**: Yes
- **Purpose**: Identifier for person who extracted data
- **Format**: Name, initials, or ID (team decision)
- **Examples**: `"Researcher_A"`, `"JMS"`, `"jane.smith@university.edu"`
- **Usage**: Inter-rater reliability analysis, workload tracking, accountability

#### `microscope_version`

- **Type**: String
- **Required**: Yes
- **Purpose**: Version of Microscope prompt used for extraction
- **Format**: `"vX.Y"` matching prompt file version
- **Example**: `"v1.0"`
- **Usage**: Track which extraction instructions were used; critical for reproducibility
- **Validation**: Must correspond to existing prompt in `prompts/microscope/`

#### `claude_model`

- **Type**: String
- **Required**: Yes
- **Purpose**: Claude model version used for AI-assisted extraction
- **Format**: Full model identifier
- **Example**: `"claude-sonnet-4-5-20250929"`
- **Usage**: Model comparison, reproducibility, performance tracking

#### `screening_decision`

- **Type**: String (Enum)
- **Required**: Yes
- **Purpose**: Whether study is included in or excluded from meta-analysis
- **Allowed Values**: `"include"` or `"exclude"`
- **Example**: `"include"`
- **Usage**: Filter studies for analysis; exclusion reasons can be noted in quality_scores or Additional Notes section

#### `quality_scores`

- **Type**: Dictionary/Object (YAML mapping)
- **Required**: Yes
- **Purpose**: Quality assessment results for the study
- **Format**: Checklist-specific key-value pairs
- **Example (Generic Checklist)**:
  ```yaml
  quality_scores:
    random_allocation: "yes"
    blinding: "partial"
    attrition_rate: "low"
    overall_quality: "moderate"
  ```
- **Example (ROB2 Checklist)**:
  ```yaml
  quality_scores:
    domain_1_bias: "low"
    domain_2_bias: "some_concerns"
    domain_3_bias: "high"
    overall_risk: "some_concerns"
  ```
- **Usage**: Risk of bias assessment, quality filtering, sensitivity analysis

### Optional Fields

#### `doi`

- **Type**: String
- **Required**: No (but strongly recommended)
- **Purpose**: Digital Object Identifier for permanent paper link
- **Format**: Standard DOI string
- **Example**: `"10.1037/ccp0000789"`
- **Usage**: Citation linking, automatic metadata retrieval, reference management

---

## Markdown Table Conventions

Data cards use GitHub-Flavored Markdown tables to organize extracted data. Tables provide structure while remaining human-readable.

### General Table Rules

1. **Alignment**: Use pipes (`|`) to separate columns; whitespace alignment improves readability but isn't required
2. **Header Row**: First row defines column names
3. **Separator Row**: Second row with hyphens (`---`) separates headers from data
4. **Data Rows**: Each subsequent row is one observation/data point

**Example**:
```markdown
| Variable | Value | Source Label & Evidence |
|----------|-------|------------------------|
| Sample size | 156 | 🟢 (p. 234, Results) |
```

### Standard Table Structures

The template provides four standard table types. Use these as starting points and modify as needed.

#### 1. Participant Demographics Table

**Purpose**: Document sample characteristics

**Standard Columns**:
- `Variable`: Demographic characteristic name
- `Value`: Extracted value (number, range, description)
- `Source Label & Evidence`: Label (🟢🟡🔴) + page reference/calculation/explanation

**Common Rows**:
- Sample sizes (total, by group)
- Age (mean, median, range)
- Gender distribution
- Population description
- Inclusion/exclusion criteria

**Customization**: Add discipline-specific demographics (e.g., disease severity, socioeconomic status, education level)

#### 2. Study Design Table

**Purpose**: Describe methodological characteristics

**Standard Columns**:
- `Design Element`: Aspect of study design
- `Description`: Details extracted from paper
- `Source Label & Evidence`: Label + evidence

**Common Rows**:
- Study design type (RCT, cohort, etc.)
- Intervention description
- Control/comparison description
- Duration and follow-up
- Randomization and blinding methods
- Setting

#### 3. Outcomes and Measures Table

**Purpose**: Document dependent variables and measurement instruments

**Standard Columns**:
- `Outcome Variable`: Name of outcome
- `Measurement Instrument`: Scale/tool used
- `Reliability/Validity`: Psychometric properties
- `Time Point`: When measured
- `Source Label & Evidence`: Label + evidence

**Usage Note**: Include all outcomes, not just statistically significant ones (avoid publication bias)

#### 4. Effect Sizes Table

**Purpose**: Extract quantitative results for meta-analysis

**Standard Columns**:
- `Outcome`: Which dependent variable
- `Comparison`: Which groups compared
- `Effect Size Type`: Cohen's d, odds ratio, correlation, etc.
- `Value`: Point estimate
- `SE`: Standard error
- `95% CI Lower`: Lower confidence interval bound
- `95% CI Upper`: Upper confidence interval bound
- `Source Label & Evidence`: Label + calculation/citation

**Critical Note**: This table often requires 🟡 labels because effect sizes must be calculated from reported means and SDs.

### Custom Tables

You may create additional tables for:
- Discipline-specific data (e.g., medication dosages in pharmacology)
- Multiple comparison groups
- Longitudinal data with many time points
- Subgroup analyses

**Guidelines for Custom Tables**:
1. Keep column names descriptive
2. Always include a "Source Label & Evidence" column
3. Document custom table purpose in a comment above the table
4. Ensure tables can be parsed by python-markdown (standard markdown syntax)

### Table Formatting Best Practices

- **One data point per row** when possible (aids compilation)
- **Consistent column order** across similar tables
- **Use N/A** for not applicable; use 🔴 for missing/unclear data
- **Keep tables readable** by avoiding extremely long cell contents (use notes section for lengthy descriptions)

---

## Three-Color Labeling Rules

The three-color source labeling system is MAestro's **core differentiator** and the foundation of academic credibility. Every extracted data point must have a label.

### System Overview

| Label | Name | Meaning | Evidence Required |
|-------|------|---------|-------------------|
| 🟢 | Green | Direct quote/observation from paper | Page number and section reference |
| 🟡 | Yellow | Computed or inferred value | Calculation formula or reasoning + source pages |
| 🔴 | Red | Uncertain, ambiguous, or missing data | Explanation of uncertainty or what's missing |

### Label Definitions

#### 🟢 Green: Direct Quote/Observation

**When to use:**
- Data is explicitly stated in the paper exactly as you're extracting it
- No interpretation, calculation, or inference required
- You can point to a specific location in the paper where it appears

**Evidence format:**
- Page number(s)
- Section name (e.g., Methods, Results, Table 2)

**Examples:**

✅ **Correct**:
```markdown
Sample size: 156 | 🟢 "One hundred fifty-six participants were randomized" (p. 234, Results)
```

✅ **Correct**:
```markdown
Mean age: 34.2 (SD=9.8) | 🟢 "Mean age was 34.2 years (SD = 9.8)" (p. 235, Table 1)
```

❌ **Incorrect** (missing page reference):
```markdown
Sample size: 156 | 🟢 Stated in Results section
```

#### 🟡 Yellow: Computed/Inferred Value

**When to use:**
- You calculated a value from other data in the paper
- You inferred information from multiple sources
- You aggregated or transformed reported data
- Effect sizes calculated from means and SDs

**Evidence format:**
- Calculation formula or reasoning process
- Page numbers of all source data used
- Intermediate steps if calculation is complex

**Examples:**

✅ **Correct** (calculated percentage):
```markdown
Gender (% female): 68% | 🟡 68% female (calculated: 106 female / 156 total, from p. 235 Table 1: "106 female, 50 male")
```

✅ **Correct** (calculated effect size):
```markdown
Cohen's d: 0.87 | 🟡 d = 0.87 (calculated: (M_cbt - M_wait) / SD_pooled = (8.2 - 11.8) / 4.14 = 0.87. Means from Table 2, p. 236: M_cbt=8.2, SD=3.9, n=74; M_wait=11.8, SD=4.3, n=76. SD_pooled = sqrt(((73*3.9²)+(75*4.3²))/148) = 4.14)
```

✅ **Correct** (inferred information):
```markdown
Attrition rate: 10.9% | 🟡 Calculated: (156 initial - 139 final) / 156 = 10.9% (Ns from p. 234 baseline and p. 237 follow-up)
```

❌ **Incorrect** (no calculation shown):
```markdown
Cohen's d: 0.87 | 🟡 Calculated from means and SDs
```

**Common Yellow Label Scenarios:**
- Cohen's d calculated from means and SDs
- Odds ratios calculated from contingency tables
- Percentages calculated from counts
- Subgroup combinations
- Conversion between effect size metrics

#### 🔴 Red: Uncertain/Missing Data

**When to use:**
- Data is not reported in the paper
- Data is ambiguous or contradictory
- Reporting is unclear and interpretation is uncertain
- You cannot determine the value with confidence

**Evidence format:**
- Clear explanation of what's missing or uncertain
- Note any relevant context (e.g., "measure mentioned but not described")
- If possible, explain impact on analysis

**Examples:**

✅ **Correct** (completely missing):
```markdown
Control group size: N/A | 🔴 Control group size not reported; unable to calculate between-group effect size
```

✅ **Correct** (insufficient information):
```markdown
Treatment satisfaction: Measured | 🔴 "10-item questionnaire" (p. 234) mentioned but no psychometric properties reported and items not described; cannot assess validity
```

✅ **Correct** (contradictory information):
```markdown
Follow-up duration: Unclear | 🔴 Abstract states "6-month follow-up" (p. 1) but Methods describes "3-month post-intervention assessment" (p. 233); unclear which is correct
```

✅ **Correct** (ambiguous reporting):
```markdown
Blinding: Unknown | 🔴 Paper states "double-blind procedure" (p. 232) but provides no details on who was blinded or how blinding was maintained; classification uncertain
```

❌ **Incorrect** (too vague):
```markdown
Standard deviation: Not reported | 🔴 Missing
```

**Common Red Label Scenarios:**
- Missing standard deviations or confidence intervals
- Unreported sample sizes for subgroups
- Vague or inconsistent methodological descriptions
- Selective outcome reporting (outcome measured but results not shown)
- Statistical significance stated without effect sizes

### Label Decision Tree

```
Is the data explicitly stated in the paper?
├─ YES → Is it stated exactly as you're extracting it?
│         ├─ YES → 🟢 GREEN (cite page & section)
│         └─ NO → Do you need to calculate or infer?
│                   └─ YES → 🟡 YELLOW (show calculation)
└─ NO → Is the data missing, unclear, or ambiguous?
          └─ YES → 🔴 RED (explain what's missing/uncertain)
```

### PRD Requirement: 90%+ Uncertain Data Flagging

MAestro's design goal is to **flag 90%+ of uncertain data** with 🔴 labels. This is critical for:
- **Academic transparency**: Readers know which data are certain vs. uncertain
- **Sensitivity analysis**: Exclude uncertain data to test robustness
- **Bias detection**: Patterns of missing data may indicate reporting bias

**Best Practice**: When in doubt, use 🔴 and explain. Over-flagging uncertainty is better than under-flagging.

### Label Application by Data Type

#### Quantitative Data (numbers)
- **Directly reported**: 🟢 with page
- **Calculated**: 🟡 with formula
- **Missing/partial**: 🔴 with explanation

#### Qualitative Data (text)
- **Direct quote**: 🟢 with page
- **Paraphrased/summarized**: 🟡 with reasoning
- **Vague/unclear**: 🔴 with explanation

#### Categorical Data (groups)
- **Explicitly categorized**: 🟢 with page
- **Inferred category**: 🟡 with reasoning
- **Ambiguous classification**: 🔴 with explanation

#### Binary Data (yes/no)
- **Clearly stated**: 🟢 with page
- **Implied/inferred**: 🟡 with reasoning
- **Unclear/not mentioned**: 🔴 with explanation

---

## Compiler Compatibility

Data cards are designed to be **human-readable during extraction** and **machine-parseable during compilation**. The Compiler tool (CROS phase) will aggregate data cards into analysis-ready datasets.

### Parsing Strategy

**YAML Frontmatter Parsing**:
- Library: PyYAML 6.0.1+ (`yaml.safe_load()` for security)
- Extracts metadata into structured Python dictionaries
- Validates schema using Pydantic models

**Markdown Table Parsing**:
- Library: python-markdown 3.6+ with table extension
- Converts markdown tables to structured data (list of dictionaries)
- Each row becomes one record; columns become fields

**Source Label Propagation**:
- Labels (🟢🟡🔴) are preserved during compilation
- Evidence text is retained in compiled dataset
- Enables downstream filtering by certainty level

### Compilation Process (CROS Phase)

1. **Discovery**: Scan `data_cards/` directory for all `.md` files
2. **Parsing**: Extract YAML and markdown tables from each data card
3. **Validation**: Check schema compliance using Pydantic models
4. **Aggregation**: Combine tables across data cards into unified datasets
5. **Export**: Output to CSV, JSON, or R/SPSS formats

**Example Compiled Output**:

| study_id | outcome | comparison | effect_size | confidence | source_label | evidence | page |
|----------|---------|-----------|-------------|------------|--------------|----------|------|
| johnson_2023 | GAD-7 | CBT vs Wait | 0.87 | 95% CI [0.54, 1.20] | 🟡 | Calculated: d=(8.2-11.8)/4.14 | 236 |
| smith_2022 | GAD-7 | CBT vs TAU | 0.62 | 95% CI [0.31, 0.93] | 🟢 | Reported in Table 3 | 145 |

### Design for Parseability

**Do**:
- Use standard markdown table syntax
- Keep column names consistent across data cards
- Use simple cell values (avoid complex formatting within cells)
- Follow YAML syntax rules in frontmatter

**Don't**:
- Use nested tables (tables within tables)
- Put critical data only in comments
- Use non-standard markdown extensions
- Rely on visual formatting (colors, fonts) for meaning

### Label-Based Filtering

During compilation, researchers can filter by source label:

```python
# Example: Create high-confidence dataset (🟢 only)
high_confidence = compiled_data[compiled_data['source_label'] == '🟢']

# Example: Sensitivity analysis excluding uncertain data (🔴)
sensitivity_data = compiled_data[compiled_data['source_label'] != '🔴']
```

This enables **transparency-aware analysis**: quantify how results change when including vs. excluding uncertain data.

---

## Validation Checklist

Use this checklist to validate data cards before considering them complete. In MVP phase, this is a **manual checklist**. In CROS phase, validation will be automated.

### YAML Validation

- [ ] All required fields are present (`study_id`, `title`, `authors`, `year`, `extraction_date`, `extractor`, `microscope_version`, `claude_model`, `screening_decision`, `quality_scores`)
- [ ] `study_id` is unique within the project (no duplicate IDs)
- [ ] `year` is a valid integer (YYYY format)
- [ ] `extraction_date` follows ISO 8601 format (`YYYY-MM-DDTHH:MM:SSZ`)
- [ ] `screening_decision` is either `"include"` or `"exclude"`
- [ ] `authors` is a list (YAML array syntax with square brackets)
- [ ] `quality_scores` is a dictionary/object (YAML mapping syntax)
- [ ] YAML syntax is valid (test with online YAML validator if unsure)

### Content Validation

- [ ] All extracted data points have source labels (🟢, 🟡, or 🔴)
- [ ] All 🟢 labels include page numbers and section references
- [ ] All 🟡 labels include calculation formulas or reasoning + source pages
- [ ] All 🔴 labels include explanations of what's missing or uncertain
- [ ] Effect sizes table includes all required columns (outcome, comparison, type, value, SE, CI)
- [ ] Participant demographics include at least: sample sizes, age, gender
- [ ] Study design describes intervention, control, and design type

### Quality Validation

- [ ] Quality assessment section is complete with justifications
- [ ] Quality scores in YAML match detailed assessment in body
- [ ] Screening decision has rationale (in Additional Notes if not obvious)
- [ ] Risk of bias is assessed for relevant domains

### Format Validation

- [ ] Markdown tables are well-formed (consistent column separators `|`)
- [ ] Tables have header row and separator row (`---`)
- [ ] Filename follows naming convention: `{study_id}.md`
- [ ] File saved in correct directory: `data_cards/`
- [ ] No markdown syntax errors (test rendering in markdown viewer)

### Completeness Validation

- [ ] No research data is missing labels
- [ ] Uncertain or missing data is flagged with 🔴 (don't just omit)
- [ ] Additional Notes section captures important context
- [ ] Self-check validation checklist at bottom of data card is completed

### Common Issues to Check

❌ **Missing evidence**: Label present but no page number/calculation
❌ **Wrong label type**: Using 🟢 for calculated values (should be 🟡)
❌ **Incomplete calculations**: 🟡 label without showing formula
❌ **Silent omissions**: Missing data not flagged with 🔴
❌ **YAML syntax errors**: Unquoted strings with colons, incorrect indentation
❌ **Inconsistent columns**: Table columns don't match across data cards

---

## Examples and Edge Cases

### Edge Case 1: Contradictory Information

**Scenario**: Paper reports conflicting values in different sections.

**Example**:
```markdown
Sample size: Unclear | 🔴 Abstract reports "N=150" (p.1) but Table 1 shows 156 participants (p.235) and CONSORT diagram shows 158 enrolled (p.234). Unable to determine correct value; senior researcher review needed.
```

**Recommendation**: Flag with 🔴, document the conflict, escalate to team.

### Edge Case 2: Partially Reported Data

**Scenario**: Paper reports mean but not standard deviation.

**Example**:
```markdown
Mean age: 42.3 years | 🟢 "Mean age = 42.3 years" (p.12, Table 1)
Age SD: Not reported | 🔴 Standard deviation not reported; cannot calculate standardized effect sizes for age-related subgroup analysis
```

**Recommendation**: Use 🟢 for what's reported, 🔴 for what's missing.

### Edge Case 3: Calculated from Multiple Sources

**Scenario**: Need to combine data from multiple tables to calculate effect size.

**Example**:
```markdown
Cohen's d: 0.73 | 🟡 d = 0.73 (calculated: Means from Table 2 (p.18): M_treatment=25.3, M_control=21.7; SDs from Table 3 (p.19): SD_treatment=6.2, SD_control=5.8; Sample sizes from CONSORT (p.15): n_treatment=45, n_control=48; SD_pooled=6.0; d=(25.3-21.7)/6.0=0.60. Wait, recalculating... SD_pooled = sqrt(((44*6.2²)+(47*5.8²))/91)=6.0; d=0.60)
```

**Recommendation**: Show all source locations, include formula, show intermediate steps if helpful.

### Edge Case 4: Inferring from Graph

**Scenario**: Data presented only in a figure, not in text or tables.

**Example**:
```markdown
Mean difference: ~3.5 points | 🟡 Estimated from Figure 2 (p.16): visual inspection of bar graph shows intervention group ~3.5 points higher than control (no exact values provided in figure or text). Uncertainty: ±0.5 points due to estimation.
```

**Recommendation**: Use 🟡 for estimates from figures, note uncertainty level.

### Edge Case 5: Measure Named but Not Described

**Scenario**: Paper mentions using a measure but provides no details.

**Example**:
```markdown
Depression: Measured | 🔴 "Depression was assessed at baseline" (p.8) but no instrument named, no results reported. Cannot extract data for meta-analysis.
```

**Recommendation**: Use 🔴 to flag incomplete reporting.

### Edge Case 6: Author-Provided Data

**Scenario**: You contacted authors and received unreported data.

**Example**:
```markdown
Control group SD: 4.8 | 🟡 SD=4.8 provided by first author via email (2025-10-15) in response to data request. Not reported in published paper. Email archived in project correspondence folder.
```

**Recommendation**: Use 🟡 (not directly in paper), document source thoroughly.

---

## FAQ

### Q1: What if a paper uses multiple comparison groups?

**A**: Add multiple rows to your Effect Sizes table, one for each pairwise comparison.

Example:
```markdown
| Outcome | Comparison | Effect Size Type | Value | ... |
|---------|-----------|-----------------|-------|-----|
| Anxiety | CBT vs. Control | Cohen's d | 0.85 | ... |
| Anxiety | Medication vs. Control | Cohen's d | 0.62 | ... |
| Anxiety | CBT vs. Medication | Cohen's d | 0.23 | ... |
```

### Q2: Should I create separate data cards for longitudinal follow-ups?

**A**: No. Include all time points in one data card. Add time point information to your tables:

```markdown
| Outcome | Time Point | Effect Size | ... |
|---------|-----------|-------------|-----|
| Anxiety | Post (8 weeks) | 0.87 | ... |
| Anxiety | Follow-up (3 months) | 0.72 | ... |
| Anxiety | Follow-up (6 months) | 0.65 | ... |
```

### Q3: What if the paper doesn't fit standard tables?

**A**: Customize! Add custom tables or columns as needed. Just ensure:
1. You include "Source Label & Evidence" columns
2. Tables follow standard markdown syntax
3. Custom tables are documented with comments

### Q4: How detailed should evidence be for 🟡 calculations?

**A**: Detailed enough for someone to reproduce your calculation. Include:
- Formula
- All input values
- Source page for each input
- Intermediate steps if calculation is complex

### Q5: Can I use color coding or highlighting in data cards?

**A**: No. Markdown is plain text. Use only the emoji labels (🟢🟡🔴) for semantic meaning. Visual formatting won't be preserved during parsing.

### Q6: What if I make an error in extraction?

**A**: Edit the data card file and commit the change to Git. The Git history will show:
- What changed
- When it changed
- Who changed it
- Why it changed (if you write a descriptive commit message)

This audit trail is a feature, not a bug.

### Q7: Do I need to extract every single value from a paper?

**A**: No. Extract data relevant to your meta-analysis research questions. However:
- Don't selectively extract only significant results (publication bias)
- Do extract quality-related information even if not directly analyzed
- Flag missing data with 🔴 rather than silently omitting it

### Q8: Can I use abbreviated source labels to save time?

**A**: No. Every label needs full evidence. This is non-negotiable for academic credibility. However:
- Use copy-paste for repeated page numbers
- Create text expansion shortcuts if typing the same evidence repeatedly
- The effort ensures transparency and enables your work to be trusted

### Q9: What happens to data cards after compilation?

**A**: Data cards remain the "source of truth." Compiled datasets (CSVs, etc.) are generated outputs that can be regenerated anytime from data cards. Think of compilation as "export," not "migration."

### Q10: How do I handle non-English papers?

**A**: Extract in the paper's language, or translate during extraction. If translating:
- Note translation in evidence: `🟢 "Sample size n=156" (p.12, translated from French: "taille de l'échantillon n=156")`
- Consider inter-rater reliability if translation is complex
- Store original language version of paper for verification

---

## Related Documentation

- **Template**: `templates/data_card.md` - Empty template for new extractions
- **Example**: `examples/sample_data_card.md` - Completed example with annotations
- **Architecture**: `docs/architecture/data-models.md` - DataCard and DataPoint model specifications
- **Quality Checklists**: `modules/generic/` and `modules/rob2/` - Quality assessment tools
- **Microscope Prompt**: `prompts/microscope/` - AI-assisted extraction instructions (Story 1.4)

---

## Version History

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | 2025-10-20 | Initial specification | Dev Agent (James) - Story 1.2 |

---

**Questions or Issues?**

- Consult project documentation at `docs/`
- Review example data card at `examples/sample_data_card.md`
- Raise issues with project team lead or via project repository

**Remember**: The data card format is the foundation of MAestro. Careful adherence to this specification ensures your meta-analysis data is transparent, reproducible, and academically credible.
