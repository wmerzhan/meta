# RAAA Transparency Appendix Template

**Version:** 1.0
**Last Updated:** October 23, 2025
**For Use With:** MAestro v1.0+ (Microscope, Compiler, Oracle)

---

## Instructions for Authors

This template documents your AI-assisted meta-analysis methodology transparently. Complete all sections and use the **Compliance Checklist** (bottom) to verify completeness before submission.

**Time Estimate:** 20-30 minutes for experienced researchers
**Best For:** Journal articles, preprints, graduate theses
**Questions?** See Troubleshooting section or RAAA usage guide

---

# Appendix: Reproducible AI-Assisted Analysis (RAAA)

## Context

{{PROJECT_TITLE}} used AI-assisted data extraction to systematically extract data from {{NUMBER_OF_PAPERS}} research papers. This appendix documents the AI tools, validation procedures, and data quality metrics to enable peer review and reproducibility.

**Meta-Analysis Research Question:** {{RESEARCH_QUESTION}}

**Studies Analyzed:** {{NUMBER_OF_PAPERS}} papers, {{TOTAL_PARTICIPANTS}} total patients

---

## 1. AI Tools Used

### Claude Model

| Parameter | Value |
|-----------|-------|
| **Model Name** | {{CLAUDE_MODEL_NAME}} |
| **Version** | {{CLAUDE_VERSION}} |
| **Release Date** | {{RELEASE_DATE}} |
| **Provider** | Anthropic |
| **Key Capabilities** | Document understanding, data extraction, code generation |
| **Known Limitations** | Training cutoff: {{TRAINING_CUTOFF}}; potential hallucination of unreported data |

### MAestro Tool Versions

| Tool | Version | Release Date | Purpose |
|------|---------|--------------|---------|
| **Microscope** | {{MICROSCOPE_VERSION}} | {{MICROSCOPE_DATE}} | Paper review and data card extraction |
| **Compiler** | {{COMPILER_VERSION}} | {{COMPILER_DATE}} | CSV compilation and data standardization |
| **Oracle** | {{ORACLE_VERSION}} | {{ORACLE_DATE}} | Statistical code generation (if used) |

### Complementary Tools

{{OPTIONAL: List any additional tools used (Excel, Python, R libraries, etc.) with versions}}

---

## 2. Human Validation Steps

### Validation Methodology

**Primary Validator:** {{VALIDATOR_NAME}}, {{VALIDATOR_TITLE}}
- Expertise: {{VALIDATOR_EXPERTISE}}
- Affiliation: {{VALIDATOR_AFFILIATION}}
- Conflicts of Interest: {{CONFLICTS_OR_NONE}}

**Validation Approach:** {{DESCRIBE: spot-check, systematic review, expert panel, etc.}}

**Papers Validated:** {{NUMBER_VALIDATED}} of {{TOTAL_PAPERS}} papers ({{VALIDATION_PERCENTAGE}}%)
- Selection method: {{random sample / high-priority studies / other}}
- Validation date(s): {{DATE_RANGE}}

**Validation Method:** {{Manual re-extraction / comparison with original / other}}

### Validation Results

| Metric | Result | Interpretation |
|--------|--------|-----------------|
| Agreement Rate | {{AGREEMENT_PERCENTAGE}}% | {{high / moderate / low}} agreement |
| Data Points Validated | {{NUMBER_OF_DATAPOINTS}} | {{COVERAGE_INTERPRETATION}} |
| Discrepancies Found | {{NUMBER}} | {{RESOLUTION_SUMMARY}} |
| Inter-Rater Reliability | {{KAPPA_VALUE}} ({{INTERPRETATION}}) | {{RELIABILITY_ASSESSMENT}} |

### Conflict Resolution

**When AI and human extraction disagreed:**

1. **Investigation Process:** {{DESCRIBE: source paper review, expert judgment, calculation verification}}
2. **Decision Criterion:** {{DESCRIBE: what determined final value}}
3. **Example:**
   - Variable: {{VARIABLE_NAME}}
   - AI Output: {{VALUE}}
   - Human Review: {{VALUE}}
   - Final Decision: {{VALUE}} — Reason: {{JUSTIFICATION}}
   - Quality Label: {{🟢/🟡/🔴}}

{{REPEAT example block for 2-3 representative conflicts}}

### Validation Limitations

{{DESCRIBE: coverage <50%? limited to certain paper types? explain limitations honestly}}

---

## 3. Data Quality Breakdown

### Three-Color Labeling System

| Label | Definition | Example | Confidence |
|-------|-----------|---------|-----------|
| 🟢 **Green (Direct)** | Data explicitly reported in source paper | Sample size from abstract; outcome from results section | Very High |
| 🟡 **Yellow (Computed)** | Value calculated from reported data; computation documented | Effect size derived from confidence interval | Moderate |
| 🔴 **Red (Uncertain)** | Data absent or uncertain; assumption required | Missing dropout rate; ambiguous outcome definition | Low |

### Overall Quality Distribution

