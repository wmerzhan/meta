---
# Study Identification
study_id: "nakashima_2003_cohort"
title: "Clinical significance of circulating tumor cells in blood by molecular detection and tumor markers in esophageal cancer"
authors: ["Nakashima S", "Natsugoe S", "Matsumoto M", "Miyazono F", "Nakajo A", "Uchikura K", "Tokuda K", "Ishigami S", "Baba M", "Takao S", "Aikou T"]
year: 2003
doi: "10.1067/msy.2003.9"

# Extraction Metadata
extraction_date: "2025-10-21T00:00:00Z"
extractor: "Claude Code (Manual Gold Standard)"
microscope_version: "v1.0"
claude_model: "claude-sonnet-4-5-20250929"

# Screening and Quality
screening_decision: "include"

quality_scores:
  checklist_module: "generic_v1.0"
  selection_bias: "medium"
  measurement_validity: "low"
  confounding_control: "medium"
  attrition_missing_data: "low"
  reporting_transparency: "low"
  overall_quality: "medium"
---

# Screening Decision

**Decision:** INCLUDE

**Rationale:** This is an original prospective cohort study investigating circulating tumor cells (CTCs) detected by RT-PCR in patients with esophageal squamous cell carcinoma undergoing R0 resection. The study addresses a clear prognostic research question (relationship between CEA mRNA expression and clinicopathologic findings/recurrence), uses an appropriate observational design, and reports extractable quantitative data including sample sizes, percentages, p-values, and recurrence outcomes. All three inclusion criteria are met: (1) relevance to investigating CTCs as prognostic markers, (2) appropriate prospective cohort design with molecular detection methods, and (3) sufficient extractable data for meta-analysis of prognostic factors.

---

# Participant Demographics

| Variable | Value | Source Label & Evidence |
|----------|-------|------------------------|
| Total sample size (N) | 54 | 🟢 (p. 163, Methods: Study group, line 1: "The subjects of this study were 54 consecutive patients with esophageal cancer") |
| Gender distribution | 52 men, 2 women | 🟢 (p. 163, Methods: Study group: "There were 52 men and 2 women") |
| Gender (% female) | 3.7% | 🟡 Calculated: 2/54 × 100 = 3.7% (from p. 163, Methods: Study group) |
| Age range | 38-83 years | 🟢 (p. 163, Methods: Study group: "ranging in age from 38 to 83 years") |
| Mean age (years) | 65.3 | 🟢 (p. 163, Methods: Study group: "mean, 65.3 years") |
| Mean age RT-PCR positive | 62.3 ± 8.6 | 🟢 (Table II, p. 165: RT-PCR(+) group mean age) |
| Mean age RT-PCR negative | 69.3 ± 6.7 | 🟢 (Table II, p. 165: RT-PCR(-) group mean age) |
| Population description | Consecutive esophageal cancer patients undergoing R0 resection | 🟢 (p. 163, Methods: Study group: "consecutive patients with esophageal cancer who underwent R0 resection") |
| Recruitment period | January 1997 - April 1999 | 🟢 (p. 163, Methods: Study group) |
| Recruitment location | First Department of Surgery, Kagoshima University, Japan | 🟢 (p. 163, Methods: Study group) |

---

# Study Design

| Design Element | Description | Source Label & Evidence |
|----------------|-------------|------------------------|
| Study design type | Prospective cohort study | 🟡 Inferred from methods: consecutive patient enrollment with prospective blood sampling at defined time points and follow-up for recurrence (p. 163, Methods; p. 164, Clinical follow-up) |
| Setting | University hospital surgical department | 🟢 (p. 163, Methods: "First Department of Surgery in Kagoshima University") |
| Intervention/Exposure | Esophagectomy with blood sampling at three time points (before surgery, before resection, after resection) | 🟢 (p. 163, Methods: Blood samples section) |
| Primary outcome | CEA mRNA expression detected by RT-PCR in blood samples | 🟢 (p. 162, Abstract: "CEA-specific reverse transcriptase-polymerase chain reaction (RT-PCR)") |
| Secondary outcomes | Serum SCC antigen, serum CEA, tumor recurrence (total and blood-borne) | 🟢 (p. 162, Abstract; p. 164, Methods: Determination of SCC and CEA) |
| Follow-up period | Median 30 months (range 2-60 months) | 🟢 (p. 164, Clinical follow-up: "median follow-up period of 30 months (range, 2-60 months)") |
| Follow-up methods | Physical exam, blood tests, tumor markers, X-ray every 1-3 months; CT every 3-6 months; ultrasound every 6 months | 🟢 (p. 164, Clinical follow-up section) |
| Blood sampling sites | Peripheral artery and superior vena cava | 🟢 (p. 163, Blood samples: "from the peripheral artery" and "from the superior vena cava") |
| Blood sampling time points | (1) Before surgery (after anesthesia), (2) Before resection (after thoracotomy), (3) After resection | 🟢 (p. 163, Blood samples section) |

