# Microscope v1.0 - Research Paper Data Extraction Prompt

<!-- Powered by BMAD™ Core -->

**Version:** 1.0
**Created:** 2025-10-20
**Template Type:** microscope
**Compatible Claude Models:**
- claude-sonnet-4-5 (primary, 200K context)
- claude-opus-4 (alternative, 200K context)
- claude-sonnet-3.5 (fallback, 200K context)

**Tested with Papers:** 8,000-12,000 words, IMRAD structure, quantitative studies with statistical tables

---

## What This Prompt Does

This prompt guides you through **systematic extraction of research data from a single academic paper** into a standardized, version-controllable data card format. The extraction process consists of three stages:

1. **Screening Decision:** Determine if the paper should be included in the meta-analysis
2. **Quality Assessment:** Evaluate methodological rigor using a 5-domain checklist
3. **Data Extraction:** Extract study data with transparent source labeling

**Input:** Full text of one research paper (paste below this prompt)

**Output:** Complete data card in markdown format with YAML frontmatter, ready to save as `data_cards/{study_id}.md`

---

## SECTION 1: SCREENING DECISION

### Task

Read the research paper and decide whether it should be **INCLUDED** or **EXCLUDED** from the meta-analysis.

### Inclusion Criteria Framework

Consider the following factors:

1. **Relevance to Research Question**
   - Does the study address the research question or phenomenon of interest?
   - Are the outcomes measured relevant to the meta-analysis?

2. **Study Design Appropriateness**
   - Is the study design suitable for answering the research question?
   - Does it provide empirical data (not purely theoretical/conceptual)?

3. **Extractable Data Availability**
   - Does the paper report sufficient data for extraction (sample sizes, means, effect sizes, etc.)?
   - Can key statistics be extracted or calculated from reported information?

### Decision Output

**Provide your screening decision in this format:**

```yaml
screening_decision: "include"  # or "exclude"
screening_rationale: |
  [2-4 sentence justification for your decision]
  - Mention specific reasons related to the criteria above
  - For EXCLUDE decisions, cite which criterion/criteria failed
  - For INCLUDE decisions, confirm all criteria are met
```

### Common Scenarios

**INCLUDE Examples:**
- RCT investigating target intervention with appropriate outcome measures and reported statistics
- Observational study with clear methods and extractable effect sizes
- Pilot study with limited sample size but relevant data and sound methodology

**EXCLUDE Examples:**
- Review article or meta-analysis (no original empirical data)
- Qualitative study when meta-analysis requires quantitative data
- Conference abstract without full methods or results
- Study with completely missing outcome data or critical methodological information

---

## SECTION 2: QUALITY ASSESSMENT

### Task

Evaluate the methodological quality and risk of bias using the Generic Quality Assessment Checklist. Rate each of the 5 methodological domains, then synthesize an overall quality rating.

### Generic Quality Checklist v1.0

This checklist assesses 5 fundamental methodological domains applicable across research designs. For each domain, rate the paper as **Low Risk** (high quality), **Medium Risk** (moderate concerns), or **High Risk** (serious quality issues).

**IMPORTANT:** Base assessments only on information in the main paper text provided. Do not assume access to supplementary materials. Document all ratings with page/section references using the three-color labeling system (explained in Section 3).

---

#### Domain 1: Selection Bias

**Purpose:** Assess whether sampling and recruitment methods could introduce systematic bias.

**1.1 Sampling Method Appropriateness**

Was the sampling method appropriate for the study design and research question?

- **Low Risk:** Probability sampling (random, stratified) for population studies; purposive/theoretical sampling justified for qualitative work; clear match to research aims
- **Medium Risk:** Convenience sampling with acknowledged limitations; partial sampling rationale; minor representativeness concerns
- **High Risk:** Sampling method unclear/unstated; unjustified convenience sampling; obvious mismatch with study aims

**1.2 Participant Recruitment Transparency**

