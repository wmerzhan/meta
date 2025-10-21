# Three-Color Labeling Coverage Analysis

<!-- Powered by BMAD™ Core -->

**Story:** 1.6 - Test Microscope with Sample Papers
**Purpose:** Measure 🟢🟡🔴 labeling coverage and patterns (AC #4)
**Goal:** Establish baseline labeling statistics for Microscope v1.0

## Three-Color Labeling System

- 🟢 **Green (Direct Quote):** Value directly observed in paper with page reference
- 🟡 **Yellow (Computed):** Value calculated/inferred with documented calculation
- 🔴 **Red (Uncertain):** Missing or uncertain data with explanation

**Target:** 90%+ of uncertain data should be flagged with 🔴 labels

## Per-Paper Coverage

| Paper ID | Total Data Points | 🟢 Count | 🟢 % | 🟡 Count | 🟡 % | 🔴 Count | 🔴 % | Notes |
|----------|------------------|---------|------|---------|------|---------|------|-------|
| _Example: smith_2023_ | _45_ | _18_ | _40%_ | _15_ | _33%_ | _12_ | _27%_ | _High quality paper_ |
|  |  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |  |

## Aggregate Statistics

_Across all papers:_

- **Total data points extracted:** [N]
- **Mean 🟢 percentage:** [X%] (SD: [Y%])
- **Mean 🟡 percentage:** [X%] (SD: [Y%])
- **Mean 🔴 percentage:** [X%] (SD: [Y%])

### Distribution Summary

```
Expected distribution (hypothetical):
🟢 Green:  ████████████░░░░░░░░ 40-50%  (direct observations)
🟡 Yellow: ██████████░░░░░░░░░░ 25-35%  (computed values)
🔴 Red:    ████████░░░░░░░░░░░░ 20-30%  (uncertainties)
```

## Coverage by Paper Characteristics

### By Reporting Quality

| Quality Level | Mean 🟢% | Mean 🟡% | Mean 🔴% | Count |
|--------------|---------|---------|---------|-------|
| High |  |  |  | [N] |
| Medium |  |  |  | [N] |
| Low |  |  |  | [N] |

**Expected pattern:** Low-quality papers should have higher 🔴% (more missing data)

### By Study Design

| Design | Mean 🟢% | Mean 🟡% | Mean 🔴% | Count |
|--------|---------|---------|---------|-------|
| Simple RCT |  |  |  | [N] |
| Complex RCT |  |  |  | [N] |
| Quasi-experimental |  |  |  | [N] |
| Other |  |  |  | [N] |

### By Discipline

| Discipline | Mean 🟢% | Mean 🟡% | Mean 🔴% | Count |
|-----------|---------|---------|---------|-------|
| Medicine |  |  |  | [N] |
| Psychology |  |  |  | [N] |
| Education |  |  |  | [N] |
| Other |  |  |  | [N] |

## Label Evidence Quality

For each label type, assess if evidence is provided:

### 🟢 Green Label Evidence

- **Total 🟢 labels:** [N]
- **With page reference:** [N] ([X%])
- **With section reference:** [N] ([X%])
- **Missing evidence:** [N] ([X%])

**Quality assessment:** [Pass/Fail - should be >95% with evidence]

### 🟡 Yellow Label Evidence

- **Total 🟡 labels:** [N]
- **With calculation shown:** [N] ([X%])
- **With source pages:** [N] ([X%])
- **Missing evidence:** [N] ([X%])

**Quality assessment:** [Pass/Fail - should be >95% with evidence]

### 🔴 Red Label Evidence

- **Total 🔴 labels:** [N]
- **With explanation:** [N] ([X%])
- **With impact note:** [N] ([X%])
- **Missing evidence:** [N] ([X%])

**Quality assessment:** [Pass/Fail - should be >90% with evidence]

## Uncertainty Flagging Effectiveness

**Goal:** 90%+ of uncertain/missing data should be flagged with 🔴

**Validation method:** Compare against gold standard extractions

_For papers with gold standards:_

| Paper ID | True Uncertain Data (Gold Std) | 🔴 Labels Applied | Flagging Rate |
|----------|-------------------------------|------------------|---------------|
| [paper_1] | [N items] | [N labels] | [X%] |
| [paper_2] | [N items] | [N labels] | [X%] |
| [paper_3] | [N items] | [N labels] | [X%] |

**Overall flagging effectiveness:** [X%] (target: >90%)

## Label Misclassification Analysis

_Based on gold standard comparison:_

**Common misclassifications:**
- 🟢 used when should be 🟡: [N cases] - _Example: Calculated values marked as direct quotes_
- 🟡 used when should be 🟢: [N cases] - _Example: Directly reported values marked as computed_
- 🔴 used when should be 🟢/🟡: [N cases] - _Example: Available data marked as uncertain_
- Missing 🔴 when should be flagged: [N cases] - _Example: Missing data not flagged_

**Misclassification rate:** [X%] (lower is better)

## Observations

_Document patterns and insights:_

- Are labels consistently applied across papers?
- Do certain data types have predictable label patterns?
- Are computed effect sizes always labeled 🟡?
- Are baseline characteristics with missing SDs labeled 🔴?
- Is evidence quality consistent?

## Recommendations

_Based on coverage analysis:_

- Should prompt provide more explicit label selection guidance?
- Are there data types that frequently get mislabeled?
- Should evidence requirements be strengthened?
- What labeling patterns should be documented for users?

## Baseline for Future Comparison

These statistics establish **Microscope v1.0 baseline** for:
- Expected labeling distribution
- Evidence quality standards
- Uncertainty flagging effectiveness

Future prompt versions (v1.1+) should maintain or improve these metrics.