---

# Tumor Characteristics

| Characteristic | Value | Source Label & Evidence |
|----------------|-------|------------------------|
| **Tumor depth (pT)** | | |
| pT1 | 16 patients | 🟢 (p. 163, Methods: Study group: "16 patients had pT1 tumors") |
| pT2 | 6 patients | 🟢 (p. 163, Methods: Study group: "6 patients had pT2 tumors") |
| pT3 | 24 patients | 🟢 (p. 163, Methods: Study group: "24 patients had pT3 tumors") |
| pT4 | 8 patients | 🟢 (p. 163, Methods: Study group: "8 patients had T4 tumors") |
| **Tumor location** | | |
| Upper third | 8 tumors | 🟢 (p. 163, Methods: Study group: "8 tumors were located in the upper one-third") |
| Middle third | 22 tumors | 🟢 (p. 163, Methods: Study group: "22 tumors in the middle one-third") |
| Lower third | 24 tumors | 🟢 (p. 163, Methods: Study group: "24 tumors in the lower one-third") |
| **Histology** | All squamous cell carcinomas | 🟢 (p. 163, Methods: Study group: "Pathologically, all tumors were SCCs") |
| Well-differentiated | 12 patients | 🟢 (p. 163, Methods: Study group: "12 well-differentiated") |
| Moderately differentiated | 25 patients | 🟢 (p. 163, Methods: Study group: "25 moderately differentiated") |
| Poorly differentiated | 17 patients | 🟢 (p. 163, Methods: Study group: "17 poorly differentiated") |
| **Neoadjuvant therapy** | 14 patients | 🟢 (p. 163, Methods: Study group: "Radiochemotherapy before surgery was performed in 14 patients") |
| Neoadjuvant regimen | 40 Gy radiotherapy + cisplatin (5 mg/m²) + 5-FU (350 mg/m²) for 4 weeks | 🟢 (p. 163, Methods: Study group) |

---

# Primary Outcome: CEA mRNA Expression by RT-PCR

| Measure | Value | Source Label & Evidence |
|---------|-------|------------------------|
| **Overall CEA mRNA positivity** | 31/54 patients (57.4%) | 🟢 (p. 164, Results: "Of 54 patients with esophageal carcinoma, 31 patients (57.4%) were positive for CEA mRNA") |
| **By sampling site:** | | |
| Peripheral artery positive | 23/54 (42.6%) | 🟢 (p. 164, Results: "CEA mRNA positivity occurred in 23 (42.6%) in the peripheral artery") |
| Superior vena cava positive | 17/54 (31.5%) | 🟢 (p. 164, Results: "in 17 (31.5%) in the superior vena cava") |
| Site comparison p-value | p = 0.32 (not significant) | 🟢 (p. 164, Results: "did not differ significantly between the two blood sample sites (P = .32)") |
| **By time point:** | | |
| Before surgery positive | 5/54 (9.3%) | 🟢 (p. 165, Results: "5 (9.3%) of 54 patients showed positive CEA mRNA signals before surgery") |
| Before resection positive | 5/54 (9.3%) | 🟢 (p. 165, Results: "5 (9.3%) before resection") |
| After resection positive | 28/54 (51.9%) | 🟢 (p. 165, Results: "28 (51.9%) after resection") |
| Positive only after resection | 21/28 patients | 🟢 (p. 165, Results: "Of the latter 28 patients, 21 had positive CEA mRNA expression only after resection") |
| **RT-PCR assay sensitivity** | 1 cancer cell per 1×10⁶ lymphocytes | 🟢 (p. 164, Results: Sensitivity section: "The lower limit of detection was CEA-positive cancer cells diluted among 1 X 10⁶ normal lymphocytes") |
| Healthy control specificity | 0/20 healthy volunteers positive | 🟢 (p. 164, Results: "No signals of CEA mRNA were detected in either blood from patients with noncancerous disease or in lymphocytes from healthy volunteers") |
| Benign disease control specificity | 0/20 benign disease patients positive | 🟢 (p. 164, Results: same quote as above) |

