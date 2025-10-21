# Tech Stack

⚠️ **CRITICAL SECTION - Single Source of Truth for All Technology Decisions**

## Cloud Infrastructure

**MAestro is a LOCAL-FIRST application with NO traditional cloud infrastructure.**

- **Provider:** N/A (Local Desktop Application)
- **Key External Services:** Claude Code (user's installation)
- **Deployment Model:** Desktop distribution via PyPI (Python CLI) and VS Code Marketplace (Extension)
- **Data Residency:** All research data stored on user's local machine (filesystem + SQLite)

## Technology Stack Table

| Category | Technology | Version | Purpose | Rationale |
|----------|-----------|---------|---------|-----------|
| **Python Runtime** | Python | 3.9+ | CROS CLI runtime and core logic | 3.9 minimum for type hinting improvements; research community standard |
| **Python Package Manager** | Poetry | 1.8+ | Dependency management and packaging | Modern pyproject.toml standard; lockfile for reproducibility |
| **CLI Framework** | Typer | 0.12+ | Command-line interface framework | Built on Click; automatic help generation; Rich integration |
| **Terminal UI** | Rich | 13.7+ | Terminal formatting and progress displays | Beautiful tables, progress bars, syntax highlighting |
| **Python Type Checking** | mypy | 1.9+ | Static type analysis | PRD requirement for code quality; catches bugs pre-runtime |
| **Python Testing** | pytest | 8.0+ | Unit and integration testing | Industry standard; fixture support; excellent plugin ecosystem |
| **Data Validation** | Pydantic | 2.6+ | Schema validation for data cards | Type-safe data models; JSON schema generation; clear validation errors |
| **DataFrame Library** | pandas | 2.2+ | CSV compilation and data manipulation | Research community standard; compatibility with statistical tools |
| **YAML Parser** | PyYAML | 6.0.1+ | Data card frontmatter parsing | Standard YAML library; safe_load for security |
| **Markdown Parser** | python-markdown | 3.6+ | Data card table extraction | Parse markdown tables to structured data |
| **Local Database** | SQLite | 3.45+ (stdlib) | Project metadata, logs, conversation history | Zero-config; file-based; ACID transactions |
| **VS Code Extension Runtime** | Node.js | 20.11.0 LTS | VS Code extension JavaScript runtime | VS Code requirement; LTS for stability |
| **VS Code Extension Language** | TypeScript | 5.4+ | Extension development language | VS Code Extension API requirement; type safety |
| **VS Code Extension Build** | esbuild | 0.20+ | Fast TypeScript bundling | 100x faster than webpack; VS Code recommended |
| **VS Code Extension Testing** | @vscode/test-electron | 2.3+ | Extension integration testing | Official testing harness; runs in VS Code instance |
| **Git** | Git | 2.40+ | Version control for data cards and prompts | Research community standard; collaboration support |
| **Documentation** | MkDocs | 1.5+ | Static site generation for docs | Material theme; markdown-native; GitHub Pages deployment |
| **Code Formatting (Python)** | black | 24.0+ | Automated Python formatting | Opinionated; eliminates bikeshedding; PEP 8 compliant |
| **Code Linting (Python)** | ruff | 0.3+ | Fast Python linter | 10-100x faster than flake8; comprehensive rules |
| **Code Formatting (TS)** | prettier | 3.2+ | Automated TypeScript/JSON formatting | Opinionated; integrates with VS Code |
| **Code Linting (TS)** | eslint | 8.57+ | TypeScript linter | VS Code ecosystem standard; type-aware rules |
| **CI/CD** | GitHub Actions | N/A (latest) | Automated testing and publishing | Free for open source; cross-platform testing |
| **License** | MIT | N/A | Open source license | Maximum academic reuse; research community expectation |

---
