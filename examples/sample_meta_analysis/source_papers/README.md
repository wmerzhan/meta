# Sample Papers for Microscope Testing

<!-- Powered by BMAD™ Core -->

This directory contains (or references) the research papers used to test Microscope v1.0 in Story 1.6.

## Purpose

These sample papers serve multiple purposes:
- **Validation:** Test Microscope extraction accuracy across diverse study types
- **Documentation:** Demonstrate MAestro workflow with real examples
- **Training:** Help new users understand the extraction process
- **Benchmarking:** Establish baseline extraction times and labeling coverage

## Paper Selection Criteria

Papers were selected to represent diverse characteristics:

### Discipline Coverage (minimum 3)
- Medicine (clinical trials, interventions)
- Psychology (behavioral interventions, measures)
- Education (learning interventions, academic outcomes)
- Other: Public Health, Social Work, Nutrition

### Study Design Variety
- **Simple RCTs:** 8-10 pages, clear IMRAD structure, straightforward results
- **Complex RCTs:** >12 pages, multiple outcomes, subgroup analyses
- **Quasi-experimental/Observational:** Non-randomized designs
- **Meta-analyses/Reviews:** For testing exclusion workflow

### Complexity Dimensions
- **Word count:** 8,000-12,000 words (primary target), one 15,000+ words (stress test)
- **Reporting quality:** High (complete data), medium (typical), low (substantial missing data)
- **Statistical complexity:** Simple (t-tests, ANOVAs) to complex (mixed models, SEMs)
- **Table density:** Few tables vs. many detailed statistical tables

## Copyright Considerations

### Included Papers
If papers are public domain, Creative Commons licensed, or permission obtained:
- PDF files stored directly in this directory
- Named: `{first_author}_{year}_{short_title}.pdf`

### Referenced Papers (Copyright Protected)
If papers cannot be redistributed due to copyright:
- This README documents full citations, DOIs, and access information
- Users must obtain papers independently through institutional access or publishers

## Sample Papers Used in Story 1.6 Testing

**Total Papers:** 11 (5 Medicine, 3 Psychology, 3 Education)
**Disciplines:** 3 ✅ (Medicine/Surgery, Psychology, Education)
**Designs:** Cohort studies, RCTs, Quasi-experimental

---

## MEDICINE / SURGERY (5 Papers)

All papers focus on circulating tumor cells (CTCs) in esophageal cancer patients.

### Paper M1: Nakashima et al. 2003
- **Citation:** Nakashima, S., Natsugoe, S., Matsumoto, M., Miyazono, F., Takao, S., Uchikura, K., Tokuda, K., Ishigami, S., Baba, M., Takaki, Y., & Aikou, T. (2003). Clinical significance of circulating tumor cells in blood by molecular detection and tumor markers in esophageal cancer. Surgery, 133(2), 162-169.
- **DOI:** 10.1067/msy.2003.30
- **Discipline:** Medicine (Surgery/Oncology)
- **Design:** Prospective cohort study
- **Sample Size:** n=54 ESCC patients
- **Method:** CEA mRNA RT-PCR CTC detection at 3 timepoints
- **Pages:** 8
- **Quality:** MEDIUM (Selection: Medium, Measurement: Low, Confounding: Medium, Attrition: Low, Reporting: Low)
- **Rationale:** Medium complexity, moderate quality, multiple timepoints
- **File:** `nakashima_2003_cohort.pdf` (if available) or via DOI
- **Gold Standard:** ✅ COMPLETED (~150 min, 54%🟢/33%🟡/13%🔴)

