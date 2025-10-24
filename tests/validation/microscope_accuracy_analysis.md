# Microscope Accuracy Analysis - Simulated vs Gold Standards

<!-- Powered by BMAD™ Core -->

**Analysis Type:** Predictive/Simulated (based on cross-discipline gold standard patterns)
**Date:** 2025-10-21
**Gold Standards Analyzed:** 4 (Medicine n=2, Psychology n=1, Education n=1)
**Purpose:** Predict systematic error types for Microscope v1.0 automated extraction

---

## Executive Summary

This analysis **simulates** the accuracy assessment that would be performed by comparing automated Microscope extractions to the 4 gold standard manual extractions. Since Microscope automation is not yet implemented, we predict likely error patterns based on:

1. **Cross-discipline reporting gaps** identified in gold standards (🔴 red labels)
2. **Known LLM limitations** (hallucination, calculation errors, context management)
3. **Complexity factors** (statistical reporting density, table structures, intervention details)

**Predicted Overall Accuracy:** 85-92% data point agreement with gold standards

**Predicted Error Distribution:**
- **Critical errors** (wrong values): 3-5%
- **Moderate errors** (missing data, wrong labels): 5-8%
- **Minor errors** (formatting, evidence incompleteness): 5-7%

**Discipline-Specific Predictions:**
- **Medicine:** Highest accuracy (90-95%) - well-structured reporting
- **Psychology:** Moderate accuracy (85-90%) - missing data challenges
- **Education:** Lower accuracy (80-85%) - intervention detail extraction challenges

---

## Error Taxonomy (8 Categories)

Based on Story 1.6 testing framework and cross-discipline gold standard analysis:

### 1. Incorrect Values (CRITICAL)

**Definition:** Extracted numeric values that do not match paper

**Predicted Frequency:** 2-4% of numeric data points

**Likely Causes:**
- Misreading tables (wrong row/column)
- Confusing similar values (e.g., pretest vs posttest)
- Calculation errors (manual computation mistakes)
- Unit conversion errors (e.g., months vs years)

**Examples from Gold Standards:**
- **Medicine:** Confusing CTC+ vs CTC- subgroup values (Reeh 2015 has stratified tables)
- **Psychology:** Misreading CA-CBT vs CBT group values (Hwang 2015 has small group differences)
- **Education:** Confusing experimental vs control means (Banda 2022 has dual outcomes)

**Severity:** **CRITICAL** - Direct impact on meta-analysis results

**Mitigation:**
- Double-check table coordinates (row + column labels)
- Cross-reference Abstract vs Results section for key values
- Flag when pretest and posttest values are similar (potential confusion)

### 2. Missing Data Points (MODERATE)

**Definition:** Data present in paper but not extracted by Microscope

**Predicted Frequency:** 3-6% of extractable data points

**Likely Causes:**
- Data buried in dense text (not in tables)
- Implicit data requiring inference (e.g., "all patients received..." → 100%)
- Data in figures only (not extractable from text)
- Supplementary materials not accessed

**Examples from Gold Standards:**
- **Medicine:** Nakashima 2003 has timepoint-specific data in paragraphs, not tables
- **Psychology:** Hwang 2015 session 4 and 8 HDRS data mentioned but values not shown
- **Education:** Banda 2022 has 4/7 motivation constructs with significance stated but F-statistics missing

**Predicted Pattern:**
- Medicine: 2-3% missing (most data in tables)
- Psychology: 5-7% missing (attrition details, intermediate timepoints often in text)
- Education: 7-10% missing (intervention specifics in Methods prose)

**Severity:** **MODERATE** - Reduces data completeness but doesn't introduce errors

**Mitigation:**
- Systematic Methods section parsing for intervention details
- Parse Results paragraphs for values not in tables
- Explicitly check for "data not reported" patterns

### 3. Hallucinated Data (CRITICAL)

**Definition:** Extracted values that do NOT appear in the paper

**Predicted Frequency:** 1-2% of data points (LOW with conservative prompting)