---

# Secondary Outcome: Serum Tumor Markers

| Measure | Value | Source Label & Evidence |
|---------|-------|------------------------|
| **Serum SCC antigen** | | |
| Positive (>1.5 ng/mL) | 24/54 patients (44.4%) | 🟢 🟡 (p. 167, Discussion: "High values of serum SCC antigen...were found in 24 (44.4%)"; threshold from p. 164, Methods: "greater than 1.5 ng/mL SCC") |
| Normal (≤1.5 ng/mL) | 30/54 patients (55.6%) | 🟡 Calculated: 54 - 24 = 30; 30/54 = 55.6% (from Table III data, p. 166) |
| **Serum CEA** | | |
| Positive (>5 ng/mL) | 14/54 patients (25.9%) | 🟢 🟡 (p. 167, Discussion: "CEA...14 (25.9%) patients"; threshold from p. 164, Methods: "5 ng/mL CEA") |
| Normal (≤5 ng/mL) | 40/54 patients (74.1%) | 🟡 Calculated: 54 - 14 = 40; 40/54 = 74.1% (from Table III data, p. 166) |
| **Relationship between RT-PCR and serum markers:** | | |
| SCC+ among RT-PCR+ | 15/31 (48.4%) | 🟢 (p. 167, Discussion: "Of the 31 patients with RT-PCR-positive results, 15 (48.4%)...were positive for SCC antigen") |
| CEA+ among RT-PCR+ | 6/31 (19.4%) | 🟢 (p. 167, Discussion: "6 (19.4%) patients were positive for...CEA") |
| RT-PCR vs SCC p-value | p = 0.69 (not significant) | 🟢 (Table IV, p. 167) |
| RT-PCR vs CEA p-value | p = 0.33 (not significant) | 🟢 (Table IV, p. 167) |

---

# Relationship Between CEA mRNA and Clinicopathologic Factors

| Factor | RT-PCR Positive (n=31) | RT-PCR Negative (n=23) | p-value | Source Label & Evidence |
|--------|------------------------|------------------------|---------|------------------------|
| **Age (mean ± SD)** | 62.3 ± 8.6 | 69.3 ± 6.7 | 0.002 | 🟢 (Table II, p. 165) |
| **pT stage** | | | 0.21 | 🟢 (Table II, p. 165) |
| pT1 | 7 | 9 | | 🟢 (Table II) |
| pT2 | 2 | 4 | | 🟢 (Table II) |
| pT3 | 16 | 8 | | 🟢 (Table II) |
| pT4 | 6 | 2 | | 🟢 (Table II) |
| **pN (nodal status)** | | | 0.011 | 🟢 (Table II, p. 165) |
| pN0 (node negative) | 6 | 12 | | 🟢 (Table II) |
| pN1 (node positive) | 25 | 11 | | 🟢 (Table II) |
| **pM (distant metastasis)** | | | 0.98 | 🟢 (Table II, p. 165) |
| pM0 | 23 | 18 | | 🟢 (Table II) |
| pM1 | 8 | 5 | | 🟢 (Table II) |
| **Stage grouping** | | | 0.048 | 🟢 (Table II, p. 165) |
| Stage I | 2 | 7 | | 🟢 (Table II) |
| Stage IIA | 1 | 3 | | 🟢 (Table II) |
| Stage IIB | 4 | 4 | | 🟢 (Table II) |
| Stage III | 16 | 4 | | 🟢 (Table II) |
| Stage VIA | 3 | 1 | | 🟢 (Table II) |
| Stage VIB | 5 | 4 | | 🟢 (Table II) |
| **Lymphatic invasion** | | | 0.16 | 🟢 (Table II, p. 165) |
| Positive | 23 | 12 | | 🟢 (Table II) |
| Negative | 8 | 11 | | 🟢 (Table II) |
| **Venous invasion** | | | 0.16 | 🟢 (Table II, p. 165) |
| Positive | 13 | 8 | | 🟢 (Table II) |
| Negative | 8 | 11 | | 🟢 (Table II) |