Was recruitment clearly described and free from obvious selection pressures?

- **Low Risk:** Detailed recruitment procedures (where, when, how); timeline specified; response rates reported; minimal selection pressure
- **Medium Risk:** Basic recruitment description; some details missing (response rates, timeline); adequately described but lacks detail
- **High Risk:** Vague/unreported recruitment; self-selection concerns not addressed; potential coercion/undue influence

**1.3 Inclusion/Exclusion Criteria Clarity**

Were criteria clearly defined, appropriate, and consistently applied?

- **Low Risk:** Explicit criteria stated and justified; consistency documented
- **Medium Risk:** Criteria stated but minimal justification; some ambiguity; minor inconsistencies possible
- **High Risk:** Criteria unclear/unreported; overly restrictive without justification; evidence of inconsistent application

**1.4 Selection Process Documentation**

Was participant flow from recruitment to final sample clearly documented?

- **Low Risk:** Flow diagram or equivalent; numbers at each stage; exclusion reasons specified
- **Medium Risk:** Flow described in text without diagram; most numbers reported; some exclusion reasons missing
- **High Risk:** Unclear flow; discrepancies in sample sizes; exclusion reasons not provided

**Domain 1 Rating:** [low/medium/high]

---

#### Domain 2: Measurement Validity

**Purpose:** Evaluate whether outcomes were measured using valid, reliable instruments and procedures.

**2.1 Outcome Measure Validation Status**

Were outcome measures validated, standardized, or appropriately justified?

- **Low Risk:** Validated instruments with psychometric properties reported; widely accepted standardized measures; validation study citations
- **Medium Risk:** Established measures but psychometric properties unreported; face validity argued for custom measures; limited validation
- **High Risk:** Unvalidated ad hoc measures without justification; no reliability/validity evidence; poorly defined outcomes

**2.2 Measurement Instrument Reliability**

Was measurement reliability assessed and reported for this study?

