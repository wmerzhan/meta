# Epic 2: End-to-End Analysis Pipeline (Compiler + Oracle)

**Goal:** Complete the three-element MAestro toolbox by delivering Compiler v1.0 for aggregating multiple data cards into analysis-ready datasets and Oracle v1.0 for natural language statistical analysis, enabling researchers to progress from extracted data to interpreted forest plots and effect size summaries.

## Story 2.1: Design Standardized CSV/TSV Output Schema

As a researcher preparing to analyze Meta-analysis data,
I want a well-defined, standardized CSV/TSV output format from the Compiler,
so that I can import aggregated data seamlessly into R, Python, Excel, or statistical software without manual reformatting.

**Acceptance Criteria:**

1. CSV/TSV schema documented (`docs/compiled-data-schema.md`) defining required columns: study_id, authors, year, sample_size, intervention, comparison, outcome_measure, effect_size, confidence_interval_lower, confidence_interval_upper, quality_score, source_color_label
2. Schema includes metadata columns for data provenance: data_card_file, extraction_date, extractor_name
3. Schema accommodates multiple outcome types: continuous (mean difference, standardized mean difference), dichotomous (odds ratio, risk ratio), correlation coefficients
4. Documentation explains how three-color labels are preserved in compiled dataset (source_color_label column with 🟢/🟡/🔴 values)
5. Example compiled CSV file provided (`examples/sample_compiled_data.csv`) showing aggregated results from 5-10 data cards
6. Schema validated for compatibility with R's `readr::read_csv()` and Python's `pandas.read_csv()` (test scripts provided)
7. Guidance on handling missing values and heterogeneous data structures included (e.g., when papers report different effect size metrics)

## Story 2.2: Create Compiler v1.0 Prompt Template

As a researcher with multiple completed data cards,
I want a prompt template that instructs Claude Code to aggregate data cards into unified CSV/TSV datasets,
so that I can transition from distributed markdown files to analysis-ready tabular data without manual copy-paste.

**Acceptance Criteria:**

1. Compiler prompt template file created (`prompts/compiler_v1.md`) with instructions for reading multiple data card markdown files
2. Prompt specifies output format matching Story 2.1 schema exactly (column names, data types, missing value conventions)
3. Template includes logic for handling heterogeneous data cards (different extraction fields, varying quality assessment structures)
4. Prompt instructs AI to preserve three-color labeling in source_color_label column and flag any inconsistencies across data cards
5. Instructions for generating data quality summary included: percentage of data points with 🟢/🟡/🔴 labels, list of papers with high 🔴 counts (potential re-extraction targets)
6. Prompt designed to handle 10-100 data cards within context window limits (tested with at least 20 cards)
7. Usage instructions provided (`docs/compiler-usage.md`) explaining how to specify input directory, output filename, and customization options
8. Error handling guidance included (what to do when data cards have format violations, missing required fields, or conflicting data)

## Story 2.3: Test Compiler with Data Cards from Epic 1

As a solo founder validating the Compiler workflow,
I want to test Compiler v1.0 with data cards generated in Epic 1 Story 1.6,
so that I can verify that aggregation works correctly and identify edge cases before beta testing.

**Acceptance Criteria:**

1. Compiler tested with at least 10 data cards from Epic 1 (sample papers across disciplines)
2. Compilation time measured and documented (target: <30 seconds for 10-20 cards, scaling to 100 cards)
3. Output CSV validated against schema from Story 2.1 (all required columns present, data types correct, no malformed rows)
4. Three-color label preservation verified: manual spot-check that source_color_label column accurately reflects labels from source data cards
5. Data quality summary generated and reviewed: percentage breakdown of 🟢/🟡/🔴 labels matches expectations from Epic 1 testing
6. Edge cases documented and handled: missing fields in data cards, papers with multiple outcomes, heterogeneous effect size metrics
7. Refinements to Compiler prompt implemented based on testing (e.g., improved error messages, better handling of missing data)
8. Example compiled dataset added to `examples/` directory with documented lineage (which data cards were compiled)
9. **Context window limit testing conducted: test compilation with 50 data cards and 100 data cards to verify Claude's context limits are not exceeded, document maximum practical limit, provide guidance for batch compilation if limits are reached** *(PO Validation: Should-Fix #8 / Ambiguous Requirement #2)*

