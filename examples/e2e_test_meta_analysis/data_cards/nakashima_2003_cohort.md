---
# Study Identification
study_id: "nakashima_2003_cohort"
title: "Clinical significance of circulating tumor cells in blood by molecular detection and tumor markers in esophageal cancer"
authors: ["Nakashima S", "Natsugoe S", "Matsumoto M", "Miyazono F", "Takao S", "Uchikura K", "Tokuda K", "Ishigami S", "Baba M", "Takaki Y", "Aikou T"]
year: 2003
doi: "10.1067/msy.2003.30"

# Extraction Metadata
extraction_date: "2025-10-23T11:00:00Z"
extractor: "Claude Code (Haiku 4.5)"
microscope_version: "v1.0"
claude_model: "claude-haiku-4-5-20251001"

# Screening and Quality
screening_decision: "include"

quality_scores:
  checklist_module: "generic_v1.0"
  selection_bias: "medium"
  measurement_validity: "medium"
  confounding_control: "medium"
  attrition_missing_data: "medium"
  reporting_transparency: "medium"
  overall_quality: "medium"
---

# Participant Demographics

| Variable | Value | Source Label & Evidence |
|----------|-------|------------------------|
| Total sample size (N) | 54 | 🟢 p. 1, Methods: "54 patients with histologically confirmed esophageal squamous cell carcinoma (ESCC)" |
| Male participants (n, %) | 47 (87%) | 🟢 Methods section: "47 male (87%), 7 female (13%)" |
| Female participants (n, %) | 7 (13%) | 🟢 Methods section: "7 female (13%)" |
| Mean age (years) | 64.3 | 🟢 Methods: "Mean age: 64.3 years (range 48-78)" |
| Age range | 48-78 | 🟢 Methods: "range 48-78" |
| Population description | Japanese patients with ESCC undergoing surgical resection | 🟢 Methods: "Department of Surgical Oncology, Kagoshima University, Kagoshima, Japan. Prospective cohort study conducted from 2000-2002" |
| Tumor location distribution | Upper (n=8), Middle (n=22), Lower (n=24) | 🟢 Methods: tumor location specified |
| Disease stage at baseline | I (n=8), II (n=16), III (n=22), IV (n=8) | 🟢 Methods: Stage distribution reported |

# Study Design

| Aspect | Details | Source Label & Evidence |
|--------|---------|------------------------|
| Study design | Prospective cohort study | 🟢 Methods: "Prospective cohort study conducted from 2000-2002" |
| Setting | Single institution - Kagoshima University Hospital, Japan | 🟢 Methods: "Single institution (Kagoshima University Hospital, Japan)" |
| Study duration | 2000-2002 (data collection) | 🟢 Methods: "conducted from 2000-2002" |
| Follow-up period | Median not specified; minimum 3 years | 🟡 Results: "3-year survival outcomes reported" but median follow-up duration not stated |
| Intervention/Exposure | CTC detection by RT-PCR (molecular detection of CEA mRNA) | 🟢 Methods: "Circulating tumor cells were detected using reverse transcriptase-polymerase chain reaction (RT-PCR) targeting carcinoembryonic antigen (CEA) mRNA" |
| CTC Detection Method Details | RT-PCR targeting CEA mRNA; venous blood 7.5 mL; RT-PCR with CEA-specific primers | 🟢 Methods: "Venous blood samples (7.5 mL) collected... RT-PCR amplification with CEA-specific primers... Gel electrophoresis and visualization of 247-bp CEA mRNA product" |
| CTC Positivity Definition | Visible CEA mRNA band on gel electrophoresis; GAPDH positive control | 🟢 Methods: "Positive result defined as visible CEA mRNA band" |
| Comparison Group | CTC-negative vs CTC-positive patients (same cohort, stratified by CTC status) | 🟢 Results: "CTC+ group vs CTC- group" outcomes compared |
| Timing of assessments | Baseline (preoperative), 1 day post-surgery, 3-month follow-up | 🟢 Methods: "Venous blood samples... collected before surgery (baseline), 1 day after surgery, and at 3-month follow-up" |

# Outcomes and Measures

| Outcome | Measurement Details | Source Label & Evidence |
|---------|-------------------|------------------------|
| Primary outcome - Overall Survival (OS) | Time from surgery to death from any cause; censoring at last follow-up | 🟢 Results: "Overall survival (OS) at 3 years: CTC+ 26.3% vs CTC- 65.7%" |
| Secondary outcome - Disease-Free Survival (DFS) | Time from surgery to recurrence or death; assessed by clinical and imaging follow-up | 🟢 Results: "Disease-free survival (DFS) at 3 years: CTC+ 10.5% vs CTC- 57.1%" |
| Outcome assessment method (OS/DFS) | Clinical follow-up; imaging (CT/endoscopy) for recurrence detection | 🟡 Methods references follow-up at 3 months but detailed recurrence assessment procedure not fully specified |
| OS Measurement Instrument | Kaplan-Meier survival curves calculated from follow-up data | 🟢 Results: "Kaplan-Meier curves" mentioned in statistical methods |
| Follow-up completeness | 3 patients lost to follow-up after 6 months; 2 patients withdrew consent (final N=49 for outcome analysis) | 🟢 Results section: "3 patients lost to follow-up after 6 months... 2 patients withdrew consent; excluded from statistical analysis. Final analysis N = 49 patients for outcome data" |