### Paper M2: Reeh et al. 2015
- **Citation:** Reeh, M., Effenberger, K. E., Koenig, A. M., Riethdorf, S., Eichstadt, D., Welt, A., Pantel, K., Izbicki, J. R., & Knoefel, W. T. (2015). Circulating tumor cells as a biomarker for preoperative prognostic staging in patients with esophageal cancer. Annals of Surgery, 261(6), 1124-1130.
- **DOI:** 10.1097/SLA.0000000000001130
- **PMID:** 25607767
- **ClinicalTrials.gov:** NCT01858805
- **Discipline:** Medicine (Surgery/Oncology)
- **Design:** Prospective single-center cohort study
- **Sample Size:** n=100 EC patients (47 SCC, 53 adenocarcinoma)
- **Method:** CellSearch System CTC detection
- **Pages:** 7
- **Quality:** HIGH (all 5 domains LOW risk)
- **Rationale:** High complexity (stratified tables, multivariate Cox), excellent reporting
- **File:** `reeh_2015_cohort.pdf` (if available) or via DOI
- **Gold Standard:** ✅ COMPLETED (~180 min, 58%🟢/33%🟡/8%🔴)

### Paper M3: Matsushita et al. 2015
- **Citation:** Matsushita, D., Arigami, T., Uenosono, Y., Yanagita, S., Nishizono, Y., Uchikado, Y., Kijima, Y., Kurahara, H., Kita, Y., Mori, S., Sasaki, K., Matsumoto, M., Okumura, H., Ishigami, S., & Natsugoe, S. (2015). Clinical significance of circulating tumor cells detected by a novel filtration device in patients with esophageal squamous cell carcinoma. Annals of Surgical Oncology, 22(S3), S1566-S1571.
- **Discipline:** Medicine (Surgery/Oncology)
- **Design:** Prospective cohort
- **Sample Size:** n=90 esophageal SCC patients
- **Pages:** 7
- **File:** `matsushita_2015_cohort.pdf` (if available) or via DOI

### Paper M4: Hoffmann et al. 2010
- **Citation:** Hoffmann, A.-C., et al. (2010). Circulating tumor cells in esophageal cancer patients. Pharmacogenomics, [details to be confirmed]
- **Discipline:** Medicine (Oncology)
- **Design:** Prospective study
- **Sample Size:** n=62 esophageal cancer patients
- **Pages:** ~7
- **File:** `hoffmann_2010_cohort.pdf` (if available) or via DOI

### Paper M5: Honma et al. 2006
- **Citation:** Honma, H., et al. (2006). [CTC detection in esophageal SCC]. Surgery, [details to be confirmed]
- **Discipline:** Medicine (Surgery)
- **Design:** Prospective study
- **Sample Size:** n=46 esophageal SCC patients
- **Pages:** ~8
- **File:** `honma_2006_cohort.pdf` (if available) or via DOI

---

## PSYCHOLOGY (3 Papers)

All papers focus on behavioral/mental health interventions with college/community samples.

### Paper P1: Hwang et al. 2015
- **Citation:** Hwang, W.-C., Myers, H. F., Chiu, E., Mak, E., Butner, J. E., Fujimoto, K., Wood, J. J., & Miranda, J. (2015). Culturally adapted cognitive-behavioral therapy for Chinese Americans with depression: A randomized controlled trial. Psychiatric Services, 66(10), 1035-1042.
- **DOI:** 10.1176/appi.ps.201400358
- **PMC:** PMC4591116
- **Discipline:** Psychology (Clinical)
- **Design:** Randomized Controlled Trial
- **Sample Size:** n=50 Chinese Americans with major depression
- **Groups:** CA-CBT (n=27) vs. Standard CBT (n=23)
- **Intervention:** 12 sessions, culturally adapted CBT
- **Primary Outcome:** HDRS (Hamilton Depression Rating Scale)
- **Key Results:** CA-CBT showed ~2x symptom reduction; dropout CBT 26% vs CA-CBT 7%
- **Pages:** ~8-10
- **Quality:** HIGH (RCT, registered, complete reporting)
- **Rationale:** Simple RCT, Psychology discipline, clear cultural adaptation focus
- **File:** Access via PMC4591116 (open access)
- **Gold Standard:** ⏸️ PLANNED

