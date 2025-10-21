# API Reference

Welcome to the MAestro API reference documentation.

## Overview

This section provides detailed API documentation for MAestro's CLI tools and programmatic interfaces.

**Note**: Full API documentation will be available in the **CROS Phase** when the Python CLI and programmatic interfaces are implemented.

## Current Phase: MVP

The MVP phase focuses on prompt templates and manual workflows. There are no programmatic APIs available yet.

### Available Resources

- [Prompt Templates](../../prompts/) - Microscope, Compiler, and Oracle workflows
- [File Templates](../../templates/) - Data card and appendix templates
- [Quality Checklists](../../modules/) - Generic and discipline-specific checklists

## Future: CROS Phase

The CROS phase will introduce:

### Python CLI API

Command-line interface for automation:

```bash
# Data card parsing
maestro parse-data-card study_001.md

# Dataset compilation
maestro compile data_cards/ --output compiled/dataset.csv

# Validation
maestro validate data_cards/

# Quality assessment
maestro qa-check data_cards/ --module rob2
```

### Python Programmatic API

Python library for custom workflows:

```python
from maestro import DataCard, Compiler, Validator

# Parse a data card
card = DataCard.from_file("study_001.md")

# Access extracted data
for point in card.extracted_data:
    print(f"{point.outcome}: {point.value} ({point.confidence_label})")

# Compile multiple data cards
compiler = Compiler()
dataset = compiler.compile_cards(["study_001.md", "study_002.md"])
dataset.to_csv("compiled/dataset.csv")

# Validate data
validator = Validator()
issues = validator.validate_card(card)
if issues:
    print(f"Validation errors: {issues}")
```

### Type Definitions

```python
from typing import Literal

ConfidenceLabel = Literal["🟢", "🟡", "🔴"]

class DataPoint:
    outcome: str
    group: str
    n: int
    mean: float
    sd: float
    confidence_label: ConfidenceLabel
    notes: str | None

class DataCard:
    study_id: str
    title: str
    authors: str
    year: int
    extracted_data: list[DataPoint]
    quality_assessment: dict[str, str]
```

## VS Code Extension API

The Extension phase will provide:

### Extension Commands

- `maestro.createDataCard` - Create new data card from template
- `maestro.validateDataCard` - Validate current data card
- `maestro.compileDataset` - Compile data cards in workspace
- `maestro.runQualityCheck` - Run quality assessment

### Extension Events

- `onDataCardSaved` - Triggered when data card is saved
- `onCompilationComplete` - Triggered when compilation finishes
- `onValidationError` - Triggered when validation fails

### WebView API

Interactive panels for:
- Data card editing with live validation
- Dataset compilation preview
- Quality assessment checklist
- Analysis code generation

## Documentation Status

This API documentation will be expanded as features are implemented:

- ✅ MVP Phase: Prompt templates available
- 🚧 CROS Phase: CLI and Python API (in development)
- 📅 Extension Phase: VS Code extension API (planned)

## Contributing to API Design

We welcome feedback on API design! If you have suggestions for the CROS or Extension phase APIs:

1. Open a [GitHub Discussion](https://github.com/your-org/maestro/discussions)
2. Propose your API design with examples
3. Participate in design reviews

## Additional Resources

- [Architecture Overview](../architecture.md) - System design and technical approach
- [Development Setup](../../DEVELOPMENT_SETUP.md) - Set up development environment
- [Contributing Guide](../../CONTRIBUTING.md) - How to contribute code

---

**Check back later for full API documentation as the CROS phase development progresses!**
