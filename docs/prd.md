# MAestro Product Requirements Document (PRD)

## Goals and Background Context

### Goals

- Validate core three-element workflow (Microscope, Compiler, Oracle) with 10+ researchers successfully completing end-to-end exploratory Meta-analyses across 3+ disciplines by Q2 2026
- Achieve 50% time reduction in data extraction phase compared to manual Excel-based workflows through conversation-driven automation
- Establish academic credibility through methodology paper publication in Meta-research journal and 3+ testimonials from established Meta-analysis methodologists by end of 2026
- Build sustainable open-source community with 100+ active users, 50+ GitHub stars, and 20+ community-contributed discipline modules by end of 2026
- Secure pathway to CROS (Conversational Research OS) development by validating technical feasibility and identifying funding source by Q4 2026
- Democratize Meta-analysis methodology by lowering barriers to entry for individual researchers, students, and small teams lacking specialized software or statistical support

### Background Context

Meta-analysis has become the gold standard for evidence-based decision making, yet conducting rigorous Meta-analyses remains an elite practice accessible to fewer than 10% of researchers who could benefit from these methods. Current tools (RevMan, Stata, Covidence) impose steep learning curves requiring weeks-to-months of training, demand expensive licenses ($1,500-$5,000+ annually), and enforce rigid workflows that consume 40-60% of project time on mechanical data processing tasks. This creates fundamental barriers: individual researchers and small teams lack resources for specialized software and dedicated statistical support, limiting accessibility and delaying rapid evidence synthesis in fast-moving fields.

MAestro reimagines Meta-analysis as a conversation-driven workflow built on three atomic tools that combine like building blocks: **Microscope** (deep single-paper analysis), **Compiler** (data aggregation across papers), and **Oracle** (natural language statistical interface). By leveraging Claude Code's capabilities through pure prompt-based workflows, MAestro positions itself as an "idea catalyst" rather than a "precision measurement instrument"—enabling exploratory Meta-analyses in days rather than weeks while maintaining transparency through innovative three-color source labeling (🟢 direct quote, 🟡 computed inference, 🔴 uncertain/missing) and data card microservice architecture. This local-first, Git-based approach meets researchers where they are (markdown, natural conversation) without requiring custom software development, delivering 80% of value for exploratory assessments with 20% of traditional complexity.

### Change Log

| Date | Version | Description | Author |
|------|---------|-------------|--------|
| 2025-10-19 | v0.1 | Initial PRD draft - Goals and Background Context | John (PM Agent) |

## Requirements

### Functional

1. **FR1:** Microscope prompt template enables structured single-paper analysis workflow (screening decision → quality assessment → data extraction) in one continuous conversation
2. **FR2:** Compiler prompt template aggregates multiple data card markdown files into unified datasets with standardized CSV/TSV output format
3. **FR3:** Oracle prompt template translates natural language research questions into executable R/Python statistical analysis code with annotated interpretations
4. **FR4:** Data card markdown format standard includes YAML frontmatter for metadata, markdown tables for extracted data, and integrated three-color source labels
5. **FR5:** Three-color source labeling system tags every data point as 🟢 (direct quote + evidence), 🟡 (computed inference + calculation), or 🔴 (uncertain/missing + warning)
6. **FR6:** Quick Start Guide provides step-by-step tutorial walking through example Meta-analysis (5-10 papers) with troubleshooting guide for common failure modes
7. **FR7:** RAAA (Reproducible AI-Assisted Analysis) appendix template documents prompts used, AI model version, human validation steps, and data quality breakdown by color labels
8. **FR8:** Git integration guidance enables version control for data cards and project files using standard Git workflows
9. **FR9:** Compiler output format ensures compatibility with R (readr::read_csv) and Python (pandas.read_csv) data import functions
10. **FR10:** Oracle generates both R and Python code variants for statistical analyses including pooled effects, heterogeneity (I²), and subgroup analysis
11. **FR11:** Best practices documentation covers prompt optimization, cost estimation, context limit management, and discipline-specific adaptations
12. **FR12:** Data card template includes inline documentation explaining YAML schema, markdown table conventions, and three-color labeling usage

