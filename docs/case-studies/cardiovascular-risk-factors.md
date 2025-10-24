# Case Study: Accelerating Cardiovascular Risk Factor Reviews

## Context
- **Beta tester:** Tester-02 (assistant professor in public health / epidemiology)  
- **Research question:** Identify cardiovascular disease risk factors from recent cohort and RCT evidence.  
- **Baseline workflow:** Manual extraction in Excel (≈90 minutes per paper) prior to MAestro beta.  
- **Prompt versions:** Microscope v1.1.0, Compiler v1.1.0, Oracle v1.1.0.

## Workflow
1. Ran Microscope v1.1.0 with the new pre-extraction PDF quality checklist to triage 14 papers (3 gold-standard references).  
2. Logged extraction sessions using the Story 3.5 time-tracking template and uploaded data cards to the shared validation workspace.  
3. Compiled cleaned data cards with Compiler v1.1.0, enabling the multi-arm trial summary to confirm subgroup handling for two nutrition studies.  
4. Generated exploratory heterogeneity analyses in Oracle v1.1.0, capturing MAestro’s code provenance for arXiv preprint drafting.

## Outcomes
- **Papers processed:** 14 total (13 completed during study window, one carried into Story 3.6 follow-up).  
- **Gold standard accuracy:** 3/3 papers ≥90% field-level match (100% success) with no red-label disagreements.  
- **Time savings:** Average extraction time dropped from 90 → 40.8 minutes per paper (55% reduction) after week-two ramp-up.  
- **Confidence shift:** Self-rated trust in extracted fields improved from 2.8 → 4.2 / 5 over six weeks.  
- **User testimonial:** “MAestro saved me hours every week… probably 50-60% faster than doing it all manually.” — Tester-02.

## Lessons
- Pre-extraction PDF screening avoided wasting cycles on two low-quality scans, allowing focus on higher-value papers.  
- Multi-arm comparison prompts ensured cardiovascular subgroup analyses (smokers vs. non-smokers) stayed audit-ready.  
- Recommended next iteration: add automated reminders to review Compiler validation logs before Oracle runs so epidemiology teams can document QA sign-off faster.
