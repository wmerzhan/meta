# Story 3.2: Best Practices Documentation - Expert Review Brief

**Document Version:** 1.0
**Preparation Date:** 2025-10-23
**Primary Deliverable:** `docs/best-practices.md` (1,420 lines)

---

## Purpose of This Review

This document has been created as **comprehensive guidance for researchers optimizing MAestro workflows**. It builds on the Quick Start Guide (Story 3.1, already validated with users) to provide:

- Advanced optimization strategies (cost, performance, workflow)
- Practical solutions to 10 documented failure modes
- Guidance on tool selection (MAestro vs. traditional approaches)
- Data quality management frameworks

**Expert Review Goal:** Validate **methodological accuracy** and **practical usefulness** of guidance, particularly for meta-analysis best practices.

---

## Document Scope & Content Overview

### Section Mapping to Acceptance Criteria

| AC# | Requirement | Document Section | Key Content |
|-----|-------------|------------------|------------|
| AC1 | Cost estimation & budgeting | Section 1 | Per-project cost breakdown; cost factors; calculator template |
| AC1 | Prompt optimization | Section 2 | Token efficiency strategies (batching, caching, pre-screening) |
| AC2 | Tool selection guidance | Section 3 | Exploratory vs. publication-grade matrix; hybrid approaches |
| AC3 | Data quality management | Section 4 | Three-color system; quality distribution interpretation; sensitivity analysis |
| AC4 | Advanced topics | Section 6 | Discipline-specific checklists; heterogeneous designs; team workflows |
| AC5 | Common mistakes | Section 5 | 10 documented failure modes with solutions (synthesized from Stories 1.6 & 3.1) |
| AC6 | Performance optimization | Section 7 | Batching strategies; extraction timing benchmarks; Oracle optimization |
| AC7 | Community resources | Section 8 | Getting help, bug reporting, contribution guidelines, citations |

### Document Statistics

- **Total Length:** 1,420 lines
- **Sections:** 10 major sections + reference
- **Examples:** 40+ concrete examples from Story 2.6 case study (14-paper esophageal cancer CTC meta-analysis)
- **Code Snippets:** 15+ R/Python code examples
- **Tables:** 25+ reference tables
- **Decision Trees:** 5 structured decision frameworks

---

## Key Content to Validate

### 1. Cost Estimation Accuracy (AC1)

**What Reviewers Should Check:**

1. **Example Costs:** Are these realistic for Claude 3.5 Sonnet pricing?
   - Small project (5 papers): ~$0.13
   - Medium project (14 papers): ~$0.39
   - Large project (50 papers): ~$1.50
   - Source: Claude pricing $3/MTok input, $15/MTok output; validated against Story 2.6

2. **Token Consumption Estimates:** Are these accurate?
   - Per-paper Microscope: ~2,000-3,000 tokens (standard papers)
   - Compiler batching: ~800 tokens for 10-20 papers
   - Oracle analyses: ~1,000-3,500 tokens depending on complexity

3. **Cost Savings Claims:** Verify "95-99% cost reduction vs. traditional approach"
   - Traditional Excel-based: 6-8 hours × $25-50/hour = $150-400
   - MAestro: ~$0.40 for 14 papers
   - Claim: 375-1000x cheaper

### 2. Three-Color Labeling Framework (AC3)

**What Reviewers Should Check:**

1. **Labeling Definitions** (Section 4.1):
   - 🟢 = Direct evidence (explicitly stated) → Appropriate?
   - 🟡 = Computed/inferred (with calculation shown) → Clear distinction from 🟢?
   - 🔴 = Uncertain/missing (not reported, requires assumption) → Appropriate for uncertain data?

2. **Quality Distribution Thresholds** (Section 4.2):
   - Table mapping 🟢/🟡/🔴 percentages to confidence levels
   - Recommendation: >80% 🟢 = Excellent, 50-70% 🟢 = Moderate, <50% 🟢 = Low
   - Is this aligned with meta-analysis standards?

3. **Sensitivity Analysis Guidance** (Section 4.4):
   - Recommendation: Re-run excluding 🔴 data
   - Check effect size stability (±10% threshold)
   - CI overlap as validation of robustness
   - Appropriate methodology?

### 3. Tool Selection Framework (AC2)

**What Reviewers Should Check:**

