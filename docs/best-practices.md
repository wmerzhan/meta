# Best Practices

This guide provides best practices for conducting meta-analyses with MAestro, covering data extraction, compilation, and analysis generation workflows.

## General Principles

### 1. Version Everything

**Prompts**: Always use versioned prompt templates and document which version you used.

```markdown
<!-- In your project README -->
Data extraction: microscope_v1.0.md
Compilation: compiler_v1.0.md
Analysis: oracle_v1.0.md
```

**Data Cards**: Track changes to data cards using Git commits.

**Analysis Code**: Version generated analysis code and link it to the dataset version.

### 2. Maintain Transparency

Document all decisions:
- Why certain data were excluded
- How missing data were handled
- Rationale for analytical choices

### 3. Use Confidence Labels Consistently

Apply the three-tier labeling system rigorously:

- 🟢 **Green**: Only when data are directly reported
- 🟡 **Yellow**: When calculation is straightforward and documented
- 🔴 **Red**: When estimation or assumption is required

## Data Extraction Best Practices

### Before Starting Extraction

1. **Review the Paper Thoroughly**
   - Read abstract and methods first
   - Identify outcome measures and time points
   - Note any data reporting issues

2. **Prepare Your Data Card**
   - Copy the template to a new file
   - Name systematically: `study_001_smith2023.md`
   - Fill in metadata fields

3. **Check Quality Criteria**
   - Review relevant quality checklist (generic, RoB 2, etc.)
   - Note quality issues in data card

### During Extraction

1. **Extract Systematically**
   - Follow the Microscope prompt workflow
   - Extract data in the order presented
   - Double-check numerical values

2. **Apply Confidence Labels**
   - Default to 🟢 for directly reported data
   - Use 🟡 for calculated values with clear formulas
   - Use 🔴 sparingly and document assumptions

3. **Document Decisions**
   - Note ambiguities in extraction notes
   - Explain any calculations or conversions
   - Record page numbers for data locations

### After Extraction

1. **Review for Completeness**
   - Verify all required fields are filled
   - Check for missing data points
   - Ensure confidence labels are applied

2. **Validate Calculations**
   - Re-run any calculations independently
   - Verify converted units or scales
   - Cross-check totals

3. **Store Safely**
   - Commit data card to Git
   - Use descriptive commit messages
   - Tag milestones (e.g., "Completed initial extraction")

## Data Compilation Best Practices

### Before Compilation

1. **Review All Data Cards**
   - Ensure consistent formatting
   - Verify YAML frontmatter is valid
   - Check table structures match

2. **Plan Your Dataset Structure**
   - Decide on wide vs. long format
   - Determine which variables to include
   - Plan handling of missing data

### During Compilation

1. **Use the Compiler Prompt**
   - Follow the workflow systematically
   - Specify output format clearly
   - Document any transformations

2. **Handle Missing Data Explicitly**
   - Don't silently drop missing values
   - Code missing data consistently (NA, empty, etc.)
   - Document missingness patterns

3. **Preserve Confidence Labels**
   - Include label column in compiled dataset
   - Consider aggregating labels (e.g., "all green" vs. "mixed")
   - Use labels to inform sensitivity analyses

### After Compilation

1. **Validate Compiled Dataset**
   - Compare row counts to data card counts
   - Spot-check values against source data cards
   - Verify variable types and ranges

2. **Generate Summary Statistics**
   - Count studies, participants, outcomes
   - Summarize confidence label distribution
   - Check for outliers or anomalies

3. **Document the Compilation**
   - Record compiler version used
   - Note any exclusions or transformations
   - Save compiled dataset with timestamp

## Analysis Generation Best Practices

### Before Analysis

1. **Review Research Question**
   - Clearly state hypotheses
   - Specify primary and secondary outcomes
   - Define subgroup analyses upfront

2. **Choose Analytical Approach**
   - Fixed vs. random effects
   - Meta-regression variables
   - Sensitivity analyses planned

3. **Prepare Dataset**
   - Ensure correct variable types
   - Check for required columns
   - Verify no missing critical data

### During Analysis Generation

