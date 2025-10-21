---
# =============================================================================
# DATA CARD TEMPLATE v1.0
# =============================================================================
# This template defines the standardized format for extracting research data
# in MAestro meta-analysis projects. Each data card is a self-contained,
# version-controllable markdown file representing one research paper.
#
# YAML FRONTMATTER: Contains metadata about the study and extraction process
# MARKDOWN BODY: Contains extracted data in structured tables with source labels
#
# Template Version: 1.0
# Template Created: 2025-10-20
# Compatible with: Microscope v1.0+, Compiler v1.0+
# =============================================================================

# -----------------------------------------------------------------------------
# STUDY IDENTIFICATION
# -----------------------------------------------------------------------------

# Unique identifier for this study (required)
# Format: lowercase, underscore-separated, e.g., "smith_2023_rct"
# Must be unique within your project
study_id: ""

# Full title of the research paper (required)
title: ""

# List of author names (required)
# Format: ["LastName FirstInitial", "LastName FirstInitial", ...]
authors: []

# Publication year (required)
# Format: Integer (YYYY)
year:

# Digital Object Identifier (optional)
# Format: Standard DOI string, e.g., "10.1000/xyz123"
doi: ""

# -----------------------------------------------------------------------------
# EXTRACTION METADATA
# -----------------------------------------------------------------------------

# Date when data extraction was performed (required)
# Format: ISO 8601 datetime (YYYY-MM-DDTHH:MM:SSZ)
extraction_date: ""

# Person or identifier who performed the extraction (required)
# Format: String (name, initials, or ID)
extractor: ""

# Version of Microscope prompt used for extraction (required)
# Format: "vX.Y" matching prompt version in prompts/microscope/
microscope_version: ""

# Claude model version used for extraction (required)
# Format: Model identifier, e.g., "claude-sonnet-4-5-20250929"
claude_model: ""

# -----------------------------------------------------------------------------
# SCREENING AND QUALITY ASSESSMENT
# -----------------------------------------------------------------------------

# Screening decision for meta-analysis inclusion (required)
# Values: "include" | "exclude"
screening_decision: ""

# Quality assessment scores (required)
# This object will be populated based on the quality checklist used
# Format: Dictionary with checklist-specific fields
# Example for generic checklist:
#   random_allocation: "yes"
#   blinding: "partial"
#   attrition_rate: "low"
# Example for ROB2:
#   domain_1_bias: "low"
#   domain_2_bias: "some_concerns"
quality_scores: {}

---

<!--
=============================================================================
MARKDOWN BODY: EXTRACTED DATA WITH SOURCE LABELS
=============================================================================

This section contains the actual research data extracted from the paper.
All data points MUST include source labels using the three-color system.

THREE-COLOR SOURCE LABELING SYSTEM:
This labeling system ensures transparency and traceability of all extracted data.

🟢 GREEN - Direct Quote/Observation
   - Data taken directly from the paper without interpretation
   - Always include: page number and section reference
   - Example: "Sample size n=42 (p. 7, Methods section)"
   - Use for: directly reported statistics, exact quotes, tables from paper

🟡 YELLOW - Computed/Inferred Value
   - Data calculated or inferred from information in the paper
   - Always include: calculation formula or reasoning process
   - Always include: page numbers of source data used in calculation
   - Example: "Mean age 35.2 years (calculated as weighted average from
              Table 2 groups: [30*20 + 40*22]/42, p. 8)"
   - Use for: computed effect sizes, derived statistics, aggregated values

🔴 RED - Uncertain/Missing Data
   - Data not clearly reported, ambiguous, or completely missing
   - Always include: explanation of what's uncertain or missing
   - Always include: impact on analysis if relevant
   - Example: "Control group size not reported; unable to calculate
              between-group effect size"
   - Use for: missing data, contradictory information, unclear reporting

CRITICAL RULES:
1. Every data point must have a label (🟢/🟡/🔴)
2. Every label must have evidence (page/section/calculation/explanation)
3. When in doubt, use 🔴 and explain the uncertainty
4. Labels ensure academic credibility and allow uncertainty quantification

=============================================================================
-->

# Participant Demographics

<!--
Table for population characteristics. Include source labels for all values.
Rows can be added/removed based on study design.
-->

| Variable | Value | Source Label & Evidence |
|----------|-------|------------------------|
| Total sample size (N) | | 🟢/🟡/🔴 |
| Intervention group (n) | | 🟢/🟡/🔴 |
| Control group (n) | | 🟢/🟡/🔴 |
| Mean age (years) | | 🟢/🟡/🔴 |
| Age range | | 🟢/🟡/🔴 |
| Gender (% female) | | 🟢/🟡/🔴 |
| Population description | | 🟢/🟡/🔴 |
| Inclusion criteria | | 🟢/🟡/🔴 |
| Exclusion criteria | | 🟢/🟡/🔴 |

<!-- Add additional demographic variables as needed for your meta-analysis -->

---

# Study Design

<!--
Table for study design characteristics. Essential for quality assessment
and subgroup analysis.
-->

