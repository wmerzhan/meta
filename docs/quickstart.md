# Quick Start Guide

Welcome to MAestro! This guide will help you get started with AI-assisted meta-analysis workflows.

## Prerequisites

Before starting, ensure you have:

- **Python 3.9+** installed
- **Git 2.40+** installed
- **Claude Code** CLI or Desktop application
- Basic familiarity with meta-analysis concepts

For detailed installation instructions, see [Development Setup](../DEVELOPMENT_SETUP.md).

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/your-org/maestro.git
cd maestro
```

### 2. Verify Installation

```bash
# Check directory structure
ls -la

# You should see:
# - prompts/     (Prompt templates)
# - modules/     (Quality checklists)
# - templates/   (File templates)
# - examples/    (Sample projects)
```

## Your First Meta-Analysis Project

### Step 1: Set Up Project Structure

Create a new directory for your meta-analysis project:

```bash
mkdir my-meta-analysis
cd my-meta-analysis
```

Copy the data card template:

```bash
cp ../templates/data_card.md ./study_001.md
```

### Step 2: Extract Data with Microscope

1. Open your first study paper (PDF)
2. Open the Microscope prompt template: `prompts/microscope/microscope_v1.0.md`
3. Use Claude Code with the Microscope prompt to extract data
4. Save extracted data to your data card file

The Microscope workflow will guide you through:
- Identifying study characteristics
- Extracting outcome data
- Applying three-tier confidence labels (🟢/🟡/🔴)
- Documenting extraction decisions

### Step 3: Compile Dataset

Once you have multiple data cards:

1. Use the Compiler prompt: `prompts/compiler/compiler_v1.0.md`
2. Claude Code will compile data cards into a CSV dataset
3. Review the compiled dataset for consistency

### Step 4: Generate Analysis Code

1. Use the Oracle prompt: `prompts/oracle/oracle_v1.0.md`
2. Provide your compiled dataset and research question
3. Claude Code generates reproducible R or Python analysis code
4. Review and execute the generated code

## Example Workflow

Here's a complete example using the sample project:

```bash
# Navigate to example project
cd examples/sample_meta_analysis

# Explore the structure
ls -la
# data_cards/    - Contains extracted data cards
# compiled/      - Contains compiled datasets
# analyses/      - Contains generated analysis code

# Use Claude Code with Microscope prompt
claude code --prompt ../../prompts/microscope/microscope_v1.0.md

# Follow the prompts to extract data
# Save to data_cards/study_001.md

# Compile all data cards
claude code --prompt ../../prompts/compiler/compiler_v1.0.md

# Generate analysis code
claude code --prompt ../../prompts/oracle/oracle_v1.0.md
```

## Key Concepts

### Data Cards

Data cards are markdown files containing:
- Study metadata (authors, year, journal)
- Extracted data points with confidence labels
- Extraction notes and decisions

**Example structure:**
```markdown
---
study_id: study_001
title: "Effect of Intervention X on Outcome Y"
authors: "Smith et al."
year: 2023
---

## Extracted Data

| Outcome | Group | N | Mean | SD | Label |
|---------|-------|---|------|----|----|
| Anxiety | Treatment | 50 | 12.5 | 2.3 | 🟢 |
| Anxiety | Control | 48 | 15.2 | 2.8 | 🟢 |
```

### Confidence Labels

MAestro uses three-tier confidence labels:

- 🟢 **Green** - High confidence: data directly reported in text/tables
- 🟡 **Yellow** - Medium confidence: calculated from reported data
- 🔴 **Red** - Low confidence: estimated or imputed

### Prompt Templates

Prompt templates are versioned workflows stored in `prompts/`:

- **Microscope** - Data extraction from papers
- **Compiler** - Dataset compilation from data cards
- **Oracle** - Analysis code generation

Each template is versioned (e.g., `microscope_v1.0.md`) to ensure reproducibility.

## Next Steps

- **Explore Examples**: Review `examples/sample_meta_analysis` for a complete project
- **Read Best Practices**: Learn effective workflows in [Best Practices](best-practices.md)
- **Customize Prompts**: Adapt templates to your research domain
- **Join Community**: Contribute improvements via [GitHub](https://github.com/your-org/maestro)

## Troubleshooting

### Common Issues

**Q: Claude Code can't find the prompt template**

A: Ensure you're using the correct relative path from your working directory.

**Q: Data extraction quality is inconsistent**

A: Review the Microscope prompt and ensure you're following the confidence labeling guidelines.

**Q: Compilation fails with parsing errors**

A: Verify your data cards use the correct YAML frontmatter format and markdown table structure.

## Getting Help

- **Documentation**: Browse the [full documentation](index.md)
- **GitHub Issues**: Report bugs or request features
- **Discussions**: Ask questions in GitHub Discussions

---

Happy meta-analyzing! 🔬