### Paper P2: de Sousa et al. 2021
- **Citation:** de Sousa, G. M., de Lima-Araújo, G. L., de Araújo, D. B., & de Sousa, M. B. C. (2021). Brief mindfulness-based training and mindfulness trait attenuate psychological stress in university students: A randomized controlled trial. BMC Psychology, 9(21).
- **DOI:** 10.1186/s40359-021-00520-y
- **PMC:** PMC7852130
- **Discipline:** Psychology (Mindfulness/Stress)
- **Design:** Randomized Controlled Trial
- **Sample Size:** n=40 university students (20 per group)
- **Groups:** Mindfulness Training (MT) vs. Active Control (AC)
- **Intervention:** 30-min audio-guided meditation, 3 consecutive days
- **Primary Outcomes:** Anxiety state, perceived stress, state mindfulness
- **Key Results:** Only MT group reduced anxiety and stress; marginally decreased cortisol
- **Pages:** ~20
- **Quality:** HIGH (CONSORT compliant, complete tables)
- **Rationale:** Brief intervention, university students, complete statistical reporting
- **File:** Access via PMC7852130 (open access)

### Paper P3: Bai et al. 2020
- **Citation:** Bai, S., Elavsky, S., Kishida, M., Dvořáková, K., & Greenberg, M. T. (2020). Effects of mindfulness training on daily stress response in college students: Ecological momentary assessment of a randomized controlled trial. Mindfulness, 11(6), 1433-1445.
- **DOI:** 10.1007/s12671-020-01358-3
- **PMC:** PMC7748211
- **Discipline:** Psychology (Mindfulness/College Students)
- **Design:** Randomized Controlled Trial with Ecological Momentary Assessment (EMA)
- **Sample Size:** n=52 first-year college students
- **Groups:** Mindfulness training vs. Waitlist control
- **Intervention:** 8-session "Just Breathe" program (80-min sessions over 6 weeks)
- **Primary Outcomes:** Negative emotion, rumination, interference, emotion regulation
- **Key Results:** Reduced negative emotion, rumination, and interference in response to family stress; stable emotion regulation across semester
- **Pages:** ~25-30
- **Quality:** HIGH (rigorous EMA design, complete statistical tables)
- **Rationale:** Complex RCT design, first-year college students (high stress), longitudinal EMA data
- **File:** Access via PMC7748211 (open access)

---

## EDUCATION (3 Papers)

All papers focus on learning interventions with students (K-12 or undergraduate).

### Paper E1: Banda & Nzabahimana 2022
- **Citation:** Banda, H. J., & Nzabahimana, J. (2022). The impact of Physics Education Technology (PhET) interactive simulation-based learning on motivation and academic achievement among Malawian physics students. Journal of Science Education and Technology, 32, 127-141.
- **DOI:** 10.1007/s10956-022-10010-3
- **PMC:** PMC9761040
- **Discipline:** Education (Physics/STEM)
- **Design:** Quasi-experimental (pretest-posttest control group)
- **Sample Size:** n=280 students (144 experimental, 136 control)
- **Intervention:** PhET interactive simulations, 6 weeks
- **Primary Outcomes:** Achievement test, motivation questionnaire
- **Key Results:** Cohen's d=1.14 (very large effect); experimental group significantly outperformed control; high motivation
- **Pages:** ~15
- **Quality:** MEDIUM-HIGH (rigorous quasi-experimental, complete statistical reporting)
- **Rationale:** Education discipline, STEM intervention, large effect size, complete data
- **File:** Access via PMC9761040 (open access)
- **Gold Standard:** ⏸️ PLANNED

