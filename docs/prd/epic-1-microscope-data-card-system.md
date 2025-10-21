# Epic 1: Microscope & Data Card System

**Goal:** Deliver the foundational atomic unit of MAestro—single-paper data extraction workflow—by establishing repository structure, defining data card markdown format with three-color labeling system, and creating Microscope v1.0 prompt template that guides researchers through screening → quality assessment → data extraction in one conversation.

## Story 1.1: Initialize Repository and Project Structure

As a project maintainer,
I want a well-organized GitHub repository with clear folder structure and foundational documentation,
so that contributors can navigate the project easily and understand how to add prompts, modules, and examples.

**Acceptance Criteria:**

1. Repository created with monorepo structure including `prompts/`, `modules/`, `templates/`, `docs/`, `tests/`, and `examples/` directories
2. README.md includes project overview, quick start placeholder, and links to documentation
3. LICENSE file added (MIT or Apache 2.0, decision documented in ARCHITECTURE.md or similar)
4. .gitignore configured to exclude common IDE files, OS files (.DS_Store), and temporary files
5. CONTRIBUTING.md outlines community contribution guidelines and peer review process for discipline modules
6. Initial GitHub Pages setup configured (even if minimal) to host documentation
7. Repository is publicly accessible on GitHub with appropriate topics/tags for discoverability
8. **Initial commit created with foundational files (README, LICENSE, .gitignore, directory structure) establishing Git baseline** *(PO Validation: Critical Issue #1)*
9. **DEVELOPMENT_SETUP.md created with consolidated environment setup instructions including: Poetry installation, Python 3.9+ version management, Claude Code CLI/Desktop setup, required tools and versions, cross-platform setup notes (Windows/macOS/Linux)** *(PO Validation: Critical Issue #2)*

## Story 1.2: Define Data Card Markdown Format Standard

As a researcher using MAestro,
I want a standardized, well-documented format for storing extracted data as markdown files,
so that my data cards are consistent, human-readable, version-controllable via Git, and compatible with the Compiler tool.

**Acceptance Criteria:**

1. Data card template file created (`templates/data_card.md`) with YAML frontmatter schema for metadata (paper title, authors, DOI, extraction date, extractor, quality assessment scores)
2. Template includes markdown table structures for common data types (participant demographics, outcomes, effect sizes, confidence intervals)
3. Three-color labeling syntax documented and demonstrated in template (🟢 for direct quotes with page/section references, 🟡 for computed values with calculation shown, 🔴 for uncertain/missing with explanation)
4. Inline comments in template explain each section's purpose and usage guidelines
5. Example data card provided (`examples/sample_data_card.md`) showing completed extraction from a real or simulated paper
6. Documentation file (`docs/data-card-format.md`) explains format rationale, YAML field definitions, table conventions, and three-color labeling rules
7. Format validation checklist provided (manual checklist for MVP; automated validation deferred to CROS phase)

## Story 1.3: Develop Generic Quality Assessment Checklist

As a researcher evaluating research paper quality,
I want a discipline-agnostic quality assessment framework that can be integrated into Microscope,
so that I can systematically evaluate study rigor and risk of bias even without access to specialized tools like RoB2 or Campbell checklists.

**Acceptance Criteria:**

1. Generic quality checklist created (`modules/generic_quality_checklist.md`) covering fundamental methodological domains: selection bias, measurement validity, confounding control, attrition/missing data, reporting transparency
2. Checklist items are answerable from typical research paper content (not requiring supplementary materials or external knowledge)
3. Each checklist item includes guidance on what constitutes low/medium/high risk or quality rating
4. Checklist formatted for easy integration into Microscope prompt template (Story 1.4)
5. Documentation explains that discipline-specific modules (RoB2, Campbell, etc.) are Phase 2 additions, and generic checklist is MVP baseline
6. Checklist formatted for easy copy-paste modification by researchers needing custom criteria
7. Example quality assessment structure provided for reference

## Story 1.4: Create Microscope v1.0 Prompt Template

As a researcher conducting a Meta-analysis,
I want a structured prompt template that guides me through systematic paper analysis with Claude Code,
so that I can extract high-quality data consistently across papers without manually designing prompts each time.

**Acceptance Criteria:**

1. Microscope prompt template file created (`prompts/microscope_v1.md`) as reusable markdown document
2. Prompt includes clear sections: (a) screening decision guidance (include/exclude with rationale), (b) quality assessment framework integrating generic checklist from Story 1.3, (c) data extraction instructions emphasizing three-color labeling
3. Template instructs AI to output data in standardized data card format matching Story 1.2 specifications
4. Prompt explicitly requires three-color labeling for all extracted data points with explanations of label criteria
5. Instructions for handling edge cases included (missing data, unclear reporting, conflicting values across paper sections)
6. **Prompt designed to fit within Claude's context window when combined with typical research paper (tested with 8,000-12,000 word papers representing diverse characteristics: standard IMRAD structure with Methods/Results sections, quantitative study with statistical tables, at least one paper with complex nested data requiring inference)** *(PO Validation: Ambiguous Requirement #1)*
7. Version metadata included in template (version number, creation date, compatible Claude model versions)
8. Usage instructions provided (`docs/microscope-usage.md`) explaining how to use the prompt with Claude Code
9. Example quality assessment completed in sample data card (Story 1.2 example) using integrated checklist

## Story 1.5: Create Git Integration Best Practices Guide

As a researcher managing Meta-analysis data over weeks or months,
I want clear guidance on using Git for version control of data cards and project files,
so that I can track changes, revert mistakes, and collaborate with team members without losing work or creating conflicts.

**Acceptance Criteria:**

1. Git best practices documentation created (`docs/git-integration.md`) covering: repository initialization, recommended .gitignore patterns, commit message conventions for research workflows
2. Guide explains branching strategy: main branch for validated extractions, feature branches for exploratory/draft work, how to merge when validation completes
3. Instructions for common workflows provided: "How to version a data card," "How to track extraction criteria changes," "How to handle conflicts when two team members extract the same paper"
4. Documentation assumes basic Git familiarity but provides command examples for all recommended operations
5. Guidance on what NOT to commit (large PDFs, API keys, personal notes files) with .gitignore template
6. Async collaboration workflow explained (no real-time co-editing; use PRs for dual-screening conflict resolution)
7. Troubleshooting section for common Git issues (merge conflicts in data cards, recovering from accidental commits)

## Story 1.6: Test Microscope with Sample Papers Across Disciplines

As a solo founder validating MVP assumptions,
I want to test Microscope v1.0 with 5-10 sample papers from different research disciplines,
so that I can identify failure modes, measure extraction time, and refine the prompt before beta testing with real users.

**Acceptance Criteria:**

1. Sample papers selected representing at least 3 disciplines (e.g., medicine, psychology, education) with varying complexity (simple RCT, meta-analysis, quasi-experimental study)
2. Each sample paper processed using Microscope prompt, generating complete data card following format standard
3. Extraction time measured and documented (target: <5 minutes per paper for typical 8-10 page journal articles)
4. Three-color labeling coverage analyzed: percentage of data points labeled 🟢/🟡/🔴 recorded to establish baseline
5. Known data extraction errors documented (at least 2-3 papers should have "gold standard" manual extraction for comparison, even if informal)
6. Failure modes identified and categorized (prompt misunderstanding, format violations, hallucinated data, context length issues)
7. Refinements to Microscope prompt documented and implemented based on testing results
8. Sample data cards added to `examples/` directory with accompanying source papers (if copyright permits) or detailed descriptions
9. **Terminal output formatting validated with 2-3 non-technical users for readability: test markdown rendering in terminal, three-color emoji visibility across platforms (Windows Terminal, macOS Terminal.app, Linux terminals), error message clarity, progress indicator comprehensibility** *(PO Validation: Critical Issue #4)*

## Story 1.7: Setup GitHub Actions CI/CD Pipeline *(PO Validation: Critical Issue #3)*

As a project maintainer,
I want automated continuous integration and deployment workflows,
so that code quality is enforced consistently and deployment processes are reliable across all platforms.

**Acceptance Criteria:**

1. **GitHub Actions workflow created (`.github/workflows/test.yml`) with cross-platform testing matrix: Ubuntu (latest), Windows (latest), macOS (latest)**
2. **Python linting workflow integrated: black (formatting check), ruff (linting), mypy (type checking) running on every pull request and push to main branch**
3. **Prompt template validation workflow created: validates all prompts in `prompts/` directory have required metadata (version, compatible models, creation date), checks markdown syntax correctness**
4. **Documentation build workflow (`.github/workflows/deploy-docs.yml`) configured to build and deploy MkDocs site to GitHub Pages on push to main branch**
5. **Workflow status badges added to README.md showing build status, test coverage (when applicable), and documentation deployment status**
6. **Branch protection rules configured: require CI checks to pass before merging to main branch, require at least one approval for PRs (for team growth)**
7. **Workflow execution tested: intentionally introduce linting error, verify workflow fails; fix error, verify workflow passes**
8. **CI/CD setup documented in DEVELOPMENT_SETUP.md: how workflows are triggered, how to run checks locally before pushing, how to debug workflow failures**

**Technical Notes:**
- For MVP phase, focus on markdown validation and documentation deployment
- Python testing workflows (pytest) will be added in CROS phase when Python CLI is developed
- Keep workflow files minimal and well-commented for community contributors to understand