### Non Functional

1. **NFR1:** Microscope processes single paper in <5 minutes (primarily AI response time, not compute-bound)
2. **NFR2:** Data extraction via Microscope achieves 90%+ agreement with expert manual extraction on standardized test papers
3. **NFR3:** Three-color labeling system successfully flags 90%+ of uncertain/computed data in validation studies
4. **NFR4:** New users complete first data card within 45 minutes of reading Quick Start Guide (time-to-first-value threshold)
5. **NFR5:** Local-first architecture keeps all research data on user's machine; only prompts + paper text sent to Claude API
6. **NFR6:** Cross-platform compatibility supports Windows, macOS, and Linux via Claude Code CLI/Desktop application
7. **NFR7:** API cost efficiency targets ~$3-10 per complete project (10-30 papers) through prompt token optimization
8. **NFR8:** Compiler aggregates 100 data cards into unified dataset in <30 seconds
9. **NFR9:** Oracle generates statistical analysis code + interpretation in <2 minutes
10. **NFR10:** System maintains data privacy with secure API key storage using OS keychain (macOS Keychain, Windows Credential Manager, Linux Secret Service)
11. **NFR11:** Documentation maintains <40% bounce rate and average 10+ minute session time indicating quality resource engagement
12. **NFR12:** Prompt templates remain stable and effective across Claude model version updates through version pinning and compatibility testing

## User Interface Design Goals

### Overall UX Vision

**MVP Phase (Prompt-Based Workflow):**
MAestro prioritizes **conversation over clicks**—the interface IS the conversation with Claude Code. Users interact through natural language in their terminal or Claude Code Desktop app, with the "UI" being well-formatted markdown outputs (data cards, analysis results, documentation). This deliberately minimalist approach eliminates GUI complexity that would delay MVP validation, focusing instead on workflow ergonomics: clear prompts, predictable outputs, and human-readable file artifacts.

**CROS Phase (Future Rich Interface):**
Evolve toward "conversational software"—maintaining natural language as primary input modality while adding visual scaffolding for complex operations. Think "VS Code Copilot meets data analysis workbench": users type intent, system provides contextual suggestions, visualizes project state (progress tracking, data quality heatmaps), and surfaces actionable insights without requiring command memorization.

**Core UX Principle:** The system should feel like collaborating with an expert colleague, not operating a machine. Every interaction should reduce cognitive load, preserve research context, and make expertise transparent (not hidden behind automation black boxes).

### Key Interaction Paradigms

1. **Natural Language Commands:** Primary interaction model—users describe intent ("analyze these 10 papers for treatment effects") rather than navigating menus or filling forms
2. **Markdown-Centric Artifacts:** All outputs (data cards, compilations, analyses) stored as human-readable .md files that serve as both data and documentation
3. **Progressive Disclosure:** Simple workflows accessible immediately (single-paper Microscope); advanced features (batch processing, custom quality modules) discovered through documentation and community examples
4. **Stateless Operations (MVP) → Stateful Sessions (CROS):** MVP treats each conversation independently; CROS maintains project memory across sessions (remembers extraction criteria, tracks progress, resumes interrupted workflows)
5. **Three-Stage Collaboration Loop:** (1) AI generates initial output → (2) Human validates/corrects using three-color labels as guide → (3) AI polishes based on feedback. This paradigm repeats at every workflow stage.

### Core Screens and Views

**MVP Phase (No GUI - File/Terminal Based):**
- **Project Folder Structure:** User organizes files in local directory (e.g., `my_meta_analysis/data_cards/`, `my_meta_analysis/compiled/`, `my_meta_analysis/analyses/`)
- **Claude Code Terminal Session:** Primary "screen"—scrolling conversation with command prompts and formatted markdown responses
- **Data Card View:** Individual .md files opened in user's text editor (VS Code, Sublime, Vim) showing structured data with color labels
- **Compiled Dataset View:** CSV/TSV files opened in Excel, R, or Python for statistical analysis
- **Documentation View:** GitHub Pages or local markdown files viewed in browser or editor

