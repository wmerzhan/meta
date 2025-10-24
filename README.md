# MAestro

![Tests](https://github.com/wmerzhan/meta/actions/workflows/test.yml/badge.svg)
![Lint](https://github.com/wmerzhan/meta/actions/workflows/lint.yml/badge.svg)
![Docs](https://github.com/wmerzhan/meta/actions/workflows/deploy-docs.yml/badge.svg)
![Coverage](https://img.shields.io/badge/coverage-pending-lightgrey)
![Release](https://img.shields.io/badge/version-0.1.0--alpha-blue)
![License](https://img.shields.io/badge/license-MIT-green)

**Meta-Analysis Extraction, Synthesis, and Transparency Research Orchestrator**

## Overview

MAestro is an open-source framework designed to revolutionize systematic reviews and meta-analyses through AI-assisted workflows. By leveraging Claude Code and structured prompt templates, MAestro enables researchers to:

- **Extract data** from scientific papers with high accuracy using AI-guided Microscope workflows
- **Compile datasets** from standardized data cards into analysis-ready formats
- **Generate reproducible analyses** with transparent R/Python statistical code
- **Maintain research integrity** through version-controlled prompts and three-tier confidence labels (green/yellow/red)

MAestro is a **local-first** application where all research data remains on your machine, ensuring data privacy and compliance with research ethics standards.

## Project Status

**Current Phase:** MVP (Minimum Viable Product)  
**Version:** 0.1.0-alpha

The MVP phase provides:
- Prompt templates for data extraction (Microscope), compilation (Compiler), and analysis generation (Oracle)
- Discipline-specific quality checklists (generic and RoB 2)
- File templates for data cards and appendices
- Comprehensive documentation and best practices

Future phases will introduce:
- **CROS Phase:** Python CLI tools for automation and validation
- **Extension Phase:** VS Code extension for enhanced IDE integration

## Quick Start

### Prerequisites

- **Python:** 3.9 or higher
- **Git:** 2.40 or higher
- **Claude Code:** CLI or Desktop version (for AI-assisted workflows)

For detailed setup instructions, see [DEVELOPMENT_SETUP.md](DEVELOPMENT_SETUP.md).

### Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/wmerzhan/meta.git
   cd meta
   ```
2. **Explore prompt templates:**
   - Browse `prompts/microscope/` for data extraction workflows
   - Check `prompts/compiler/` for dataset compilation instructions
   - Review `prompts/oracle/` for analysis generation guides
3. **Use templates:**
   - Copy templates from `templates/` to start your meta-analysis project
   - Follow examples in `examples/sample_meta_analysis/`
4. **Read the documentation:**
   - Visit our [documentation site](https://maestro-meta.github.io)
   - Review best practices and workflow guides

## Documentation

Full documentation is available at [https://maestro-meta.github.io](https://maestro-meta.github.io).

Key documentation:
- [Quick Start Guide](docs/quickstart.md)
- [Best Practices](docs/best-practices.md)
- [Architecture Overview](docs/architecture.md)
- [Compiled Dataset Schema](docs/compiled-data-schema.md) – includes sample CSV outputs (`examples/sample_meta_analysis/compiled/sample_compiled_data.csv`) and validation scripts for Python (`tests/validation/test_compiled_schema_io.py`) and R (`tests/validation/test_compiled_schema_readr.R`)
- [Compiler Usage Guide](docs/compiler-usage.md) – instructions for working with Compiler v1.1.0 (`prompts/compiler/compiler_v1.1.0.md`)
- [API Reference](docs/api/)

## Success Stories

Real-world beta testers validated MAestro across multiple disciplines:
- [Cardiovascular Risk Factor Review](docs/case-studies/cardiovascular-risk-factors.md)
- [K-12 Literacy Interventions](docs/case-studies/literacy-interventions-novice-user.md)
- [Climate Intervention Evidence Synthesis](docs/case-studies/climate-intervention-exploration.md)

## Launch Resources

- [Community Launch Plan](docs/launch/community-launch-plan.md)
- [Launch Metrics Dashboard](docs/launch/metrics-dashboard.md)
- [Methodology Preprint Outline](docs/launch/methodology-preprint.md)
- [Testimonials & Credibility Signals](docs/launch/testimonials.md)
- [Post-Launch Support Plan](docs/launch/support-plan.md)

## Prompt Versions

| Prompt | Current Version | Changelog |
|--------|----------------|-----------|
| Microscope | v1.1.0 | [CHANGELOG](prompts/microscope/CHANGELOG.md) |
| Compiler | v1.1.0 | [CHANGELOG](prompts/compiler/CHANGELOG.md) |
| Oracle | v1.1.0 | [CHANGELOG](prompts/oracle/CHANGELOG.md) |

## Contributing

We welcome contributions from the research community. MAestro is designed for collaborative development, especially for discipline-specific quality checklists and prompt refinements.

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:
- Submitting new prompt templates
- Adding discipline-specific modules
- Peer review process for quality checklists
- Code style and quality standards

## License

MAestro is licensed under the [MIT License](LICENSE), promoting maximum academic reuse and research community collaboration.

## Community

- **Issues:** [GitHub Issues](https://github.com/wmerzhan/meta/issues)
- **Discussions:** [GitHub Discussions](https://github.com/wmerzhan/meta/discussions)

## Citation

If you use MAestro in your research, please cite:

```bibtex
@software{maestro2025,
  title = {MAestro: Meta-Analysis Extraction, Synthesis, and Transparency Research Orchestrator},
  author = {MAestro Contributors},
  year = {2025},
  url = {https://github.com/wmerzhan/meta}
}
```

---

**Built for researchers, by researchers** 🔬
