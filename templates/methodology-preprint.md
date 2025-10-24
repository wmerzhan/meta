# {{ title }}
Version: {{ version }}
Last Updated: {{ date }}
Primary Author(s): {{ authors }}
Target Venue: {{ venue }}

---

## Abstract
{{ abstract_placeholder }}

## 1. Introduction
- Problem statement and motivation
- Background on MAestro development and related work

## 2. System Overview

### 2.1 Three-Element Toolbox
- Microscope {{ microscope_version }} – key refinements and role
- Compiler {{ compiler_version }} – validation workflow and guarantees
- Oracle {{ oracle_version }} – analysis generation safeguards

### 2.2 Local-First Design
- Data residency commitments
- Dependency on user-controlled Claude Code installation
- Security and logging policies

### 2.3 Data Card Microservice Model
- Template structure and provenance fields
- Integration with Project and CompiledDataset models
- ConversationLog usage for transparency

## 3. Methods
- Beta validation cohort summary (participants, timeline)
- Instruments and metrics collected
- Refinement/re-testing protocol references

## 4. Results
- Accuracy metrics (gold standard comparisons)
- Time savings analyses
- Label distribution and reliability
- User sentiment and adoption readiness

## 5. Transparency & Compliance
- RAAA appendix linkage and required disclosures
- Prompt version pinning and change log references
- Data availability and reproducibility package contents

## 6. Discussion
- Interpretation of validation outcomes
- Limitations and risks
- Comparison to traditional workflows

## 7. Future Work
- Planned enhancements (CLI, extension, collaborative roadmap)
- Community engagement strategy

## Appendices
- Appendix A: Transparency appendix template mapping
- Appendix B: Beta tester roster and consent summary
- Appendix C: Prompt/version matrices
- Appendix D: Validation instrument snippets

---

### Author Checklist
- [ ] Abstract finalized and approved
- [ ] Figures/tables exported from validation assets
- [ ] RAAA appendix cross-checked against Docs
- [ ] Prompt versions and conversation logs verified
- [ ] Submission package prepared for {{ venue }}
