# Case Study: Scaling Climate Intervention Evidence Synthesis

## Context
- **Beta tester:** Tester-07 (environmental policy PhD student, moderate technical comfort).  
- **Research question:** Assess effectiveness of climate behavior interventions across policy and community trials.  
- **Baseline workflow:** Manual extraction with R/Excel hybrids (≈85 minutes per paper).  
- **Prompt versions:** Microscope v1.1.0, Compiler v1.1.0, Oracle v1.1.0.

## Workflow
1. Employed Microscope v1.1.0 across 12 papers, leveraging the multi-arm handling upgrade to separate policy vs. incentive comparisons.  
2. Used the Story 3.5 time log and weekly usability surveys to monitor confidence growth and flag environmental-specific metrics.  
3. Ran Compiler v1.1.0 to aggregate energy use, emissions, and behavior change outcomes, using the new outlier checks to highlight unit inconsistencies.  
4. Built exploratory meta-analytic models in Oracle v1.1.0 with automatic warnings for small sample counts (k < 5) in subgroup analyses.

## Outcomes
- **Papers processed:** 12 total during beta (volunteered to add a 13th paper during Story 3.6 regression).  
- **Gold standard accuracy:** 3/3 papers achieved ≥90% field-level agreement (100% pass).  
- **Time savings:** Average extraction time fell from 85 → 43.1 minutes (49% reduction) once MAestro glossaries covered environmental metrics.  
- **Confidence shift:** Trust in the labeling system improved from 3.0 → 4.1 / 5, driven by better handling of emissions units.  
- **User testimonial:** “Surprisingly good for environmental science. I’d use it for exploratory reviews right away.” — Tester-07.

## Lessons
- Domain-specific glossary entries (Story 3.6) prevented mislabeling of carbon footprint metrics and accelerated review cycles.  
- Compiler’s multi-row study summary ensured multi-site interventions stayed aligned with policy categories during aggregation.  
- Recommended next iteration: expand automated unit normalization so environmental teams can push results straight into public dashboards.