**CROS Phase (VS Code Extension Concept):**
- **Project Dashboard:** Visual overview showing extraction progress (15/30 papers completed), data quality summary (🟢 85%, 🟡 12%, 🔴 3%), recent activity
- **Interactive Data Card Editor:** Split view with paper text on left, extracted data table on right; inline three-color labeling with hover tooltips explaining label rationale
- **Conversation Sidebar:** Persistent chat interface for Oracle queries ("What's the pooled effect?") with statistical results embedded inline
- **Quality Control Panel:** Random sampling for validation; conflict flagging for team projects; audit trail visualization
- **PRISMA Flow Diagram Generator:** Auto-populated diagram based on screening decisions tracked across data cards

### Accessibility

**WCAG AA** (CROS Phase Target)

MVP relies on terminal/editor accessibility features. CROS phase targets WCAG AA compliance for VS Code extension (keyboard navigation, screen reader support, sufficient color contrast beyond three-color system, adjustable text sizes).

### Branding

**Minimalist, Academic, Trustworthy Design**

- **Visual Identity:** Academic tool aesthetic (LaTeX, Zotero, Jupyter style); avoid flashy startup branding
- **Color System:** Three-color labels (🟢🟡🔴) are functional, not decorative—consistent across all materials
- **Typography:** Monospace fonts for data/code (Fira Code, JetBrains Mono); serif fonts for documentation (Merriweather, Crimson Text)
- **Logo/Icon:** Microscope emoji 📌 for tool branding; abstract "convergent synthesis" visual concept
- **Tone & Voice:** Documentation is clear, pedagogical, respectful; error messages are helpful and educative; community communications emphasize collaborative open-source ethos

### Target Device and Platforms

**Desktop Cross-Platform: Web Responsive** (Windows, macOS, Linux)

**Supported:**
- Windows 10/11 (PowerShell, Windows Terminal, VS Code)
- macOS 10.15+ (Terminal.app, iTerm2, VS Code)
- Linux - Ubuntu, Fedora, Arch (bash terminals, VS Code)

**NOT Supported:**
- Mobile (iOS/Android) - Meta-analysis workflows require large screens and extended focus sessions
- Web-Only (Browser-Based) - Local-first architecture is non-negotiable for data privacy
- Tablets - Not prioritized for MVP or CROS phases

## Technical Assumptions

### Repository Structure: Monorepo

Single repository containing all MAestro components—prompt templates, documentation, CROS tools (Python CLI + VS Code extension), discipline modules, validation tests, and example projects.

**Repository Structure:**
```
maestro/
├── prompts/              # Microscope, Compiler, Oracle templates
├── modules/              # Discipline-specific quality assessment modules
├── templates/            # Data card format, RAAA appendix, project scaffolding
├── docs/                 # Documentation (Quick Start, best practices)
├── tools/
│   ├── cli/              # Python CLI (CROS phase)
│   └── vscode-extension/ # VS Code extension (CROS phase)
├── tests/                # Validation datasets, benchmark papers
└── examples/             # Sample Meta-analysis projects
```

### Service Architecture

**MVP Phase: No Services - Pure Prompt Execution**

Users interact directly with Claude Code using prompt templates. No backend services, no orchestration layer, no state management beyond filesystem.

**CROS Phase: Local Monolithic Application**

```
User ↔ CROS Interface (Python CLI or VS Code Extension)
              ↓
       Claude API (Anthropic)
              ↓
    Local Filesystem (Data Cards, Outputs)
              ↓
       SQLite (Project Metadata, Logs)
```

Monolithic local application optimized for deployment simplicity, zero network latency between components, easier debugging, and alignment with local-first privacy principles.

### Testing Requirements

**MVP Phase: Manual Validation Studies**
- Manual end-to-end testing with 5-10 beta testers across disciplines
- Validation testing: Systematic comparison against expert manual extraction using benchmark dataset (20-30 papers with gold-standard answers)
- Performance testing: Measure time-to-completion, API costs, accuracy metrics (90% agreement threshold)
- Unit/integration testing NOT prioritized for prompts (resource constraints, declarative nature of prompts)

