# Contributing to MAestro

Thank you for your interest in contributing to MAestro! This document provides guidelines for contributing to the project, particularly for discipline-specific modules, prompt templates, and quality checklists.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Contribution Types](#contribution-types)
- [Peer Review Process](#peer-review-process)
- [Development Standards](#development-standards)
- [Submitting Contributions](#submitting-contributions)

## Code of Conduct

MAestro is committed to fostering an open, inclusive, and respectful research community. We expect all contributors to:

- Be respectful and constructive in communications
- Welcome diverse perspectives and research methodologies
- Focus on what is best for the research community
- Show empathy towards other community members
- Credit others' work and contributions appropriately

## How to Contribute

Contributions can take many forms:

1. **Bug reports** - Report issues with prompt templates, documentation, or tools
2. **Feature requests** - Suggest new workflows or improvements
3. **Prompt templates** - Submit new or improved prompt templates for Microscope, Compiler, or Oracle
4. **Discipline modules** - Add quality checklists for specific research disciplines
5. **Documentation** - Improve guides, tutorials, or API documentation
6. **Code contributions** - Enhance CLI tools or VS Code extension (CROS phase and beyond)

## Contribution Types

### Submitting Prompt Templates

Prompt templates are versioned markdown files located in `prompts/`:

**Guidelines:**
- Create a new version file (e.g., `microscope_v1.1.md`) rather than modifying existing versions
- Include a detailed CHANGELOG.md in the prompt directory documenting changes
- Test the prompt with real research papers before submitting
- Provide example outputs demonstrating the prompt's effectiveness
- Follow the prompt template structure established in existing files

**Review criteria:**
- Clarity and specificity of instructions
- Handling of edge cases and ambiguous data
- Adherence to three-tier confidence labeling (🟢/🟡/🔴)
- Reproducibility across different research contexts

### Adding Discipline-Specific Modules

Discipline modules are quality checklists located in `modules/`:

**Guidelines:**
- Create a new directory under `modules/` for your discipline (e.g., `modules/psychology/`)
- Include a checklist file (e.g., `psychology_quality_checklist.md`)
- Provide a README.md explaining the module's purpose and scope
- Reference authoritative sources (e.g., PRISMA, CONSORT, RoB 2)
- Include example applications with real studies

**Peer review process:**
Discipline-specific modules require review by at least **two domain experts** before merging. Reviewers should:
1. Verify alignment with discipline standards and best practices
2. Test the checklist on representative studies
3. Confirm clarity and usability for researchers in the field
4. Suggest improvements or clarifications

To request peer review, add the `peer-review-needed` label to your pull request and tag relevant experts.

### Submitting Examples

Examples help researchers understand MAestro workflows:

**Guidelines:**
- Place examples in `examples/` with descriptive directory names
- Include complete project structure (data cards, compiled datasets, analyses)
- Provide a README.md explaining the example and workflow steps
- Use anonymized or publicly available research data
- Ensure reproducibility by documenting all steps

### Documentation Improvements

Documentation is critical for MAestro's accessibility:

**Guidelines:**
- Follow the existing documentation structure in `docs/`
- Use clear, jargon-free language suitable for researchers from diverse backgrounds
- Include practical examples and step-by-step instructions
- Test documentation with new users when possible
- Update related documentation when making changes

## Development Standards

### Code Style and Quality

**Python (for CROS phase and beyond):**
- Python 3.9+ with type hints (mandatory)
- Format with `black`: `poetry run black maestro/`
- Lint with `ruff`: `poetry run ruff check maestro/`
- Type check with `mypy`: `poetry run mypy maestro/`
- Follow naming conventions: snake_case for functions/modules, PascalCase for classes

**TypeScript (for VS Code extension):**
- TypeScript 5.4+ with strict mode enabled
- Format with `prettier`
- Lint with `eslint`
- Follow naming conventions: camelCase for functions, PascalCase for classes

**General:**
- Use pathlib for cross-platform path handling
- Include comprehensive type hints
- Write self-documenting code with clear variable names
- Add comments for complex logic or non-obvious decisions

### Testing

**For CROS phase and beyond:**
- Write unit tests for new functions and classes
- Include integration tests for workflows
- Ensure tests pass before submitting: `poetry run pytest`
- Aim for high test coverage (>80% for critical paths)

**For MVP phase (current):**
- Manual testing and validation is sufficient
- Document test procedures in pull request descriptions

### Version Control

- Create feature branches from `main`: `git checkout -b feature/your-feature-name`
- Use descriptive commit messages following conventional commits format:
  - `feat: Add new microscope prompt for qualitative data`
  - `fix: Correct YAML parsing in data card template`
  - `docs: Update contributing guidelines`
- Keep commits focused and atomic
- Rebase on `main` before submitting pull requests

## Submitting Contributions

### Pull Request Process

1. **Fork the repository** and create a feature branch
2. **Make your changes** following the development standards
3. **Test thoroughly** - ensure all tests pass and documentation builds
4. **Update documentation** - reflect changes in relevant docs
5. **Submit a pull request** with:
   - Clear title describing the change
   - Detailed description of what changed and why
   - References to related issues (e.g., "Closes #123")
   - Screenshots or examples for UI/template changes
6. **Respond to feedback** - address reviewer comments promptly
7. **Wait for approval** - maintainers will review and merge when ready

### Pull Request Review Criteria

All pull requests must meet these criteria:

- **Code quality:** Passes linting and type checking
- **Testing:** Includes appropriate tests (when applicable)
- **Documentation:** Updates relevant documentation
- **Backwards compatibility:** Avoids breaking existing functionality
- **Clarity:** Code is readable and well-commented
- **Scope:** Focused on a single feature or fix

### Peer Review for Discipline Modules

Discipline-specific modules require additional peer review:

1. Submit pull request with `peer-review-needed` label
2. Maintainers identify and invite domain expert reviewers
3. At least two domain experts approve the module
4. Maintainers merge after successful peer review

## Getting Help

- **Questions:** Ask in [GitHub Discussions](https://github.com/your-org/maestro/discussions)
- **Bug reports:** File an issue with detailed reproduction steps
- **Feature ideas:** Open a discussion to gather feedback before implementation
- **Security issues:** Email security@maestro-meta.org (do not file public issues)

## Recognition

All contributors will be recognized in:
- CONTRIBUTORS.md file
- Release notes for relevant versions
- Project documentation (for significant contributions)

Thank you for helping make MAestro better for the research community! 🎉