**Likely Causes:**
- LLM confabulation filling in missing data
- Confusion between similar papers (if multiple papers in context)
- Over-inference from partial information
- Calculation from insufficient data

**Examples (Predicted Scenarios):**
- **Medicine:** Inferring CTC-negative count when only CTC-positive and total given (should calculate, not hallucinate)
- **Psychology:** Guessing missing SDs from other timepoints
- **Education:** Fabricating session frequency when "not reported" in Methods

**Predicted Pattern:**
- Medicine: 0.5-1% (clear reporting reduces hallucination risk)
- Psychology: 1-2% (missing data temptation)
- Education: 2-3% (intervention detail gaps may tempt inference)

**Severity:** **CRITICAL** - Introduces false data into meta-analysis

**Mitigation:**
- Strong conservative labeling prompt: "If uncertain, use 🔴 and explain, NEVER guess"
- Require explicit page references for all 🟢 labels
- Flag any inferred values as 🟡 with calculation shown

### 4. Source Label Errors (MODERATE)

**Definition:** Incorrect 🟢🟡🔴 classification

**Predicted Frequency:** 8-12% of labels

**Likely Causes:**
- **🟢 when should be 🟡:** Value calculated but presented as direct quote
- **🟡 when should be 🟢:** Direct quote misclassified as computed
- **🟢/🟡 when should be 🔴:** Ambiguous data labeled as certain
- **🔴 when should be 🟢:** Conservative over-flagging

**Examples from Gold Standards:**
- **🟢→🟡 errors:** Percentages stated in text but actually calculated from frequencies (should show calculation)
- **🟡→🟢 errors:** Values that appear calculated but are actually directly reported in supplementary tables
- **🟢/🟡→🔴 errors:** "Approximately 50" treated as exact value (should flag imprecision)

**Predicted Pattern:**
- Medicine: 5-8% label errors (clear tables reduce ambiguity)
- Psychology: 10-12% label errors (ambiguous statistical reporting)
- Education: 12-15% label errors (intervention details often vague)

**Severity:** **MODERATE** - Affects transparency but not data values

**Mitigation:**
- Decision tree for labeling:
  - Exact quote in paper → 🟢
  - Calculation shown → 🟡
  - ANY doubt → 🔴
- Examples in prompt for edge cases

### 5. Missing Evidence (MODERATE)

**Definition:** Correct label (🟢🟡🔴) but missing required evidence

**Predicted Frequency:** 5-10% of labels

**Likely Causes:**
- 🟢 without page reference
- 🟡 without calculation shown
- 🔴 without explanation of what's missing

**Examples:**
- "N=50 🟢" without "(Table 1, p. 5)"
- "Gain score: 10.5 🟡" without showing "63.5 - 53.0 = 10.5 (from Results, p. 8)"
- "SD not reported 🔴" without explaining impact on analysis

**Predicted Pattern:**
- All disciplines: 5-10% (consistent across disciplines; evidence completeness is formatting issue, not content issue)

**Severity:** **MODERATE** - Reduces auditability but data is correct

**Mitigation:**
- Post-processing check: every label has evidence
- Automated validation: regex check for page references, calculation symbols, explanations

### 6. Quality Assessment Errors (MODERATE)

**Definition:** Incorrect domain ratings (LOW/MEDIUM/HIGH risk) or missing justifications

**Predicted Frequency:** 15-25% disagreement with gold standard ratings

**Likely Causes:**
- **Selection Bias domain:** Misunderstanding randomization adequacy
- **Attrition domain:** Not recognizing completers-only analysis as HIGH risk
- **Confounding domain:** Overlooking missing baseline adjustment
- **Rating threshold differences:** Borderline cases (e.g., MEDIUM vs HIGH)

**Examples from Gold Standards:**
- **Hwang 2015:** Missing ITT analysis should be HIGH attrition risk (Microscope might miss this)
- **Banda 2022:** Non-random assignment should be MEDIUM-HIGH selection bias (might under-rate)
- **Reeh 2015:** Comprehensive reporting might be over-rated if multivariate analysis not recognized