**CROS Phase: Automated Testing Required**
- Unit tests: Python CLI and VS Code extension with pytest/Jest coverage (target 80%+ for core logic)
- Integration tests: Automated workflow tests (process papers → compile → analyze end-to-end)
- Regression tests: Validate prompt stability across Claude model updates
- User acceptance testing: Continued manual testing with research community

### Additional Technical Assumptions and Requests

**Programming Languages:**
- MVP: No programming required (pure markdown prompt templates)
- CROS Python CLI: Python 3.9+ with type hints (mypy for code quality)
- CROS VS Code Extension: TypeScript 4.5+ for type safety in API interactions
- Statistical Output: R and Python code generation (dual support for maximum user base)

**Frameworks & Libraries:**
- Python CLI: Click/Typer (CLI framework), Rich (terminal UI), Anthropic SDK, Pandas (data validation), SQLite3
- VS Code Extension: VS Code Extension API, Webview API, TypeScript, Anthropic SDK

**APIs & External Services:**
- Anthropic Claude API (claude-3-5-sonnet or latest Sonnet variant) with model version pinning support
- GitHub API (optional, CROS phase) for community module discovery
- Strict local-first architecture—no other external services

**Data Storage:**
- MVP: Filesystem only (markdown files, CSV outputs)
- CROS: Filesystem + SQLite for project configs, conversation history, logs, metrics, preferences
- Filesystem remains primary data store for transparency and Git compatibility
- No cloud database, no remote storage

**Deployment & Distribution:**
- MVP: GitHub repository with GitHub Pages documentation
- CROS Python CLI: PyPI distribution (`pip install maestro-meta`)
- CROS VS Code Extension: VS Code Marketplace
- Semantic versioning (SemVer); optional opt-in anonymous telemetry (feature usage, error rates only—no research content)

**Security & Privacy:**
- API key storage via OS-native secure storage (macOS Keychain, Windows Credential Manager, Linux Secret Service)
- Data transmission: Only prompts + paper text sent to Claude API; extracted data stays local
- Documentation warnings against PHI/PII inclusion
- No analytics tracking of research content

**Version Control:**
- Git integration with best practices documentation for data card versioning
- Recommended branching: feature branches for exploratory analyses, main branch for validated results
- Collaboration model: Async Git-based (no real-time co-editing for MVP/CROS Phase 1)

**Documentation & Licensing:**
- Format: Markdown for all documentation
- Hosting: GitHub Pages
- License: MIT (maximum academic reuse) or Apache 2.0 (stronger patent protection)
- Community modules: Peer review process for discipline-specific contributions

**Performance Targets:**
- Microscope: <5 min per paper
- Compiler: <30 sec for 100 data cards
- Oracle: <2 min for statistical analysis
- CROS Startup: <3 seconds

**Scalability:**
- Target: 10-50 papers (typical exploratory Meta-analysis)
- Maximum tested: 100 papers
- Not designed for: >200 papers (filesystem-based approach limitations documented)

**Platform-Specific:**
- Windows: Path handling with backslashes, PowerShell compatibility
- macOS: Native keychain, Intel and Apple Silicon support
- Linux: Minimal distro-specific dependencies, Ubuntu testing priority

**Internationalization:**
- MVP: English only
- Future: Multi-language support for non-English papers (Claude supports 95+ languages)

## Epic List

### Epic 1: Microscope & Data Card System
Establish foundational repository infrastructure, define data card markdown format standard with three-color labeling system, and deliver Microscope v1.0 prompt template enabling researchers to systematically extract data from individual papers through AI-guided conversations.

### Epic 2: End-to-End Analysis Pipeline (Compiler + Oracle)
Build complete Meta-analysis workflow by delivering Compiler v1.0 for aggregating multiple data cards into unified datasets and Oracle v1.0 for natural language statistical analysis, enabling researchers to progress from extracted data to interpreted results.