| Design Element | Description | Source Label & Evidence |
|----------------|-------------|------------------------|
| Study design type | | 🟢/🟡/🔴 |
| Intervention description | | 🟢/🟡/🔴 |
| Control/comparison description | | 🟢/🟡/🔴 |
| Duration of intervention | | 🟢/🟡/🔴 |
| Follow-up period | | 🟢/🟡/🔴 |
| Randomization method | | 🟢/🟡/🔴 |
| Blinding | | 🟢/🟡/🔴 |
| Setting | | 🟢/🟡/🔴 |

---

# Outcomes and Measures

<!--
Table for outcome variables and measurement instruments.
Add rows for each outcome measured in the study.
-->

| Outcome Variable | Measurement Instrument | Reliability/Validity | Time Point | Source Label & Evidence |
|------------------|----------------------|---------------------|------------|------------------------|
| Primary outcome 1 | | | | 🟢/🟡/🔴 |
| Secondary outcome 1 | | | | 🟢/🟡/🔴 |
| Secondary outcome 2 | | | | 🟢/🟡/🔴 |

<!-- Add additional outcome rows as needed -->

---

# Effect Sizes

<!--
Table for effect size data. This is often the core data for meta-analysis.
Each row should represent one comparison for one outcome.

IMPORTANT: Effect sizes often require calculation (🟡) when papers only
report means, SDs, and sample sizes. Always show your calculation.
-->

| Outcome | Comparison | Effect Size Type | Value | SE | 95% CI Lower | 95% CI Upper | Source Label & Evidence |
|---------|-----------|-----------------|-------|----|--------------|--------------|-----------------------|
| | | Cohen's d / OR / r | | | | | 🟢/🟡/🔴 |

<!--
Effect size calculation examples:

🟡 Cohen's d calculation from means and SDs:
   d = (M1 - M2) / SD_pooled
   where SD_pooled = sqrt(((n1-1)*SD1^2 + (n2-1)*SD2^2) / (n1+n2-2))

   Example: "d = (5.2 - 4.1) / 1.85 = 0.59
            [calculated from Table 3, p. 12: M_int=5.2, SD_int=1.8, n_int=42;
             M_ctrl=4.1, SD_ctrl=1.9, n_ctrl=38]"

🟡 Standard error calculation:
   SE = sqrt((n1+n2)/(n1*n2) + d^2/(2*(n1+n2)))

🟢 Directly reported effect size:
   "r = 0.42, 95% CI [0.28, 0.56] (Table 4, p. 15)"

🔴 Missing data for effect size:
   "Means reported without SDs or CIs; cannot calculate effect size (Results, p. 10)"
-->

---

# Attrition and Missing Data

<!--
Document sample attrition and missing data patterns.
Critical for quality assessment and sensitivity analysis.
-->

| Measure | Value | Source Label & Evidence |
|---------|-------|------------------------|
| Initial sample size | | 🟢/🟡/🔴 |
| Final sample size | | 🟢/🟡/🔴 |
| Attrition rate (%) | | 🟢/🟡/🔴 |
| Reasons for attrition | | 🟢/🟡/🔴 |
| Missing data handling | | 🟢/🟡/🔴 |

---

# Additional Notes

<!--
Free-form section for:
- Important contextual information
- Methodological concerns or limitations
- Unusual features of the study
- Extraction notes or questions for review
- Cross-references to other data cards

This section should still use source labels where appropriate.
-->

**Methodological Notes:**

**Concerns or Limitations:**

**Links to Related Studies:**

---

# Quality Assessment Details

<!--
This section elaborates on the quality_scores in the YAML frontmatter.
Provide justification for each quality rating based on extracted information.

Format depends on the quality checklist module used (generic, ROB2, etc.).
-->

**Overall Quality Rating:**

**Domain-Specific Assessments:**

1. **[Domain 1 Name]:** [Rating]
   - Justification: [Reference specific information from paper with source label]

2. **[Domain 2 Name]:** [Rating]
   - Justification: [Reference specific information from paper with source label]

<!-- Add additional quality domains based on your checklist -->

---

# Extraction Validation Checklist

<!--
SELF-CHECK: Complete this checklist before finalizing the data card.
This ensures consistency and completeness.
-->

- [ ] All required YAML fields are populated
- [ ] study_id is unique and follows naming convention
- [ ] All extracted data points have source labels (🟢/🟡/🔴)
- [ ] All source labels include evidence (page numbers/calculations/explanations)
- [ ] Effect sizes are calculated correctly (if 🟡) with formulas shown
- [ ] Quality assessment is complete and justified
- [ ] Screening decision is documented with rationale
- [ ] Tables are well-formed with consistent columns
- [ ] No research data is missing labels
- [ ] Uncertain or missing data is flagged with 🔴 and explained

---

<!--
=============================================================================
END OF DATA CARD TEMPLATE
=============================================================================

USAGE INSTRUCTIONS:
1. Copy this template for each new paper extraction
2. Save as: data_cards/{study_id}.md
3. Complete YAML frontmatter first (metadata)
4. Extract data into appropriate tables
5. Apply source labels (🟢/🟡/🔴) to ALL data points
6. Provide evidence for every label
7. Complete quality assessment
8. Review validation checklist before finalizing

For detailed guidance, see: docs/data-card-format.md

Questions or issues? Consult project documentation or team lead.
=============================================================================
-->