1. **Exploratory vs. Publication-Grade Distinction:**
   - MAestro for: 5-20 papers, exploratory RQs, 4-10 hours work, $0.50-3.00 cost
   - Traditional tools for: 50+ papers, pre-registered protocol, PRISMA 2020, clinical impact
   - Is this realistic distinction?

2. **Hybrid Approach Validity:**
   - Suggestion: Use MAestro for scoping → then formal systematic review
   - Is this a sensible workflow?
   - Any concerns about methodological rigor?

3. **Publication Readiness Guidance:**
   - MAestro results publishable as: Scoping reviews, preliminary analyses, supplementary materials
   - MAestro results NOT for: Formal registered reviews, clinical guidelines, policy decisions
   - Appropriate framing?

### 4. Failure Modes & Solutions (AC5)

**What Reviewers Should Check:**

All 10 documented failure modes from Stories 1.6 & 3.1:

1. **YAML Formatting Issues** → Solution: Template + YAML validator
2. **Missing Metadata Fields** → Solution: Required field checklist
3. **Three-Color Labeling Ambiguity** → Solution: Decision tree (see 4.1)
4. **Context Window Exceeded** → Solution: Section-by-section extraction
5. **Emoji Encoding Issues** → Solution: UTF-8 import (platform-specific)
6. **Heterogeneous Effect Metrics** → Solution: Log-scale standardization
7. **Missing Data Handling** → Solution: Decision framework for inclusion/exclusion
8. **Microscope Hallucination** → Solution: QA spot-check checklist + sensitivity analysis
9. **Compiler Schema Failures** → Solution: Error documentation + field validation
10. **Oracle Code Execution Errors** → Solution: Package installation + path verification

**Check:** Are solutions practical and sufficient to resolve issues without external support?

### 5. Advanced Topics Relevance (AC4)

**What Reviewers Should Check:**

1. **Discipline-Specific Checklists** (Section 6.1):
   - Generic checklist provided as baseline
   - RoB2 (clinical), PRISMA-P (psychology), Campbell (economics) frameworks referenced
   - Appropriate for different meta-analysis contexts?

2. **Heterogeneous Study Design Handling** (Section 6.2):
   - Decision matrix: when to pool vs. stratify
   - Meta-regression example provided
   - Sound statistical guidance?

3. **Large Project Workflow** (Section 6.3):
   - 50-paper project broken into phases (1-5 weeks)
   - Team structure suggested (3-4 extractors, 1 lead, 1 analyst)
   - Realistic timeline and resource estimates?

### 6. Performance Optimization Recommendations (AC6)

**What Reviewers Should Check:**

1. **Batching Strategy** (Section 7.1):
   - Claim: Batch all papers at once (800 tokens) vs. incremental (2,400 tokens) = 67% savings
   - Timing: Both complete in ~30 seconds
   - Recommendation: Always batch → Sound?

2. **Extraction Timing Benchmarks** (Section 7.2):
   - Short papers (5-8 pages): 3-4 min/paper
   - Standard papers (8-12 pages): 4-5 min/paper
   - Long papers (15+ pages): 5-7 min or 3-4 min per section
   - Based on testing; realistic?

3. **Question Optimization** (Section 7.3):
   - Combining related Oracle questions saves 33% cost + produces better code
   - Example: Single call for pooled effect + heterogeneity + subgroups
   - Sound recommendation?

---

## Validation Checklist for Expert Reviewer

**Please mark completion:**

### Methodological Accuracy
- [ ] Cost estimation examples are realistic and well-grounded
- [ ] Three-color labeling framework aligns with data quality best practices
- [ ] Sensitivity analysis recommendations are statistically sound
- [ ] Tool selection guidance appropriately distinguishes use cases
- [ ] Guidance on heterogeneous design handling is methodologically appropriate
- [ ] Quality thresholds (excellent/good/moderate/low) are defensible
- [ ] All code examples are statistically correct

### Practical Usefulness
- [ ] Cost estimation calculator is actionable for users planning projects
- [ ] Optimization strategies are concrete and implementable
- [ ] Failure mode solutions are sufficient to resolve without external help
- [ ] Team collaboration workflows are realistic
- [ ] Timing benchmarks are realistic based on testing data
- [ ] Examples are relevant and concrete

### Completeness
- [ ] All 8 ACs explicitly addressed with sufficient depth
- [ ] Failure modes comprehensively covered
- [ ] Advanced topics provide value beyond Quick Start Guide
- [ ] Community resources section enables ongoing support

