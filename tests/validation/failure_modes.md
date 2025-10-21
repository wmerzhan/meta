# Microscope v1.0 Failure Mode Catalog

<!-- Powered by BMAD™ Core -->

**Story:** 1.6 - Test Microscope with Sample Papers
**Purpose:** Document systematic failures and issues identified during testing
**Created:** 2025-10-21

## Failure Mode Categories

This catalog organizes failures by root cause to enable systematic improvements.

## Category 1: Prompt Misunderstanding

_Claude Code didn't follow the extraction workflow correctly_

### Failure Mode 1.1: [Name]

**Description:** [What went wrong]

**Frequency:** [N papers / Total papers]

**Severity:** [Critical / Moderate / Minor]

**Example:**
```
Paper: [paper_id]
Expected: [What should have happened]
Actual: [What Claude Code did]
```

**Root Cause:** [Analysis of why it occurred]

**Mitigation:**
- **Short-term (workaround):** [How users can handle it now]
- **Long-term (prompt fix):** [How to prevent in v1.1]

**Related ACs:** [Which acceptance criteria affected]

---

## Category 2: Format Violations

_Output doesn't match data card template structure_

### Failure Mode 2.1: [Name]

**Description:** [What went wrong]

**Frequency:** [N papers / Total papers]

**Severity:** [Critical / Moderate / Minor]

**Example:**
```yaml
# Expected YAML frontmatter format:
---
study_id: "smith_2023_rct"
screening_decision: "include"
---

# Actual malformed output:
---
study_id: smith_2023_rct  # Missing quotes
screening_decision: "include"
# Missing closing delimiter
```

**Root Cause:** [Analysis]

**Mitigation:**
- **Short-term:** [Workaround]
- **Long-term:** [Prompt fix]

**Related ACs:** [Which acceptance criteria affected]

---

## Category 3: Hallucinated Data

_Microscope extracted data not present in source paper_

### Failure Mode 3.1: [Name]

**Description:** [What went wrong]

**Frequency:** [N papers / Total papers]

**Severity:** [Critical / Moderate / Minor]

**Example:**
```
Paper: [paper_id]
Gold Standard: Sample size = 120 (from Methods section, p. 7)
Microscope Output: Sample size = 142 (NOT in paper)
```

**Root Cause:** [Analysis - why did Claude Code invent this data?]

**Mitigation:**
- **Short-term:** [Always validate against source paper]
- **Long-term:** [Strengthen evidence requirements in prompt]

**Related ACs:** AC #5 (Extraction accuracy)

---

## Category 4: Context Length Issues

_Paper too long for context window, causing truncation or incomplete extraction_

### Failure Mode 4.1: [Name]

**Description:** [What went wrong]

**Frequency:** [N papers / Total papers]

**Severity:** [Critical / Moderate / Minor]

**Example:**
```
Paper: [paper_id]
Length: 18,000 words (>15K stress test)
Issue: Results section extraction incomplete, stopped mid-table
```

**Root Cause:** [Exceeded 200K token context window OR processing limits]

**Mitigation:**
- **Short-term:** [Limit papers to <12K words]
- **Long-term:** [Chunking strategy or summarization for long papers]

**Related ACs:** AC #2 (Complete data card generation)

---

## Category 5: Quality Assessment Errors

_Incorrect domain ratings or missing justifications_

### Failure Mode 5.1: [Name]

**Description:** [What went wrong]

**Frequency:** [N papers / Total papers]

**Severity:** [Critical / Moderate / Minor]

**Example:**
```
Paper: [paper_id]
Gold Standard: Selection Bias = High Risk (convenience sample, no randomization)
Microscope Output: Selection Bias = Low Risk (misread study design)
```

**Root Cause:** [Analysis - misunderstanding of quality criteria?]

**Mitigation:**
- **Short-term:** [Manual review of quality ratings]
- **Long-term:** [Add examples to quality checklist]

**Related ACs:** AC #2 (Quality assessment completion)

---

## Category 6: Source Label Errors

_Wrong 🟢🟡🔴 classifications or missing evidence_

### Failure Mode 6.1: [Name]

**Description:** [What went wrong]

**Frequency:** [N papers / Total papers]

**Severity:** [Critical / Moderate / Minor]