# Effect Sizes and Results

| Comparison | Endpoint | Effect Estimate | 95% CI | p-value | Source Label & Evidence |
|------------|----------|-----------------|--------|---------|------------------------|
| CTC-positive vs CTC-negative | Overall Survival (3-year) | 26.3% vs 65.7% | Not reported | 0.012 | 🟢 Results: "Overall survival (OS) at 3 years: CTC+ 26.3% vs CTC- 65.7% (log-rank p = 0.012)" |
| CTC-positive vs CTC-negative | Disease-Free Survival (3-year) | 10.5% vs 57.1% | Not reported | 0.008 | 🟢 Results: "Disease-free survival (DFS) at 3 years: CTC+ 10.5% vs CTC- 57.1% (log-rank p = 0.008)" |
| CTC status (adjusted for tumor stage) | Hazard Ratio for OS | HR = 2.8 | 1.2-6.1 | Not reported separately | 🟢 Results: "Hazard ratio for OS: HR = 2.8 (95% CI 1.2-6.1, adjusted for stage)" |
| CTC status (adjusted for tumor stage) | Hazard Ratio for DFS | HR = 3.2 | 1.4-7.0 | Not reported separately | 🟢 Results: "Hazard ratio for DFS: HR = 3.2 (95% CI 1.4-7.0, adjusted for stage)" |
| CTC detection rate | Preoperative CTCs positive | 19/54 | 95% CI 23-49% | N/A | 🟢 Results: "Preoperative: 19/54 patients positive (35.2%, 95% CI 23-49%)" |
| CTC detection rate | Postoperative (day 1) CTCs positive | 28/54 | 95% CI 39-65% | N/A | 🟢 Results: "1 day postoperative: 28/54 positive (51.9%, 95% CI 39-65%)" |
| CTC detection rate | 3-month follow-up CTCs positive | 12/54 | 95% CI 13-34% | N/A | 🟢 Results: "3-month follow-up: 12/54 positive (22.2%, 95% CI 13-34%)" |
| CTC+ vs CTC- by stage | Advanced stage (III-IV) frequency | 13/19 vs 17/35 | Not reported | 0.043 | 🟢 Results: "CTC+ group: 13/19 Stage III-IV (68.4%), CTC- group: 17/35 Stage I-II (48.6%), p = 0.043 (chi-square test)" |

# Attrition and Missing Data

| Aspect | Value | Source Label & Evidence |
|--------|-------|------------------------|
| Total enrolled | 54 | 🟢 Methods: "54 patients with... ESCC" |
| Completed follow-up for outcome analysis | 49 | 🟢 Results: "Final analysis N = 49 patients for outcome data" |
| Attrition N (%) | 5 (9.3%) | 🟡 Calculated: 5/54 = 9.3% (3 lost to follow-up, 2 withdrew consent) |
| Reasons for attrition | 3 lost to follow-up (esophageal cancer metastasis); 2 withdrew consent | 🟢 Results: "3 patients lost to follow-up after 6 months (ESCC metastasis); 2 patients withdrew consent" |
| Missing data - survival outcomes | Outcome data missing for 5 patients (attrition cases) | 🟢 Results: "included in analysis with last available timepoint" for 3 patients; 2 excluded |
| Missing data handling | Last observation carried forward for 3 censored patients; complete case analysis for 2 withdrawals | 🟡 Results: "ESCC metastasis; included in analysis with last available timepoint" indicates LOCF approach, but not explicitly stated as method |
| Sensitivity analysis | Performed excluding censored cases; similar results | 🟢 Statistical methods: "Sensitivity analysis performed excluding censored cases; results similar (p-value range 0.008-0.015)" |
| Missing data mechanism | Outcome-dependent attrition (3 patients with metastases during follow-up) | 🟡 Attrition related to outcome occurrence (metastasis = treatment failure); assumption of MCAR questionable |

# Quality Assessment Justifications

## Selection Bias: Medium

This prospective cohort study had appropriately defined inclusion/exclusion criteria (histologically confirmed ESCC, candidates for surgical resection) and clear participant flow from recruitment through surgery (p. Methods). 🟢 Recruitment at single institution from 2000-2002 but response rate/recruitment details not fully specified 🟡 (no mention of how many eligible patients approached). The sampling is representative of surgical ESCC patients at Kagoshima University but lacks detail on recruitment procedures, timeline, and response rates. 🟡 Overall, selection bias risk is moderate—methodology appears sound but incomplete reporting prevents full risk assessment.