```
Total Data Points Extracted: {{TOTAL_COUNT}}

🟢 Green (Direct Evidence)
  Count: {{GREEN_COUNT}}
  Percentage: {{GREEN_PERCENTAGE}}%

🟡 Yellow (Computed/Inferred)
  Count: {{YELLOW_COUNT}}
  Percentage: {{YELLOW_PERCENTAGE}}%

🔴 Red (Uncertain/Missing)
  Count: {{RED_COUNT}}
  Percentage: {{RED_PERCENTAGE}}%
```

### Quality Interpretation

**Status:** {{✅ ACCEPTABLE FOR PUBLICATION / ⚠️ ACCEPTABLE WITH LIMITATIONS / ❌ EXPLORATORY ONLY}}

**Threshold Analysis:**
- Percentage green: {{PERCENTAGE}}%
- Publication readiness: {{INTERPRETATION}}
- Recommended sensitivity analyses: {{LIST}}

### Quality Breakdown by Study

| Study ID | Paper Citation | Design | Green % | Yellow % | Red % | Notes |
|----------|----------------|--------|---------|----------|-------|-------|
| {{STUDY_1}} | {{CITATION}} | {{DESIGN}} | {{GREEN%}} | {{YELLOW%}} | {{RED%}} | {{NOTES}} |
| {{STUDY_2}} | {{CITATION}} | {{DESIGN}} | {{GREEN%}} | {{YELLOW%}} | {{RED%}} | {{NOTES}} |
| {{REPEAT...}} | | | | | | |

### Quality by Variable Type

| Variable Category | Green % | Yellow % | Red % | Interpretation |
|---|---|---|---|---|
| {{CATEGORY_1}} | {{%}} | {{%}} | {{%}} | {{INTERPRETATION}} |
| {{CATEGORY_2}} | {{%}} | {{%}} | {{%}} | {{INTERPRETATION}} |
| {{REPEAT...}} | | | | |

### Data Quality Visualization

[OPTIONAL: Include pie chart of 🟢/🟡/🔴 distribution]

**Data Quality Summary:**
- {{PERCENTAGE}}% of data is directly reported (high confidence)
- {{PERCENTAGE}}% is computed/inferred with documented methodology (moderate confidence)
- {{PERCENTAGE}}% is uncertain and marked for sensitivity analysis (low confidence)

---

## 4. Prompts Used & Reproducibility

### Prompt Version Pinning

This analysis used **unmodified MAestro v{{MAESTRO_VERSION}} prompts**, pinned to exact GitHub commit hashes for permanent reproducibility.

| Tool | Version | Commit Hash | GitHub Link | Release Date | Compatible Models |
|------|---------|-------------|-------------|--------------|-------------------|
| **Microscope** | {{VERSION}} | {{HASH}} | {{URL}} | {{DATE}} | Claude 3.5 Sonnet, Claude 3 Opus |
| **Compiler** | {{VERSION}} | {{HASH}} | {{URL}} | {{DATE}} | Any Claude model |
| **Oracle** | {{VERSION}} | {{HASH}} | {{URL}} | {{DATE}} | Any Claude model |

### Prompt Integrity

**Modifications:** {{None / Describe specific changes and justify}}

**Verification:** Readers can verify exact prompts by visiting GitHub links above. Commit hashes enable permanent access even if repository is updated.

### Reproducibility Statement

To reproduce this analysis with identical results:
1. Use {{CLAUDE_MODEL}} ({{CLAUDE_VERSION}})
2. Set API parameters: temperature={{TEMP}}, max_tokens={{TOKENS}}
3. Use prompt text from commit hashes above
4. Process same {{NUMBER}} papers in {{same order / randomized}} order

---

## 5. Standards Compliance

This RAAA documentation aligns with:

- ✅ **PRISMA 2020** Items 8, 13, 16, 18 (reporting transparency)
- ✅ **Cochrane Handbook** (independent verification, transparent methodology)
- ✅ **Emerging CONSORT-AI standards** (model version, validation, data quality, reproducibility)
- ✅ **Journal AI policies** ({{journal_name}} transparency requirements)

{{OPTIONAL: Add venue-specific compliance notes}}

---

## 6. Potential Biases & Limitations

### AI-Related Limitations

- {{DESCRIBE: Training data cutoff date implications}}
- {{DESCRIBE: Potential hallucination risk and mitigation}}
- {{DESCRIBE: Context window constraints}}

### Extraction-Related Limitations

- {{DESCRIBE: Papers with poor reporting affected extraction quality}}
- {{DESCRIBE: Ambiguous data definitions or missing information}}
- {{DESCRIBE: How limitations affected data quality distribution}}

### Validation Limitations

- {{DESCRIBE: Validation coverage <50%? Limited to certain paper types?}}
- {{DESCRIBE: How limitation affects confidence in results}}
- {{DESCRIBE: Planned sensitivity analyses to address}}

---

## 7. Compliance Checklist

**Before submitting, verify all items:**

### Section 1: AI Tools (Answers should be ✅ Complete)