### Epic 3: Documentation, Validation & Academic Credibility
Create Quick Start Guide with example workflow, develop Best Practices documentation, design RAAA transparency appendix template, and conduct validation studies with beta testers to establish academic credibility and enable community adoption.

## Epic 1: Microscope & Data Card System

**Goal:** Deliver the foundational atomic unit of MAestro—single-paper data extraction workflow—by establishing repository structure, defining data card markdown format with three-color labeling system, and creating Microscope v1.0 prompt template that guides researchers through screening → quality assessment → data extraction in one conversation.

### Story 1.1: Initialize Repository and Project Structure

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

### Story 1.2: Define Data Card Markdown Format Standard

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

### Story 1.3: Develop Generic Quality Assessment Checklist

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

### Story 1.4: Create Microscope v1.0 Prompt Template

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

### Story 1.5: Create Git Integration Best Practices Guide

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

### Story 1.6: Test Microscope with Sample Papers Across Disciplines

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

### Story 1.7: Setup GitHub Actions CI/CD Pipeline *(PO Validation: Critical Issue #3)*

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

## Epic 2: End-to-End Analysis Pipeline (Compiler + Oracle)

**Goal:** Complete the three-element MAestro toolbox by delivering Compiler v1.0 for aggregating multiple data cards into analysis-ready datasets and Oracle v1.0 for natural language statistical analysis, enabling researchers to progress from extracted data to interpreted forest plots and effect size summaries.

### Story 2.1: Design Standardized CSV/TSV Output Schema

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

### Story 2.2: Create Compiler v1.0 Prompt Template

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

### Story 2.3: Test Compiler with Data Cards from Epic 1

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

### Story 2.4: Create Oracle v1.0 Prompt Template for Statistical Analysis

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

### Story 2.5: Generate and Validate R and Python Code Variants

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

### Story 2.6: Test End-to-End Workflow (Microscope → Compiler → Oracle)

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

## Epic 3: Documentation, Validation & Academic Credibility

**Goal:** Enable community adoption and establish academic legitimacy by creating comprehensive Quick Start Guide with example workflow, developing Best Practices documentation for optimization and advanced usage, designing RAAA transparency appendix template for publication compliance, and conducting validation studies with 5-10 beta testers to verify 90% extraction accuracy and gather testimonials from the research community.

### Story 3.1: Create Quick Start Guide with Example Workflow

As a new user discovering MAestro,
I want a step-by-step tutorial that walks me through my first complete Meta-analysis,
so that I can go from zero to working analysis within 45 minutes without getting stuck or confused.

**Acceptance Criteria:**

1. Quick Start Guide created (`docs/quickstart.md`) walking through complete workflow: project setup → extract data from 5 sample papers using Microscope → compile with Compiler → analyze with Oracle → interpret results
2. Guide uses concrete example from Epic 2 Story 2.6 end-to-end test (research question, actual papers, real results)
3. Every command and prompt shown explicitly with expected outputs (copy-paste ready)
4. Screenshots or terminal output examples included for key steps to set expectations
5. Time estimates provided for each phase (e.g., "Extracting one paper takes ~5 minutes")
6. Troubleshooting section addresses 5-10 most common failure modes from Epic 1-2 testing (format errors, context limits, missing fields)
7. Guide tested with at least 2 naive users (friends/colleagues unfamiliar with MAestro) to validate <45 minute time-to-first-value
8. Links to detailed documentation (data card format, prompt usage guides) provided for users wanting deeper understanding

### Story 3.2: Develop Best Practices Documentation

As a researcher using MAestro for a real Meta-analysis project,
I want guidance on optimizing workflows, managing costs, and handling edge cases,
so that I can use the tools efficiently and avoid common pitfalls that waste time or produce unreliable results.

**Acceptance Criteria:**