**Predicted Pattern:**
- Medicine: 10-15% disagreement (quality criteria clearer for biomedical studies)
- Psychology: 20-25% disagreement (attrition and ITT analysis often missed)
- Education: 25-30% disagreement (fidelity assessment understanding variable)

**Severity:** **MODERATE** - Affects study weight in meta-analysis but is subjective

**Mitigation:**
- Provide domain-specific checklists in prompt
- Examples of HIGH risk criteria for each domain
- Conservative rating: "When in doubt, rate higher risk"

### 7. Format Violations (MINOR)

**Definition:** YAML syntax errors, malformed tables, markdown issues

**Predicted Frequency:** 10-15% of data cards have at least one format issue

**Likely Causes:**
- YAML frontmatter indentation errors
- Markdown table alignment issues
- Missing section headers
- Incorrect emoji encoding

**Examples:**
- YAML `study_id:nakashima_2003` (missing space after colon)
- Markdown table with misaligned columns
- Using `:green_circle:` instead of 🟢 emoji

**Severity:** **MINOR** - Affects parseability but not content

**Mitigation:**
- Post-processing YAML validation
- Markdown linter
- Standard template with clear format examples

### 8. Calculation Errors (MODERATE-CRITICAL)

**Definition:** Incorrect computed values (effect sizes, percentages, pooled SDs)

**Predicted Frequency:** 3-5% of computed values

**Likely Causes:**
- **Effect size calculation errors:** Wrong formula (Cohen's d vs Hedges' g)
- **Pooled SD errors:** Complex formulas with multiple groups
- **Percentage errors:** Rounding vs exact calculation
- **CI calculation errors:** Wrong confidence level (90% vs 95%)

**Examples from Gold Standards:**
- **Medicine:** Pooled SD calculation for CTC+ and CTC- subgroups (complex formula)
- **Psychology:** Effect size from incomplete data (mean diff without SDs)
- **Education:** Cohen's d calculation from t-statistic and sample sizes

**Predicted Pattern:**
- Medicine: 2-3% (fewer complex calculations)
- Psychology: 4-5% (effect size calculations common)
- Education: 5-7% (multiple effect sizes, complex ANCOVA results)

**Severity:** **MODERATE-CRITICAL** depending on calculation type
- Effect sizes: CRITICAL (core meta-analysis metric)
- Percentages: MODERATE (verification possible)
- Confidence intervals: MODERATE (alternative formulas exist)

**Mitigation:**
- Show all calculation steps (not just final value)
- Use standard formulas (provide in prompt)
- Cross-check with multiple calculation methods when possible

---

## Predicted Accuracy by Discipline

### Medicine/Surgery (Nakashima 2003, Reeh 2015)

**Predicted Overall Accuracy:** 90-95%

**Strengths:**
- Clear table structures (stratified, well-labeled)
- Comprehensive statistical reporting (means, SDs, HRs, CIs mostly present)
- CONSORT-compliant (cohort equivalent)
- Objective biomarkers (CTC counts, survival times)

**Predicted Error Types:**
- **Low risk:** Hallucination (0.5-1%), Missing data (2-3%), Incorrect values (1-2%)
- **Moderate risk:** Quality assessment (10-15%), Source labels (5-8%)

**Challenging Areas:**
- Multivariate Cox regression table interpretation (Reeh 2015)
- Timepoint-specific data buried in text (Nakashima 2003)
- Subgroup stratification (all tables stratified by CTC status in Reeh 2015)

**Recommendation:** Medicine papers likely to have highest Microscope accuracy

### Psychology/Clinical (Hwang 2015)

**Predicted Overall Accuracy:** 85-90%

**Strengths:**
- RCT structure familiar to LLMs (common study design)
- Primary outcome clearly defined (HDRS)
- Baseline characteristics table standard format

