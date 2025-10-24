# MAestro Methodology Preprint – Draft Outline

**Working Title:** Local-First Meta-Analysis with MAestro: From Prompted Extraction to Transparent Synthesis  
**Version:** Draft 0.1 (2025-10-24)  
**Primary Author:** Solo founder (MAestro)  
**Target Venues:** Meta-Research journal (PeerJ, Research Integrity and Peer Review) or arXiv (stat.ME / cs.HC)

---

## 1. Abstract (To be drafted last)
- 150–200 word executive summary covering problem, approach, validation metrics (accuracy 95.2% on gold standards, 52% time savings), and transparency guarantees.

## 2. Introduction
- Pain points in manual meta-analysis (time, error, transparency gaps).  
- Motivation for AI-assisted workflows and need for auditable automation.  
- Brief history of MAestro development (Epic 1–3 milestones).

## 3. System Overview

### 3.1 Three-Element Toolbox Architecture
- **Microscope v1.1.0:** Data extraction prompt with pre-extraction PDF quality checks, multi-arm handling, and anti-hallucination safeguards.  
- **Compiler v1.1.0:** Aggregation workflow with structural validation, multi-arm summaries, and green/yellow/red source integrity checks.  
- **Oracle v1.1.0:** Analysis generation with small-sample warnings and data quality diagnostics.

### 3.2 Local-First Design Principles
- Offline-first execution, no external servers; data residency on researcher machines.  
- Leverages Claude Code installed by users; MAestro orchestrates prompts locally.  
- Security stance: zero raw research data logged (Rule 5 of coding standards).

### 3.3 Data Card Microservice Model
- Data card template as unit of record; YAML + markdown frontmatter.  
- Alignment with `Project`, `CompiledDataset`, and `ConversationLog` models (docs/architecture/data-models.md).  
- Provenance tracking: prompt template IDs, model versions, and source label retention.

## 4. Methods

### 4.1 Beta Validation Design (Story 3.5)
- Cohort: 7 testers across 5 disciplines, 91 papers, 21 gold standards.  
- Instruments: validation protocol, time logs, labeling evaluation, qualitative interviews.  
- Metrics: accuracy ≥90% target, 50%+ time savings, labeling fidelity, sentiment distribution.

### 4.2 Refinement Cycle (Story 3.6)
- Feedback categorization (33 items; 4 critical fixes).  
- Prompt/documentation updates leading to Microscope/Compiler/Oracle v1.1.0.  
- Regression testing: 10 papers across domains, 100% pass rate; expert re-testing with 0 major issues.

### 4.3 Data Sources for Preprint
- Quantitative tables: `tests/validation/3.5_FINAL_VALIDATION_REPORT.md`, `3.5_time_logs_combined.csv`, `3.5_labeling_distribution_analysis.csv`.  
- Qualitative insights: `3.5_qualitative_feedback_summary.md`, `3.6_beta_feedback_aggregation.md`.  
- Prompt change logs: `prompts/microscope/CHANGELOG.md`, `prompts/compiler/CHANGELOG.md`, `prompts/oracle/CHANGELOG.md`.

## 5. Results (to be expanded with figures/tables)
- **Accuracy:** 20/21 gold standard papers ≥90% field-level match (95.2%).  
- **Time Efficiency:** 52% average reduction (95 → 41 minutes median).  
- **Label Reliability:** Green/yellow/red distribution (74%/21%/4.5%) with false negative rate 28.6% on mismatches.  
- **User Sentiment:** 71.4% positive, 85.7% willingness to adopt, quotes from success stories.  
- **Regression Validation:** 100% pass on 10-paper suite post-refinement.

## 6. Transparency & RAAA Alignment
- Incorporate RAAA appendix guidance (docs/raaa-usage.md, Story 3.3) covering prompt provenance, model versions, and decision audit trails.  
- Document conversation log handling, API token accounting, and synthetic data disclosure.  
- Provide reproducibility package: data cards, compiled datasets, CLI scripts (future CROS phase roadmap).

## 7. Discussion
- Implications for controlled beta launch and academic adoption.  
- Limitations: synthetic validation data pending real-world replication, PDF quality dependency, multi-arm edge cases.  
- Comparison to traditional workflows and related tools.

## 8. Roadmap & Future Work
- Phase 2 (CROS): Python CLI automation, analytics dashboards, data quality monitoring.  
- Phase 3 (Extension): VS Code integration, real-time extraction guidance, community contributions.  
- Plans for open benchmark datasets and collaborative validation.

## 9. Appendices
- **Appendix A:** RAAA transparency appendix (from Story 3.3 template).  
- **Appendix B:** Beta tester roster and consent statements.  
- **Appendix C:** Prompt version matrices and change logs.  
- **Appendix D:** Validation instrument excerpts (time logs, surveys, failure mode catalog).

---

### Writing Next Steps
1. Populate Abstract and Results narrative once Story 3.7 assets finalized.  
2. Export tables/figures from validation CSV files; include forest plot mockups.  
3. Schedule internal review with beta testers (Tester-02 and Tester-05 as co-authors).  
4. Prepare arXiv submission package (LaTeX template + supporting markdown) after QA sign-off.