- **Low Risk:** Internal consistency (Cronbach's α ≥ 0.70) or inter-rater reliability (κ ≥ 0.60, ICC ≥ 0.70) reported for current sample
- **Medium Risk:** Reliability from prior studies cited but not assessed in current sample; acceptable but suboptimal values
- **High Risk:** No reliability information; unacceptable reliability values (α < 0.60); single-item measures without validation

**2.3 Blinding/Masking of Assessors**

Were outcome assessors blinded to group assignment or hypotheses when appropriate?

- **Low Risk:** Assessors masked to intervention/exposure status; blinding verified; objective outcomes where blinding unnecessary
- **Medium Risk:** Partial blinding (some outcomes masked); blinding stated but not verified; self-report where blinding impractical
- **High Risk:** No blinding when feasible/necessary; high detection bias risk; subjective outcomes assessed by unblinded evaluators

**2.4 Measurement Timing Appropriateness**

Were outcomes measured at appropriate time points to capture effects?

- **Low Risk:** Timing justified based on mechanism; appropriate follow-up duration; baseline and post-intervention timing clearly reported
- **Medium Risk:** Timing generally appropriate but minimal justification; adequate but not optimal follow-up
- **High Risk:** Timing inappropriate for detecting effects; critical time points missing; timing poorly documented

**Domain 2 Rating:** [low/medium/high]

---

#### Domain 3: Confounding Control

**Purpose:** Assess whether alternative explanations were adequately addressed through design or analysis.

**3.1 Baseline Group Comparability**

Were comparison groups (or pre/post measurements) similar at baseline?

- **Low Risk:** Baseline characteristics reported for all groups; statistical tests conducted; groups demonstrably similar on key confounders
- **Medium Risk:** Baseline characteristics reported but limited comparison; minor imbalances acknowledged; some differences addressed in analysis
- **High Risk:** Baseline characteristics not/partially reported; substantial differences not addressed; inadequate baseline assessment

**3.2 Control for Known Confounders**

Were known confounders identified and controlled through design or analysis?

- **Low Risk:** Key confounders identified a priori; randomization OR statistical adjustment in observational studies; confounders validly measured
- **Medium Risk:** Some confounders controlled but not comprehensive; appropriate but limited adjustment; post-hoc identification
- **High Risk:** Known confounders not addressed; no randomization and no statistical control in observational studies; poorly measured confounders

**3.3 Statistical Adjustment Methods**

If statistical adjustment used, were methods appropriate and transparently reported?

- **Low Risk:** Appropriate multivariable methods (regression, propensity scores); model building described; adjustment variables justified; assumptions addressed
- **Medium Risk:** Adjustment attempted but limited reporting; assumptions not verified; variables selected without clear justification
- **High Risk:** Inappropriate methods; overfitting concerns; adjustment strategy unclear/unreported

**3.4 Randomization Quality (if applicable)**

If randomized, was it properly implemented and concealed?

- **Low Risk:** Random sequence generation specified (computer-generated, random table); allocation concealment described; balance achieved
- **Medium Risk:** Randomization stated but method not fully described; concealment unclear; some imbalance addressed statistically
- **High Risk:** Randomization method unclear/flawed (alternation); no allocation concealment; evidence of selection bias despite claimed randomization
- **N/A:** Non-randomized study

**Domain 3 Rating:** [low/medium/high]

---

#### Domain 4: Attrition/Missing Data

**Purpose:** Evaluate how dropout and missing data were handled and whether they could bias results.

**4.1 Dropout Rates Reported**

Were participant dropout/loss to follow-up rates clearly reported?

- **Low Risk:** Attrition rates reported for all groups at all time points; percentages clear; flow diagram showing retention
- **Medium Risk:** Overall attrition reported but not by group/time point; numbers provided but percentages unclear
- **High Risk:** Attrition rates not reported/incalculable; discrepancies between reported sample sizes; no accounting for missing participants

**4.2 Attrition Analysis Provided**

Was differential attrition analyzed and reported?

- **Low Risk:** Comparison of completers vs. dropouts on baseline characteristics; statistical testing for differential attrition; reasons analyzed by group
- **Medium Risk:** Basic description of dropout reasons; limited completer vs. dropout comparison; attrition acknowledged but minimal analysis
- **High Risk:** No analysis of who dropped out or why; differential attrition not addressed; potential selection bias not discussed

**4.3 Missing Data Handling Transparency**

Were missing data methods clearly described and appropriate?

- **Low Risk:** Missing data mechanism considered (MAR, MCAR, MNAR); appropriate methods (multiple imputation, maximum likelihood); sensitivity analyses
- **Medium Risk:** Methods stated (complete case, single imputation) but limited justification; extent reported; basic approach documented
- **High Risk:** Handling unclear/unreported; inappropriate methods (listwise deletion with substantial missingness); extent not quantified

**4.4 Differential Attrition Assessment**

Was differential attrition low enough to minimize bias?

- **Low Risk:** Attrition < 10% overall; group difference < 5%; attrition unrelated to outcomes
- **Medium Risk:** Attrition 10-20%; group difference 5-10%; some outcome-related attrition but addressed in sensitivity analysis
- **High Risk:** Attrition > 20%; group difference > 10%; evidence of outcome-related attrition; no sensitivity analysis

**Domain 4 Rating:** [low/medium/high]

---

#### Domain 5: Reporting Transparency

**Purpose:** Assess whether methodological and statistical details enable reproducibility and evaluation.

**5.1 Methods Section Completeness**

Does methods provide sufficient detail to replicate the study?

- **Low Risk:** Comprehensive methods (design, setting, participants, interventions/exposures, outcomes, sample size, statistics); protocol/pre-registration referenced
- **Medium Risk:** Key elements present but some details missing; general approach understandable but not fully replicable
- **High Risk:** Sparse/vague methods; critical details missing; insufficient information to evaluate quality

**5.2 Results Reporting Clarity**

Are results complete and clear, including effect sizes and precision estimates?

- **Low Risk:** All outcomes reported (including non-significant); effect sizes and CIs provided; sample sizes clear; no selective reporting evident
- **Medium Risk:** Primary outcomes fully reported but secondary incomplete; effect sizes/CIs sometimes missing; mostly complete with minor omissions
- **High Risk:** Selective outcome reporting suspected; effect sizes/precision frequently missing; p-values without effect sizes; incomplete results

**5.3 Statistical Details Provided**

Are statistical methods and assumptions sufficiently documented?

- **Low Risk:** Tests clearly specified; assumptions checked and reported; violation handling described; software/versions noted
- **Medium Risk:** Methods stated but assumptions not verified; standard analyses adequately described; some analytical details missing
- **High Risk:** Methods unclear/unreported; inappropriate analyses or unaddressed violations; p-values without test specifications

**5.4 Conflicts of Interest Disclosed**

Were funding sources and conflicts transparently disclosed?

- **Low Risk:** Funding sources explicit; author conflicts disclosed; sponsor role clarified; transparency statement included
- **Medium Risk:** Funding mentioned but details limited; conflicts statement present but vague; partial disclosure
- **High Risk:** No funding disclosure; no conflict statement; industry funding not acknowledged; bias sources not addressed

**Domain 5 Rating:** [low/medium/high]

---

### Overall Quality Synthesis

After rating all 5 domains, synthesize an **overall quality rating** using these guidelines:

**High Quality:**
- Most domains (4-5 out of 5) rated **Low Risk**
- No domains rated **High Risk**
- Study demonstrates methodological rigor; minor limitations don't threaten validity

**Medium Quality:**
- Mix of Low/Medium Risk domains (2-3 Low, 2-3 Medium)
- OR one High Risk domain but all others Low Risk
- Acceptable quality but notable limitations; results interpreted with some caution

**Low Quality:**
- Multiple domains (2+) rated **High Risk**
- OR one critical High Risk domain undermining validity
- Substantial limitations threaten validity; considerable caution needed

### Quality Assessment Output Format

**Provide quality assessment in this YAML structure:**

```yaml
quality_scores:
  checklist_module: "generic_v1.0"
  selection_bias: "low"           # or "medium" or "high"
  measurement_validity: "low"
  confounding_control: "medium"
  attrition_missing_data: "low"
  reporting_transparency: "low"
  overall_quality: "medium"       # "high", "medium", or "low"
```

**Also provide justifications** in narrative form in the data card body, citing specific page numbers and sections using three-color labels (explained in next section).

---

## SECTION 3: DATA EXTRACTION

### Task

Extract study data into standardized markdown tables, labeling EVERY data point with source transparency indicators.

### Three-Color Source Labeling System

**CRITICAL RULE:** Every extracted data point must include a source label (🟢/🟡/🔴) with evidence. This system ensures academic credibility and allows uncertainty quantification.

#### 🟢 GREEN - Direct Quote/Observation

**Definition:** Data taken directly from the paper without interpretation or calculation.

**Evidence Requirements:**
- Page number AND section reference
- Direct quote if possible

**When to Use:**
- Directly reported statistics (means, SDs, sample sizes, p-values)
- Exact quotes from text
- Values copied from tables/figures
- Categorical classifications stated in paper

**Examples:**
- ✅ `N=120 (p. 7, Methods: Participants section)`
- ✅ `Mean age 34.5 years, SD=6.2 (Table 1, p. 9)`
- ✅ `"Randomized controlled trial" (p. 6, Methods: Study Design)`
- ✅ `Dropout rate 15% (p. 12, Results: Attrition)`

---

#### 🟡 YELLOW - Computed/Inferred Value

**Definition:** Data calculated or inferred from information reported in the paper.

**Evidence Requirements:**
- Complete calculation formula OR reasoning process
- Page numbers of all source data used
- Show your work step-by-step

**When to Use:**
- Computed effect sizes (Cohen's d, Hedges' g, correlation r)
- Derived statistics (pooled SD, standard errors, confidence intervals)
- Aggregated values (total sample size from subgroups, weighted means)
- Reasonable inferences from reported data

**Examples:**
- ✅ `Cohen's d = (M1 - M2) / SD_pooled = (42.3 - 38.1) / 8.5 = 0.49 (calculated from Table 2, p. 10)`
- ✅ `Total N = 64 + 58 = 122 (sum of intervention and control groups, Table 1, p. 9)`
- ✅ `Pooled SD = sqrt(((n1-1)*SD1² + (n2-1)*SD2²) / (n1+n2-2)) = sqrt(((64-1)*8.2² + (58-1)*8.9²) / (122-2)) = 8.5 (from Table 2, p. 10)`
- ✅ `Attrition rate intervention group = 12/76 = 15.8% (calculated from Figure 1 flow diagram, p. 8)`

---

#### 🔴 RED - Uncertain/Missing Data

**Definition:** Data not clearly reported, ambiguous, contradictory, or completely missing.

**Evidence Requirements:**
- Clear explanation of what's uncertain or missing
- Quote contradictory statements if applicable
- Note potential impact on analysis

**When to Use:**
- Data not reported in paper
- Partial reporting (e.g., "p < 0.05" without exact value)
- Contradictory information across paper sections
- Ambiguous wording preventing certain extraction
- Insufficient data for needed calculations
- Supplementary materials referenced but not accessible

**Examples:**
- ✅ `Control group sample size not reported; only total N=120 provided (p. 7, Methods). Unable to calculate group-specific statistics.`
- ✅ `Baseline mean reported as "approximately 35" without exact value or SD (p. 9, Results, Table 1). Insufficient precision for meta-analysis.`
- ✅ `Abstract states N=150 but Methods states N=142 (p. 1 vs p. 6). Unclear which is correct; using 142 from Methods but flagging discrepancy.`
- ✅ `Effect size reported as "p < 0.001" without means, SDs, or effect size estimate (p. 11, Results). Cannot extract for meta-analysis.`
- ✅ `"See supplementary materials for full statistical results" but supplementary materials not accessible (p. 12, Results).`

---

### Labeling Decision Tree

**Use this decision tree when uncertain which label to apply:**

1. **Is the value stated directly in the paper (in text, table, or figure)?**
   - YES → Use 🟢 with page/section reference
   - NO → Go to step 2

2. **Can the value be reliably calculated from reported data?**
   - YES → Use 🟡 with full calculation shown
   - NO → Go to step 3

3. **Is there partial information allowing reasonable inference?**
   - YES, and inference is low-risk → Use 🟡 with reasoning explained
   - NO, or inference would be speculative → Use 🔴 explaining missing information

**CRITICAL: When in doubt, use 🔴 and explain the uncertainty.** Over-flagging uncertainty is preferred to under-flagging.

### Evidence Field Requirements

Every data point must include an evidence field explaining the source label:

| Source Label | Evidence Must Include |
|--------------|----------------------|
| 🟢 Green | Page number + section/table reference + (optional) direct quote |
| 🟡 Yellow | Complete calculation OR reasoning + page numbers of all source data |
| 🔴 Red | Explanation of what's missing/uncertain + impact on analysis |

**Poor Evidence Examples (Don't do this):**
- ❌ `N=50 🟢` (missing page/section reference)
- ❌ `Cohen's d=0.6 🟡 calculated` (calculation not shown, sources not cited)
- ❌ `Missing 🔴` (no explanation of what's missing or why)

**Good Evidence Examples:**
- ✅ `N=50 🟢 (p. 8, Methods: Sample section)`
- ✅ `Cohen's d=0.6 🟡 (M1-M2)/SD_pooled = (5.2-4.6)/1.0 = 0.6 (Table 2, p. 11)`
- ✅ `Baseline SD not reported 🔴 (p. 9, Results, Table 1). Cannot calculate standardized effect size; will request from authors.`

---

## SECTION 4: OUTPUT FORMAT - DATA CARD STRUCTURE

### Complete Data Card Template

Your final output should follow this exact structure:

```markdown
---
# Study Identification
study_id: "[author_year_design]"  # e.g., "smith_2023_rct"
title: "[Full paper title]"
authors: ["LastName FirstInitial", "LastName FirstInitial"]
year: [YYYY as integer]
doi: "[DOI if available]"

# Extraction Metadata
extraction_date: "[YYYY-MM-DDTHH:MM:SSZ]"  # Current timestamp
extractor: "Claude Code"
microscope_version: "v1.0"
claude_model: "[Your model identifier, e.g., claude-sonnet-4-5-20250929]"

# Screening and Quality
screening_decision: "[include|exclude]"

quality_scores:
  checklist_module: "generic_v1.0"
  selection_bias: "[low|medium|high]"
  measurement_validity: "[low|medium|high]"
  confounding_control: "[low|medium|high]"
  attrition_missing_data: "[low|medium|high]"
  reporting_transparency: "[low|medium|high]"
  overall_quality: "[high|medium|low]"
---

# Participant Demographics

| Variable | Value | Source Label & Evidence |
|----------|-------|------------------------|
| Total sample size (N) | [value] | 🟢/🟡/🔴 [evidence] |
| Intervention group (n) | [value] | 🟢/🟡/🔴 [evidence] |
| Control group (n) | [value] | 🟢/🟡/🔴 [evidence] |
| Mean age (years) | [value] | 🟢/🟡/🔴 [evidence] |
| Age range | [value] | 🟢/🟡/🔴 [evidence] |
| Gender (% female) | [value] | 🟢/🟡/🔴 [evidence] |
| Population description | [value] | 🟢/🟡/🔴 [evidence] |

# Study Design

| Aspect | Details | Source Label & Evidence |
|--------|---------|------------------------|
| Study design | [e.g., RCT, cohort, cross-sectional] | 🟢/🟡/🔴 [evidence] |
| Setting | [e.g., university, clinic, community] | 🟢/🟡/🔴 [evidence] |
| Intervention (if applicable) | [description] | 🟢/🟡/🔴 [evidence] |
| Control/Comparison | [description] | 🟢/🟡/🔴 [evidence] |
| Duration of intervention | [value] | 🟢/🟡/🔴 [evidence] |
| Follow-up period | [value] | 🟢/🟡/🔴 [evidence] |

# Outcomes and Measures

| Outcome | Instrument/Method | Source Label & Evidence |
|---------|------------------|------------------------|
| Primary outcome | [description] | 🟢/🟡/🔴 [evidence] |
| Measurement instrument | [e.g., scale name, assessment tool] | 🟢/🟡/🔴 [evidence] |
| Reliability in this study | [e.g., Cronbach's α = 0.87] | 🟢/🟡/🔴 [evidence] |
| Validity evidence | [description] | 🟢/🟡/🔴 [evidence] |

# Effect Sizes and Results

| Comparison | Effect Size | 95% CI | p-value | Source Label & Evidence |
|------------|-------------|--------|---------|------------------------|
| [Intervention vs Control on Outcome] | [value] | [lower, upper] | [value] | 🟢/🟡/🔴 [evidence] |

**Add additional rows for multiple outcomes or subgroup analyses as needed**

# Attrition and Missing Data

| Aspect | Value | Source Label & Evidence |
|--------|-------|------------------------|
| Total attrition N (%) | [value] | 🟢/🟡/🔴 [evidence] |
| Intervention group attrition | [value] | 🟢/🟡/🔴 [evidence] |
| Control group attrition | [value] | 🟢/🟡/🔴 [evidence] |
| Reasons for dropout | [description] | 🟢/🟡/🔴 [evidence] |
| Missing data handling | [description] | 🟢/🟡/🔴 [evidence] |

# Quality Assessment Justifications

## Selection Bias: [Low/Medium/High]

[Provide 2-4 sentence justification with page references using 🟢🟡🔴 labels]

## Measurement Validity: [Low/Medium/High]

[Provide 2-4 sentence justification with page references using 🟢🟡🔴 labels]

## Confounding Control: [Low/Medium/High]

[Provide 2-4 sentence justification with page references using 🟢🟡🔴 labels]

## Attrition/Missing Data: [Low/Medium/High]

[Provide 2-4 sentence justification with page references using 🟢🟡🔴 labels]

## Reporting Transparency: [Low/Medium/High]

[Provide 2-4 sentence justification with page references using 🟢🟡🔴 labels]

## Overall Quality: [High/Medium/Low]

[Synthesize overall assessment in 2-3 sentences, explaining rationale for overall rating]

# Additional Notes

[Any additional observations, concerns, or notes about this paper that may be relevant for the meta-analysis]
```

### Key Formatting Requirements

1. **YAML Frontmatter:** Must be valid YAML syntax with `---` delimiters
2. **Markdown Tables:** Use proper pipe (`|`) delimiters and alignment
3. **Source Labels:** Must appear in EVERY data row in "Source Label & Evidence" column
4. **Headers:** Use `#` for main sections, `##` for subsections
5. **Consistency:** Use consistent terminology and formatting throughout

---

## SECTION 5: EDGE CASES AND SPECIAL SCENARIOS

### Handling Missing Data

**Scenario: Data Not Reported**

When a data point is completely unreported:

```
Control group size not reported 🔴 (Methods section, p. 6-7, reviews entire participant description). Unable to calculate group-specific statistics or between-group effect sizes.
```

**Scenario: Partial Reporting**

When some but not all needed information is provided:

```
Mean reported as 42.5 but SD not provided 🔴 (Table 2, p. 10). Range given as 28-61 but insufficient for SD estimation. Cannot include in meta-analysis without contacting authors.
```

**Scenario: Supplementary Materials Referenced**

When critical data is in inaccessible supplementary materials:

```
"Full statistical results in Supplementary Table S3" 🔴 (p. 12, Results) but supplementary materials not available. Cannot verify or extract detailed statistics.
```

---

### Handling Unclear Reporting

**Scenario: Ambiguous Wording**

When author language is vague or imprecise:

```
Sample described as "approximately 50 adults" 🔴 (p. 7, Methods). Exact sample size unclear; could be 48-52. Insufficient precision for analysis.
```

**Scenario: Data Ranges Without Exact Values**

When ranges are provided instead of point estimates:

- If narrow range and midpoint is reasonable:
  ```
  Mean age estimated as 42 years 🟡 (midpoint of reported range 40-44 years, Table 1, p. 8). Author states "mean approximately 42" but exact value not provided.
  ```

- If wide range or midpoint unreliable:
  ```
  Age range 18-75 years with no mean or median reported 🔴 (p. 7, Methods). Cannot estimate central tendency from wide range.
  ```

**Scenario: Unclear Sample Sizes**

When different sample sizes appear across analyses:

```
Methods reports N=120 recruited, Results Table 1 shows N=112 analyzed, but Results text mentions N=108 for primary outcome 🔴 (p. 7 Methods, p. 10-11 Results). Inconsistent reporting; using N=108 for primary outcome as stated in Results text, but flagging discrepancy.
```

---

### Handling Conflicting Values

**Scenario: Abstract vs. Results Discrepancy**

When abstract and main text report different values:

```
Abstract reports N=150 but Methods reports N=142 🔴 (p. 1 Abstract vs. p. 6 Methods). Using Methods value (142) as more detailed section, but noting inconsistency for potential author clarification.
```

**Scenario: Inconsistent Reporting Across Tables**

When tables contradict each other:

```
Table 1 reports intervention group N=64, but Table 3 reports N=62 for same group 🔴 (p. 9 Table 1 vs p. 13 Table 3). Likely due to missing data in Table 3 analysis, but not explicitly stated. Using N=64 as baseline, flagging discrepancy.
```

**Scenario: Text Contradicts Tables**

When narrative and tabular data conflict:

```
Text states "no significant difference" but Table 2 shows p=0.03 🔴 (p. 11 Results text vs Table 2, p. 12). Contradiction between narrative and table. Using table value (p=0.03) as more precise, but noting inconsistency.
```

---

### Handling Calculations

**Scenario: Effect Sizes Not Directly Reported**

When effect sizes must be computed:

```
Cohen's d = 0.61 🟡 Calculated using (M_intervention - M_control) / SD_pooled = (42.3 - 38.1) / ((sqrt((63*8.2² + 57*8.9²) / (64+58-2))) = 4.2 / 8.53 = 0.49 (means and SDs from Table 2, p. 10; n values from Table 1, p. 9)
```

**Scenario: Missing SDs but CIs Available**

When standard deviations must be back-calculated:

```
SD = 8.2 🟡 Back-calculated from 95% CI. SE = (CI_upper - CI_lower) / (2 * 1.96) = (44.7 - 39.9) / 3.92 = 1.22; SD = SE * sqrt(N) = 1.22 * sqrt(45) = 8.2 (CI from Table 2, p. 10; N=45 from Methods, p. 7)
```

**Scenario: Incomplete Data for Calculation**

When calculation cannot be completed:

```
Unable to calculate Cohen's d 🔴 (p. 11, Results). Means reported for both groups (Table 2, p. 11) but standard deviations not provided and cannot be estimated from available information. Would need author contact or supplementary materials.
```

---

### Emphasis on Conservative Labeling

**CRITICAL PRINCIPLE:** When you are uncertain whether data is directly reported, reliably calculable, or too ambiguous, **default to 🔴 and explain your reasoning.**

**Examples of Conservative Labeling:**

- "Authors state outcome improved 'significantly'" → If no statistics: 🔴 (vague qualitative claim without numerical data)
- "Mean was around 45" → 🔴 (imprecise language, exact value uncertain)
- "See Figure 2 for results" → If values not extractable from figure: 🔴 (data visualization without extractable numbers)

**The goal is 90%+ uncertain data flagging** - it's better to over-flag uncertainty than to present uncertain data as certain.

---

## FINAL VALIDATION CHECKLIST

Before submitting your data card, verify:

- [ ] **Screening decision** provided with clear rationale
- [ ] **All 5 quality domains** rated (low/medium/high)
- [ ] **Overall quality** synthesized (high/medium/low)
- [ ] **Quality justifications** provided with page references and 🟢🟡🔴 labels
- [ ] **YAML frontmatter** is valid syntax with all required fields
- [ ] **study_id** follows format: author_year_design (e.g., "smith_2023_rct")
- [ ] **extraction_date** is current timestamp in ISO 8601 format
- [ ] **microscope_version** is "v1.0"
- [ ] **All data points** have source labels (🟢/🟡/🔴)
- [ ] **All source labels** have evidence (page/section/calculation/explanation)
- [ ] **All 🟢 labels** include page number and section reference
- [ ] **All 🟡 labels** show complete calculations with source pages
- [ ] **All 🔴 labels** explain what's missing/uncertain and why
- [ ] **Markdown tables** are properly formatted with aligned columns
- [ ] **No data point** is missing its source label

---

## YOU ARE NOW READY TO EXTRACT DATA

**Instructions:**

1. Read the complete research paper provided below this prompt
2. Follow the extraction workflow: Screening → Quality Assessment → Data Extraction
3. Output a complete data card following the template structure above
4. Ensure every data point has a source label with evidence
5. When uncertain, use 🔴 and explain

**Please paste the research paper below and begin extraction.**

---

*End of Microscope v1.0 Prompt Template*