### Clarity & Accessibility
- [ ] Explanations accessible to researchers without advanced AI background
- [ ] Technical terminology defined appropriately
- [ ] Examples effectively illustrate concepts
- [ ] Decision trees and frameworks are clear and usable
- [ ] Cross-references to Quick Start work correctly

### Consistency
- [ ] Terminology consistent with Quick Start Guide
- [ ] Example data (esophageal cancer case) used consistently
- [ ] Tone professional and educational throughout
- [ ] Style appropriate for target audience (experienced researchers)

### Accuracy of Technical Details
- [ ] Cost estimates match Claude API pricing
- [ ] Token counts plausible based on documented testing
- [ ] Tool capabilities accurately represented
- [ ] Architecture references correct

---

## How to Conduct This Review

### Time Requirement

Estimated **2-3 hours** for thorough expert review:
- 30 min: Read scope, AC mapping, statistics overview
- 45 min: Deep-dive on Sections 1-4 (cost, optimization, tool selection, data quality)
- 45 min: Deep-dive on Sections 5-7 (mistakes, advanced topics, performance)
- 30 min: Final assessment + validation checklist

### Review Process

1. **Skim full document** (10 min) to understand scope and structure
2. **Deep-read Sections 1-4** (30 min): Focus on cost, three-color system, tool selection
3. **Deep-read Sections 5-7** (30 min): Focus on failure modes, advanced topics, optimization
4. **Section 8-9** (15 min): Community resources and Story 3.1 integration
5. **Validation checklist** (30 min): Complete assessment on provided checklist

### Feedback Incorporation

**Process for integrating expert feedback:**
1. Document all feedback with specific sections referenced
2. Categorize as: Critical (methodological error), Important (clarification needed), Nice-to-have (enhancement)
3. Implement critical changes immediately
4. Schedule follow-up review for important changes if needed
5. Document acknowledgment of reviewer in final publication

---

## Reviewer Credentials Requirements

**Ideal Expert Profile:**
- PhD or equivalent in epidemiology, biostatistics, or health sciences
- 5+ years experience conducting or supervising meta-analyses
- Publication record in systematic reviews/meta-analyses
- Familiarity with PRISMA guidelines and quality assessment tools

**Expertise Areas (any one sufficient):**
- Epidemiology & meta-analysis methodology
- Biostatistics & effect size estimation
- Data quality assessment in systematic reviews
- Research methods & evidence synthesis

---

## Contact & Submission Information

**Review Submission:**
- Provide feedback via: [Process to be defined with reviewer]
- Format: Marked-up document or feedback report
- Timeline: 2 weeks preferred; coordinate with reviewer

**Acknowledgment:**
- Reviewer name and credentials will be documented in final publication
- Citation: "Expert review conducted by [Name], [Affiliation], [Date]"
- Option to remain anonymous available upon request

---

## Expected Outcomes

### If Expert Review PASSES:
- ✅ Document ready for production publication
- ✅ Confidence in methodological accuracy for end users
- ✅ Ready for inclusion in Story 3.2 final deliverables
- ✅ Suitable for external sharing and citation

### If Expert Review Identifies Issues:
- 🔄 Critical issues: Implement changes → Re-review
- 🔄 Important issues: Implement changes → Review updated sections
- 📝 Nice-to-have: Document for future iterations (Story 3.6, etc.)

---

## Additional Resources for Reviewer

**Supporting Documents:**
- `docs/quickstart.md` — Quick Start Guide (Story 3.1, user-tested)
- `docs/stories/2.6.end-to-end-workflow-validation.md` — Case study (14-paper meta-analysis)
- `docs/stories/3.1.create-quick-start-guide-with-example-workflow.md` — User testing results
- `docs/architecture/coding-standards.md` — Documentation standards

**External References:**
- PRISMA 2020 guidelines (systematic review reporting)
- Cochrane Handbook (meta-analysis methodology)
- Risk of Bias 2 (clinical trial quality assessment)

---

**Thank you for reviewing this documentation!**

This expert validation is critical for ensuring MAestro guidance meets academic and methodological standards.

---

**Prepared by:** Dev Agent (Claude Code)
**Date:** 2025-10-23
**Story:** 3.2 - Develop Best Practices Documentation
