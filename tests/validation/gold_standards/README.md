# Gold Standard Data Card Extractions

<!-- Powered by BMAD™ Core -->

This directory contains manually-created "gold standard" data card extractions used to validate the accuracy of Microscope-generated extractions in Story 1.6.

## Purpose

Gold standards serve as ground truth for measuring extraction accuracy. By comparing Microscope-generated data cards against these manually-created extractions, we can:

- Identify extraction errors (incorrect values, missing data, hallucinations)
- Measure labeling accuracy (correct 🟢🟡🔴 classifications)
- Assess quality rating consistency
- Document systematic failure modes

## Creation Process

For each gold standard:

1. **Read paper thoroughly** without using Microscope prompt
2. **Manually extract data** following `templates/data_card.md` format
3. **Apply three-color labels** based on personal expert judgment:
   - 🟢 Direct quotes/observations with page references
   - 🟡 Computed/inferred values with calculation documentation
   - 🔴 Uncertain/missing data with explanations
4. **Document extraction time** (for comparison with Microscope speed)
5. **Record extraction decisions** and rationale in extraction notes

## Naming Convention

Files should be named: `{study_id}_gold.md`

Example: `smith_2023_rct_gold.md`

## Quality Standards

Gold standard extractions should:
- Follow data card format precisely
- Include all required YAML frontmatter fields
- Provide complete source labeling evidence
- Document quality assessment rationale
- Represent expert-level manual extraction

## Usage in Validation

Compare gold standards to Microscope extractions using error taxonomy:

| Error Type | Definition |
|------------|------------|
| Incorrect Value | Wrong number extracted |
| Missing Data Point | Gold standard has it, Microscope missed |
| Hallucinated Data | Microscope extracted non-existent data |
| Wrong Source Label | Incorrect 🟢🟡🔴 classification |
| Missing Evidence | Label without page ref/calculation |
| Calculation Error | Incorrect effect size computation |
| Quality Rating Error | Domain rated incorrectly |
| Format Violation | YAML syntax error, malformed structure |

## Files

_Gold standard extractions will be added during Story 1.6 testing._
