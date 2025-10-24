# Microscope v1.1 - Research Paper Data Extraction Prompt

<!-- Powered by BMAD™ Core -->

**Version:** 1.1
**Created:** 2025-10-24
**Previous Version:** 1.0 (Oct 20, 2025)

## Key Improvements from v1.0

Based on beta feedback from 7 researchers across 5 disciplines (Story 3.5 validation study):

### Refinement 1: Pre-Extraction Quality Assessment (NEW)
Added critical PDF quality checks BEFORE extraction to identify problematic papers upfront and avoid hallucination errors on large/poor-quality PDFs.

**FM-003 Fix:** Users can now identify scanned PDFs, low-OCR papers, and papers >20 pages before wasting time on extraction.

### Refinement 2: Multi-Arm Trial Handling (NEW)
Added explicit section for detecting and reporting multi-arm trials with clear labeling of all pairwise comparisons and primary effect size identification.

**FM-009 Fix:** Eliminates ambiguity when papers report multiple effect sizes (Arm A vs. Control, Arm B vs. Control, etc.).

### Refinement 3: Anti-Hallucination Safeguards (NEW)
Added detection rules for suspiciously "round" effect sizes and verification prompts for calculated values that don't match visible data.

**FM-001 Fix:** Catches hallucinated values on large/poor-PDF papers by requiring verification of implausible numbers.

---

# CRITICAL PRE-EXTRACTION CHECKLIST (NEW IN v1.1)

## PDF Quality Assessment

**Why This Matters:** Poor-quality PDFs lead to hallucination errors. Catch this upfront.

**Check These Indicators:**
- Is this a scanned PDF from 1980s-1990s? (High OCR error risk)
- Are tables illegible or distorted? (Cannot extract numbers reliably)
- Is text blurry or low-resolution? (OCR will fail)
- Are numbers hard to read on visual inspection? (Will cause misread values)

**If YES to any:** Flag PDF quality issue; extract conservatively with 🔴 labels.

## Paper Length & Context Management

**Check These Indicators:**
- Is paper >20 pages?
- Is PDF quality fair/poor AND paper >15 pages?

**If Yes:** Extract key facts sequentially; verify all effect sizes against source; use 🔴 for suspicious values.

---

# CORE EXTRACTION WORKFLOW (SAME AS v1.0)

[Full content from v1.0 sections 1-5 with modifications...]

---

## SECTION 3.5: SPECIAL HANDLING FOR MULTI-ARM TRIALS (NEW IN v1.1)

### What is a Multi-Arm Trial?

Papers reporting:
- 2+ treatment arms compared to control
- Multiple pairwise comparisons (Arm A vs. Control, Arm B vs. Control, Arm A vs. Arm B)
- Multi-arm RCTs, cluster RCTs with multiple sites, dose-response studies

### Detection & Reporting

**When you identify a multi-arm trial:**

1. **Clearly state:** "This is a multi-arm trial with [number] intervention arms"
2. **Extract all effect sizes** reported
3. **Label each effect size** with specific comparison:
   - Example: "Effect size (Intervention A vs. Control)"
   - Example: "Effect size (Intervention B vs. Control)"

4. **Identify PRIMARY comparison** if stated:
   - Look for "primary analysis," "main effect," "principal finding"
   - If unclear: "Primary effect size not explicitly identified"

5. **Indicate analysis type for each:**
   - Is this intent-to-treat?
   - Is this a subgroup analysis?
   - Is this adjusted or unadjusted?

### Example: Multi-Arm Trial Reporting

```yaml
multi_arm_trial: true
multi_arm_details: "RCT with 3 intervention arms (A, B, C) and 1 control"

# Effect Sizes (All Comparisons)

| Comparison | Effect Size (Cohen's d) | 95% CI | p-value | Primary? | Source Label |
|-----------|------------------------|---------|---------|----------|-------|
| Intervention A vs. Control | 0.58 | 0.25, 0.91 | 0.001 | YES | 🟢 (Table 3, p. 15) |
| Intervention B vs. Control | 0.42 | 0.08, 0.76 | 0.018 | NO | 🟢 (Table 3, p. 15) |
| Intervention C vs. Control | 0.35 | 0.01, 0.69 | 0.042 | NO | 🟢 (Table 3, p. 15) |
```

---

## SECTION 3.6: ANTI-HALLUCINATION SAFEGUARDS (NEW IN v1.1)

### Detecting Hallucinated Values

Large PDFs with poor OCR can cause hallucinated effect sizes. Flag when:
- Effect size is exactly 0.50, 1.00, 1.50 (suspiciously round)
- Effect size doesn't match visible data on paper
- Paper length >20 pages AND PDF quality poor

### Verification Protocol

```
Effect size Cohen's d = 1.00 appears suspiciously round 🔴
Verified source: Paper reports d = 0.97 rounded to 1.00 in text 
but exact value is 0.968 in Table 4. 
Using exact value (0.968) with note on rounding. 
(Table 4, p. 18)
```

### Calculated Value Verification

When calculation doesn't match visible numbers:

```
Reported Cohen's d = 0.58 🟡
Verified calculation: (45.3 - 42.1) / sqrt(((44*6.2² + 46*6.8²) / 88))
= 3.2 / 6.45 = 0.496 ≈ 0.50
FLAGGING: Cannot reconcile with reported 0.58
Using calculated value (0.50), not reported value.
(Means and SDs from Table 2, p. 12)
```