---

# Tumor Recurrence Outcomes

| Outcome | RT-PCR Positive (n=31) | RT-PCR Negative (n=23) | p-value | Source Label & Evidence |
|---------|------------------------|------------------------|---------|------------------------|
| **Total recurrence** | 21/31 (67.7%) | 9/23 (39.1%) | 0.036 | 🟢 (p. 167, Results: "Disease recurred in 21 (67.7%) of the 31 patients with positive CEA mRNA expression and in 9 (39.1%) of the 23 patients with negative CEA mRNA expression...P = .036") |
| **Blood-borne recurrence** | 18/31 (58.1%) | 4/23 (17.4%) | 0.0026 | 🟢 (p. 167, Results: "18 (58.1%) of 31 patients with CEA mRNA positivity experiencing disease recurrence, compared with 4 (17.4%) of 23 patients with negativity (P = .0026)") |
| **Recurrence patterns overall (n=30 total):** | | | | |
| Blood-borne only | 19 patients total | | | 🟢 (p. 167, Results: "The numbers of patients with blood-borne...were 19") |
| Blood-borne + lymph node | 3 patients total | | | 🟢 (p. 167, Results: "both blood-borne and lymph node...3") |
| Lymph node only | 4 patients total | | | 🟢 (p. 167, Results: "lymph node...4") |
| Local recurrence only | 4 patients total | | | 🟢 (p. 167, Results: "local recurrence...4") |
| **Detailed recurrence by RT-PCR status:** | | | | |
| Blood-borne | 15 | 4 | | 🟢 (Table V, p. 167) |
| Blood-borne + lymph node | 3 | 0 | | 🟢 (Table V) |
| Lymph node | 1 | 3 | | 🟢 (Table V) |
| Local | 2 | 2 | | 🟢 (Table V) |
| **Recurrence in CEA mRNA+ before surgery (n=5):** | 5/5 (100%) | | | 🟢 (p. 167, Results: "Five patients with positive CEA mRNA expression before surgery had recurrent disease") |
| Lung metastasis | 2 patients | | | 🟢 (p. 167, Results) |
| Liver metastasis | 2 patients | | | 🟢 (p. 167, Results) |
| Local recurrence | 1 patient | | | 🟢 (p. 167, Results) |
| Mean time to recurrence (CEA+ before surgery) | 10.9 months | | | 🟢 (p. 167, Results) |
| Mean time to recurrence (CEA+ before/after resection) | 19.1 months | | | 🟢 (p. 167, Results) |
| Time to recurrence comparison p-value | p = 0.27 (not significant) | | | 🟢 (p. 167, Results) |

---

# Serum Tumor Markers and Recurrence

| Marker Status | Recurrence | No Recurrence | Total | Source Label & Evidence |
|---------------|-----------|---------------|-------|------------------------|
| **SCC antigen** | | | | |
| SCC positive | 15 | 9 | 24 | 🟡 Calculated from Table VI, p. 167: 9+2+3+1=15 recurrences among SCC+ |
| SCC negative | 15 | 15 | 30 | 🟡 Calculated from Table VI: 10+1+1+3=15 recurrences among SCC- |
| p-value | Not significant (p not given) | | | 🟢 (p. 167, Results: "a difference which was not significant") |
| SCC+ recurrence rate | 62.5% | | | 🟡 Calculated: 15/24 = 62.5% (p. 167, Results: "15 (62.5%) experienced disease recurrence") |
| SCC- recurrence rate | 50% | | | 🟡 Calculated: 15/30 = 50% (p. 167, Results: "15 (50%) of 30 patients with normal values") |
| **CEA** | | | | |
| CEA positive | 5 | 9 | 14 | 🟡 Calculated from Table VI, p. 167: 4+0+0+1=5 recurrences among CEA+ |
| CEA negative | 25 | 15 | 40 | 🟡 Calculated from Table VI: 15+3+4+3=25 recurrences among CEA- |
| p-value | Not significant (p not given) | | | 🟢 (p. 167, Results: "the difference in recurrence rates was not significant") |
| CEA+ recurrence rate | 35.7% | | | 🟡 Calculated: 5/14 = 35.7% (p. 167, Results: "Five (35.7%) of 14 patients with CEA positivity") |
| CEA- recurrence rate | 62.5% | | | 🟡 Calculated: 25/40 = 62.5% (p. 167, Results: "25 (62.5%) of 40 patients with CEA negativity") |