1. Best Practices document created (`docs/best-practices.md`) covering: prompt optimization for token efficiency, cost estimation and budgeting (~$3-10 per project), managing context window limits for long papers, discipline-specific adaptations, team collaboration workflows
2. Section on "When to Use MAestro vs. Traditional Tools" addresses exploratory vs. publication-grade Meta-analysis distinction, helps users understand appropriate use cases
3. Data quality management guidance: interpreting three-color labels, when to re-extract 🔴 flagged data, sensitivity analysis recommendations
4. Advanced topics included: customizing quality assessment checklist, handling heterogeneous study designs, managing large projects (50+ papers)
5. Common mistakes documented from Epic 1-2 testing with solutions (e.g., "Don't process papers in single long conversation—use separate sessions per paper")
6. Performance optimization tips: batching strategies, when to use Compiler incrementally vs. all-at-once
7. Links to community resources: where to ask questions, how to contribute discipline modules, how to report bugs
8. Document reviewed by at least one experienced Meta-analysis researcher for methodological accuracy

### Story 3.3: Design RAAA Transparency Appendix Template

As a researcher preparing to publish AI-assisted Meta-analysis,
I want a standardized template for documenting my AI usage transparently,
so that reviewers and readers can evaluate the rigor and reproducibility of my work.

**Acceptance Criteria:**

1. RAAA (Reproducible AI-Assisted Analysis) Appendix template created (`templates/raaa_appendix.md`) with sections: AI Tools Used (Claude model version, MAestro prompt versions), Human Validation Steps (how data was verified), Data Quality Breakdown (percentage 🟢/🟡/🔴 labeled data), Prompts Used (full text or references to versioned prompts in MAestro repo)
2. Template includes example completed appendix from Epic 2 Story 2.6 end-to-end test
3. Guidance on adapting template for different publication venues (journal article appendix, preprint supplement, thesis chapter)
4. Checklist for transparency compliance: "Have you documented AI model version? Have you reported data quality metrics? Have you included validation procedures?"
5. Rationale section explains WHY transparency matters (academic credibility, reproducibility, ethical AI use in research)
6. Template reviewed by at least one Meta-analysis methodologist or journal editor for alignment with emerging reporting standards
7. Integration guidance: how to generate data quality breakdown from compiled dataset, how to reference MAestro prompts (GitHub commit hashes for version pinning)

### Story 3.4: Recruit and Onboard Beta Testers *(PREREQUISITE: Stories 3.1 & 3.2 MUST be completed first)*

As a solo founder ready to validate MVP with real users,
I want to recruit 5-10 beta testers from diverse research backgrounds,
so that I can gather empirical evidence of MAestro's value proposition and identify issues that solo testing missed.

