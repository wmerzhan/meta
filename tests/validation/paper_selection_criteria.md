# Paper Selection Criteria for Story 1.6 Testing

<!-- Powered by BMAD™ Core -->

**Story:** 1.6 - Test Microscope with Sample Papers Across Disciplines
**Purpose:** Document systematic criteria for selecting representative test papers
**Created:** 2025-10-21

## Selection Framework

This document defines the criteria for selecting 5-10 research papers to test Microscope v1.0 extraction capabilities.

## Target: 5-10 Papers

**Minimum requirements:**
- At least 3 different disciplines
- At least 4 different study designs
- Mix of complexity levels
- Range of reporting quality

## Dimension 1: Discipline Diversity (minimum 3)

| Discipline | Rationale | Target Count |
|------------|-----------|--------------|
| **Medicine** | Clinical trials, well-established reporting standards (CONSORT) | 2-3 papers |
| **Psychology** | Behavioral interventions, psychological measures, varied designs | 2-3 papers |
| **Education** | Learning interventions, academic outcomes, school-based settings | 1-2 papers |
| **Public Health** | (Optional) Population-level interventions, health behaviors | 0-1 papers |
| **Social Work** | (Optional) Social interventions, vulnerable populations | 0-1 papers |

**Selection strategy:** Prioritize medicine and psychology (established meta-analysis traditions), add education for diversity.

## Dimension 2: Study Design Variety (minimum 4 types)

| Design Type | Characteristics | Count | Purpose |
|-------------|----------------|-------|---------|
| **Simple RCT** | 8-10 pages, clear IMRAD, straightforward results | 2 papers | Test baseline extraction workflow |
| **Complex RCT** | >12 pages, multiple outcomes, subgroup analyses, many tables | 1 paper | Test context window limits, complex data handling |
| **Quasi-Experimental** | Non-randomized, observational, matching/adjustment methods | 1 paper | Test non-RCT design handling |
| **Meta-analysis/Review** | Systematic review or meta-analysis (should be EXCLUDED) | 1 paper | Test exclusion workflow, screening accuracy |
| **Observational** | (Optional) Cohort, case-control, cross-sectional | 0-1 papers | Test diverse design handling |

**Selection strategy:** Cover core designs; ensure exclusion workflow is tested.

## Dimension 3: Word Count / Length

| Category | Word Count | Pages | Count | Purpose |
|----------|-----------|-------|-------|---------|
| **Short** | 6,000-8,000 | 6-8 | 1 paper | Test minimum viable extraction |
| **Standard** | 8,000-12,000 | 8-12 | 6-7 papers | Primary target range for Microscope v1.0 |
| **Long** | 15,000+ | 15+ | 1 paper | Stress test context window (200K tokens) |

**Selection strategy:** Focus on standard range (8-12K words), one stress test paper.

**Calculation:**
- Typical journal article: ~500 words per page
- 10-page paper ≈ 5,000 words (text only)
- With tables/references ≈ 8,000-10,000 words total

## Dimension 4: Reporting Quality

| Quality Level | Characteristics | Count | Purpose |
|---------------|----------------|-------|---------|
| **High** | Complete data reporting, high-impact journal, CONSORT compliance | 2-3 papers | Establish best-case extraction accuracy |
| **Medium** | Typical reporting, some missing data, standard journal | 3-4 papers | Represent common real-world scenario |
| **Low** | Substantial missing data, poor reporting, older publication | 1-2 papers | Test 🔴 labeling system, flag uncertainty |

**Selection strategy:** Most papers should be medium quality (real-world representative).

**Quality indicators:**
- High: All CONSORT items reported, effect sizes provided, confidence intervals present
- Medium: Some missing secondary outcomes, SDs computed from other statistics
- Low: Missing baseline data, unclear methods, no effect size reporting

## Dimension 5: Statistical Complexity

| Complexity | Analysis Types | Count | Purpose |
|------------|---------------|-------|---------|
| **Simple** | t-tests, chi-square, basic ANOVA, simple regression | 3-4 papers | Test straightforward extraction |
| **Moderate** | ANCOVA, multiple regression, repeated measures | 2-3 papers | Test computed effect sizes (🟡 labels) |
| **Complex** | Mixed models, SEM, meta-regression, multiple comparisons | 1-2 papers | Test complex statistics handling |