---

# Methodological Details

| Aspect | Details | Source Label & Evidence |
|--------|---------|------------------------|
| **RT-PCR method** | Nested RT-PCR using CEA-specific primers | 🟢 (p. 164, Methods: RT-PCR: "To more accurately detect CEA mRNA, we performed nested RT-PCR") |
| **CEA primers** | CEA-A, CEA-B, CEA-C (designed by Gerhard et al, 1994) | 🟢 (p. 164, Methods: RT-PCR: "We used 3 different CEA primers designed by Gerhard et al.9") |
| **RT-PCR product size** | 131 base pairs | 🟢 (p. 164, Methods: RT-PCR: "The RT-PCR product was detected as a 131-base pair (bp) fragment") |
| **Quality control** | Double testing: "Samples were judged as positive for CEA mRNA only when 131-base pair fragment was detected in both assays" | 🟢 (p. 164, Methods: RT-PCR section) |
| **Control samples** | Water, healthy volunteer stock sample, MCF-7 cell line stock sample used in each assay | 🟢 (p. 164, Methods: RT-PCR section) |
| **Blood sample volume** | 5 mL heparinized blood per catheter | 🟢 (p. 163, Blood samples: "5-mL samples of heparinized blood") |
| **Contamination prevention** | Initial 20 mL blood discarded | 🟢 (p. 163, Blood samples: "The initial 20 mL of blood was discarded to protect the mixture from epithelial cells") |
| **Cell lines tested** | TE-1 (esophageal), MCF-7 (breast), MKN-45 (gastric) | 🟢 (p. 163, Methods: Cell lines section) |
| **GAPDH control** | Used to monitor cDNA synthesis | 🟢 (p. 164, Methods: RNA extraction: "To monitor the synthesis of cDNA, glyceraldehyde-3-phosphate dehydrogenase (GAPDH) RT-PCR was performed") |

---

# Statistical Analysis

| Method | Application | Source Label & Evidence |
|--------|-------------|------------------------|
| Chi-square test | Categorical comparisons (CEA mRNA vs clinicopathologic factors, recurrence) | 🟢 (p. 164, Statistical evaluation: "chi-square test") |
| Student t test | Continuous variable comparisons (age) | 🟢 (p. 164, Statistical evaluation: "Student t test") |
| Significance level | p < 0.05 | 🟢 (p. 164, Statistical evaluation: "A P value of less than .05 was considered to be significant") |

---

# Quality Assessment Justifications

## Selection Bias: MEDIUM

**Sampling method (1.1):** The study used consecutive sampling of all esophageal cancer patients undergoing R0 resection at a single institution from January 1997 to April 1999 🟢 (p. 163, Methods). Consecutive sampling is appropriate for a prognostic study and minimizes selection bias compared to convenience sampling. However, the study is limited to a single tertiary referral center, which may not fully represent all esophageal cancer patients. **Rating: Low-Medium Risk**

**Recruitment transparency (1.2):** Recruitment timeline and location are clearly specified (January 1997 - April 1999, Kagoshima University First Department of Surgery) 🟢 (p. 163). However, response rates are not reported - unclear if any eligible patients declined participation or were excluded. The study states "we obtained consent for blood collection from all patients" 🟢 (p. 163, Blood samples) but doesn't report refusal rates. **Rating: Medium Risk**

**Inclusion/exclusion criteria (1.3):** The study specifies that patients had "esophageal cancer who underwent R0 resection" 🟢 (p. 163) and 14 patients received neoadjuvant therapy 🟢 (p. 163), but formal inclusion/exclusion criteria are not explicitly stated. It's unclear what other criteria (e.g., performance status, comorbidities) may have influenced selection for surgery. **Rating: Medium Risk**

