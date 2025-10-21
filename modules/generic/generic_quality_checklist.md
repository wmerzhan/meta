# Generic Quality Assessment Checklist v1.0

<!-- Powered by BMAD™ Core -->

**Version:** 1.0
**Created:** 2025-10-20
**Compatible with:** Microscope v1.0
**Checklist Module ID:** `generic_v1.0`

---

## About This Checklist

### Purpose and Scope

This **Generic Quality Assessment Checklist** provides a discipline-agnostic framework for evaluating research quality and risk of bias across diverse study designs. It is designed for use with the MAestro Microscope tool during data card extraction.

**This is the MVP baseline quality assessment framework.** Specialized tools like Cochrane's Risk of Bias 2 (RoB2), Campbell Collaboration checklists, and GRADE assessments will be added as Phase 2 discipline-specific modules in the `modules/rob2/`, `modules/campbell/`, etc. directories.

### When to Use This Checklist

- **Cross-disciplinary meta-analyses** requiring consistent quality assessment across fields
- **When specialized tools are unavailable** for your research domain
- **As a starting point** for custom quality criteria (easily modifiable)
- **For pilot meta-analyses** before implementing discipline-specific assessment

### Checklist Philosophy

This checklist focuses on **five fundamental methodological domains** that apply across research designs:

1. **Selection Bias** - How participants were recruited and selected
2. **Measurement Validity** - Quality and appropriateness of outcome measures
3. **Confounding Control** - Management of alternative explanations
4. **Attrition/Missing Data** - Handling of dropout and incomplete data
5. **Reporting Transparency** - Completeness of methodological documentation

Each domain can be rated as **Low Risk** (high quality), **Medium Risk** (moderate concerns), or **High Risk** (serious quality issues).

---

## How to Use This Checklist

### During Data Extraction with Microscope

1. **Read the research paper** while keeping this checklist accessible
2. **Answer each question** based on information in the main paper (do not assume supplementary materials)
3. **Assign ratings** using the Low/Medium/High risk guidance provided
4. **Document justifications** with page/section references (🟢 direct quotes preferred)
5. **Synthesize overall quality** based on domain ratings
6. **Record results** in the data card's `quality_scores` YAML frontmatter

### Rating Scale Interpretation

- **Low Risk / High Quality:** Best practices followed, minimal threats to validity
- **Medium Risk / Moderate Quality:** Acceptable but imperfect practices, minor concerns
- **High Risk / Low Quality:** Serious quality concerns or critical information missing

### Customization for Your Meta-Analysis

This checklist is designed for easy modification:

- **Add custom items:** Insert additional questions relevant to your research domain
- **Remove irrelevant items:** Skip questions that don't apply to your study designs
- **Adjust rating criteria:** Modify Low/Medium/High definitions to match your standards
- **Combine with specialized tools:** Use alongside discipline-specific checklists

To customize, copy this file and edit while preserving the basic structure for Microscope integration.

---

## Domain 1: Selection Bias

**Purpose:** Assess whether the study's sampling and recruitment methods could introduce systematic bias in participant selection.

### Checklist Items

#### 1.1 Sampling Method Appropriateness

**Question:** Was the sampling method appropriate for the study design and research question?

**Rating Guidance:**
- **Low Risk:** Probability sampling (random, stratified) for population studies; purposive/theoretical sampling clearly justified for qualitative work; sampling method explicitly matched to research aims
- **Medium Risk:** Convenience sampling with acknowledgment of limitations; partial description of sampling rationale; minor concerns about representativeness
- **High Risk:** Sampling method unclear or unstated; convenience sampling without justification; obvious mismatch between sampling and study aims

#### 1.2 Participant Recruitment Transparency

**Question:** Was the participant recruitment process clearly described and free from obvious selection pressures?

**Rating Guidance:**
- **Low Risk:** Detailed recruitment procedures documented (where, when, how participants contacted); recruitment timeline specified; response rates reported; minimal selection pressure
- **Medium Risk:** Basic recruitment description provided; some details missing (e.g., response rates, recruitment timeline); recruitment method adequately described but lacks detail
- **High Risk:** Recruitment process vague or unreported; self-selection concerns not addressed; potential coercion or undue influence in recruitment

