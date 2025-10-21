# MAestro

**Meta-Analysis Extraction, Synthesis, and Transparency Research Orchestrator**

## Overview

MAestro is an open-source framework designed to revolutionize systematic reviews and meta-analyses through AI-assisted workflows. By leveraging Claude Code and structured prompt templates, MAestro enables researchers to:

- **Extract data** from scientific papers with high accuracy using AI-guided microscope workflows
- **Compile datasets** from standardized data cards into analysis-ready formats
- **Generate reproducible analyses** with transparent R/Python statistical code
- **Maintain research integrity** through version-controlled prompts and three-tier confidence labels (🟢/🟡/🔴)

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
   git clone https://github.com/your-org/maestro.git
   cd maestro
   ```

2. **Explore prompt templates:**
   - Browse `prompts/microscope/` for data extraction workflows
   - Check `prompts/compiler/` for dataset compilation instructions
   - Review `prompts/oracle/` for analysis generation guides

3. **Use templates:**
   - Copy templates from `templates/` to start your meta-analysis project
   - Follow examples in `examples/sample_meta_analysis/`

4. **Read the documentation:**
   - Visit our [documentation site](https://maestro-meta.github.io) (coming soon)
   - Review best practices and workflow guides

## Documentation

Full documentation is available at [https://maestro-meta.github.io](https://maestro-meta.github.io) (coming soon).

Key documentation:
- [Quick Start Guide](docs/quickstart.md)
- [Best Practices](docs/best-practices.md)
- [Architecture Overview](docs/architecture.md)
- [API Reference](docs/api/)

## Contributing

We welcome contributions from the research community! MAestro is designed for collaborative development, especially for discipline-specific quality checklists and prompt refinements.

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:
- Submitting new prompt templates
- Adding discipline-specific modules
- Peer review process for quality checklists
- Code style and quality standards

## License

MAestro is licensed under the [MIT License](LICENSE), promoting maximum academic reuse and research community collaboration.

## Community

- **Issues:** [GitHub Issues](https://github.com/your-org/maestro/issues)
- **Discussions:** [GitHub Discussions](https://github.com/your-org/maestro/discussions)

## Citation

If you use MAestro in your research, please cite:

```bibtex
@software{maestro2025,
  title = {MAestro: Meta-Analysis Extraction, Synthesis, and Transparency Research Orchestrator},
  author = {MAestro Contributors},
  year = {2025},
  url = {https://github.com/your-org/maestro}
}
```

---

**Built for researchers, by researchers** 🔬