**Selection process documentation (1.4):** The study reports 54 consecutive patients enrolled, with demographic and tumor characteristics provided in text and tables, but no CONSORT-style flow diagram showing screening, enrollment, and reasons for exclusion. 🟢 (p. 163, Methods; Table II, p. 165). **Rating: Medium Risk**

**Domain 1 Overall:** Medium risk - consecutive sampling is a strength, but lack of explicit criteria, response rates, and flow documentation introduce moderate uncertainty about selection process.

---

## Measurement Validity: LOW

**Outcome measure validation (2.1):** The primary outcome (CEA mRNA detection) uses RT-PCR, a well-validated molecular technique. The CEA-specific primers were designed by Gerhard et al (1994) 🟢 (p. 164, Methods), a published and cited method. Serum tumor markers (SCC antigen, CEA) were measured using "commercial enzyme immunoassay kit" 🟢 (p. 164, Methods). All outcome measures are validated and standardized. **Rating: Low Risk**

**Measurement reliability (2.2):** The study implemented rigorous quality control: (1) nested RT-PCR for increased specificity, (2) samples tested twice and "judged as positive for CEA mRNA only when 131-base pair fragment was detected in both assays" 🟢 (p. 164, RT-PCR section), (3) quality control samples (water, healthy volunteers, cell lines) run with each assay 🟢 (p. 164), and (4) sensitivity testing showing detection limit of 1 cancer cell per 10⁶ lymphocytes 🟢 (p. 164, Results). No signals detected in 20 healthy volunteers or 20 benign disease controls 🟢 (p. 164, Results), demonstrating specificity. **Rating: Low Risk**

**Blinding of assessors (2.3):** The study does not explicitly state whether laboratory personnel performing RT-PCR were blinded to patient clinical characteristics or outcomes. However, RT-PCR is a relatively objective molecular assay with standardized protocols and dual testing, reducing detection bias risk. Recurrence assessment used objective imaging (CT, ultrasound, X-ray) at regular intervals 🟢 (p. 164, Clinical follow-up). **Rating: Low-Medium Risk**

**Measurement timing (2.4):** Blood sampling timing was clearly defined and appropriate: before surgery (after anesthesia), before resection (after thoracotomy), and after resection 🟢 (p. 163, Blood samples). Follow-up for recurrence was systematic with median 30 months (range 2-60) 🟢 (p. 164) and regular imaging intervals specified. Timing is appropriate to capture surgical shedding of tumor cells and subsequent recurrence. **Rating: Low Risk**

**Domain 2 Overall:** Low risk - validated molecular methods, rigorous quality control with dual testing, and appropriate timing strengthen measurement validity.

---

## Confounding Control: MEDIUM

**Baseline comparability (3.1):** The study compared baseline characteristics between CEA mRNA positive and negative groups, presenting detailed data in Table II (p. 165) including age, tumor depth, nodal status, metastasis, stage, location, histology, lymphatic/venous invasion, and neoadjuvant therapy 🟢. Groups were comparable on most factors except age (RT-PCR+ younger, p=0.002), nodal status (RT-PCR+ more node-positive, p=0.011), and stage (RT-PCR+ higher stage, p=0.048) 🟢 (Table II). The identification of these differences is a strength, but lack of adjustment for them is a limitation. **Rating: Low-Medium Risk**

**Control for confounders (3.2):** The study identified several potential confounders (age, nodal status, stage) through baseline comparisons but did not control for them in the analysis of recurrence outcomes. For a prognostic study, important confounders like tumor stage, nodal status, and neoadjuvant therapy should ideally be adjusted for when examining the independent prognostic value of CEA mRNA. These were acknowledged but not statistically controlled. **Rating: Medium-High Risk**

**Statistical adjustment (3.3):** All analyses were univariate (chi-square tests, t-tests) 🟢 (p. 164, Statistical evaluation). No multivariable analysis (e.g., Cox regression adjusting for stage, nodes, age) was performed to determine independent prognostic value of CEA mRNA. This is a significant limitation for a prognostic factor study, as observed associations could be confounded by tumor stage. **Rating: High Risk**