## Story 2.4: Create Oracle v1.0 Prompt Template for Statistical Analysis

As a researcher ready to analyze aggregated Meta-analysis data,
I want a natural language interface to statistical analysis via Claude Code,
so that I can describe my research questions in plain language and receive executable code with interpretable results without mastering R or Python syntax.

**Acceptance Criteria:**

1. Oracle prompt template file created (`prompts/oracle_v1.md`) accepting natural language research questions (e.g., "What is the pooled effect size?", "Is there significant heterogeneity?", "Do effects differ by study quality?")
2. Prompt generates statistical analysis code for common Meta-analysis operations: pooled effect calculation (fixed-effect and random-effects models), heterogeneity assessment (I² statistic, Q-test), subgroup analysis, forest plot generation
3. Template supports both R (using `metafor` package) and Python (using `meta` or custom code) output—user specifies preferred language
4. Generated code includes inline comments explaining each step and statistical concept (pedagogical approach for learning users)
5. Prompt instructs AI to interpret results in accessible language: "The pooled effect size is X (95% CI: Y-Z), indicating a [small/medium/large] [positive/negative] effect. Heterogeneity is [low/moderate/high] (I²=W%), suggesting..."
6. Instructions for handling data quality flags included: Oracle should note when analysis includes high proportion of 🟡 or 🔴 labeled data and recommend sensitivity analyses
7. Usage instructions provided (`docs/oracle-usage.md`) with example research questions and expected code outputs
8. Version metadata and Claude model compatibility noted

## Story 2.5: Generate and Validate R and Python Code Variants

As a researcher with preference for either R or Python,
I want Oracle to produce functional, well-documented code in my chosen language,
so that I can execute analyses in my familiar environment without learning a new language.

**Acceptance Criteria:**

1. Oracle tested with at least 5 common research questions, generating both R and Python variants for each
2. R code validated for correctness: tested by executing with sample compiled dataset from Story 2.3, verifying outputs match expected statistical results
3. Python code validated for correctness: same validation as R (execute with sample data, verify results)
4. Code quality standards met: proper indentation, meaningful variable names, no hard-coded values (uses parameters from compiled data), includes library installation instructions
5. Statistical equivalence verified: R and Python implementations produce same numerical results (within floating-point precision) for identical inputs
6. Forest plot generation tested: both R (using `metafor::forest()`) and Python (using `matplotlib` or similar) produce publication-quality visualizations
7. Documentation of dependencies added: R code lists required packages (`metafor`, `readr`, etc.), Python code lists required packages (`pandas`, `numpy`, `meta`, `matplotlib`)
8. Example code outputs added to `examples/` directory with commented annotations

## Story 2.6: Test End-to-End Workflow (Microscope → Compiler → Oracle)

As a solo founder preparing for beta release,
I want to complete at least one full Meta-analysis workflow from start to finish using all three tools,
so that I can validate the complete value proposition and identify integration issues before real users encounter them.

**Acceptance Criteria:**

1. End-to-end test completed: select a research question, identify 10-15 papers, use Microscope to extract data cards, use Compiler to aggregate, use Oracle to analyze and interpret
2. Total workflow time measured and documented (target: days, not weeks—validating "50% time reduction" claim)
3. Final deliverables produced: compiled CSV dataset, R and Python analysis scripts, forest plot visualization, interpretation summary
4. Data quality audit conducted: review three-color labels in final dataset, calculate percentage of data with 🟢/🟡/🔴 labels, assess whether flags correctly identified uncertain data
5. Comparison against traditional workflow attempted (if feasible): manually extract same data using Excel, compare accuracy and time investment
6. Integration pain points documented: transitions between tools (Microscope → Compiler, Compiler → Oracle), file management challenges, prompt handoff issues
7. User experience notes captured: cognitive load assessment, moments of confusion, unexpected behaviors, suggestions for improvement
8. Refinements implemented across all three prompts based on end-to-end testing insights
9. Success story documented as case study for Epic 3 Quick Start Guide