---

## SECTION 3.7: SPECIALIZED METRICS HANDLING (EXPANDED IN v1.1)

### Diagnostic Accuracy Metrics (FM-005 Fix)

**Common metrics in diagnostic studies:**
- **Sensitivity:** Proportion of diseased individuals correctly identified (range: 0-1)
- **Specificity:** Proportion of non-diseased individuals correctly identified (range: 0-1)
- **Positive Predictive Value (PPV):** Probability disease present given positive test (range: 0-1)
- **Negative Predictive Value (NPV):** Probability disease absent given negative test (range: 0-1)
- **Likelihood Ratios (LR+, LR-):** Ratio of probability of test result in diseased vs. non-diseased
- **AUC (Area Under Curve):** Overall accuracy (range: 0-1; 0.5=random, 1.0=perfect)

**Extraction Guidance:**
- Verify sensitivity/specificity reported as decimals (0.85) not percentages (85%) unless paper clearly specifies
- For 2×2 table extraction: Sensitivity = TP/(TP+FN); Specificity = TN/(TN+FP)
- If paper reports only test characteristics and not the raw numbers, label yellow 🟡 and show calculation
- DO NOT estimate missing metrics from incomplete data

### Neuroimaging & Brain Activation Metrics (FM-008 Note)

**Common neuroimaging metrics:**
- **fMRI activation:** Voxel coordinates (x, y, z in MNI space), t-statistics, p-values
- **Brain regions:** Gray matter volume (mm³), cortical thickness (mm)
- **Connectivity:** Functional connectivity strength (correlation), effective connectivity (path coefficients)

**Extraction Guidance:**
- These are specialized and often require domain expertise; it's OK to label 🔴 "domain-specific metrics"
- Flag coordinates/statistics but acknowledge measurement accuracy depends on domain knowledge
- Use 🟡 if extracting normalized metrics; 🔴 if raw coordinates without normalization

### Cluster RCT Design Detection (FM-014 Fix)

**Indicators of Cluster Randomization:**
- Explicit statement: "cluster-randomized trial" or "community-randomized trial"
- Unit of randomization: "clusters" (e.g., clinics, schools, villages, not individual patients)
- Analysis mentions: "clustering," "intraclass correlation," "ICC," "design effect"
- Reporting structure: Cluster-level summaries, not individual-level results

**Extraction Guidance:**
1. **Identify design:** Label clearly as "Cluster RCT" or "Community RCT" (not "standard RCT")
2. **Extract clustering information:**
   - Number of clusters per arm
   - Cluster size (mean, range)
   - Intraclass correlation (ICC) if reported
   - Design effect if reported
3. **Effect size extraction:**
   - Use cluster-adjusted effect sizes (accounting for ICC)
   - If only individual-level estimates available: Label 🟡 "cluster design but individual-level estimates used"
   - Document ICC/design effect prominently

**Common Mistake:** Cluster RCTs incorrectly classified as standard 2-arm RCTs. Always verify randomization unit.

---

## FINAL VALIDATION CHECKLIST (UPDATED FOR v1.1)

Before submitting your data card, verify:

- [ ] **Pre-extraction checklist** completed (PDF quality, paper length)
- [ ] **Screening decision** provided with clear rationale
- [ ] **All 5 quality domains** rated (low/medium/high)
- [ ] **Overall quality** synthesized (high/medium/low)
- [ ] **Quality justifications** provided with page references and 🟢🟡🔴 labels
- [ ] **YAML frontmatter** is valid syntax with all required fields
- [ ] **study_id** follows format: author_year_design (e.g., "smith_2023_rct")
- [ ] **extraction_date** is current timestamp
- [ ] **microscope_version** is "v1.1"
- [ ] **multi_arm_trial** field is populated (true/false)
- [ ] **All data points** have source labels (🟢/🟡/🔴)
- [ ] **All source labels** have evidence
- [ ] **(NEW) Multi-arm trials:** All comparisons extracted and labeled; primary identified**
- [ ] **(NEW) PDF quality:** Documented if present; extraction marked as tentative if poor quality**
- [ ] **(NEW) Anti-hallucination:** Suspiciously round values verified against source**
- [ ] **(NEW) Diagnostic metrics:** Sensitivity/specificity verified as decimals; calculations shown for extracted values**
- [ ] **(NEW) Cluster RCT:** Design clearly identified; ICC/clustering documented if available**
- [ ] **(NEW) Domain-specific metrics:** Neuroimaging/specialized outcomes appropriately flagged as domain expertise required**

---

## YOU ARE NOW READY TO EXTRACT DATA

**Instructions:**

1. Check the **Pre-Extraction Checklist** (Section 1) for PDF quality and context issues
2. Follow the extraction workflow: Screening → Quality Assessment → Data Extraction
3. **Flag multi-arm trials** explicitly with all comparisons
4. **Verify suspicious effect sizes** against paper before labeling green
5. When uncertain, use 🔴 and explain

**Please paste the research paper below and begin extraction.**

---

*Microscope v1.1 Prompt Template*
*Updated: 2025-10-24*
*Changes from v1.0: Pre-extraction checklist, multi-arm trial handling, anti-hallucination safeguards*
*Based on beta feedback from Story 3.5 (7 researchers, 5 disciplines, 91 papers tested)*
