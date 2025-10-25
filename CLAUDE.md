# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**MAestro** is an AI-assisted meta-analysis framework that extracts research data, compiles datasets, and generates reproducible statistical analyses. The project is in MVP (v0.1.0-alpha) phase with three core workflow pillars:

1. **Microscope** - Research paper data extraction with three-tier confidence labeling (🟢🟡🔴)
2. **Compiler** - Dataset standardization and compilation into CSV/TSV formats
3. **Oracle** - Reproducible R/Python statistical code generation

**Critical Context:** This is a prompt-template-based framework for researchers using Claude Code directly. There is no backend API or web interface in the MVP phase. Future phases (CROS and Extension) will add Python CLI tools and VS Code extension integration.

---

## Architecture & Data Flow

### Three-Tier Workflow

```
Research Paper
    ↓
[Microscope] → Extract data with confidence labels (🟢 high confidence, 🟡 calculated/inferred, 🔴 missing/uncertain)
    ↓
Data Cards (YAML + markdown with evidence documentation)
    ↓
[Compiler] → Standardize and compile into analysis-ready CSV
    ↓
Compiled Dataset (structured format with metadata)
    ↓
[Oracle] → Generate statistical code (R/Python)
    ↓
Analysis Results
```

### Key Data Structures

**Data Card (template):** `templates/data_card.md`
- YAML frontmatter with study metadata and quality assessment
- Outcome tables with three-color source labeling
- Evidence documentation for every labeled data point
- Quality assessment across 5 domains: selection bias, measurement, confounding, attrition, reporting

**Compiled Dataset Schema:** `docs/compiled-data-schema.md`
- Standardized CSV structure with columns for study ID, outcome, effect size, confidence limits
- `source_color_label` column tracks confidence (GREEN, YELLOW, RED)
- Sample data: `examples/sample_meta_analysis/compiled/sample_compiled_data.csv`

**Prompt Versions:** Located in `prompts/` with semantic versioning (v1.0, v1.1, etc.)
- Each version has a CHANGELOG documenting improvements
- Fixes are beta-tested before release (see Story 3.5 beta testing)
- Multi-arm trial handling, anti-hallucination safeguards, and diagnostic metric rules are key v1.1 enhancements

---

## File Organization

```
maestro/
├── prompts/                      # Core prompt templates (immutable per version)
│   ├── microscope/
│   │   ├── microscope_v1.0.md
│   │   ├── microscope_v1.1.md   (current)
│   │   ├── CHANGELOG.md
│   │   └── ...
│   ├── compiler/                (similar structure)
│   └── oracle/                  (similar structure)
│
├── templates/                    # User-facing templates to copy
│   ├── data_card.md            (main template for data extraction)
│   ├── raaa_appendix.md        (AI transparency template for publication)
│   ├── methodology-preprint.md
│   └── ...
│
├── modules/                      # Discipline-specific quality checklists
│   ├── generic/                 (cross-discipline)
│   │   └── generic_quality_checklist.md
│   └── rob2/                    (bias assessment for RCTs)
│       └── rob2_quality_checklist.md
│
├── docs/                         # User documentation
│   ├── quickstart.md            (15-minute getting started)
│   ├── best-practices.md        (1,420 lines; cost, optimization, troubleshooting)
│   ├── architecture/            (technical architecture deep-dive)
│   ├── case-studies/            (3 validated real-world examples)
│   ├── launch/                  (community launch materials)
│   │   ├── community-launch-plan.md
│   │   ├── metrics-dashboard.md
│   │   ├── support-plan.md      (24/48hr SLA)
│   │   └── testimonials.md
│   └── ...
│
├── examples/                     # Working examples
│   ├── sample_meta_analysis/    (esophageal cancer CTC meta-analysis)
│   │   ├── source_papers/       (11 papers across 3 disciplines)
│   │   ├── data_cards/          (gold standards: 4 papers)
│   │   ├── compiled/            (sample_compiled_data.csv)
│   │   └── analyses/            (R/Python results from Oracle)
│   └── ...
│
├── tests/validation/            # Beta testing & validation
│   ├── gold_standards/          (4 manually extracted reference data cards)
│   ├── microscope_accuracy_analysis.md
│   ├── failure_modes.md         (documented error patterns & mitigations)
│   ├── labeling_coverage_analysis_RESULTS.md
│   └── TESTING_STATUS.md
│
├── .github/workflows/           # CI/CD automation
│   ├── test.yml                (lint, type check, docs build)
│   ├── deploy-docs.yml         (mkdocs build → GitHub Pages)
│   └── validate-prompts.yml    (prompt structure validation)
│
├── .bmad-core/                 # Project management framework (agents, checklists, templates)
│   ├── agents/                 (PO, Dev, QA, architect personas)
│   ├── checklists/             (story DOD, QA gates)
│   └── ...
│
└── docs/qa/gates/              # Quality gate decision records (20 gates, 20 PASS)
    ├── 1.1-initialize-repository.yml
    ├── 1.6-test-microscope-sample-papers.yml
    ├── 2.6-test-end-to-end-workflow.yml
    └── ...
```