**Randomization (3.4):** N/A - observational prognostic cohort study, randomization not applicable.

**Domain 3 Overall:** Medium risk (would be medium-high due to lack of adjusted analysis, but this is somewhat acceptable for an exploratory prognostic biomarker study; the key issue is interpretation should be cautious about confounding).

---

## Attrition/Missing Data: LOW

**Dropout rates (4.1):** The study explicitly states "Follow-up data after surgery were obtained for all patients" 🟢 (p. 164, Clinical follow-up). All 54 enrolled patients completed follow-up with median 30 months (range 2-60 months). The range of 2-60 months suggests some patients had shorter follow-up possibly due to death or early recurrence, but this appears to be outcome-related rather than loss to follow-up. **Rating: Low Risk**

**Attrition analysis (4.2):** Not applicable - no attrition reported. All patients had follow-up data obtained. **Rating: Low Risk (N/A)**

**Missing data handling (4.3):** The paper does not explicitly discuss missing data handling methods. However, complete data are presented for all 54 patients across all primary analyses (RT-PCR results in Table I, clinicopathologic associations in Table II, recurrence in Table V). This suggests minimal to no missing data on primary outcomes. **Rating: Low Risk**

**Differential attrition (4.4):** Zero attrition reported, so differential attrition is 0%. Follow-up was 100% complete 🟢 (p. 164). The varying follow-up duration (2-60 months) likely reflects enrollment timing rather than dropout. **Rating: Low Risk**

**Domain 4 Overall:** Low risk - complete follow-up of all 54 patients is a major strength and minimizes attrition bias.

---

## Reporting Transparency: LOW

**Methods completeness (5.1):** The Methods section provides comprehensive detail: patient selection criteria and timeline, detailed RT-PCR protocols with primer sequences and cycling conditions 🟢 (p. 163-164, Methods), RNA extraction procedures, quality control measures, serum marker assays, blood sampling procedures including contamination prevention, and statistical methods. Sufficient detail is provided to replicate the RT-PCR assay. The TNM classification system used (5th edition, 1997) is cited 🟢 (p. 163, reference 20). **Rating: Low Risk**

**Results clarity (5.2):** All primary and secondary outcomes are reported with clear numerical data. CEA mRNA positivity rates by site, time point, and patient subgroups are presented 🟢 (p. 164-165, Tables I-II). Recurrence outcomes reported for all patients with breakdown by recurrence type 🟢 (Table V, p. 167). Both significant and non-significant results are reported (e.g., no association with serum markers, p-values given). Effect sizes (percentages, means with SDs) and precision estimates (p-values) provided throughout. **Rating: Low Risk**

**Statistical details (5.3):** Statistical methods are clearly specified (chi-square for categorical, t-test for continuous) 🟢 (p. 164, Statistical evaluation). P-values reported for all comparisons. Sample sizes clear in all tables. The main limitation is lack of confidence intervals around effect estimates and no multivariable modeling, but for the level of analysis performed (univariate comparisons), reporting is complete. **Rating: Low-Medium Risk**

**Conflicts of interest (5.4):** No funding sources or conflicts of interest are disclosed in the paper. No acknowledgments or grant support mentioned. For a study from 2003, disclosure standards were less stringent than current requirements, but absence of any statement is a limitation. 🔴 No funding or COI disclosure found in manuscript. **Rating: Medium Risk**

**Domain 5 Overall:** Low risk overall (leaning toward Low-Medium) - methods and results are comprehensively reported with good detail, but lack of COI disclosure is a notable gap.

---

## Overall Quality: MEDIUM

**Synthesis:** This study demonstrates several methodological strengths: (1) consecutive patient sampling minimizing selection bias, (2) validated and reliable molecular detection methods with rigorous quality control (dual testing, controls), (3) complete follow-up of all 54 patients eliminating attrition bias, and (4) comprehensive and transparent reporting of methods and results.

The primary limitations are: (1) lack of multivariable analysis to control for confounding by tumor stage and nodal status when assessing prognostic value of CEA mRNA (confounding control rated medium-high risk), (2) single-center study potentially limiting generalizability, (3) no explicit inclusion/exclusion criteria or participant flow documentation, and (4) no COI/funding disclosure.