#### 1.3 Inclusion/Exclusion Criteria Clarity

**Question:** Were inclusion and exclusion criteria clearly defined, appropriate, and applied consistently?

**Rating Guidance:**
- **Low Risk:** Explicit inclusion/exclusion criteria stated; criteria justified in relation to research question; consistency of application documented
- **Medium Risk:** Criteria stated but minimal justification; some ambiguity in criteria application; minor inconsistencies possible
- **High Risk:** Criteria unclear, overly restrictive without justification, or not reported; evidence of inconsistent application

#### 1.4 Selection Process Documentation

**Question:** Was the flow of participants from recruitment through final sample clearly documented?

**Rating Guidance:**
- **Low Risk:** CONSORT-style flow diagram or equivalent; numbers reported at each stage (screened, eligible, enrolled, analyzed); reasons for exclusions specified
- **Medium Risk:** Participant flow described in text without diagram; most key numbers reported; some exclusion reasons missing
- **High Risk:** Participant flow unclear; discrepancies in reported sample sizes; reasons for exclusions not provided

---

## Domain 2: Measurement Validity

**Purpose:** Evaluate whether outcomes were measured using valid, reliable instruments and appropriate procedures.

### Checklist Items

#### 2.1 Outcome Measure Validation Status

**Question:** Were outcome measures validated, standardized, or appropriately justified?

**Rating Guidance:**
- **Low Risk:** Validated instruments with psychometric properties reported (reliability, validity coefficients); widely accepted standardized measures; citations to validation studies provided
- **Medium Risk:** Established measures but psychometric properties not reported; face validity argued for custom measures; limited validation evidence
- **High Risk:** Unvalidated or ad hoc measures without justification; no evidence of reliability or validity; outcome measurement poorly defined

#### 2.2 Measurement Instrument Reliability

**Question:** Was measurement reliability assessed and reported for this study?