**Selection strategy:** Majority simple/moderate to match typical meta-analysis papers.

## Dimension 6: Table Density

| Density | Characteristics | Count | Purpose |
|---------|----------------|-------|---------|
| **Sparse** | 2-3 tables total, mostly text | 2 papers | Test narrative data extraction |
| **Moderate** | 4-6 tables, balanced text/data | 4-5 papers | Standard extraction scenario |
| **Dense** | 8+ tables, extensive supplementary data | 1-2 papers | Test table parsing, data overload |

**Selection strategy:** Match typical published papers (moderate density).

## Specific Selection Checklist

When selecting each paper, verify:

- [ ] **Accessible:** Can obtain full text (institutional access, open access, or purchased)
- [ ] **Copyright:** Understand redistribution rights (for `examples/` directory)
- [ ] **Complete:** Full text available (not just abstract)
- [ ] **Language:** English (for this testing phase)
- [ ] **Recent:** Published within last 15 years (modern reporting standards)
- [ ] **Peer-reviewed:** Published in academic journal (not preprint)
- [ ] **IMRAD structure:** Introduction, Methods, Results, Discussion (standard format)
- [ ] **Quantitative:** Reports numerical data suitable for meta-analysis

## Gold Standard Selection (subset of 2-3)

From the 5-10 papers, select 2-3 for manual "gold standard" extraction:

**Criteria for gold standard subset:**
- [ ] One simple RCT (baseline comparison)
- [ ] One medium-quality paper (real-world representative)
- [ ] One paper from each of the 3 core disciplines

**Time commitment:** ~2-3 hours per gold standard extraction (manual process)

## Documentation Requirements

For each selected paper, document:

1. **Full citation** (APA format)
2. **DOI or access link**
3. **File location** (if stored locally)
4. **Characteristics:**
   - Discipline
   - Study design
   - Word count (estimated)
   - Page count
   - Reporting quality (High/Medium/Low)
   - Statistical complexity (Simple/Moderate/Complex)
   - Table density (Sparse/Moderate/Dense)
5. **Selection rationale:** Why this paper was chosen (what dimension it covers)

## Example Paper Profile Template

```markdown
### Paper ID: smith_2023_rct

**Citation:** Smith, J., Johnson, M., & Williams, K. (2023). Effect of mindfulness intervention on academic performance: A randomized controlled trial. *Journal of Educational Psychology*, 115(4), 823-838. https://doi.org/10.1037/edu0000xxx

**Characteristics:**
- Discipline: Education
- Design: Simple RCT
- Word Count: ~9,500 words
- Pages: 12
- Reporting Quality: High (CONSORT compliant)
- Statistical Complexity: Moderate (ANCOVA, effect sizes reported)
- Table Density: Moderate (5 tables)

**Selection Rationale:**
- Represents education discipline
- Simple RCT design for baseline testing
- High reporting quality for best-case accuracy measurement
- Standard length (within 8-12K word target)
- Moderate complexity suitable for effect size computation testing

**Gold Standard:** Yes (selected for manual extraction)

**File:** `smith_2023_mindfulness_rct.pdf` (stored locally)
```

## Selection Timeline

1. **Initial search:** Identify 15-20 candidate papers
2. **Screening:** Apply selection criteria to narrow to 10-12 papers
3. **Final selection:** Choose 5-10 papers ensuring all dimensions covered
4. **Gold standard designation:** Select 2-3 for manual extraction
5. **Documentation:** Complete paper profiles for all selected papers

## Quality Gate

Before proceeding to testing, verify:

- [ ] At least 5 papers selected (maximum 10)
- [ ] At least 3 disciplines represented
- [ ] At least 4 study design types covered
- [ ] Majority (60%+) are standard length (8-12K words)
- [ ] Mix of reporting quality levels
- [ ] 2-3 papers designated for gold standard extraction
- [ ] All papers documented with complete profiles
- [ ] Copyright status confirmed for redistribution

## Related Files

- Paper profiles: `examples/sample_meta_analysis/source_papers/README.md`
- Gold standard extractions: `tests/validation/gold_standards/`
- Testing results: `tests/validation/1.6_microscope_testing_results.md`
