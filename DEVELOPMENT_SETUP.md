# Development Setup

This guide provides comprehensive instructions for setting up your development environment for MAestro.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Python Environment Setup](#python-environment-setup)
- [Claude Code Setup](#claude-code-setup)
- [Development Tools](#development-tools)
- [Platform-Specific Notes](#platform-specific-notes)
- [Verification](#verification)
- [Continuous Integration & Deployment](#continuous-integration--deployment)

## Prerequisites

### Required Software

| Tool | Minimum Version | Purpose |
|------|----------------|---------|
| Python | 3.9+ | Core runtime for CLI tools |
| Poetry | 1.8+ | Dependency management and packaging |
| Git | 2.40+ | Version control |
| MkDocs | 1.5+ | Documentation generation |
| Node.js | 20.11.0 LTS | VS Code extension development (future) |

### Optional Tools

- **VS Code** - Recommended IDE for development
- **Claude Code CLI or Desktop** - For AI-assisted workflows

## Python Environment Setup

### 1. Install Python 3.9+

**macOS:**
```bash
# Using Homebrew
brew install python@3.9

# Verify installation
python3 --version
```

**Linux (Ubuntu/Debian):**
```bash
# Update package list
sudo apt update

# Install Python 3.9+
sudo apt install python3.9 python3.9-venv python3-pip

# Verify installation
python3.9 --version
```

**Windows:**
1. Download Python installer from [python.org](https://www.python.org/downloads/)
2. Run installer and check "Add Python to PATH"
3. Verify installation in Command Prompt:
   ```cmd
   python --version
   ```

### 2. Install Poetry

**All Platforms:**
```bash
# Official installer (recommended)
curl -sSL https://install.python-poetry.org | python3 -

# Verify installation
poetry --version
```

**Configure Poetry (optional):**
```bash
# Create virtual environments in project directory
poetry config virtualenvs.in-project true
```

### 3. Install Project Dependencies (CROS Phase and Beyond)

```bash
# Navigate to CLI tools directory
cd tools/cli

# Install dependencies
poetry install

# Activate virtual environment
poetry shell
```

**Note:** For MVP phase, Python dependencies are not yet required as the project consists of markdown templates only.

## Claude Code Setup

### Option 1: Claude Code CLI

**Installation:**
```bash
# macOS/Linux (using Homebrew)
brew install anthropics/claude/claude

# Verify installation
claude --version
```

**Windows:**
Download the installer from [Claude Code website](https://claude.com/claude-code) and follow installation instructions.

**Configuration:**
```bash
# Authenticate with your Anthropic API key
claude auth login

# Verify authentication
claude auth whoami
```

### Option 2: Claude Code Desktop

1. Download from [https://claude.com/claude-code](https://claude.com/claude-code)
2. Install the application
3. Open and authenticate with your Anthropic account
4. Configure workspace settings as needed

## Development Tools

### Git Configuration

```bash
# Set your identity
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Recommended settings
git config --global core.autocrlf input  # macOS/Linux
git config --global core.autocrlf true   # Windows
git config --global pull.rebase false
```

### MkDocs Installation

**For documentation development:**

```bash
# Install MkDocs and Material theme
pip install mkdocs mkdocs-material

# Verify installation
mkdocs --version

# Serve documentation locally
mkdocs serve
```

Access documentation at `http://127.0.0.1:8000/`

### Node.js Installation (Future: VS Code Extension)

**macOS:**
```bash
# Using nvm (recommended)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 20.11.0
nvm use 20.11.0
```

**Windows:**
1. Download installer from [nodejs.org](https://nodejs.org/)
2. Choose LTS version 20.11.0
3. Verify installation:
   ```cmd
   node --version
   npm --version
   ```

**Linux:**
```bash
# Using nvm (recommended)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc
nvm install 20.11.0
nvm use 20.11.0
```

## Platform-Specific Notes

### Windows

**Path Handling:**
- MAestro uses `pathlib` for cross-platform compatibility
- Use forward slashes (`/`) in documentation examples, but Windows backslashes (`\`) will work

**Line Endings:**
- Ensure Git is configured to handle line endings correctly:
  ```cmd
  git config --global core.autocrlf true
  ```

**PowerShell vs CMD:**
- PowerShell is recommended for better Unix-like command compatibility
- Some bash examples may need adaptation for Windows

### macOS

**Permissions:**
- You may need to grant Terminal or iTerm2 full disk access in System Preferences > Security & Privacy

**Homebrew:**
- Install Homebrew first: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

### Linux

**Python Development Headers:**
```bash
# Ubuntu/Debian
sudo apt install python3-dev

# Fedora
sudo dnf install python3-devel
```

**Build Tools:**
```bash
# Ubuntu/Debian
sudo apt install build-essential

# Fedora
sudo dnf groupinstall "Development Tools"
```

## Environment Variables (Optional)

Currently, MAestro does not require environment variables for MVP phase. Future phases may require:

```bash
# Example for CROS phase
export MAESTRO_DATA_DIR="$HOME/maestro-data"
export MAESTRO_LOG_LEVEL="INFO"
```

## Verification

### Verify All Prerequisites

**Create a verification script:**

```bash
#!/bin/bash
# verify-setup.sh

echo "Verifying development environment..."

# Check Python
python3 --version && echo "✅ Python installed" || echo "❌ Python missing"

# Check Poetry
poetry --version && echo "✅ Poetry installed" || echo "❌ Poetry missing"

# Check Git
git --version && echo "✅ Git installed" || echo "❌ Git missing"

# Check MkDocs
mkdocs --version && echo "✅ MkDocs installed" || echo "❌ MkDocs missing"

# Check Node.js (optional)
node --version && echo "✅ Node.js installed" || echo "⚠️  Node.js missing (optional for MVP)"

# Check Claude Code CLI (optional)
claude --version && echo "✅ Claude Code CLI installed" || echo "⚠️  Claude Code CLI missing (optional)"

echo "Verification complete!"
```

**Run verification:**
```bash
chmod +x verify-setup.sh
./verify-setup.sh
```

### Test Documentation Build

```bash
# From repository root
mkdocs build

# Serve locally
mkdocs serve
```

### Test Poetry Environment (CROS Phase)

```bash
# Navigate to CLI tools
cd tools/cli

# Install dependencies
poetry install

# Run tests (when available)
poetry run pytest

# Check code quality
poetry run black --check maestro/
poetry run ruff check maestro/
poetry run mypy maestro/
```

## Continuous Integration & Deployment

### Workflow Overview

- **Tests (`.github/workflows/test.yml`)** — Executes the Python test suite on Ubuntu, Windows, and macOS for every pull request and push to `main`. The job installs `pytest` and only runs it when test files are present; coverage remains placeholder until automated scenarios from Story 1.6 transition from simulation to production (see `docs/stories/1.6.test-microscope-sample-papers.md#dev-agent-record`).
- **Lint (`.github/workflows/lint.yml`)** — Runs `black`, `ruff`, and `mypy` to enforce formatting, lint rules, and typing standards on every pull request and push to `main`.
- **Validate Prompts (`.github/workflows/validate-prompts.yml`)** — Verifies that each prompt template includes required metadata and passes markdown sanity checks whenever prompt files change.
- **Deploy Docs (`.github/workflows/deploy-docs.yml`)** — Builds the MkDocs site with `--strict` mode and deploys it to GitHub Pages on pushes to `main` (can be triggered manually via the Actions tab).

### Run Checks Locally Before Pushing

```bash
# Test suite (skips gracefully if no tests exist yet)
python -m pip install --upgrade pip pytest
pytest

# Formatting, linting, and typing
python -m pip install black ruff mypy
black --check scripts
ruff check scripts
mypy scripts

# Prompt metadata validation
python scripts/ci/validate_prompts.py

# Documentation build parity
python -m pip install mkdocs mkdocs-material
mkdocs build --strict
```

### Branch Protection Configuration

1. Open **Settings → Branches** in the GitHub repository.
2. Create or edit the rule for the `main` branch:
   - Require status checks to pass before merging and select `Tests`, `Lint`, `Validate Prompts`, and `Deploy Docs`.
   - Require at least one approving review before merging.
   - (Optional) Enable additional protections (linear history, signed commits) per team standards.
3. Communicate these rules to new maintainers so the protection stays aligned with the CI setup.

### Debugging Workflow Failures

- Inspect failing runs via the **Actions** tab and expand the failing step for full logs.
- Reproduce locally with the commands above, fix issues, and push a new commit.
- For GitHub Pages failures, download the uploaded artifact to inspect the `site/` output, then re-run the `Deploy Docs` workflow from the Actions UI after fixes.

## Troubleshooting

### Poetry Installation Issues

**Issue:** `poetry: command not found`

**Solution:** Add Poetry to PATH:
```bash
# Add to ~/.bashrc or ~/.zshrc
export PATH="$HOME/.local/bin:$PATH"
source ~/.bashrc  # or ~/.zshrc
```

### Python Version Issues

**Issue:** Multiple Python versions installed

**Solution:** Use `pyenv` for version management:
```bash
# Install pyenv
curl https://pyenv.run | bash

# Install Python 3.9
pyenv install 3.9.18
pyenv global 3.9.18
```

### MkDocs Build Errors

**Issue:** Missing dependencies

**Solution:**
```bash
pip install --upgrade mkdocs mkdocs-material
```

### Git Line Ending Issues

**Issue:** Line ending differences between Windows and Unix

**Solution:**
```bash
# Normalize line endings
git add --renormalize .
git commit -m "Normalize line endings"
```

## Next Steps

Once your environment is set up:

1. **Explore the codebase:**
   - Read `docs/architecture.md` for system overview
   - Review `prompts/` for template structure
   - Check `examples/` for sample projects

2. **Run the project:**
   - For MVP: Explore markdown templates
   - For CROS phase: Run CLI commands
   - For Extension phase: Load VS Code extension

3. **Start contributing:**
   - Review `CONTRIBUTING.md` for guidelines
   - Pick an issue from GitHub Issues
   - Submit your first pull request!

## Support

If you encounter issues not covered here:
- Check [GitHub Issues](https://github.com/your-org/maestro/issues)
- Ask in [GitHub Discussions](https://github.com/your-org/maestro/discussions)
- Review documentation at [https://maestro-meta.github.io](https://maestro-meta.github.io)

Happy coding! 🚀