**Rating Guidance:**
- **Low Risk:** Internal consistency (Cronbach's α ≥ 0.70) or inter-rater reliability (κ ≥ 0.60, ICC ≥ 0.70) reported for current sample; measurement error quantified
- **Medium Risk:** Reliability from prior studies cited but not assessed in current sample; acceptable but not ideal reliability values; minimal reliability reporting
- **High Risk:** No reliability information provided; unacceptable reliability values (α < 0.60); single-item measures without validation

#### 2.3 Blinding/Masking of Assessors

**Question:** Were outcome assessors blinded to group assignment or study hypotheses when appropriate?

**Rating Guidance:**
- **Low Risk:** Outcome assessors masked to intervention/exposure status; blinding verification reported; objective outcomes where blinding unnecessary
- **Medium Risk:** Partial blinding (some outcomes masked, others not); blinding stated but not verified; self-report outcomes where blinding impractical
- **High Risk:** No blinding when feasible and necessary; high risk of detection bias; subjective outcomes assessed by unblinded evaluators

#### 2.4 Measurement Timing Appropriateness

**Question:** Were outcomes measured at appropriate time points to capture the effect of interest?

**Rating Guidance:**
- **Low Risk:** Measurement timing justified based on intervention/exposure mechanism; follow-up duration appropriate for outcome; baseline and post-intervention timing clearly reported
- **Medium Risk:** Timing generally appropriate but minimal justification; follow-up duration adequate but not optimal; timing reported but rationale unclear
- **High Risk:** Measurement timing inappropriate for detecting effects; critical time points missing; timing poorly documented

---

## Domain 3: Confounding Control

**Purpose:** Assess whether alternative explanations for observed effects were adequately addressed through design or analysis.

### Checklist Items

#### 3.1 Baseline Group Comparability

**Question:** Were comparison groups (or pre/post measurements) similar at baseline on key characteristics?

**Rating Guidance:**
- **Low Risk:** Baseline characteristics reported for all groups; statistical tests of baseline differences conducted; groups demonstrably similar on key confounders
- **Medium Risk:** Baseline characteristics reported but limited statistical comparison; minor imbalances acknowledged; some baseline differences noted but addressed in analysis
- **High Risk:** Baseline characteristics not reported or only partially reported; substantial baseline differences not addressed; inadequate baseline assessment

#### 3.2 Control for Known Confounders

**Question:** Were known confounders identified and controlled for through design or analysis?

**Rating Guidance:**
- **Low Risk:** Key confounders identified a priori; randomization used OR statistical adjustment for confounders in observational studies; confounding variables measured validly
- **Medium Risk:** Some confounders controlled but not comprehensive; adjustment methods appropriate but limited; confounders identified post-hoc
- **High Risk:** Known confounders not addressed; no randomization and no statistical control in observational studies; confounding variables poorly measured

#### 3.3 Statistical Adjustment Methods

**Question:** If statistical adjustment was used, were methods appropriate and transparently reported?

**Rating Guidance:**
- **Low Risk:** Appropriate multivariable methods (regression, propensity scores, etc.); model building strategy described; adjustment variables justified; multicollinearity and model assumptions addressed
- **Medium Risk:** Statistical adjustment attempted but limited reporting of methods; model assumptions not verified; adjustment variables selected without clear justification
- **High Risk:** Inappropriate adjustment methods; overfitting concerns (too many variables for sample size); adjustment strategy unclear or unreported

#### 3.4 Randomization Quality (if applicable)

**Question:** If randomization was used, was it properly implemented and concealed?

**Rating Guidance:**
- **Low Risk:** Random sequence generation method specified (computer-generated, random number table); allocation concealment described (sealed envelopes, central randomization); balance achieved across groups
- **Medium Risk:** Randomization stated but method not fully described; allocation concealment unclear; some imbalance but addressed statistically
- **High Risk:** Randomization method unclear or potentially flawed (e.g., alternation); no allocation concealment; evidence of selection bias despite claimed randomization
- **N/A:** Non-randomized study (rate based on other confounding control items)

---

## Domain 4: Attrition/Missing Data

**Purpose:** Evaluate how participant dropout and missing data were handled and whether they could bias results.

### Checklist Items

#### 4.1 Dropout Rates Reported

**Question:** Were participant dropout/loss to follow-up rates clearly reported?

**Rating Guidance:**
- **Low Risk:** Attrition rates reported for all groups at all time points; total dropout percentage clear; flow diagram showing participant retention
- **Medium Risk:** Overall attrition reported but not by group or time point; dropout numbers provided but percentages unclear; some retention information missing
- **High Risk:** Attrition rates not reported or impossible to calculate; discrepancies between reported sample sizes across outcomes; no accounting for missing participants

#### 4.2 Attrition Analysis Provided

**Question:** Was differential attrition analyzed and reported?

**Rating Guidance:**
- **Low Risk:** Comparison of completers vs. dropouts on baseline characteristics; statistical testing for differential attrition across groups; attrition reasons analyzed by group
- **Medium Risk:** Basic description of dropout reasons; limited comparison of completers vs. dropouts; acknowledgment of attrition but minimal analysis
- **High Risk:** No analysis of who dropped out or why; differential attrition concerns not addressed; potential selection bias due to attrition not discussed

#### 4.3 Missing Data Handling Transparency

**Question:** Were missing data handling methods clearly described and appropriate?

**Rating Guidance:**
- **Low Risk:** Missing data mechanism considered (MAR, MCAR, MNAR); appropriate methods used (multiple imputation, maximum likelihood); sensitivity analyses conducted
- **Medium Risk:** Missing data methods stated (e.g., complete case analysis, single imputation) but limited justification; missing data extent reported; basic handling approach documented
- **High Risk:** Missing data handling unclear or not reported; inappropriate methods (listwise deletion with substantial missingness); extent of missing data not quantified

#### 4.4 Differential Attrition Assessment

**Question:** Was differential attrition across groups low enough to minimize bias?

**Rating Guidance:**
- **Low Risk:** Attrition < 10% overall; difference in attrition rates between groups < 5%; attrition unrelated to outcomes based on analysis
- **Medium Risk:** Attrition 10-20% overall; difference in attrition rates between groups 5-10%; some evidence of outcome-related attrition but addressed in sensitivity analysis
- **High Risk:** Attrition > 20% overall; difference in attrition rates between groups > 10%; evidence that attrition related to outcomes; no sensitivity analysis for attrition bias

---

## Domain 5: Reporting Transparency

**Purpose:** Assess whether methodological and statistical details are reported with sufficient completeness to enable reproducibility and evaluation.

### Checklist Items

#### 5.1 Methods Section Completeness

**Question:** Does the methods section provide sufficient detail to replicate the study?

**Rating Guidance:**
- **Low Risk:** Comprehensive methods reporting (design, setting, participants, interventions/exposures, outcomes, sample size, statistical methods); protocol or pre-registration referenced; sufficient detail for replication
- **Medium Risk:** Key methods elements present but some details missing; enough information to understand general approach but not fully replicate; methods adequately described
- **High Risk:** Methods section sparse or vague; critical methodological details missing; insufficient information to evaluate study quality

#### 5.2 Results Reporting Clarity

**Question:** Are results reported completely and clearly, including effect sizes and precision estimates?

**Rating Guidance:**
- **Low Risk:** All outcomes reported (including non-significant); effect sizes and confidence intervals provided; sample sizes for analyses clearly stated; no selective outcome reporting evident
- **Medium Risk:** Primary outcomes reported fully but secondary outcomes incomplete; effect sizes or CIs sometimes missing; mostly complete results with minor omissions
- **High Risk:** Selective outcome reporting suspected; effect sizes or precision estimates frequently missing; p-values reported without effect sizes; results reporting incomplete

#### 5.3 Statistical Details Provided

**Question:** Are statistical analysis methods and assumptions sufficiently documented?

**Rating Guidance:**
- **Low Risk:** Statistical tests clearly specified; assumptions checked and reported; handling of violations described; software/package versions noted; analysis plan transparent
- **Medium Risk:** Statistical methods stated but assumptions not verified; standard analyses described adequately; some analytical details missing; minimal documentation of statistical approach
- **High Risk:** Statistical methods unclear or not reported; inappropriate analyses or assumption violations not addressed; p-values reported without test specifications

#### 5.4 Conflicts of Interest Disclosed

**Question:** Were funding sources and potential conflicts of interest transparently disclosed?

**Rating Guidance:**
- **Low Risk:** Funding sources explicitly stated; author conflicts of interest disclosed; sponsor role in research clarified; transparency statement included
- **Medium Risk:** Funding mentioned but details limited; conflicts of interest statement present but vague; partial disclosure of financial relationships
- **High Risk:** No funding disclosure; no conflict of interest statement; industry funding not acknowledged; potential bias sources not addressed

---

## Overall Quality Synthesis

### Combining Domain Ratings into Overall Quality

After rating each domain, synthesize an **overall quality rating** using these guidelines:

**High Quality:**
- Most domains (4-5 out of 5) rated **Low Risk**
- No domains rated **High Risk**
- Study demonstrates methodological rigor across multiple quality dimensions
- Minor limitations present but do not substantially threaten validity

**Medium Quality:**
- Mix of **Low Risk** and **Medium Risk** domains (e.g., 2-3 Low, 2-3 Medium)
- OR one **High Risk** domain but all others Low Risk
- Study has acceptable quality but notable limitations
- Results should be interpreted with some caution

**Low Quality:**
- Multiple domains (2+) rated **High Risk**
- OR one **critical High Risk domain** (e.g., severe confounding) that undermines validity
- Substantial methodological limitations that threaten validity
- Results should be interpreted with considerable caution or potentially excluded from meta-analysis

### Critical vs. Non-Critical High Risk Domains

Not all High Risk ratings equally threaten validity. Consider:

- **Critical domains** (vary by research question): Confounding control for causal claims, measurement validity for all studies
- **Less critical domains**: Reporting transparency (affects replicability more than validity)

Use judgment in synthesis, considering which domains most affect your research question.

---

## Integration with Data Cards

### Quality Scores YAML Frontmatter Format

When using this checklist during data extraction, record results in the data card's `quality_scores` section:

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

**Key Requirements:**
- `checklist_module` must be `"generic_v1.0"` for this checklist
- Domain scores use lowercase: `"low"`, `"medium"`, `"high"`
- `overall_quality` must be one of: `"high"`, `"medium"`, `"low"`

### Documenting Quality Assessment Justifications

In the data card body (below YAML frontmatter), document your quality assessment ratings with **three-color labeling**:

- 🟢 **Direct evidence:** Quote from paper with page/section reference
- 🟡 **Computed/inferred:** Your reasoning or calculation based on reported information
- 🔴 **Uncertain/missing:** Gaps in reporting or ambiguous information

**Example:**
```markdown
## Quality Assessment Notes

### Selection Bias: Low Risk
- **Sampling:** 🟢 "Participants randomly selected from population registry" (p. 5, Methods)
- **Recruitment:** 🟢 "74% response rate, non-responders similar on age and gender" (p. 6)
- **Criteria:** 🟢 Inclusion/exclusion criteria in Table 1 (p. 6)

### Confounding Control: Medium Risk
- **Baseline:** 🟢 Groups balanced on age, gender (Table 2, p. 8)
- **Adjustment:** 🟡 Regression adjusted for 3 confounders but education level not controlled
- **Concern:** 🔴 Socioeconomic status not measured, potential residual confounding
```

---

## Example Quality Assessment

### Hypothetical Study: "Mindfulness Training for Academic Performance"

**Study Design:** Randomized controlled trial, N=120 university students, mindfulness intervention vs. waitlist control

#### Domain Ratings with Justifications

**Selection Bias: Medium Risk**
- ✅ Sampling: Convenience sample of volunteers from psychology courses (self-selection concerns)
- ✅ Recruitment: Process described ("recruited via course announcements"), but response rate not reported
- ✅ Criteria: Inclusion/exclusion criteria clear (undergraduate students, no meditation experience)
- ⚠️ Issue: Convenience sampling limits generalizability, but appropriate for efficacy trial

**Measurement Validity: Low Risk**
- ✅ Outcome: GPA (objective measure) and validated Academic Self-Efficacy Scale (α = 0.89 in prior studies)
- ✅ Reliability: Internal consistency α = 0.92 for self-efficacy in current sample
- ✅ Blinding: GPA from registrar (objective); self-report measures inherently unblinded but validated
- ✅ Timing: Baseline and 8-week follow-up appropriate for intervention duration

**Confounding Control: Low Risk**
- ✅ Randomization: Computer-generated random sequence, allocation concealment via opaque envelopes
- ✅ Baseline: Groups balanced on GPA, age, gender, prior meditation experience (Table 1)
- ✅ Adjustment: ANCOVA controlling for baseline GPA
- ✅ No evidence of selection bias or baseline imbalances

**Attrition/Missing Data: High Risk**
- ⚠️ Attrition: 25% overall (15/120 students), 30% in intervention group, 20% in control
- ⚠️ Analysis: Completers-only analysis (no ITT analysis), differential attrition not analyzed
- ❌ Missing data: No comparison of completers vs. dropouts, reasons for dropout not reported
- ❌ Critical issue: High differential attrition (10% difference) with no sensitivity analysis

**Reporting Transparency: Low Risk**
- ✅ Methods: Detailed description of intervention, measures, procedures
- ✅ Results: Effect sizes (Cohen's d) and 95% CIs reported for all outcomes
- ✅ Statistics: Analysis methods clearly described, assumptions checked
- ✅ Conflicts: Funding and conflicts of interest disclosed (university internal grant, no conflicts)

#### Overall Quality: Medium

**Synthesis:**
- **Strengths:** Strong measurement, good randomization, transparent reporting
- **Primary concern:** High differential attrition threatens validity of findings
- **Rating rationale:** One High Risk domain (attrition) prevents High Quality rating, but otherwise methodologically sound
- **Recommendation:** Include in meta-analysis but conduct sensitivity analysis excluding studies with >20% differential attrition

**Quality Scores YAML:**
```yaml
quality_scores:
  checklist_module: "generic_v1.0"
  selection_bias: "medium"
  measurement_validity: "low"
  confounding_control: "low"
  attrition_missing_data: "high"
  reporting_transparency: "low"
  overall_quality: "medium"
```

---

## Future Discipline-Specific Modules (Phase 2)

### Planned Specialized Checklists

The generic checklist serves as the MVP baseline. Specialized assessment tools will be added in future releases:

| Module | File Location | Target Disciplines | Status |
|--------|--------------|-------------------|--------|
| **RoB2** | `modules/rob2/rob2_checklist.md` | Medicine, health sciences (RCTs) | Phase 2 |
| **ROBINS-I** | `modules/robins/robins_checklist.md` | Medicine, health sciences (observational) | Phase 2 |
| **Campbell** | `modules/campbell/campbell_checklist.md` | Education, social welfare, criminal justice | Phase 2 |
| **GRADE** | `modules/grade/grade_checklist.md` | Evidence quality rating (all disciplines) | Phase 2 |
| **JBI** | `modules/jbi/jbi_checklist.md` | Qualitative, mixed methods | Phase 2 |

### When to Wait for Specialized Modules vs. Use Generic

**Use Generic Checklist Now If:**
- You need to start your meta-analysis immediately
- Your discipline doesn't have a widely-accepted specialized tool
- You're conducting a cross-disciplinary meta-analysis
- You want a customizable starting point

**Consider Waiting for Specialized Module If:**
- Your discipline has a gold-standard assessment tool (e.g., RoB2 for medical RCTs)
- Journal/funding requirements specify a particular quality assessment framework
- You need compatibility with existing systematic reviews using specialized tools
- Timeline allows waiting for Phase 2 release

**Hybrid Approach:**
- Use generic checklist for initial screening and pilot extraction
- Re-assess with specialized tool when available
- Supplement generic checklist with custom discipline-specific items

---

## Modification Guide for Custom Checklists

### How to Customize This Checklist

This checklist is designed for adaptation to your specific research needs:

**Step 1: Copy and Rename**
```bash
cp modules/generic/generic_quality_checklist.md modules/generic/my_custom_checklist_v1.0.md
```

**Step 2: Update Metadata**
- Change `checklist_module` ID (e.g., `custom_cardiology_v1.0`)
- Update version and creation date
- Document what you modified and why

**Step 3: Modify Domains and Items**
- **Add items:** Insert discipline-specific questions (e.g., blinding of surgeons for surgical trials)
- **Remove items:** Delete questions irrelevant to your study designs (e.g., randomization for observational-only meta-analysis)
- **Reword items:** Adjust language to match your discipline's terminology
- **Adjust rating criteria:** Modify Low/Medium/High definitions for your standards

**Step 4: Update Integration Instructions**
- Ensure YAML format matches your modified domain names
- Update example quality assessment to reflect your changes
- Document how your custom checklist differs from generic

**Step 5: Version Control**
- Commit custom checklist to your Git repository
- Reference custom checklist module ID in all data cards using it
- Track changes across versions for reproducibility

---

## References and Acknowledgments

This generic quality checklist was developed based on widely-accepted research quality frameworks:

- **Cochrane Risk of Bias Tools** (RoB2, ROBINS-I): Inspiration for domain structure
- **CONSORT Statement**: Reporting standards for randomized trials
- **STROBE Statement**: Reporting standards for observational studies
- **Campbell Collaboration**: Quality assessment for social interventions
- **NIH Study Quality Assessment Tools**: Generic quality appraisal approaches

**No endorsement** by these organizations is implied. This is an independent generic adaptation for MAestro.

---

## Changelog

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | 2025-10-20 | Initial release of generic quality assessment checklist | MAestro Development Team |

---

**For questions or feedback on this checklist, please refer to the MAestro documentation or submit an issue to the repository.**
