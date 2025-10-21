# Technical Assumptions

## Repository Structure: Monorepo

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

## Service Architecture

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

## Testing Requirements

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

## Additional Technical Assumptions and Requests

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