### Paper E2: Alnuaim 2024
- **Citation:** Alnuaim, A. (2024). The impact and acceptance of gamification by learners in a digital literacy course at the undergraduate level: Randomized controlled trial. JMIR Serious Games, 12, e52017.
- **DOI:** 10.2196/52017
- **PMC:** PMC11363743
- **Discipline:** Education (Digital Literacy/Higher Ed)
- **Design:** Randomized Controlled Trial (pretest-posttest)
- **Sample Size:** n=168 undergraduate students
- **Groups:** Experimental (gamification) vs. Control (conventional)
- **Intervention:** NOVA Labs gamification platform (16-week course, last 6 weeks gamified)
- **Primary Outcomes:** Academic performance in digital literacy, student acceptance
- **Key Results:** Experimental M=21.00 (SD=1.88) vs Control M=15.87 (SD=2.15), t(166)=-16.435, p=.001; high satisfaction (M=3.857, SD=0.61)
- **Pages:** ~20-25
- **Quality:** HIGH (CONSORT-like reporting, multiple statistical methods: t-tests, ANOVA, regression)
- **Rationale:** RCT, undergraduate students, complete statistical reporting, moderate complexity
- **File:** Access via PMC11363743 (open access)

### Paper E3: Wanzek et al. 2020
- **Citation:** Wanzek, J., et al. (2020). Comparing the effects of reading intervention versus reading and mindset intervention for upper elementary students with reading difficulties. Journal of Learning Disabilities.
- **DOI:** [To be confirmed]
- **PMC:** PMC8075103
- **Discipline:** Education (Reading/Elementary)
- **Design:** Randomized Controlled Trial (3 groups)
- **Sample Size:** n=361 fourth-grade students
- **Groups:** Reading intervention, Reading+mindset, Business-as-usual
- **Intervention:** Lindamood Phoneme Sequencing (LiPS) program + Brainology mindset program
- **Primary Outcomes:** Nonword reading, phonological processing, reading comprehension
- **Key Results:** Reading intervention effects d=0.29-0.35 (nonword), d=0.20-0.28 (phonological), d=0.19-0.23 (comprehension); no significant mindset effects
- **Pages:** ~30-35
- **Quality:** HIGH (RCT, complete statistical analysis)
- **Rationale:** Complex 3-arm RCT, diverse student sample (51% female, 46% Hispanic, 42% Black, 14% ELL), complete effect size reporting
- **File:** Access via PMC8075103 (open access)

---

## Usage

To use these sample papers for learning:

1. **Review the data cards** in `examples/sample_meta_analysis/data_cards/` to see extraction outputs
2. **Obtain the source paper** (from this directory or via DOI)
3. **Compare** the paper to the data card to understand extraction decisions
4. **Practice** by extracting a paper yourself using Microscope prompt
5. **Compare** your extraction to the sample data card

## Testing Results Summary

**Status:** Testing in progress (Phase 2/8)

### Papers Acquired (Phase 1 Complete ✅)
- **Total papers:** 11
- **Disciplines covered:** Medicine/Surgery (5), Psychology (3), Education (3) ✅
- **Study designs:** Cohort studies (5), RCTs (5), Quasi-experimental (1) ✅

### Gold Standards Completed (Phase 2 In Progress)
- **Medicine:** 2/2 completed
  - Nakashima 2003: ~150 min, 54%🟢/33%🟡/13%🔴
  - Reeh 2015: ~180 min, 58%🟢/33%🟡/8%🔴
- **Psychology:** 0/1 planned (Hwang 2015 selected)
- **Education:** 0/1 planned (Banda 2022 selected)

### Overall Testing Progress
- ✅ Phase 1: Cross-discipline paper acquisition (11 papers found)
- ⏸️ Phase 2: Gold standard extractions (2/4 complete)
- ⏸️ Phase 3: Automated Microscope testing
- ⏸️ Phase 4: Accuracy analysis
- ⏸️ Phase 5: Cross-discipline labeling coverage analysis
- ⏸️ Phase 6: Terminal output user testing (simulated)
- ⏸️ Phase 7: Prompt optimization recommendations
- ⏸️ Phase 8: Final compilation to 100%

**Estimated completion:** Phases 2-8 require ~25-30 additional hours
