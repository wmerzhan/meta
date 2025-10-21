# Git Integration Best Practices for MAestro

<!-- Powered by BMAD™ Core -->

## Introduction

This guide provides comprehensive Git version control guidance for researchers using MAestro to conduct meta-analyses. Git integration is essential for:

- **Reproducibility:** RAAA (Reproducible AI-Assisted Analysis) requires version-controlled extraction workflows
- **Collaboration:** Teams need async workflows for dual extraction and peer review
- **Safety:** Track changes and recover from mistakes during long meta-analysis projects
- **Academic credibility:** Version history provides audit trail for data extraction decisions

**Prerequisites:** This guide assumes basic Git familiarity (clone, commit, push/pull) but provides complete command examples for all recommended operations.

## Table of Contents

1. [Repository Initialization and Setup](#repository-initialization-and-setup)
2. [Branching Strategy for Research Workflows](#branching-strategy-for-research-workflows)
3. [Common Workflow Guides](#common-workflow-guides)
   - [How to Version a Data Card](#how-to-version-a-data-card)
   - [How to Track Extraction Criteria Changes](#how-to-track-extraction-criteria-changes)
   - [How to Handle Dual Extraction Conflicts](#how-to-handle-dual-extraction-conflicts)
4. [Commit Message Conventions](#commit-message-conventions)
5. [What NOT to Commit](#what-not-to-commit)
6. [Async Collaboration Workflows](#async-collaboration-workflows)
7. [Troubleshooting Common Issues](#troubleshooting-common-issues)
8. [Best Practices and Recommendations](#best-practices-and-recommendations)
9. [Git Command Reference](#git-command-reference)

---

## Repository Initialization and Setup

### When to Initialize Git

**For new meta-analysis projects:**
```bash
# Navigate to your project directory
cd my_meta_analysis

# Initialize Git repository
git init

# Verify initialization
git status
```

**For existing projects:**
If you already have data cards and want to add version control, initialize Git and commit existing files as your baseline.

### Recommended Directory Structure

Your meta-analysis project should follow this structure:

```plaintext
my_meta_analysis/                 # Your project root (Git repository)
├── data_cards/                   # Extracted data (VERSION CONTROLLED)
│   ├── smith-2020.md
│   ├── jones-2019.md
│   └── ...
├── compiled/                     # Compiled datasets (VERSION CONTROLLED)
│   └── dataset_2024-10-20.csv
├── analyses/                     # Statistical analysis code (VERSION CONTROLLED)
│   └── meta_regression.R
├── papers/                       # Research PDFs (NOT version controlled)
│   ├── smith-2020.pdf            # Excluded by .gitignore
│   └── jones-2019.pdf
├── .gitignore                    # Git configuration
├── README.md                     # Project documentation
└── project_config.yaml           # MAestro configuration
```

### Configuring .gitignore

Create a `.gitignore` file in your project root to exclude files that should NOT be version controlled:

```gitignore
# Research papers (copyright, large files)
papers/*.pdf
*.pdf

# Personal notes and temporary files
notes/
personal/
*.notes
*.tmp
*.bak

# SQLite databases (user-specific, CROS phase)
*.db
*.sqlite

# Statistical software temporary files
.Rhistory
.RData
.Rproj.user/

# Python temporary files (if using Python analysis)
__pycache__/
*.pyc
.pytest_cache/
venv/
.env

# IDE and OS files
.vscode/
.idea/
.DS_Store
Thumbs.db
Desktop.ini

# Large compressed data (if not needed for reproducibility)
*.csv.gz
*.zip
*.tar.gz

# Logs
*.log
logs/
```

**Why these exclusions?**
- **PDFs:** Copyrighted research papers are large binary files that bloat Git repositories
- **Personal notes:** Private reviewer comments should remain private
- **Temporary files:** Editor backups and OS files are not research artifacts
- **Databases:** Local SQLite files (CROS phase) are user-specific and should not be shared

### Initial Commit Best Practices

After setting up your project structure and `.gitignore`:

```bash
# Review what will be committed
git status

# Stage all project files (respecting .gitignore)
git add .

# Create initial commit
git commit -m "docs: Initialize meta-analysis project structure"

# Verify commit
git log --oneline
```

**Pro tip:** Always review `git status` and `git diff --cached` before committing to ensure you're not accidentally including sensitive or large files.

---

## Branching Strategy for Research Workflows

### Main Branch Philosophy

The **main** (or **master**) branch contains **validated, peer-reviewed extractions** ready for compilation and analysis.

**Characteristics:**
- Only validated data cards
- Protected: requires pull request review (team projects)
- Tagged at major milestones
- Deployable: ready for Compiler and Oracle

### Feature Branch Workflow

Create feature branches for:
- Individual paper extractions (before validation)
- Experimental methodology changes
- Peer review and corrections
- Draft work

### Branch Naming Conventions

Use descriptive, consistent naming:

```bash
# Individual paper extractions
git checkout -b extraction/smith-2020
git checkout -b extraction/jones-2019-rct

# Peer review and validation
git checkout -b review/smith-2020-validation
git checkout -b review/dual-screening-batch-1

# Experimental methodology changes
git checkout -b experiment/new-quality-criteria
git checkout -b experiment/sensitivity-analysis

# Bug fixes and corrections
git checkout -b fix/brown-2021-effect-size
git checkout -b fix/table-2-typos
```

### Creating and Working with Branches

**Create new branch for paper extraction:**
```bash
# Create and switch to new branch
git checkout -b extraction/smith-2020

# Verify you're on the new branch
git branch
# * extraction/smith-2020
#   main
```

**Make commits on feature branch:**
```bash
# Extract data using Microscope, save to data_cards/smith-2020.md

# Stage and commit
git add data_cards/smith-2020.md
git commit -m "extract: Add Smith et al. 2020 RCT data card"

# Continue working with additional commits as needed
git commit -m "review: Update quality scores after checklist validation"
```

**Merge validated work to main:**
```bash
# Switch to main branch
git checkout main

# Merge feature branch
git merge extraction/smith-2020

# Push to remote (if using GitHub/GitLab)
git push origin main
```

**Clean up merged branches:**
```bash
# Delete local branch after merge
git branch -d extraction/smith-2020

# Delete remote branch (if pushed)
git push origin --delete extraction/smith-2020
```

### When to Use Pull Requests vs Direct Merges

**Use Pull Requests (PRs) when:**
- Working in a team (peer review required)
- Dual extraction workflows (compare two reviewers' work)
- Major methodology changes (need discussion)
- Contributing to shared repository

**Use Direct Merges when:**
- Solo researcher validating own work
- Quick corrections to typos
- Emergency fixes

### Tagging Important Milestones

Mark major project phases with Git tags:

```bash
# Tag when screening is complete
git tag -a v1.0-screening-complete -m "Completed title/abstract screening: 150 papers → 42 included"

# Tag when extraction is complete
git tag -a v2.0-extraction-complete -m "Completed data extraction for all 42 included papers"

# Tag when analysis is done
git tag -a v3.0-analysis-final -m "Final meta-regression analysis with sensitivity tests"

# Push tags to remote
git push origin --tags

# List all tags
git tag -l
```

**Why tags matter:** Tags provide reproducibility checkpoints. You can reference exact analysis versions in publications: "Analysis conducted using dataset version v2.0-extraction-complete (commit hash abc123)."

---

## Common Workflow Guides

### How to Version a Data Card

**Scenario:** You're extracting data from a research paper and want to track your extraction process.

**Workflow:**

1. **Initial extraction:**
```bash
# Create feature branch
git checkout -b extraction/garcia-2021

# Extract data using Microscope
# Save result to data_cards/garcia-2021.md

# Review what changed
git status

# Stage data card
git add data_cards/garcia-2021.md

# Commit with descriptive message
git commit -m "extract: Add Garcia et al. 2021 cohort study data card"
```

2. **Track revisions and corrections:**
```bash
# You discover an error in the effect size calculation
# Edit data_cards/garcia-2021.md to fix the error

# Review changes before committing
git diff data_cards/garcia-2021.md

# Stage and commit correction
git add data_cards/garcia-2021.md
git commit -m "fix: Correct effect size calculation in Garcia-2021 (Table 3)"
```

3. **Review extraction history:**
```bash
# View all commits related to this data card
git log --oneline -- data_cards/garcia-2021.md

# View detailed changes over time
git log -p -- data_cards/garcia-2021.md

# Compare current version to initial extraction
git diff <initial-commit-hash> HEAD -- data_cards/garcia-2021.md
```

4. **Merge to main when validated:**
```bash
git checkout main
git merge extraction/garcia-2021
git branch -d extraction/garcia-2021
```

**Result:** Complete audit trail of extraction process, corrections, and validation.

---

### How to Track Extraction Criteria Changes

**Scenario:** You need to modify your quality assessment criteria mid-project and re-evaluate previously extracted papers.

**Workflow:**

1. **Create experimental branch:**
```bash
git checkout -b experiment/revised-quality-criteria

# Edit your quality checklist
# For example: modules/custom_quality_checklist.md

git add modules/custom_quality_checklist.md
git commit -m "update: Revise quality criteria to include blinding assessment"
```

2. **Re-extract sample papers with new criteria:**
```bash
# Re-run Microscope on existing papers with updated checklist
# Update data_cards/smith-2020.md
# Update data_cards/jones-2019.md

git add data_cards/smith-2020.md data_cards/jones-2019.md
git commit -m "review: Re-assess quality scores using revised criteria"
```

3. **Compare results:**
```bash
# Compare new criteria branch to main branch
git diff main...experiment/revised-quality-criteria

# View specific file differences
git diff main data_cards/smith-2020.md
```

4. **Decision point:**

**If new criteria improve quality:**
```bash
# Merge to main
git checkout main
git merge experiment/revised-quality-criteria

# Tag this major version change
git tag -a v1.1-criteria-update -m "Updated quality criteria to include blinding assessment"

# Document change in project CHANGELOG
echo "## v1.1 - 2024-10-21\n- Updated quality criteria\n- Re-assessed 15 papers" >> CHANGELOG.md
git add CHANGELOG.md
git commit -m "docs: Document quality criteria update in CHANGELOG"
```

**If no improvement (abandon experiment):**
```bash
git checkout main
git branch -d experiment/revised-quality-criteria
# Changes discarded, original criteria preserved
```

**Result:** Transparent tracking of methodology evolution with full reproducibility.

---

### How to Handle Dual Extraction Conflicts

**Scenario:** Two reviewers independently extract data from the same paper to reduce bias. Their extractions differ and need reconciliation.

**Workflow:**

1. **Reviewer A extracts:**
```bash
# Reviewer A creates branch
git checkout -b extraction-a/lopez-2022

# Extract data, save as data_cards/lopez-2022.md
git add data_cards/lopez-2022.md
git commit -m "extract: Lopez-2022 data (Reviewer A)"

# Push to remote for sharing
git push origin extraction-a/lopez-2022
```

2. **Reviewer B extracts (independently):**
```bash
# Reviewer B creates separate branch (from main, not Reviewer A's branch)
git checkout main
git checkout -b extraction-b/lopez-2022

# Extract data independently, save as data_cards/lopez-2022.md
git add data_cards/lopez-2022.md
git commit -m "extract: Lopez-2022 data (Reviewer B)"

# Push to remote
git push origin extraction-b/lopez-2022
```

3. **Compare extractions:**
```bash
# Either reviewer can compare the two branches
git diff extraction-a/lopez-2022 extraction-b/lopez-2022

# Or view side-by-side on GitHub/GitLab pull request
```

**Example diff output:**
```diff
diff --git a/data_cards/lopez-2022.md b/data_cards/lopez-2022.md
--- a/data_cards/lopez-2022.md (Reviewer A)
+++ b/data_cards/lopez-2022.md (Reviewer B)
@@ -10,7 +10,7 @@
 sample_size: 156

 | Outcome | n | Mean | SD | Label |
 |---------|---|------|-----|-------|
-| Depression | 152 | 14.2 | 4.1 | 🟢 |
+| Depression | 156 | 14.5 | 4.3 | 🟢 |
```

4. **Resolve discrepancies:**
```bash
# Create consensus branch
git checkout -b consensus/lopez-2022

# Option A: Start from Reviewer A's version
git merge extraction-a/lopez-2022

# Manually review and reconcile with Reviewer B's extraction
# Check source paper to resolve: sample size (152 vs 156), mean (14.2 vs 14.5)
# Edit data_cards/lopez-2022.md with correct values from paper

# If uncertainty remains, use 🔴 red label
# Example: | Depression | 156 | 14.5 | 4.3 | 🔴 |
# Note: Discrepancy between reviewers on sample size

git add data_cards/lopez-2022.md
git commit -m "review: Consensus data card for Lopez-2022 (resolved A/B discrepancies)"
```

5. **Merge consensus to main:**
```bash
git checkout main
git merge consensus/lopez-2022

# Clean up branches
git branch -d extraction-a/lopez-2022
git branch -d extraction-b/lopez-2022
git branch -d consensus/lopez-2022

# Delete remote branches
git push origin --delete extraction-a/lopez-2022
git push origin --delete extraction-b/lopez-2022
```

**Result:** Rigorous dual-screening process with transparent conflict resolution and audit trail.

---

## Commit Message Conventions

### Why Commit Messages Matter for Research

Clear commit messages provide:
- **Audit trail:** What changed, when, and why
- **Reproducibility:** Understand decision-making process
- **Collaboration:** Help team members understand your work
- **RAAA compliance:** Required for Reproducible AI-Assisted Analysis

### Commit Message Format

```
<type>: <brief summary (50 characters max)>

<optional detailed description>
<can span multiple lines>
```

### Type Prefixes for Meta-Analysis

| Type | Purpose | Example |
|------|---------|---------|
| `extract:` | New data card extraction | `extract: Add Kim-2023 cross-sectional study` |
| `review:` | Quality assessment or peer review | `review: Update quality scores after validation` |
| `fix:` | Correction to existing data | `fix: Correct sample size in Table 2 of Chen-2020` |
| `update:` | Revision based on new criteria | `update: Revise inclusion criteria for RCTs only` |
| `compile:` | Dataset compilation | `compile: Generate final dataset from 38 papers` |
| `analyze:` | Statistical analysis code | `analyze: Add forest plot generation script` |
| `docs:` | Documentation changes | `docs: Update README with extraction protocol` |
| `config:` | Project configuration | `config: Update project_config.yaml for RoB2` |

### Good Commit Message Examples

```bash
# Extraction
git commit -m "extract: Add Wang et al. 2021 longitudinal cohort data card"

# Review with detail
git commit -m "review: Update quality assessment for Davis-2019
- Downgraded internal validity due to selection bias
- Updated 🟢 to 🟡 for baseline characteristics table
- Added note about missing blinding information"

# Fix with context
git commit -m "fix: Correct effect size calculation in Martinez-2022 (Table 4)
- Original extraction used wrong SD (between-group instead of within-group)
- Recalculated Hedges' g: 0.42 → 0.38
- Source: Table 4, page 156"

# Update criteria
git commit -m "update: Exclude quasi-experimental designs from inclusion criteria
- Decision made during team meeting 2024-10-20
- Affects 3 previously extracted papers (flagged for re-review)
- Rationale: Insufficient rigor for causal inference"

# Compilation milestone
git commit -m "compile: Generate final dataset for meta-regression analysis
- 42 papers included (38 RCTs, 4 cohort studies)
- Dataset: compiled/dataset_final_2024-10-21.csv
- Ready for statistical analysis"
```

### Bad Commit Message Examples

❌ **Too vague:**
```bash
git commit -m "wip"
git commit -m "updates"
git commit -m "fixed stuff"
```

❌ **No context:**
```bash
git commit -m "data card"
git commit -m "changes"
```

❌ **No research relevance:**
```bash
git commit -m "asdf"
git commit -m "temp commit"
```

### How to Write Better Commit Messages

1. **Be specific:** What file/paper was changed?
2. **Explain why:** What was the reason for the change?
3. **Add context:** Where in the paper (table, page) did you find the data?
4. **Use consistent type prefixes:** Makes history searchable
5. **Keep first line short:** 50 characters max
6. **Use detailed description for complex changes:** Add blank line then details

---

## What NOT to Commit

### Files That Should NEVER Be Committed

#### 1. Large PDF Files (Research Papers)

**Why not:**
- Copyright restrictions (most papers are not openly licensed)
- Large file sizes bloat Git repository
- Makes cloning/pulling slow
- PDFs are not diffable (can't track changes)

**Exception:** Small, openly-licensed example PDFs (CC-BY, public domain) for documentation purposes.

**.gitignore configuration:**
```gitignore
papers/*.pdf
*.pdf
```

**How to reference papers without committing:**
```yaml
# In data card YAML frontmatter
source_citation: "Smith, J. et al. (2020). Title. Journal, 15(3), 123-145. DOI: 10.1234/example"
source_file: "smith-2020.pdf"  # Local reference only, file not committed
```

---

#### 2. API Keys and Credentials

**Why not:**
- Security risk (public repositories expose secrets)
- Personal credentials should not be shared
- API keys can be revoked if exposed

**Examples of sensitive files:**
```
.env
.env.local
credentials.json
api_key.txt
auth_token.txt
```

**.gitignore configuration:**
```gitignore
.env
.env.local
.env.*.local
credentials.*
*_credentials.*
api_key*
auth_token*
```

**Best practice:** Use environment variables or config files that are excluded from Git.

---

#### 3. Personal Notes and Private Comments

**Why not:**
- Reviewer private thoughts should remain private
- Personal annotations not relevant to research output
- May contain unprofessional or incomplete thoughts

**Examples:**
```
notes/
personal/
reviewer_comments.txt
*.notes
todo.txt
```

**.gitignore configuration:**
```gitignore
notes/
personal/
*.notes
*_notes.txt
todo.txt
```

**Alternative:** Use separate notes app or local-only files for personal tracking.

---

#### 4. Temporary and Build Files

**Why not:**
- Generated automatically by tools
- Can be recreated from source
- Clutter repository history
- May be user/system specific

**Examples:**
```
# Editor backups
*.tmp
*.bak
*~
*.swp

# OS files
.DS_Store
Thumbs.db
Desktop.ini

# Python artifacts (CROS phase)
__pycache__/
*.pyc
.pytest_cache/

# R temporary files
.Rhistory
.RData
.Rproj.user/

# Node.js (CROS phase)
node_modules/
dist/
```

**.gitignore configuration:**
```gitignore
# Temporary
*.tmp
*.bak
*~
*.swp

# OS
.DS_Store
Thumbs.db
Desktop.ini

# Python
__pycache__/
*.pyc
.pytest_cache/
venv/

# R
.Rhistory
.RData
.Rproj.user/
```

---

#### 5. Local SQLite Databases (CROS Phase)

**Why not:**
- User-specific metadata and caches
- Can be regenerated from source files
- Binary files are not diffable

**.gitignore configuration:**
```gitignore
*.db
*.sqlite
*.sqlite3
```

**Note:** Compiled CSV datasets (from Compiler) SHOULD be committed for reproducibility, but local database caches should not.

---

### Data Privacy Considerations

**If working with medical research:**
- **Never commit** data cards containing Protected Health Information (PHI)
- **Never commit** Personally Identifiable Information (PII)
- **Aggregate data only:** Meta-analyses typically use summary statistics (means, SDs, effect sizes), not individual patient data

**Best practice:** Review all data cards before committing to ensure they contain only aggregate, de-identified data.

---

### Recommended .gitignore Template for MAestro Projects

Create this `.gitignore` file in your meta-analysis project root:

```gitignore
# MAestro Meta-Analysis Project .gitignore

# Research papers (copyright, large files)
papers/
*.pdf

# Personal notes
notes/
personal/
*.notes
*_notes.txt
todo.txt
scratch/

# API keys and credentials
.env
.env.local
credentials.*
*_credentials.*
api_key*
auth_token*

# SQLite databases (user-specific, CROS phase)
*.db
*.sqlite
*.sqlite3

# Large compressed data (if not needed for reproducibility)
*.csv.gz
*.zip
*.tar.gz

# Statistical software temporary files
# R
.Rhistory
.RData
.Rproj.user/

# Python (if using Python for analysis)
__pycache__/
*.pyc
.pytest_cache/
venv/
env/

# IDE files
.vscode/
.idea/
*.sublime-project
*.sublime-workspace

# OS files
.DS_Store
Thumbs.db
Desktop.ini

# Temporary files
*.tmp
*.bak
*~
*.swp

# Logs
*.log
logs/
```

**Link to MAestro repository .gitignore:** The [MAestro repository](../../.gitignore) includes comprehensive .gitignore patterns for development. Adapt patterns relevant to your meta-analysis workflow.

---

## Async Collaboration Workflows

### Git is Asynchronous (Not Real-Time)

**Important:** Git is **not** a real-time collaborative editing tool like Google Docs. Instead:
- Each researcher works independently on their own branch
- Changes are shared asynchronously via commits and pushes
- Collaboration happens through pull requests and code review
- Conflicts are resolved explicitly, not automatically

**This is a feature, not a bug:** Async workflows provide audit trails and explicit review checkpoints.

---

### Pull Request Workflow for Team Collaboration

**Scenario:** Team member extracts a paper and submits for peer review.

**Workflow:**

1. **Researcher creates extraction on feature branch:**
```bash
git checkout -b extraction/nguyen-2023
# Extract data, create data_cards/nguyen-2023.md
git add data_cards/nguyen-2023.md
git commit -m "extract: Add Nguyen et al. 2023 meta-analysis data card"
git push origin extraction/nguyen-2023
```

2. **Create pull request (GitHub/GitLab):**
```bash
# Using GitHub CLI (gh)
gh pr create --title "Extract: Nguyen et al. 2023" --body "Initial extraction for peer review"

# Or create PR via web interface
```

3. **Team reviews PR:**
- Reviewers examine data card in PR diff view
- Add comments on specific lines:
  - "This sample size looks incorrect - should be 245 per Table 1"
  - "Missing baseline characteristics data"
  - "Quality score seems too high given selection bias"

4. **Researcher addresses feedback:**
```bash
# Make corrections to data_cards/nguyen-2023.md
git add data_cards/nguyen-2023.md
git commit -m "review: Address peer review feedback
- Corrected sample size to 245 (Table 1)
- Added baseline characteristics from Table 2
- Downgraded quality score due to selection bias"

git push origin extraction/nguyen-2023
# PR automatically updates with new commits
```

5. **Merge after approval:**
```bash
# Reviewer approves PR
# Researcher or team lead merges
gh pr merge extraction/nguyen-2023 --squash
# Or merge via web interface

# Delete remote branch
git push origin --delete extraction/nguyen-2023
```

**Result:** Rigorous peer review with complete discussion history preserved in PR.

---

### Dual-Screening Conflict Resolution Using PRs

**Scenario:** Two reviewers independently extract the same paper. Compare extractions and create consensus.

**Workflow:**

1. **Both reviewers extract independently:**
```bash
# Reviewer A
git checkout -b extraction-a/park-2024
# ... extract, commit, push ...

# Reviewer B (independent, from main)
git checkout main
git checkout -b extraction-b/park-2024
# ... extract, commit, push ...
```

2. **Create pull requests for both:**
```bash
# Reviewer A
gh pr create --title "Extract: Park-2024 (Reviewer A)"

# Reviewer B
gh pr create --title "Extract: Park-2024 (Reviewer B)"
```

3. **Compare using GitHub PR diff:**
- Open both PRs side-by-side
- Or use GitHub's compare view: `https://github.com/user/repo/compare/extraction-a/park-2024...extraction-b/park-2024`

4. **Discuss discrepancies in PR comments:**
```markdown
# Example PR comment thread:

**Reviewer A:** I extracted sample size as 180 from Table 1
**Reviewer B:** I found sample size as 175 from the text (page 4, paragraph 2)
**Lead Researcher:** Checked source - Table 1 reports n=180 (total enrolled), but n=175 completed study (Figure 1 CONSORT diagram). Use 175 for analysis.
```

5. **Create consensus branch:**
```bash
git checkout -b consensus/park-2024

# Manually create consensus data card incorporating both reviews
# Use 🔴 red labels for remaining uncertainties

git add data_cards/park-2024.md
git commit -m "review: Consensus data card for Park-2024
- Resolved sample size discrepancy (using n=175 completers)
- Combined quality assessments from both reviewers
- Flagged uncertainty about blinding (marked 🔴)"

git push origin consensus/park-2024
gh pr create --title "Consensus: Park-2024 (Final)"
```

6. **Merge consensus PR after team approval:**
```bash
gh pr merge consensus/park-2024
```

**Result:** Transparent dual-screening with documented conflict resolution.

---

### Coordination Strategies for Teams

**1. Assignment Tracking (Prevents Duplicate Work)**

Use GitHub Issues or project management board:
```markdown
# GitHub Issue #15: Extract batch 3 papers (10 papers)
- [ ] Taylor-2020 (assigned: @reviewer-a)
- [ ] Kim-2021 (assigned: @reviewer-b)
- [ ] Singh-2019 (assigned: @reviewer-a)
...
```

**2. Extraction Log in README**

Maintain project README with extraction status:
```markdown
## Extraction Progress

| Paper | Extractor | Status | Branch | PR |
|-------|-----------|--------|--------|-----|
| Taylor-2020 | Alice | In Progress | `extraction/taylor-2020` | - |
| Kim-2021 | Bob | Review | `extraction/kim-2021` | #12 |
| Singh-2019 | Alice | Merged | - | #10 |
```

**3. Branch Naming with Initials**

Include reviewer initials in branch names:
```bash
git checkout -b extraction/alice/martinez-2022
git checkout -b extraction/bob/martinez-2022
```

---

### Common Anti-Patterns to Avoid

❌ **Committing directly to main without review:**
```bash
# Bad: No peer review
git checkout main
git add data_cards/new-paper.md
git commit -m "extract: new paper"
git push origin main
```

✅ **Use feature branches + PRs:**
```bash
# Good: Peer-reviewed workflow
git checkout -b extraction/new-paper
git add data_cards/new-paper.md
git commit -m "extract: Add NewAuthor-2024 RCT"
git push origin extraction/new-paper
gh pr create
```

---

❌ **Force pushing to shared branches:**
```bash
# Bad: Destroys team members' work
git push --force origin main
```

✅ **Never force push to main or shared branches. Only force push to your own feature branches if absolutely necessary and after coordinating with team.**

---

❌ **Creating merge commits without resolving conflicts:**
```bash
# Bad: Blindly accepting auto-merge
git merge extraction/paper --no-edit
```

✅ **Always review conflicts carefully, especially in data cards where accuracy is critical.**

---

## Troubleshooting Common Issues

### Issue 1: Merge Conflicts in YAML Frontmatter

**Symptoms:**
```yaml
<<<<<<< HEAD
extraction_date: 2024-10-15
extractor: Alice
=======
extraction_date: 2024-10-20
extractor: Bob
>>>>>>> extraction/smith-2020
```

**Root Cause:** Two branches modified the same YAML fields (common in dual extraction).

**Resolution:**

1. **Open the conflicted file in your editor:**
```bash
# Git marks conflict
git merge extraction/smith-2020
# Auto-merging data_cards/smith-2020.md
# CONFLICT (content): Merge conflict in data_cards/smith-2020.md

# Open file
code data_cards/smith-2020.md  # or your preferred editor
```

2. **Manually resolve conflict:**
```yaml
# Choose correct values (or combine)
extraction_date: 2024-10-20    # Use more recent date
extractor: Bob                 # Or "Alice and Bob" for dual extraction
```

3. **Verify YAML syntax is valid:**
```bash
# Use YAML validator or Python
python -c "import yaml; yaml.safe_load(open('data_cards/smith-2020.md').read().split('---')[1])"
```

4. **Stage and commit resolution:**
```bash
git add data_cards/smith-2020.md
git commit -m "review: Resolve merge conflict in Smith-2020 YAML frontmatter"
```

**Prevention:**
- Clear task assignment (avoid concurrent edits to same fields)
- Use separate filenames for dual extraction (e.g., `smith-2020-a.md`, `smith-2020-b.md`)
- Communicate with team before merging

---

### Issue 2: Merge Conflicts in Markdown Tables

**Symptoms:**
```markdown
| Outcome | n | Mean | SD | Label |
|---------|---|------|-----|-------|
<<<<<<< HEAD
| Depression | 42 | 12.3 | 3.1 | 🟢 |
=======
| Depression | 40 | 12.5 | 3.2 | 🟢 |
>>>>>>> extraction/jones-2019
```

**Root Cause:** Different data points extracted by different reviewers (dual extraction).

**Resolution:**

1. **Check source paper to determine correct values:**
```bash
# Open source paper (local PDF, not in Git)
# Check Table 2, page 145
# Correct values: n=42, Mean=12.3, SD=3.1
```

2. **Resolve conflict with correct data:**
```markdown
| Outcome | n | Mean | SD | Label |
|---------|---|------|-----|-------|
| Depression | 42 | 12.3 | 3.1 | 🟢 |
```

3. **If uncertainty remains, use 🔴 red label:**
```markdown
| Outcome | n | Mean | SD | Label |
|---------|---|------|-----|-------|
| Depression | 42 | 12.3 | 3.1 | 🔴 |
```

*Note: Discrepancy between reviewers on sample size. Need to verify with lead author.*

4. **Stage and commit:**
```bash
git add data_cards/jones-2019.md
git commit -m "review: Resolve table conflict in Jones-2019 (verified n=42 from source)"
```

**Prevention:**
- Dual extraction workflow with explicit reconciliation step (see [Dual Extraction Workflow](#how-to-handle-dual-extraction-conflicts))
- Use three-color labels to flag uncertainties during extraction

---

### Issue 3: Recovering from Accidental Commits

**Scenario 1: Committed sensitive file (not yet pushed)**

```bash
# Accidentally committed API key file
git add .env
git commit -m "config: update settings"

# BEFORE PUSHING: Undo last commit (keep changes in working directory)
git reset HEAD~1

# Remove file from staging
git restore --staged .env

# Add to .gitignore
echo ".env" >> .gitignore
git add .gitignore
git commit -m "config: Add .env to .gitignore"
```

**Scenario 2: Committed large PDF (not yet pushed)**

```bash
# Accidentally committed PDF
git add papers/large-paper.pdf
git commit -m "extract: add paper"

# BEFORE PUSHING: Undo commit
git reset HEAD~1

# Add to .gitignore
echo "*.pdf" >> .gitignore
git add .gitignore
git commit -m "config: Exclude PDF files from version control"
```

**Scenario 3: Already pushed to remote (requires coordination)**

```bash
# Committed and pushed sensitive file
git push origin main

# WARNING: This rewrites history - coordinate with team first!

# Remove file from Git but keep locally
git rm --cached .env

# Add to .gitignore
echo ".env" >> .gitignore
git add .gitignore
git commit -m "fix: Remove accidentally committed .env file"

# Inform team before force pushing
git push --force origin main
```

**Scenario 4: Safe alternative using git revert (after push)**

```bash
# Instead of force push, create new commit that removes file
git rm --cached papers/large-paper.pdf
echo "*.pdf" >> .gitignore
git add .gitignore
git commit -m "fix: Remove accidentally committed PDF files"
git push origin main

# File is removed from tracking but remains in history
# For sensitive data, use git filter-branch or BFG Repo-Cleaner (advanced)
```

**Prevention:**
- Always review `git status` before committing
- Use `git diff --cached` to review staged changes
- Configure pre-commit hooks to block large/sensitive files
- Maintain comprehensive `.gitignore` from project start

---

### Issue 4: Large Repository Size from Committed PDFs

**Symptoms:**
- Repository clones are very slow
- `.git` directory is gigabytes in size
- Team members complain about long pull times

**Root Cause:** Binary files (PDFs) committed to Git history bloat repository.

**Solution (Advanced):**

**Option 1: BFG Repo-Cleaner (recommended for large cleanups)**
```bash
# Install BFG
# macOS: brew install bfg
# Windows: Download from https://rtyley.github.io/bfg-repo-cleaner/

# Clone fresh copy
git clone --mirror https://github.com/user/repo.git repo-cleanup.git
cd repo-cleanup.git

# Remove all PDFs from history
bfg --delete-files "*.pdf"

# Clean up
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# Force push (COORDINATE WITH TEAM FIRST!)
git push --force
```

**Option 2: git filter-branch (built-in but slower)**
```bash
# Remove all PDFs from history
git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch "*.pdf"' \
  --prune-empty --tag-name-filter cat -- --all

# Clean up
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# Force push (COORDINATE WITH TEAM FIRST!)
git push --force --all
```

**After cleanup, all team members must:**
```bash
# Delete local repo
cd ..
rm -rf my_meta_analysis

# Re-clone cleaned repo
git clone https://github.com/user/repo.git my_meta_analysis
```

**Prevention:**
- Configure `.gitignore` to exclude PDFs from project start
- Use pre-commit hooks to block large files
- Educate team on what not to commit
- Regular repository size monitoring

---

### Issue 5: Diverged Branches (Fast-Forward Not Possible)

**Symptoms:**
```bash
git merge extraction/paper
# error: Your local changes to the following files would be overwritten by merge
# hint: Aborting
```

**Root Cause:** Both branches have new commits (diverged), not just linear history.

**Resolution:**

1. **Commit or stash local changes:**
```bash
# Option A: Commit changes
git add .
git commit -m "wip: Save work in progress"

# Option B: Stash changes
git stash save "WIP: Temporary save"
```

2. **Pull/merge remote changes:**
```bash
git pull origin main
# or
git merge extraction/paper
```

3. **Resolve conflicts if any** (see Issues 1-2 above)

4. **If you stashed, restore changes:**
```bash
git stash pop
```

**Prevention:**
- Regularly pull from main to keep branch updated
- Commit frequently
- Don't work directly on main branch

---

### External Resources for Advanced Git Recovery

- [Git Official Documentation - Undoing Things](https://git-scm.com/book/en/v2/Git-Basics-Undoing-Things)
- [GitHub - Removing Sensitive Data](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository)
- [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/)
- [Atlassian Git Tutorials - Rewriting History](https://www.atlassian.com/git/tutorials/rewriting-history)

---

## Best Practices and Recommendations

### 1. Commit Frequently with Meaningful Messages

**Why:** Small, frequent commits are easier to review and revert if needed.

**Good practice:**
```bash
# After each data card extraction
git commit -m "extract: Add Chen-2022 cohort study"

# After quality assessment
git commit -m "review: Complete quality checklist for Chen-2022"

# After corrections
git commit -m "fix: Correct baseline characteristics table in Chen-2022"
```

**Bad practice:**
```bash
# One giant commit at end of day
git commit -m "Added 10 papers and fixed some stuff"
```

---

### 2. Always Review Before Committing

**Check what you're about to commit:**
```bash
# Review status
git status

# Review unstaged changes
git diff

# Review staged changes
git diff --cached

# Then commit
git add data_cards/new-paper.md
git commit -m "extract: Add NewPaper-2024"
```

---

### 3. Use .gitattributes for Consistent Line Endings

**Why:** Ensures markdown files use LF line endings across Windows/macOS/Linux.

**Create `.gitattributes` in project root:**
```gitattributes
# Ensure consistent line endings
*.md text eol=lf
*.yaml text eol=lf
*.yml text eol=lf
*.csv text eol=lf
*.R text eol=lf
*.py text eol=lf
*.txt text eol=lf
```

**Benefit:** Prevents spurious line ending conflicts in cross-platform teams.

---

### 4. Tag Important Milestones

**Create annotated tags for major project phases:**
```bash
# Screening complete
git tag -a v1.0-screening-complete -m "Title/abstract screening: 200 papers → 45 included"

# Extraction complete
git tag -a v2.0-extraction-complete -m "Data extraction complete for 45 papers"

# Analysis ready
git tag -a v3.0-analysis-ready -m "Final dataset compiled and validated"

# Push tags to remote
git push origin --tags
```

**Reference in publications:**
> "Meta-analysis dataset (version v2.0-extraction-complete, commit hash a3f5b9c) available at https://github.com/user/meta-analysis-project"

---

### 5. Backup to Remote Repository

**Why:** Git is version control, not backup. Use GitHub/GitLab for safety.

**Setup remote:**
```bash
# Create repository on GitHub/GitLab
# Add remote
git remote add origin https://github.com/user/my-meta-analysis.git

# Push all branches and tags
git push -u origin main
git push origin --all
git push origin --tags
```

**Regular backups:**
```bash
# Push after each work session
git push origin main
```

---

### 6. Use git log to Review Project History

**Useful log commands:**
```bash
# Concise one-line history
git log --oneline

# Show last 10 commits
git log --oneline -10

# Search commit messages
git log --grep="extract:" --oneline

# Show changes to specific file
git log --oneline -- data_cards/smith-2020.md

# Show commits by date range
git log --since="2024-10-01" --until="2024-10-31" --oneline

# Show commits by author
git log --author="Alice" --oneline
```

**Reproducibility use case:**
```bash
# Document which papers were extracted in October 2024
git log --since="2024-10-01" --until="2024-10-31" --grep="extract:" --oneline > extraction_log_oct2024.txt
```

---

### 7. Document Branching Strategy in Project README

**Add to README.md:**
```markdown
## Git Workflow

This project uses the following branching strategy:

- **main**: Validated, peer-reviewed extractions ready for analysis
- **extraction/<paper-id>**: Individual paper extractions (before validation)
- **review/<study-id>**: Peer review and quality assessment work
- **experiment/<description>**: Testing new methodologies or criteria

See [Git Integration Best Practices](docs/git-integration.md) for detailed workflow guidance.
```

---

### 8. Integrate Git Workflow with MAestro Tools

**Microscope → Git workflow:**
```bash
# 1. Create feature branch
git checkout -b extraction/author-2024

# 2. Run Microscope (Claude Code) to extract data
# Save output to data_cards/author-2024.md

# 3. Commit extraction
git add data_cards/author-2024.md
git commit -m "extract: Add Author-2024 data card via Microscope v1.0"
```

**Compiler → Git workflow:**
```bash
# 1. Ensure all data cards on main branch
git checkout main
git pull origin main

# 2. Run Compiler to aggregate data cards
# Generates compiled/dataset_2024-10-21.csv

# 3. Commit compiled dataset
git add compiled/dataset_2024-10-21.csv
git commit -m "compile: Generate dataset from 42 validated papers"
git tag -a v2.0-dataset-final -m "Final dataset for meta-regression"
```

**Oracle → Git workflow:**
```bash
# 1. Run Oracle to validate extraction
# Oracle reviews data_cards/paper.md

# 2. If Oracle finds issues, create fix branch
git checkout -b fix/paper-validation-issues

# 3. Address Oracle feedback
# Edit data_cards/paper.md

# 4. Commit fixes
git commit -m "fix: Address Oracle validation feedback for paper"
```

---

### 9. Use Pre-Commit Hooks to Prevent Mistakes

**Create `.git/hooks/pre-commit` (advanced users):**
```bash
#!/bin/bash
# Pre-commit hook to prevent committing large files

# Check for PDF files
if git diff --cached --name-only | grep -q '\.pdf$'; then
    echo "Error: Attempting to commit PDF files"
    echo "PDFs should not be version controlled"
    exit 1
fi

# Check for .env files
if git diff --cached --name-only | grep -q '\.env'; then
    echo "Error: Attempting to commit .env file"
    echo "Credentials should not be version controlled"
    exit 1
fi

exit 0
```

**Make executable:**
```bash
chmod +x .git/hooks/pre-commit
```

---

### 10. Regular Repository Maintenance

**Periodically clean up:**
```bash
# Delete merged branches
git branch --merged main | grep -v "main" | xargs git branch -d

# Clean up remote tracking branches
git remote prune origin

# Verify repository health
git fsck

# Optimize repository
git gc
```

---

## Git Command Reference

### Essential Git Commands Quick Sheet

| Command | Purpose | Example |
|---------|---------|---------|
| **Initialize** | Create new Git repository | `git init` |
| **Status** | Show working tree status | `git status` |
| **Add** | Stage files for commit | `git add data_cards/paper.md` |
| **Add All** | Stage all changes | `git add .` |
| **Commit** | Save staged changes | `git commit -m "extract: Add paper"` |
| **Log** | View commit history | `git log --oneline` |
| **Diff** | Show unstaged changes | `git diff` |
| **Diff Cached** | Show staged changes | `git diff --cached` |
| **Branch Create** | Create new branch | `git branch extraction/paper` |
| **Checkout** | Switch to branch | `git checkout main` |
| **Checkout -b** | Create and switch to branch | `git checkout -b extraction/paper` |
| **Merge** | Merge branch into current | `git merge extraction/paper` |
| **Push** | Upload commits to remote | `git push origin main` |
| **Pull** | Download and merge from remote | `git pull origin main` |
| **Clone** | Copy remote repository | `git clone https://github.com/user/repo.git` |
| **Remote Add** | Add remote repository | `git remote add origin <url>` |
| **Tag** | Create milestone tag | `git tag -a v1.0 -m "Message"` |
| **Stash** | Temporarily save changes | `git stash save "WIP"` |
| **Stash Pop** | Restore stashed changes | `git stash pop` |

---

### Common Command Sequences

**Initial project setup:**
```bash
git init
git add .
git commit -m "docs: Initialize meta-analysis project"
git remote add origin https://github.com/user/repo.git
git push -u origin main
```

**Feature branch workflow:**
```bash
git checkout -b extraction/paper
# ... work on extraction ...
git add data_cards/paper.md
git commit -m "extract: Add paper data card"
git push origin extraction/paper
# ... create PR, get approval ...
git checkout main
git merge extraction/paper
git push origin main
git branch -d extraction/paper
```

**Review changes before committing:**
```bash
git status              # See what changed
git diff                # Review unstaged changes
git add data_cards/     # Stage specific directory
git diff --cached       # Review staged changes
git commit -m "..."     # Commit
```

**Undo mistakes:**
```bash
# Undo last commit (keep changes)
git reset HEAD~1

# Discard all local changes
git restore .

# Restore specific file to last commit
git restore data_cards/paper.md
```

---

### Expected Command Outputs

**`git status` (clean working tree):**
```
On branch main
nothing to commit, working tree clean
```

**`git status` (changes to commit):**
```
On branch extraction/paper
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   data_cards/paper-2024.md
```

**`git log --oneline` (example):**
```
a3f5b9c (HEAD -> main) compile: Generate final dataset from 42 papers
d7e2c1a extract: Add Park-2024 cohort study
9b4f3e8 extract: Add Lopez-2022 RCT
f1a6d5c docs: Initialize meta-analysis project
```

**`git diff` (example):**
```diff
diff --git a/data_cards/smith-2020.md b/data_cards/smith-2020.md
index a1b2c3d..e4f5g6h 100644
--- a/data_cards/smith-2020.md
+++ b/data_cards/smith-2020.md
@@ -15,7 +15,7 @@ sample_size: 156

 | Outcome | n | Mean | SD | Label |
 |---------|---|------|-----|-------|
-| Depression | 150 | 14.2 | 4.1 | 🟡 |
+| Depression | 156 | 14.5 | 4.3 | 🟢 |
```

---

## Cross-References

For more details on MAestro tools and workflows:

- **Data Card Format:** See [docs/data-card-format.md](data-card-format.md) for data card structure and YAML schema
- **Microscope Usage:** See [docs/microscope-usage.md](microscope-usage.md) for extraction workflow with Claude Code
- **Quality Checklists:** See [modules/generic/generic_quality_checklist.md](../modules/generic/generic_quality_checklist.md) for assessment templates
- **Project Structure:** See [README.md](../README.md) for overall MAestro documentation

---

## Conclusion

Git integration provides the foundation for reproducible, collaborative meta-analysis workflows with MAestro:

- ✅ **Version control** tracks every extraction decision
- ✅ **Branching** enables safe experimentation and dual screening
- ✅ **Commit history** provides audit trail for RAAA compliance
- ✅ **Pull requests** facilitate rigorous peer review
- ✅ **Tags** mark reproducibility checkpoints for publications

**Next steps:**
1. Initialize Git repository for your meta-analysis project
2. Configure .gitignore to exclude PDFs and sensitive files
3. Establish branching strategy with your team
4. Start extracting papers using feature branches
5. Use pull requests for peer review

**Questions or issues?** See [Troubleshooting](#troubleshooting-common-issues) or consult the [Git documentation](https://git-scm.com/doc).

---

*This guide is part of the MAestro documentation. For updates and contributions, see the [MAestro repository](https://github.com/your-org/maestro).*