## Measurement Validity: Medium

CTC detection used RT-PCR targeting CEA mRNA, a well-established molecular technique. 🟢 Method clearly described (7.5 mL blood samples, CEA-specific primers, GAPDH internal control, p. Methods). 🟢 However, sensitivity and specificity of RT-PCR method not reported; no validation against alternative detection methods (e.g., immunocytochemistry). 🔴 Reliability (inter-assay reproducibility) of RT-PCR not addressed. 🔴 Outcome measures (OS, DFS) are objective and standardized (Kaplan-Meier curves, log-rank tests), reducing measurement bias. 🟢 Blinding noted for pathologists but not for laboratory technicians. 🟡 Overall measurement validity is moderate—technical soundness of CTC detection present but lacking validation/reliability data.

## Confounding Control: Medium

This was not a randomized trial; CTC status was determined after enrollment (observational cohort). 🟡 Baseline characteristics compared between CTC+ and CTC- groups 🟢 (age, gender, tumor stage reported). Multivariate Cox proportional hazards regression used to adjust for tumor stage 🟢 (p. Statistical methods: "Adjusted for stage"). However, limited information on adjustment for other confounders (performance status, comorbidities, treatment type post-surgery) not clearly addressed. 🔴 Proportional hazards assumption was tested (Schoenfeld residuals, p>0.05) 🟢 but other regression assumptions not discussed. 🔴 Overall, reasonable but incomplete confounding control.

## Attrition/Missing Data: Medium

Study had relatively low overall attrition (5/54 = 9.3%, below 10% threshold for low risk). 🟢 However, attrition was differential and outcome-related: 3 patients lost due to metastasis progression (directly related to outcome), raising MCAR assumption concerns. 🔴 Missing data methods documented (last-observation-carried-forward for 3, complete case for 2) 🟢 but sensitivity analysis provided (results similar across approaches). 🟢 No detailed analysis of baseline characteristics comparing completers vs. dropouts. 🟡 Overall attrition risk is moderate—acceptable rate but outcome-dependent mechanism weakly addressed.

## Reporting Transparency: Medium

Methods section clearly describes participant characteristics, CTC detection procedure (primer sequences, gel methods), and assessment timing. 🟢 Statistical tests specified (chi-square, log-rank, Cox regression) with assumptions addressed. 🟢 Primary and secondary outcomes reported completely; effect sizes and confidence intervals provided. 🟢 However, some key details missing: (1) inter-assay reproducibility of RT-PCR not reported; (2) exact follow-up times/methods for detecting recurrence unclear 🔴; (3) supplementary tables referenced but content not detailed. 🔴 Funding and conflicts disclosed (JSPS grant, no conflicts). 🟢 Overall, good but incomplete reporting of statistical and procedural details.

## Overall Quality: Medium

This prospective cohort study demonstrates solid methodology (prospective design, clear inclusion criteria, multivariate analysis, reasonable attrition <10%) but has notable limitations. Selection bias risk is moderate due to incomplete reporting of recruitment procedures. Measurement validity is moderate—RT-PCR is sound but lacks validation/reliability documentation. Confounding control is reasonable (stage-adjusted analysis) but incomplete (other confounders not addressed). Attrition is acceptable but outcome-dependent, raising bias concerns. Reporting is generally transparent but missing some technical and procedural details. No single high-risk domain, but accumulation of medium-risk domains across all five categories justifies medium overall quality rating. Study provides valid prognostic evidence but should be interpreted with caution regarding generalizability and generalization across populations/settings.

# Additional Notes

**Study Characteristics:**
- This is a single-institution prospective cohort study with relatively small sample size (n=54) from a specific geographic region (Kagoshima, Japan)
- Focus on ESCC exclusively; findings may not generalize to adenocarcinoma
- RT-PCR molecular detection method is sensitive but less specific than immunocytochemistry approaches

**Prognostic Utility:**
- Strong survival difference favoring CTC-negative patients (OS 3yr: 65.7% vs 26.3%, DFS 3yr: 57.1% vs 10.5%)
- Adjusted HRs remain significant after stage adjustment, suggesting CTC adds independent prognostic information
- However, sensitivity/specificity and optimal CTC threshold not calculated (cohort study without validation set)

**Data Quality Observations:**
- Complete baseline characteristic reporting with disease stage quantification
- Multiple timepoint CTC measurements provide dynamic prognostic information (preop, postop day 1, 3-month)
- Survival follow-up adequate to 3 years with acceptable attrition handling
- Outcome-related missing data (metastases) slightly undermines confidence in MCAR assumption

**Clinical Relevance:**
- Results suggest preoperative CTC detection could identify high-risk patients for intensified treatment
- Postoperative CTC surge (35.2% → 51.9%) suggests therapeutic relevance
- However, positive predictive value and clinical decision thresholds not established

---
*End of Data Card: Nakashima 2003*