**Weaknesses:**
- Missing statistical details (endpoint SDs, session 4/8 data, p-values)
- Attrition complexity (differential dropout: 7% vs 26%)
- ITT analysis absence (completers-only)

**Predicted Error Types:**
- **Moderate risk:** Missing data (5-7%), Source labels (10-12%), Quality assessment (20-25%)
- **Low risk:** Incorrect values (2-3%), Hallucination (1-2%)

**Challenging Areas:**
- Identifying completers-only analysis as HIGH attrition bias
- Recognizing missing data patterns (session 4/8 HDRS mentioned but not shown)
- Conservative labeling for incomplete statistics (should be 🔴 not 🟡)

**Recommendation:** Psychology papers require stronger attrition domain guidance in prompt

### Education/STEM (Banda 2022)

**Predicted Overall Accuracy:** 80-85%

**Strengths:**
- Clear achievement test results (pretest/posttest means, SDs, t-tests, Cohen's d)
- Large sample (n=280) reduces ambiguity in group comparisons
- Quasi-experimental design explicitly stated

**Weaknesses:**
- **Intervention details sparse** (which PhET sims? session frequency? duration?)
- **Selective motivation reporting** (4/7 constructs missing F and η²)
- **Fidelity not assessed**
- **Demographics group breakdowns missing**

**Predicted Error Types:**
- **High risk:** Missing data (7-10%), Source labels (12-15%), Quality assessment (25-30%)
- **Moderate risk:** Incorrect values (3-4%), Calculation errors (5-7%)

**Challenging Areas:**
- Extracting intervention specifics from vague Methods descriptions
- Identifying selective outcome reporting (motivation constructs)
- Calculating total analyzed from ANCOVA degrees of freedom (df=271 → n=273)
- Conservative labeling for missing fidelity data

**Recommendation:** Education papers require extensive 🔴 labeling for intervention/fidelity gaps; prompt should emphasize intervention detail extraction

---

## Predicted Error Rates by Data Type

| Data Type | Example | Predicted Error Rate | Primary Error Types |
|-----------|---------|---------------------|-------------------|
| **Sample sizes** | N, n per group | 1-3% | Incorrect values (wrong group), Missing (subgroup n) |
| **Means ± SDs** | Baseline characteristics | 3-5% | Incorrect values (wrong group), Missing SDs |
| **Percentages** | Gender, dropout rates | 4-6% | Source labels (🟢 vs 🟡), Calculation errors |
| **Effect sizes** | Cohen's d, Hedges' g | 5-8% | Calculation errors, Missing (not reported) |
| **p-values** | Statistical significance | 3-5% | Missing (selective reporting), Source labels |
| **Confidence intervals** | 95% CIs for HRs, ORs | 4-6% | Calculation errors, Missing |
| **Quality ratings** | Risk of bias domains | 15-25% | Quality assessment disagreement |
| **Intervention details** | Session frequency, content | 10-20% | Missing data, Hallucination (inferring from context) |

---

## Severity-Weighted Error Analysis

**Critical Errors (Block Usage):**
- Incorrect values: 2-4%
- Hallucinated data: 1-2%
- Major calculation errors (effect sizes): 1-2%
- **Total Critical:** 4-8%

**Moderate Errors (Reduce Quality):**
- Missing data points: 3-6%
- Source label errors: 8-12%
- Quality assessment disagreement: 15-25%
- Minor calculation errors: 2-3%
- Missing evidence: 5-10%
- **Total Moderate:** 33-56% (overlap: one data card may have multiple moderate errors)

**Minor Errors (Cosmetic):**
- Format violations: 10-15%
- **Total Minor:** 10-15%

**Overall Usability:**
- **85-92% of data cards likely usable with minor corrections**
- **8-15% may require significant review or re-extraction**

---

## Recommended Microscope v1.0 Prompt Refinements

Based on predicted error patterns:

### 1. Strengthen Conservative Labeling Directive

**Current guidance:** "When uncertain, use 🔴"

**Recommended enhancement:**
```
CRITICAL RULE - CONSERVATIVE LABELING:
- If value is "approximately X" or "about X" → 🔴 (imprecise)
- If calculation requires data not explicitly given → 🔴 (insufficient)
- If sample size differs across tables → 🔴 (investigate discrepancy)
- If multiple plausible interpretations exist → 🔴 (ambiguous)
- NEVER guess or infer values. When in doubt, 🔴 with explanation.
```

### 2. Add Discipline-Specific Sub-Prompts

**Medicine/Surgery Guidance:**
- Check all tables for subgroup stratification (e.g., by treatment, disease status)
- When extracting survival data, require median + 95% CI, not just p-value
- For multivariate analyses, extract adjusted values (not crude)

**Psychology/Clinical Guidance:**
- ALWAYS check for Intent-To-Treat (ITT) vs completers-only analysis
- If attrition >10%, label as MEDIUM risk; if differential attrition >10% difference, label as HIGH risk
- Missing SDs at endpoint → 🔴, explain cannot calculate effect size

**Education/STEM Guidance:**
- Intervention specificity checklist: materials, frequency, duration, fidelity, provider training
- If ANY intervention detail missing → 🔴 in intervention description
- Check for selective outcome reporting (all outcomes measured should be reported)

### 3. Require Calculation Transparency

**For all 🟡 yellow labels:**
```
YELLOW LABEL REQUIREMENTS:
1. Show complete calculation: "Value = A op B = C"
2. Cite source for each input: "(A from Table 1, p. 5; B from Methods, p. 3)"
3. State formula used: "Cohen's d = (M1 - M2) / SD_pooled"
4. Show intermediate steps for complex calculations

Example:
Gain score: 16.63 🟡
Calculated: 63.85 - 47.22 = 16.63
(Posttest M from Table 2, p. 8; Pretest M from Table 2, p. 8)
```

### 4. Add Quality Assessment Examples

**Provide specific HIGH risk examples for each domain:**

**Selection Bias - HIGH risk:**
- Non-random assignment without propensity matching (Banda 2022 example)
- Self-selected participants with no comparisons to refusers

**Attrition - HIGH risk:**
- Completers-only analysis when attrition >15% (Hwang 2015 example: 18% overall)
- Differential attrition >10% between groups (Hwang 2015: 7% vs 26%)

**Measurement - HIGH risk:**
- Non-blinded subjective outcomes
- Self-report for primary outcome with no validation

**Confounding - HIGH risk:**
- No adjustment for baseline differences (Hwang 2015: 3-point HDRS difference at baseline)
- Known confounders not measured or controlled

**Reporting - HIGH risk:**
- Pre-registered outcomes not reported
- Selective statistical detail (some outcomes have CIs, others don't)

### 5. Add Post-Extraction Validation Checklist

**Before finalizing data card:**
```
VALIDATION CHECKLIST:
□ Every 🟢 has page or table reference
□ Every 🟡 shows calculation steps
□ Every 🔴 explains what's missing and why
□ All sample sizes add up (n per group = total n)
□ Baseline and outcome timepoints match
□ Quality ratings have justifications with evidence
□ No values appear twice with different numbers (consistency check)
□ Intervention details complete (materials, frequency, duration, provider, fidelity)
```

---

## Simulated Comparison: Gold Standard vs Predicted Microscope Output

### Example 1: Hwang 2015 - Attrition Data

**Gold Standard (Manual):**
```yaml
| Group | Randomized | Completed | Dropped Out | Dropout Rate | Source Label |
|-------|------------|-----------|-------------|--------------|--------------|
| CA-CBT | 29 (inferred) | 27 | 2 | 7% | 🟢 Completed/dropout from Results; 🟡 Randomized calculated: 27 + 2 = 29 |
| CBT | 29 (inferred) | 23 | 6 | 26% | 🟢 Completed/dropout from Results; 🟡 Randomized calculated: 23 + 6 = 29 |

Quality Assessment - Attrition Domain: HIGH RISK
Justification: Completers-only analysis (n=50 analyzed, 11 dropped excluded); differential dropout approached significance (7% vs 26%); no ITT analysis mentioned.
```

**Predicted Microscope Output (Automated):**
```yaml
| Group | Randomized | Completed | Dropped Out | Dropout Rate | Source Label |
|-------|------------|-----------|-------------|--------------|--------------|
| CA-CBT | 🔴 Not reported | 27 | 2 | 7% | 🟢 Results: "27 CA-CBT, 23 CBT completed" |
| CBT | 🔴 Not reported | 23 | 6 | 26% | 🟢 Results |

Quality Assessment - Attrition Domain: MEDIUM RISK ⚠️ (should be HIGH)
Justification: Overall attrition 18% (11/61); dropout rates differ between groups but significance not stated.
```

**Errors Predicted:**
1. **Missing calculated data:** Randomized per group (should calculate 27+2=29)
2. **Source label error:** Should show calculation for randomized → 🟡 not 🔴
3. **Quality assessment error:** MEDIUM risk should be HIGH (missed differential attrition significance and completers-only analysis)

**Correction Needed:** Prompt should emphasize calculating derived values and recognizing completers-only as HIGH attrition risk

---

### Example 2: Banda 2022 - Intervention Details

**Gold Standard (Manual):**
```yaml
**Specific Simulations Used:** Not specified 🔴 (Which PhET sims? pendulum lab? wave interference? masses & springs? Paper says "oscillations and waves" topic but doesn't list specific simulations used)

**Frequency:** Not specified 🔴 (How many times per week? Session length not reported; typical quasi-experimental implementation gaps)

**Implementation Fidelity:** Not assessed 🔴 (No fidelity measures, observation, checklists, or adherence monitoring reported)

Quality Assessment - Confounding Domain: MEDIUM RISK
Justification: No fidelity monitoring; implementation quality unknown; potential for differential implementation between experimental and control groups.
```

**Predicted Microscope Output (Automated):**
```yaml
**Specific Simulations Used:** PhET simulations for oscillations and waves 🟢 (Methods section) ⚠️ (should be 🔴)

**Frequency:** Weekly sessions 🟡 (Inferred from typical 6-week intervention with weekly meetings) ⚠️ (HALLUCINATION - not stated)

**Implementation Fidelity:** Not reported 🟢 ⚠️ (should be 🔴 with explanation)

Quality Assessment - Confounding Domain: LOW RISK ⚠️ (should be MEDIUM)
Justification: ANCOVA controlled for pretest scores.
```

**Errors Predicted:**
1. **Source label error:** Vague intervention description labeled 🟢 (should be 🔴 for lack of specificity)
2. **Hallucinated data (CRITICAL):** "Weekly sessions" inferred, not stated
3. **Missing evidence:** "Not reported" needs explanation of why it matters
4. **Quality assessment error:** LOW risk (missed fidelity issue entirely)

**Correction Needed:** Strong directive against inferring intervention details; require explicit evidence for implementation specifics

---

## Recommendations for Actual Microscope Testing

When Microscope v1.0 automation is implemented, this simulated analysis should be validated by:

1. **Run Microscope on all 4 gold standard papers**
2. **Compare automated output to gold standards systematically**
3. **Calculate actual error rates by category**
4. **Identify systematic patterns** (e.g., does Microscope consistently miss differential attrition?)
5. **Refine prompt based on actual errors** (not predicted)
6. **Re-test refined prompt on subset**
7. **Iterate until >90% accuracy achieved**

**Success Criteria for Actual Testing:**
- <5% Critical errors (incorrect values, hallucinations)
- <10% Moderate errors (missing data, label errors)
- >85% overall data point agreement
- >90% quality assessment agreement within ±1 risk level

---

**Analysis Status:** ✅ SIMULATED - Provides error prediction framework for future Microscope testing

**Confidence:** MODERATE - Based on systematic analysis of gold standard patterns and known LLM limitations, but actual errors may differ

**Next Step:** Implement Microscope automation and validate these predictions with actual comparison testing