1. **Use the Oracle Prompt**
   - Provide clear research question
   - Specify desired outputs (forest plots, tables, etc.)
   - Indicate software preference (R, Python)

2. **Review Generated Code**
   - Read through code line by line
   - Verify package versions are specified
   - Check that code is self-contained

3. **Test Code Execution**
   - Run code in fresh environment
   - Verify all dependencies install correctly
   - Confirm outputs match expectations

### After Analysis

1. **Conduct Sensitivity Analyses**
   - Exclude 🔴 red-labeled data
   - Compare 🟢 green-only vs. all data
   - Test different analytical choices

2. **Validate Results**
   - Compare with manual calculations
   - Check consistency with published studies
   - Verify statistical significance claims

3. **Document Everything**
   - Save analysis script with version tag
   - Record software and package versions
   - Link analysis to specific dataset version

## Project Organization Best Practices

### Directory Structure

Organize your project systematically:

```
my-meta-analysis/
├── data_cards/
│   ├── study_001_smith2023.md
│   ├── study_002_jones2022.md
│   └── ...
├── compiled/
│   ├── dataset_v1.0_2025-01-15.csv
│   └── compilation_notes.md
├── analyses/
│   ├── main_analysis_v1.0.R
│   ├── sensitivity_analysis_v1.0.R
│   └── figures/
├── documentation/
│   ├── extraction_protocol.md
│   ├── inclusion_criteria.md
│   └── quality_assessment.md
└── README.md
```

### Git Workflow

1. **Initialize Git Early**
   ```bash
   git init
   git add README.md .gitignore
   git commit -m "Initial commit"
   ```

2. **Commit Frequently**
   - Commit after each data card
   - Commit after compilation
   - Commit after analysis generation

3. **Use Descriptive Messages**
   ```bash
   git commit -m "Extract data from Smith et al. 2023 (study_001)"
   git commit -m "Compile dataset v1.0 with 15 studies"
   git commit -m "Generate main meta-analysis code (random effects)"
   ```

4. **Tag Milestones**
   ```bash
   git tag -a v1.0 -m "Complete initial analysis"
   git tag -a submission-v1 -m "Version submitted for publication"
   ```

### Collaboration Best Practices

1. **Use Consistent Naming**
   - Agree on file naming conventions
   - Use study IDs consistently across files
   - Document naming scheme in README

2. **Assign Extraction Tasks Clearly**
   - Track who extracted which studies
   - Use branches for parallel extraction
   - Merge carefully and review changes

3. **Review Extractions**
   - Peer review critical data points
   - Cross-check calculations
   - Resolve discrepancies through discussion

## Quality Assurance Best Practices

### Peer Review

1. **Data Card Review**
   - Second reviewer checks 10-20% of data cards
   - Focus on high-impact studies
   - Resolve discrepancies before compilation

2. **Code Review**
   - Review generated analysis code
   - Verify statistical methods are appropriate
   - Check for coding errors or omissions

### Validation Checks

1. **Data Integrity**
   - No duplicate study IDs
   - Consistent variable names
   - Valid ranges for all variables

2. **Statistical Validity**
   - Effect sizes calculated correctly
   - Confidence intervals match reported values
   - Heterogeneity assessed appropriately

3. **Reproducibility**
   - Analysis code runs without errors
   - Results match reported findings
   - Dependencies are documented

## Common Pitfalls to Avoid

### ❌ Don't

- Modify data cards without Git commits
- Mix different prompt template versions
- Ignore 🔴 red confidence labels in main analysis
- Generate analysis code without reviewing it
- Skip documentation steps

### ✅ Do

- Version all prompts, data, and code
- Apply confidence labels consistently
- Document all decisions and assumptions
- Review generated code before execution
- Conduct sensitivity analyses by confidence level

## Additional Resources

- [Architecture Documentation](architecture.md) - Technical design details
- [Contributing Guide](../CONTRIBUTING.md) - How to improve MAestro
- [API Reference](api/index.md) - Detailed API documentation (CROS phase)

---

**Questions?** Join the discussion on [GitHub Discussions](https://github.com/your-org/maestro/discussions)!