---

## Critical Architectural Principles

### 1. Three-Color Confidence System

Every data point must be labeled:
- **🟢 GREEN:** Directly reported in paper with clear source (page, table, figure)
- **🟡 YELLOW:** Calculated from reported values OR extracted from visual but requiring verification
- **🔴 RED:** Missing, uncertain, or impossible to verify from paper

**Evidence Requirements:** All labels must include:
- Page number, table/figure reference, or explicit source
- For 🟡: Show calculation (e.g., "SD calculated from 95% CI using formula X")
- For 🔴: Explain why data is missing or uncertain

This system enables quality assessment and sensitivity analyses (meta-regression by confidence level).

### 2. Quality Assessment Framework (5 Domains)

Every study is rated on:
1. **Selection Bias** - Randomization, allocation concealment, baseline equivalence
2. **Measurement** - Outcome measure validity, blinding, consistency
3. **Confounding** - Covariate adjustment, fidelity, contamination
4. **Attrition/Missing Data** - Overall dropout, differential attrition, ITT analysis
5. **Reporting Transparency** - Pre-registration, outcome completeness, statistical detail

Each domain → Low/Medium/High risk. Used in sensitivity analyses and meta-regression.

### 3. Multi-Arm Trial & Anti-Hallucination Safeguards (v1.1)

**Multi-arm detection:** If >1 intervention arm vs. control:
- Extract ALL pairwise comparisons with labels
- Identify primary comparison if stated
- Document analysis type (ITT, adjusted, subgroup)

**Anti-hallucination checks:**
- Flag suspiciously round effect sizes (0.50, 1.00, 1.50 exactly)
- Verify calculated values match visible data
- For large/poor-OCR PDFs (>20 pages, low quality): use 🟡🔴 labels conservatively

### 4. Discipline-Specific Reporting Patterns

Documented patterns vary significantly:
- **Medicine:** 56% 🟢 (high journal standards, CONSORT compliance)
- **Psychology:** 51% 🟢 (incomplete ITT reporting, missing SDs common)
- **Education:** 43% 🟢 (intervention fidelity/specificity gaps, variable norms)

When uncertain, apply conservative labeling and document why.

### 5. Version Control for Prompts

Prompts are immutable after release:
- New fixes → new version (v1.0 → v1.1)
- CHANGELOG.md documents all improvements
- Backwards compatible data cards (old cards work with new prompts)
- GitHub commit hashes pinned for reproducibility (RAAA transparency)

---

## Common Development Commands

### Documentation

```bash
# Build documentation site locally
mkdocs serve                    # Live preview at http://localhost:8000

# Build for production
mkdocs build                    # Output to site/ directory

# Validate documentation build (used in CI)
mkdocs build --strict          # Fails on warnings (check deploy-docs.yml for --strict handling)
```

### Code Quality (Python, for CROS phase)

```bash
# Format with black
poetry run black maestro/

# Lint with ruff
poetry run ruff check maestro/

# Type check with mypy
poetry run mypy maestro/

# Run tests
poetry run pytest
```

### Git Workflow

```bash
# Feature branch from master
git checkout -b feature/your-feature-name

# Conventional commit format
git commit -m "feat: Add new microscope prompt for qualitative data"
git commit -m "fix: Correct YAML parsing in data card template"
git commit -m "docs: Update contributing guidelines"

# Rebase before PR (don't merge commits)
git rebase -i origin/master

# Push and create PR
git push origin feature/your-feature-name
```

### Validation

```bash
# Validate prompt YAML structure
.github/workflows/validate-prompts.yml  # Automated in CI

# Check data card YAML frontmatter
# Must include: study_id, extraction_date, microscope_version, quality_assessment
```

---

## Key Files for Different Tasks

| Task | Primary File(s) |
|------|-----------------|
| **Add new prompt template** | `prompts/{microscope\|compiler\|oracle}/`, create v1.X.md, update CHANGELOG.md |
| **Add discipline-specific quality checklist** | `modules/{discipline}/` with README.md and checklist.md, requires 2 expert reviewers |
| **Understand three-color system** | `docs/best-practices.md` (Section 3: Data Quality Management) |
| **Debug data card extraction** | `templates/data_card.md` (format reference), `tests/validation/gold_standards/` (examples) |
| **Review quality assessment methodology** | `modules/generic/generic_quality_checklist.md` |
| **Check extraction accuracy benchmarks** | `tests/validation/Story_1.6_FINAL_COMPLETION_REPORT.md` (666 data points, 85.5% accuracy) |
| **Understand multi-arm trial handling** | `prompts/microscope/microscope_v1.1.md` (Section 3.5) |
| **Reference anti-hallucination safeguards** | `prompts/microscope/microscope_v1.1.md` (Section 3.6) |
| **Add case study/success story** | `docs/case-studies/` with real validated data, update README and mkdocs.yml nav |
| **Update launch metrics** | `docs/launch/metrics-dashboard.md` (weekly tracking, escalation triggers) |