**Example:**
```
Variable: Cohen's d (effect size)
Gold Standard: 🟡 (Computed from means/SDs, calculation: d = (M1-M2)/SD_pooled)
Microscope Output: 🟢 (Incorrect - marked as direct quote)
```

**Root Cause:** [Confusion about label definitions?]

**Mitigation:**
- **Short-term:** [Clarify in documentation]
- **Long-term:** [Strengthen label selection guidance in prompt]

**Related ACs:** AC #4 (Three-color labeling), AC #5 (Accuracy)

---

### Failure Mode 6.2: Missing Evidence

**Description:** Labels applied without required page references or calculations

**Frequency:** [N cases / Total labels]

**Severity:** Moderate

**Example:**
```
Variable: Sample size = 120
Source Label: 🟢 (direct quote)
Evidence: [MISSING - no page reference provided]

Expected: 🟢 (p. 7, Methods, "120 participants enrolled")
```

**Root Cause:** Prompt doesn't enforce evidence requirement strongly enough

**Mitigation:**
- **Short-term:** Manual review of evidence fields
- **Long-term:** Add explicit evidence validation to prompt

**Related ACs:** AC #4 (Three-color labeling with evidence)

---

## Category 7: Calculation Errors

_Incorrect effect size computations or statistical derivations_

### Failure Mode 7.1: [Name]

**Description:** [What went wrong]

**Frequency:** [N papers / Total papers]

**Severity:** [Critical / Moderate / Minor]

**Example:**
```
Paper: [paper_id]
Reported: M1 = 85.2, M2 = 78.4, SD_pooled = 12.3
Gold Standard: Cohen's d = (85.2 - 78.4) / 12.3 = 0.55
Microscope Output: Cohen's d = 0.68 (calculation error)
```

**Root Cause:** [Mathematical error in computation]

**Mitigation:**
- **Short-term:** [Validate calculations manually]
- **Long-term:** [Provide calculation formulas in prompt]

**Related ACs:** AC #5 (Extraction accuracy)

---

## Summary Statistics

_To be completed after testing:_

### Total Failures by Category

| Category | Total Failures | Critical | Moderate | Minor |
|----------|---------------|----------|----------|-------|
| 1. Prompt Misunderstanding | [N] | [N] | [N] | [N] |
| 2. Format Violations | [N] | [N] | [N] | [N] |
| 3. Hallucinated Data | [N] | [N] | [N] | [N] |
| 4. Context Length Issues | [N] | [N] | [N] | [N] |
| 5. Quality Assessment Errors | [N] | [N] | [N] | [N] |
| 6. Source Label Errors | [N] | [N] | [N] | [N] |
| 7. Calculation Errors | [N] | [N] | [N] | [N] |
| **TOTAL** | [N] | [N] | [N] | [N] |

### Failure Rate by Paper

| Paper ID | Total Failures | Critical | Usable? |
|----------|---------------|----------|---------|
| [paper_1] | [N] | [N] | [Y/N] |
| [paper_2] | [N] | [N] | [Y/N] |
| ... | | | |

**Overall usability:** [N]/[Total] papers ([X%]) generated usable data cards

### Blocking vs. Non-Blocking

**Blocking failures** (prevent Microscope usage):
- [List of critical failure modes that block beta launch]
- _Or: **None** - All failures have workarounds_

**Non-blocking failures** (document as limitations):
- [List of failures that users can work around]

## Recommendations for Prompt Refinements

Based on failure mode analysis:

### High Priority (Create v1.1)

1. **[Issue requiring prompt change]**
   - Affected: [N] papers
   - Fix: [Specific prompt modification]

2. **[Issue requiring prompt change]**
   - Affected: [N] papers
   - Fix: [Specific prompt modification]

### Medium Priority (Document in usage guide)

1. **[Known limitation]**
   - Workaround: [How users handle it]
   - Future: [Potential CROS-phase automation]

### Low Priority (Future enhancement)

1. **[Minor issue]**
   - Impact: Minimal
   - Enhancement: [Possible improvement]

## Testing Validation

This failure mode catalog validates:

- [x] Systematic error tracking (AC #6)
- [x] Categorization by root cause
- [x] Severity assessment
- [x] Mitigation strategies documented
- [x] Informs prompt refinement decisions (AC #7)

---

**Note:** This catalog should be updated with actual failures discovered during Story 1.6 testing. Current content is a template structure.