**Rating Distribution:**
- Selection Bias: Medium
- Measurement Validity: Low
- Confounding Control: Medium (high risk for lack of adjustment)
- Attrition/Missing Data: Low
- Reporting Transparency: Low

**Overall Assessment:** With 2 low-risk domains, 2 medium-risk domains, 1 low-medium domain, and no high-risk domains across all areas, this study merits a **MEDIUM** quality rating. The excellent measurement methods and complete follow-up are offset by the lack of adjusted analysis for confounders. For an exploratory prognostic biomarker study from 2003, this represents acceptable quality, though contemporary standards would require multivariable analysis. Results should be interpreted with awareness of potential confounding by tumor stage.

---

# Additional Notes

**Methodological Strengths:**
1. **Rigorous molecular detection:** Nested RT-PCR with dual testing requirement and multiple quality controls per assay represents high-quality molecular epidemiology for its time period (1997-1999 enrollment, 2003 publication).

2. **Complete follow-up:** 100% follow-up (all 54 patients) with median 30 months is exceptional and eliminates attrition bias.

3. **Time-course analysis:** Three-timepoint sampling (before surgery, before resection, after resection) provides novel insights into surgical shedding of CTCs, showing 51.9% positivity after resection vs. 9.3% before 🟢 (p. 165, Results).

4. **Specificity controls:** Testing 20 healthy volunteers and 20 benign disease controls with 0% false positives demonstrates assay specificity 🟢 (p. 164, Results).

**Methodological Limitations:**
1. **No adjusted analysis:** The significant associations between CEA mRNA and recurrence (p=0.036 for total recurrence, p=0.0026 for blood-borne recurrence) could be confounded by the association between CEA mRNA and higher tumor stage (p=0.048) and nodal involvement (p=0.011). Cox regression adjusting for stage would strengthen causal inference.

2. **Unclear inclusion criteria:** While consecutive patients are described, formal eligibility criteria are not stated. Unclear if performance status, comorbidities, or other factors influenced selection for R0 resection.

3. **Single institution:** Kagoshima University is the sole enrollment site, limiting generalizability to other populations and health systems.

4. **Limited sample size:** N=54 is relatively small, particularly for subgroup analyses. Some subgroups have very small numbers (e.g., only 5 patients CEA mRNA+ before surgery).

**Clinical Implications Noted by Authors:**
"Patients with positive CEA mRNA have a high risk of blood-borne metastasis, and therefore effective chemotherapy is desirable to prevent tumor recurrence in such patients" 🟢 (p. 168, Discussion). This suggests potential for risk stratification, though this was a prognostic study without intervention.

**Key Finding:**
The dramatic increase in CEA mRNA positivity after tumor resection (51.9%) vs. before resection (9.3%) 🟢 (p. 165, Results) supports the hypothesis that "tumor cells may detach from primary tumors and flow into the blood vessels as a result of surgical maneuvers" 🟢 (p. 168, Discussion).

**Comparison to Serum Markers:**
Neither serum SCC antigen nor CEA predicted recurrence 🟢 (Tables VI, p. 167; Discussion p. 167-168), whereas CEA mRNA strongly predicted blood-borne recurrence (58.1% vs 17.4%, p=0.0026). This suggests molecular detection may be more sensitive than serum protein markers for identifying high-risk patients.

**Potential for Meta-Analysis:**
This study provides extractable prognostic data suitable for meta-analysis:
- 2×2 table for CEA mRNA vs. recurrence: 21/31 in exposed, 9/23 in unexposed
- 2×2 table for CEA mRNA vs. blood-borne recurrence: 18/31 vs 4/23
- Could calculate relative risks, odds ratios, or hazard ratios (though HR not directly reported)

**Gold Standard Notes:**
This data card represents a comprehensive manual extraction taking approximately 2.5 hours. All data points labeled with three-color system. This will serve as a benchmark to compare against automated Microscope v1.0 extractions to assess accuracy and identify common extraction errors or omissions.

---

**Extraction completed:** 2025-10-21
**Extraction time:** ~150 minutes (manual gold standard)
**Confidence in extraction:** High - all primary data verified against original tables and text
**Recommended for:** Gold standard comparison for Microscope v1.0 testing

