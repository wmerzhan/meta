# Compiler v1.0 Test Data Inventory

**Story:** 2.3 - Test Compiler with Data Cards from Epic 1
**Created:** 2025-10-23
**Purpose:** Document all data cards available for Compiler v1.0 testing

## Gold Standard Data Cards (Available: 4)

| # | File | Study ID | Discipline | Design | Quality | Edge Cases / Notes |
|---|------|----------|------------|--------|---------|-------------------|
| 1 | nakashima_2003_cohort.md | nakashima_2003_cohort | Medicine/Oncology | Prospective cohort | MEDIUM | Multiple sampling timepoints, heterogeneous effect metrics |
| 2 | reeh_2015_cohort.md | reeh_2015_cohort | Medicine/Oncology | Prospective cohort | HIGH | Large sample (n=100), multivariate survival analysis, complex stratified tables |
| 3 | hwang_2015_rct.md | hwang_2015_rct | Psychology | RCT | MEDIUM | Missing data (no SDs at endpoint), differential attrition, completers-only analysis |
| 4 | banda_2022_quasi.md | banda_2022_quasi | Education | Quasi-experimental | MEDIUM | Multiple outcomes (achievement + motivation), incomplete reporting of some constructs |

## Data Card Structure Verification

All 4 cards conform to Data Card Template v1.0:

✅ **YAML Frontmatter Present:**
- study_id
- extraction_date
- extractor
- microscope_version / study_type
- quality_scores (checklist_module, domain ratings, overall_quality)

✅ **Three-Color Labeling System:**
- 🟢 Green: Directly extracted from source with page/table reference
- 🟡 Yellow: Calculated or inferred from reported data
- 🔴 Red: Missing/uncertain data flagged with explanation

✅ **Required Sections:**
- Study Identification
- Study Characteristics
- Participant Demographics
- Intervention/Exposure Details
- Outcomes
- Results
- Quality Assessment

## Test Data Gap Analysis

**Target:** 10+ data cards (AC#1)
**Current:** 4 gold standard cards
**Gap:** Need 6 more data cards

**Options to reach 10+ cards:**
1. Check if Epic 1 Story 1.6 produced additional data cards beyond these 4 gold standards
2. Use simulated/synthetic data cards for context window testing (AC#9)
3. Proceed with 4 cards for initial validation testing, then expand for context window tests

## Test Strategy Recommendation

**Phase 1: Initial Validation (4 cards)**
- Use all 4 gold standard cards for initial compilation test
- Validates schema compliance, label preservation, quality summary accuracy
- Establishes baseline performance

**Phase 2: Context Window Testing (50-100 cards)**
- Duplicate gold standards with modified study_ids to simulate larger datasets
- Tests scalability and context limits (AC#9)

## Edge Case Coverage

| Edge Case | Present in Gold Standards? | Card(s) |
|-----------|---------------------------|---------|
| Missing fields (no CI bounds) | ✅ Yes | hwang_2015_rct (missing endpoint SDs) |
| Multiple outcomes per study | ✅ Yes | banda_2022_quasi (achievement + motivation) |
| Heterogeneous effect size types | ✅ Yes | nakashima_2003_cohort (RT-PCR positivity vs survival), reeh_2015_cohort (CTC vs survival) |
| Different disciplines | ✅ Yes | Medicine (2), Psychology (1), Education (1) |
| Different study designs | ✅ Yes | Cohort (2), RCT (1), Quasi-experimental (1) |
| Incomplete reporting | ✅ Yes | hwang_2015_rct, banda_2022_quasi |
| Complex stratified tables | ✅ Yes | reeh_2015_cohort (3 stratifications in Table 1) |

## Recommended Test Sets

**Test Set 1: Initial Validation (All 4 cards)**
- Purpose: Validate basic compilation functionality
- Expected output: Single CSV with ~15-30 rows (depending on how many extractable data points per card)

**Test Set 2: Discipline Homogeneity (2 medicine cards)**
- Purpose: Test compilation of same-discipline studies
- Cards: nakashima_2003_cohort.md + reeh_2015_cohort.md

**Test Set 3: Cross-Discipline Heterogeneity (All 4 cards)**
- Purpose: Test handling of heterogeneous data structures
- Cards: All 4 (medicine + psychology + education)

**Test Set 4: Context Window Stress Test (50+ cards)**
- Purpose: Test context limits (AC#9)
- Method: Duplicate gold standards with modified study_ids

## Data Card File Paths

All cards located in: `tests/validation/gold_standards/`

```
tests/validation/gold_standards/
├── nakashima_2003_cohort.md       (~365 lines)
├── reeh_2015_cohort.md            (~501 lines)
├── hwang_2015_rct.md              (~355 lines)
├── banda_2022_quasi.md            (~389 lines)
└── README.md
```

**Total content:** ~1,610 lines of data card content

## Next Steps

1. ✅ Verify data card structure (COMPLETED)
2. ⏭️ Execute Compiler v1.0 with 4-card test set
3. ⏭️ Validate compiled CSV output
4. ⏭️ Expand to context window testing with simulated larger datasets