- [ ] Claude model version documented with release date (e.g., "Claude 3.5 Sonnet, Oct 22, 2024")
- [ ] MAestro tool versions listed (Microscope v{{X}}, Compiler v{{X}}, Oracle v{{X}})
- [ ] Model capabilities explained
- [ ] Model limitations transparently documented

### Section 2: Human Validation (Answers should be ✅ Complete)

- [ ] Validator name, credentials, and expertise specified
- [ ] Validation coverage reported (e.g., "3 of 14 papers")
- [ ] Inter-rater agreement metrics provided (percentage or kappa value)
- [ ] Conflict resolution process documented with examples

### Section 3: Data Quality (Answers should be ✅ Complete)

- [ ] 🟢/🟡/🔴 percentages with counts reported
- [ ] Interpretation guidance provided (acceptable vs. concerning thresholds)
- [ ] Quality breakdown by paper or variable shown
- [ ] Visualization included (pie chart recommended)

### Section 4: Prompts & Reproducibility (Answers should be ✅ Complete)

- [ ] GitHub commit hashes provided for all prompts
- [ ] GitHub URLs tested and working
- [ ] Statement: "No modifications" OR detailed description of changes
- [ ] Reproducibility statement included

### Overall Completeness

- [ ] All 7 sections completed
- [ ] Compliance checklist items marked ✅
- [ ] No red flags identified (see below)
- [ ] Ready for peer review

---

## 8. Troubleshooting FAQ

**Q: My data quality is only 60% green. Can I publish?**

A: Depends on context:
- **Exploratory analysis:** 60% acceptable if clearly labeled "preliminary"
- **Publication-grade meta-analysis:** Recommend >80% green
- **Mitigation:** Include sensitivity analysis excluding red data; discuss limitations

**Q: I modified the MAestro prompts. What do I do?**

A: Do not claim reproducibility. Instead:
1. Provide full text of modified prompt in appendix
2. Justify modifications (what was missing from standard prompt?)
3. Document expected impact on results
4. Plan sensitivity analysis comparing standard vs. modified extraction

**Q: How do I find the GitHub commit hash?**

A: Two methods:
- **Command line:** `git log --oneline prompts/microscope_v1.0.md | head -1`
- **GitHub web:** Click "History" on file page; find relevant date; copy hash from URL

**Q: My validation coverage is <20%. Is that OK?**

A: Minimal. Recommended:
- Minimum 20% of papers (or 50+ data points)
- For large meta-analyses (>50 papers): at least 10-15% coverage
- High-priority studies should be validated first
- Increase coverage if agreement rate <90%

**Q: What if my validator is very busy?**

A: Streamline the process:
- Validate only high-stakes variables (primary outcome, sample size)
- Use random sampling (3 papers min. from 14-20 paper reviews)
- Consider second reviewer for inter-rater reliability check on 1-2 papers
- Document timeline and any coverage limitations

---

## 9. File References & Links

### Data & Code Availability

- **Compiled Dataset:** {{GITHUB_LINK_TO_CSV}}
- **Individual Data Cards:** {{GITHUB_LINK_TO_CARDS}}
- **Analysis Code (Python):** {{GITHUB_LINK_TO_PYTHON}}
- **Analysis Code (R):** {{GITHUB_LINK_TO_R}}
- **Raw Validation Notes:** {{GITHUB_LINK_OR_SUPPLEMENTARY}}

### MAestro Repository

- **Main Repository:** https://github.com/maestro-meta/maestro
- **Microscope v{{VERSION}}:** {{GITHUB_COMMIT_LINK}}
- **Compiler v{{VERSION}}:** {{GITHUB_COMMIT_LINK}}
- **Oracle v{{VERSION}}:** {{GITHUB_COMMIT_LINK}}

### Related Documentation

- **RAAA Usage Guide:** [link to docs/raaa-usage.md]
- **Quick Start Guide:** [link to docs/quickstart.md]
- **Best Practices:** [link to docs/best-practices.md]

---

## 10. Suggested Format Adaptations by Venue

### For Journal Article (Appendix A)

Keep to 2-4 pages. Focus on:
- AI Tools (1 table)
- Validation summary (1 paragraph + metrics table)
- Data Quality (1 visualization + interpretation)
- Prompts (GitHub links only, no full text)

### For Preprint Supplement

Include full content above plus:
- Extended validation documentation (all papers, not sample)
- Full prompt text (not just GitHub links)
- Additional sensitivity analyses
- Detailed quality breakdown by variable

### For Thesis

Integrate with methodology chapter and include detailed appendix:
- Main text: Brief AI methodology description (100-200 words)
- Methodology chapter section: Extraction workflow with examples
- Appendix: Complete RAAA documentation as above

---

## Additional Resources

See RAAA Usage Guide for:
- Data quality visualization code (Python/R)
- Developer integration scripts
- Standards alignment documentation
- Extended examples from different research areas

---

---

**End of RAAA Template**

**Publication Status:** Ready for peer review
**Version:** 1.0
**Last Updated:** {{TODAY_DATE}}
**Repository:** https://github.com/maestro-meta/maestro/blob/main/templates/raaa_appendix.md

