# Requirements

## Functional

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

## Non Functional

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