---

## Testing & Validation Strategy

### MVP Phase (Current)

- **Manual testing:** Data card extraction validated against gold standards
- **Beta testing:** 7 researchers across 5 disciplines tested on 91 papers (Story 3.5)
- **Gold standards:** 4 manually extracted reference data cards for cross-discipline validation
- **Failure modes:** Documented patterns (FM-001 through FM-014) with fixes applied in v1.1

### CROS Phase (Future)

- Unit tests for Python CLI tools
- Integration tests for end-to-end workflows
- Target >80% code coverage for critical paths
- Automated accuracy benchmarking against gold standards

### Quality Gates

- 20 QA gates (Epic 1-3) all PASS
- Story-level acceptance criteria fully addressed
- Comprehensive documentation for each story

---

## Important Patterns & Conventions

### Data Card Format

```yaml
---
# YAML frontmatter (required fields)
study_id: "smith_2023_rct"           # author_year_design
extraction_date: "2025-10-25"
microscope_version: "v1.1"           # Must match current version
multi_arm_trial: false               # NEW in v1.1
quality_assessment:
  selection_bias: low
  measurement: low
  confounding: medium
  attrition: high
  reporting: medium
overall_quality: "medium"
---

# Markdown section (outcomes with tables)

## Primary Outcome

| Outcome | Effect Size | 95% CI | p-value | Source Label |
|---------|------------|--------|---------|--------------|
| Depression (PHQ-9) | -2.3 | -3.1, -1.5 | 0.001 | 🟢 (Table 3, p. 15) |
| Anxiety (GAD-7) | -1.8 | -2.6, -1.0 | 0.002 | 🟡 Calculated from means/SDs (Table 2, p. 14) |
```

### Commit Message Format

```
feat: Add discipline-specific Microscope prompts for qualitative data extraction
fix: Correct YAML validation for multi-arm trial detection
docs: Update RAAA transparency template with journal-specific guidance
refactor: Streamline anti-hallucination checks in Microscope v1.2 (planned)
```

### PR Description Template

```markdown
## Summary
[1-3 bullet points describing the change]

## Story/Issue
Closes #123 (if applicable)

## Test Plan
[Checklist of manual tests, validation steps, or links to gold standards tested against]

## Documentation Updated
- [ ] docs/best-practices.md (if applicable)
- [ ] CHANGELOG.md (if new prompt version)
- [ ] mkdocs.yml nav (if new page added)
```

---

## Common Pitfalls & Solutions

| Pitfall | Root Cause | Solution |
|---------|-----------|----------|
| "Suspiciously round" effect sizes marked 🟢 | Poor PDF OCR hallucinating numbers | Always verify against visible paper; use 🔴 if unverifiable |
| Multi-arm trial comparisons mixed together | Not detecting multiple intervention arms | Microscope v1.1 explicitly requires listing ALL pairwise comparisons |
| 🟡 labels without calculation shown | Incomplete evidence documentation | Every 🟡 must include: how calculated, from which reported values |
| 🔴 labels without explanation | Insufficient documentation | Every 🔴 must include: why missing and whether re-extraction attempted |
| Data card YAML parsing errors | Quoted strings with special characters | Use YAML-safe formatting; test with `poetry run pytest` |
| Discipline-specific quality checklist not approved | Missing expert peer review | Submit PR with `peer-review-needed` label; need 2 domain expert approvals |
| CI/CD deploy-docs.yml fails | mkdocs build --strict mode with broken links | Architecture documentation has encoding issues; remove --strict temporarily or fix links |

---

## When to Ask for Help

- **Questions about prompt design:** See CONTRIBUTING.md "Submitting Prompt Templates" section
- **Discipline-specific guidance:** Review `modules/{discipline}/` or open a discussion
- **Data extraction edge cases:** Reference `tests/validation/failure_modes.md` or Story 1.6 report
- **Project management/QA:** Check `.bmad-core/` or read relevant story's QA gate decision
- **Community/launch questions:** See `docs/launch/` materials or GitHub Discussions

---

## Key References

- **Product Requirements:** `docs/architecture/high-level-architecture.md`
- **Data Schema:** `docs/compiled-data-schema.md` with Python (`tests/validation/test_compiled_schema_io.py`) and R (`tests/validation/test_compiled_schema_readr.R`) validation
- **Best Practices:** `docs/best-practices.md` (1,420 lines covering cost, optimization, troubleshooting)
- **Transparency & Publication:** `docs/raaa-usage.md` + `templates/raaa_appendix.md`
- **User Validation Results:** Story 3.5 beta testing (7 researchers, 91 papers, real-world use cases)
- **Version Status:** Check `prompts/{microscope|compiler|oracle}/CHANGELOG.md` for current versions

---

**Last Updated:** October 25, 2025 (v0.1.0-alpha)
**Maintained by:** MAestro Contributors
**Next Phase:** CROS (Python CLI tools) planned post-MVP launch