**⚠️ CRITICAL DEPENDENCY**: This story CANNOT begin until Story 3.1 (Quick Start Guide) and Story 3.2 (Best Practices) are completed, as these are required for beta tester onboarding package. *(PO Validation: Critical Issue #5 - Onboarding Sequence)*

**Acceptance Criteria:**

1. Beta tester recruitment outreach conducted: personal network, academic Twitter, relevant Reddit communities (r/AcademicPsychology, r/Scholar), Meta-analysis methodology mailing lists
2. Target diversity achieved: at least 3 different disciplines (medicine, psychology, education, social sciences, economics), mix of post-docs/students/junior faculty, mix of technical comfort levels
3. Selection criteria applied: willingness to commit 10-20 hours over 4-6 weeks, has active Meta-analysis project or willing to conduct exploratory review, comfortable providing detailed feedback
4. Onboarding package created: Quick Start Guide (Story 3.1), Best Practices docs (Story 3.2), feedback survey template, weekly check-in schedule
5. API cost support plan established: subsidize costs if needed (founder covers ~$50-100 for beta phase) or verify testers have institutional Claude access
6. Expectations set clearly: this is MVP with rough edges, focus is exploratory Meta-analysis not publication-grade, testers will encounter bugs and provide detailed reports
7. Communication channel established: Discord server, Slack workspace, or GitHub Discussions for async Q&A and community building
8. Beta testing goals communicated: validate 90% extraction accuracy, measure time savings, identify failure modes, gather testimonials
9. **Recruitment contingency plan defined: if fewer than 5 testers recruited by Week 4 of recruitment phase, pivot to extended solo testing with 20+ diverse papers across 5+ disciplines to maintain validation rigor** *(PO Validation: Must-Fix #5)*

### Story 3.5: Conduct Validation Studies with Beta Testers

As a solo founder seeking to validate MVP assumptions,
I want beta testers to complete systematic validation studies,
so that I can empirically verify extraction accuracy, time savings, and usability claims before broader release.

**Acceptance Criteria:**

1. Validation protocol designed: each beta tester extracts data from 10-20 papers using Microscope, at least 3 papers per tester have expert manual extraction "gold standard" for comparison (pre-existing or tester provides their own)
2. Accuracy validation conducted: compare AI-extracted data against gold standard, calculate agreement percentage (target: 90%+ for 🟢 labeled data, document disagreement patterns)
3. Time savings measured: testers log extraction time per paper and compare against their typical manual workflow (target: 50% reduction)
4. Usability metrics collected: time-to-first-data-card for new users (target: <45 minutes), task completion rate (target: 80%+ complete 10+ papers), user confidence self-ratings
5. Three-color labeling effectiveness evaluated: percentage of uncertain/computed data successfully flagged 🟡/🔴, false positive/negative rates
6. Failure mode documentation: collect all errors, bugs, confusion points, prompt failures encountered by beta testers with categorization
7. Qualitative feedback gathered: structured interviews or surveys asking "What worked well? What frustrated you? Would you use this for real projects? What's missing?"
8. Results documented in validation report with aggregate statistics, anonymized user quotes, recommendations for improvement

### Story 3.6: Refine Prompts and Documentation Based on Beta Feedback

As a solo founder committed to iterative improvement,
I want to systematically address feedback from beta testing,
so that subsequent users have better experience and higher success rates.

**Acceptance Criteria:**

1. Feedback analysis conducted: categorize all beta tester issues by type (prompt bugs, documentation gaps, usability problems, missing features), prioritize by frequency and severity
2. Prompt refinements implemented: update Microscope, Compiler, Oracle templates to fix identified bugs and improve clarity (minimum 5 refinements based on feedback)
3. Documentation updates applied: revise Quick Start Guide and Best Practices to address confusion points, add FAQ section with beta tester questions
4. Edge case handling improved: add guidance for failure modes discovered during beta testing that weren't caught in solo testing
5. Version changelog maintained: document all changes made post-beta in CHANGELOG.md with rationale and references to beta feedback
6. Re-testing conducted: at least 2 beta testers invited to re-test refined prompts and confirm improvements
7. Regression prevention: ensure refinements don't break functionality that was working (test with Epic 1-2 sample papers)
8. Beta tester acknowledgments: credit contributors in README and documentation (with permission)

### Story 3.7: Document Success Stories and Prepare for Community Launch

As a solo founder preparing to launch MAestro to wider community,
I want to showcase validated success stories and establish credibility,
so that new users trust the tool and the research community takes it seriously.

**Acceptance Criteria:**

1. Case studies documented: at least 2-3 beta tester projects written up as success stories (research question, papers analyzed, results obtained, user testimonial)
2. Methodology preprint drafted (optional but valuable): describe MAestro approach, three-element toolbox philosophy, three-color labeling system, validation study results—submit to Meta-research journal or arXiv
3. Community launch plan created: Reddit posts, academic Twitter announcement, relevant mailing list outreach, personal network sharing
4. GitHub repository polished: comprehensive README with badges (license, version), clear contribution guidelines, example projects showcased, documentation site live
5. Testimonials collected: at least 3 quotes from beta testers for README and launch materials (with permission and attribution)
6. Launch metrics defined: GitHub stars target (50+ in first month), documentation traffic (100+ unique visitors), community engagement (10+ questions/discussions)
7. Post-launch support plan: commit to responding to issues within 48 hours, weekly community Q&A sessions for first month, roadmap published for Phase 2 features
8. Academic credibility signals: list any Meta-analysis methodologists who reviewed/endorsed approach, reference validation study results, emphasize transparency standards (RAAA appendix)

## Checklist Results Report

**PRD Validation Date:** 2025-10-19
**Overall Completeness:** 88% (Very Strong)
**Readiness:** ✅ READY FOR ARCHITECT

### Executive Summary

The MAestro PRD demonstrates exceptional strategic clarity and appropriate MVP scoping. Epic/story breakdown is well-sequenced with testable acceptance criteria. Minor recommendations for improvement are noted below, but none are blocking for architectural work.

### Validation Results

| Category | Status | Notes |
|----------|--------|-------|
| Problem Definition & Context | PASS (95%) | Exceptionally clear problem statement from Brief |
| MVP Scope Definition | PASS (90%) | Minor CROS details could move to Phase 2 |
| User Experience Requirements | PASS (85%) | Terminal-first assumption flagged for validation |
| Functional Requirements | PASS (92%) | Excellent FR/NFR breakdown |
| Non-Functional Requirements | PARTIAL (75%) | Some targets stated as requirements (NFR2, NFR7) |
| Epic & Story Structure | PASS (95%) | Outstanding breakdown and sequencing |
| Technical Guidance | PASS (88%) | Strong guidance for architect |
| Cross-Functional Requirements | PASS (90%) | Well-covered |
| Clarity & Communication | PASS (93%) | Exceptionally well-written |

### Key Recommendations

**HIGH Priority:**
1. Rephrase NFR2 (90% accuracy) and NFR7 ($3-10 cost) as "validation targets" not absolute requirements
2. Add contingency to Story 3.4 if beta tester recruitment falls short (<5 testers)
3. Consider moving CROS technical details to separate Phase 2 document

**MEDIUM Priority:**
4. Add terminal-first UX validation with 2-3 non-technical users in Epic 1
5. Clarify Git integration as optional, provide "quick start without Git" path
6. Add three-color labeling validation to Story 1.6 with hallucination-prone test cases

**Scope Optimization (Optional):**
- Consider R-only for Oracle v1.0 (defer Python to v1.1)
- Git Integration Guide (Story 1.5) could be v1.1
- RAAA Appendix (Story 3.3) valuable but not blocking for beta testing

### Technical Risks for Architect

1. **Prompt stability across Claude model updates** - high risk, needs version pinning + fallback strategies
2. **Statistical code correctness** - AI-generated R/Python may have subtle bugs, needs validation framework
3. **Three-color labeling reliability** - core value prop depends on 90% flagging accuracy
4. **Context window limits** - some papers may exceed 200K tokens

### Timeline Assessment

- Epic 1: 2-4 weeks ✓ Realistic
- Epic 2: 3-5 weeks ✓ Realistic (Oracle is complex)
- Epic 3: 6-10 weeks ✓ Realistic (mostly beta testing wait time)
- **Total: 11-19 weeks (3-5 months)** - aligns with Brief projections

**Decision:** ✅ READY FOR ARCHITECT - Proceed with architectural design

## Next Steps

### UX Expert Prompt

Review this PRD (docs/prd.md) and the Project Brief (docs/brief.md), then create a comprehensive UI/UX design specification for MAestro's MVP phase (terminal-based workflow with markdown outputs) and CROS phase vision (VS Code extension with conversational interface). Focus on designing the conversation flow for Microscope, Compiler, and Oracle prompts, and define the visual design for three-color labeling system and data card format. Address the terminal-first UX assumption and provide recommendations for reducing cognitive load for non-technical researchers.

### Architect Prompt

Review this PRD (docs/prd.md) and create a comprehensive technical architecture for MAestro MVP. Design the data card markdown format specification with YAML frontmatter schema, define the three-element prompt template architecture (Microscope, Compiler, Oracle), and establish validation frameworks for AI-generated outputs. Address the key technical risks: prompt stability across model updates, statistical code correctness, three-color labeling reliability, and context window limits. Provide implementation guidance for Epic 1 (Microscope & Data Card System) with particular attention to the generic quality assessment framework and Git integration patterns. Ensure all architectural decisions maintain local-first principles and support the 90% extraction accuracy target.
